/**
 * Responsive E2E checks for SotongFinance production site.
 * Never logs secrets. Outputs JSON summary only.
 */
import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const BASE = process.env.BASE_URL || 'https://sotong-finance.web.app';
const VIEWPORTS = [
  { name: '360x800', width: 360, height: 800 },
  { name: '390x844', width: 390, height: 844 },
  { name: '412x915', width: 412, height: 915 },
  { name: '768x1024', width: 768, height: 1024 },
  { name: '1024x768', width: 1024, height: 768 },
  { name: '1440x900', width: 1440, height: 900 },
  { name: '1920x1080', width: 1920, height: 1080 },
];

const ROUTES = [
  '/',
  '/search',
  '/tools',
  '/diagnose',
  '/paths',
  '/ips',
  '/plan',
  '/crisis',
  '/annual-review',
  '/estate-list',
  '/timeline',
  '/project/report',
  '/learn/basics-money-role',
  '/learn/money-household',
  '/learn/re-housing-land',
  '/learn/stock-what',
  '/learn/loan-basics',
  '/learn/tax-basics',
  '/learn/pension-basics',
  '/learn/fraud-voice',
  '/tools/compound-interest',
  '/tools/loan-payment',
  '/tools/emergency-months',
  '/tools/sequence-risk',
  '/tools/concentration',
  '/tools/withdrawal',
];

function isMobile(vp) {
  return vp.width < 900;
}

async function waitFlutter(page) {
  await page.waitForTimeout(3000);
  return page.evaluate(() => {
    const canvas = document.querySelector(
      'flt-glass-pane, canvas, flutter-view, flt-scene-host',
    );
    const bodyText = document.body?.innerText || '';
    const hasFlutterLoader = Boolean(
      document.querySelector('script[src*="flutter"]') ||
        document.querySelector('flutter-view') ||
        canvas,
    );
    return {
      ok: Boolean(canvas) || bodyText.includes('SotongFinance') || bodyText.length > 40,
      hasCanvas: Boolean(canvas),
      hasFlutterLoader,
      textSampleLen: bodyText.length,
    };
  });
}

async function checkOverflow(page) {
  return page.evaluate(() => {
    const doc = document.documentElement;
    const body = document.body;
    const scrollWidth = Math.max(doc.scrollWidth, body.scrollWidth);
    const overflowX = scrollWidth > Math.ceil(window.innerWidth) + 2;
    return {
      overflowX,
      scrollWidth,
      innerWidth: window.innerWidth,
      scrollHeight: Math.max(doc.scrollHeight, body.scrollHeight),
    };
  });
}

async function run() {
  const browser = await chromium.launch({ headless: true });
  const summary = {
    base: BASE,
    viewports: {},
    routes: {},
    issues: [],
    limitations: [
      'Flutter Canvas: 드로어 자동닫힘·AppBar 높이·터치 48px·결과복사 UI는 시맨틱 DOM으로 완전 검증 불가 → UNVERIFIED',
    ],
  };

  for (const vp of VIEWPORTS) {
    const context = await browser.newContext({
      viewport: { width: vp.width, height: vp.height },
    });
    const page = await context.newPage();
    const pageErrors = [];
    page.on('pageerror', (err) => pageErrors.push(String(err.message || err)));

    const vpResult = { routes: {}, pageErrors: [], flutter: false, overflowX: false };
    for (const route of ROUTES) {
      const url = BASE + route;
      const entry = { route, http: null, flutter: false, overflowX: false, notes: [] };
      try {
        const resp = await page.goto(url, {
          waitUntil: 'domcontentloaded',
          timeout: 90000,
        });
        entry.http = resp ? resp.status() : null;
        const fl = await waitFlutter(page);
        entry.flutter = fl.ok;
        entry.flutterDetail = fl;
        const ov = await checkOverflow(page);
        entry.overflowX = ov.overflowX;
        entry.scroll = ov;
        if (entry.http !== 200) entry.notes.push('HTTP_NOT_200');
        if (!entry.flutter) entry.notes.push('FLUTTER_NOT_CONFIRMED');
        if (entry.overflowX) entry.notes.push('OVERFLOW_X');
        if (isMobile(vp) && route === '/') {
          entry.notes.push('DRAWER_AUTO_CLOSE=UNVERIFIED_CANVAS');
          entry.notes.push('APPBAR_HEIGHT=UNVERIFIED_CANVAS');
          entry.notes.push('TOUCH_TARGET_48=UNVERIFIED_CANVAS');
        }
        if (route.startsWith('/tools/')) {
          entry.notes.push('CALC_INPUT_COPY=UNVERIFIED_CANVAS');
        }
        if (route === '/search') {
          entry.notes.push('SEARCH_FILTER=UNVERIFIED_CANVAS');
        }
      } catch (e) {
        entry.notes.push(`ERROR:${e.message}`);
        summary.issues.push(`${vp.name} ${route}: ${e.message}`);
      }
      vpResult.routes[route] = entry;
      if (entry.flutter) vpResult.flutter = true;
      if (entry.overflowX) vpResult.overflowX = true;
    }
    vpResult.pageErrors = pageErrors;
    if (pageErrors.length) {
      summary.issues.push(`${vp.name} pageerror count=${pageErrors.length}`);
    }
    summary.viewports[vp.name] = vpResult;
    await context.close();
  }

  for (const route of ROUTES) {
    const r = summary.viewports['1920x1080']?.routes?.[route];
    summary.routes[route] = {
      http: r?.http ?? null,
      flutter: r?.flutter ?? false,
      overflowX: r?.overflowX ?? null,
    };
  }

  const outPath = path.join(__dirname, 'responsive-report.json');
  fs.writeFileSync(outPath, JSON.stringify(summary, null, 2));
  console.log('REPORT_WRITTEN=' + outPath);
  console.log('ISSUE_COUNT=' + summary.issues.length);
  const failHttp = Object.values(summary.routes).filter((r) => r.http !== 200).length;
  const failFlutter = Object.values(summary.routes).filter((r) => !r.flutter).length;
  console.log('HTTP_FAIL_ROUTES=' + failHttp);
  console.log('FLUTTER_FAIL_ROUTES=' + failFlutter);
  await browser.close();
  process.exit(failHttp > 0 ? 1 : 0);
}

run().catch((e) => {
  console.error('FATAL=' + e.message);
  process.exit(2);
});
