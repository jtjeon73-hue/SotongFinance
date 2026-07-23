/**
 * Responsive E2E checks for SotongFinance production site.
 * Never logs secrets. Outputs JSON summary only.
 */
const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

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
];

function isMobile(vp) {
  return vp.width < 900;
}

async function waitFlutter(page) {
  // Flutter web paints to canvas/flt-glass-pane
  await page.waitForTimeout(2500);
  const hasFlutter = await page.evaluate(() => {
    const canvas = document.querySelector('flt-glass-pane, canvas, flutter-view');
    const bodyText = document.body?.innerText || '';
    return Boolean(canvas) || bodyText.includes('SotongFinance') || bodyText.length > 20;
  });
  return hasFlutter;
}

async function checkOverflow(page) {
  return page.evaluate(() => {
    const doc = document.documentElement;
    const body = document.body;
    const overflowX = Math.max(doc.scrollWidth, body.scrollWidth) > Math.ceil(window.innerWidth) + 1;
    return {
      overflowX,
      scrollWidth: Math.max(doc.scrollWidth, body.scrollWidth),
      innerWidth: window.innerWidth,
      scrollHeight: Math.max(doc.scrollHeight, body.scrollHeight),
    };
  });
}

async function run() {
  const browser = await chromium.launch({ headless: true });
  const summary = { base: BASE, viewports: {}, routes: {}, issues: [], limitations: [] };
  summary.limitations.push(
    'Flutter Canvas/DOM shadow: 일부 터치영역·드로어 내부 텍스트는 시맨틱 DOM으로 완전 검증 불가',
  );

  for (const vp of VIEWPORTS) {
    const context = await browser.newContext({
      viewport: { width: vp.width, height: vp.height },
    });
    const page = await context.newPage();
    const pageErrors = [];
    page.on('pageerror', (err) => pageErrors.push(String(err)));

    const vpResult = { routes: {}, pageErrors: [], flutter: false, overflowX: false };
    for (const route of ROUTES) {
      const url = BASE + route;
      const entry = { route, http: null, flutter: false, overflowX: false, notes: [] };
      try {
        const resp = await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
        entry.http = resp ? resp.status() : null;
        entry.flutter = await waitFlutter(page);
        const ov = await checkOverflow(page);
        entry.overflowX = ov.overflowX;
        entry.scroll = ov;
        if (entry.http !== 200) entry.notes.push('HTTP_NOT_200');
        if (!entry.flutter) entry.notes.push('FLUTTER_NOT_CONFIRMED');
        if (entry.overflowX) entry.notes.push('OVERFLOW_X');

        if (isMobile(vp) && route === '/') {
          // Try open drawer via aria / role / flutter semantics if present
          const opened = await page.evaluate(() => {
            const buttons = Array.from(document.querySelectorAll('button, [role="button"], flt-semantics'));
            return buttons.length;
          });
          entry.notes.push(`MOBILE_INTERACTIVE_CANDIDATES=${opened}`);
          entry.notes.push('DRAWER_AUTO_CLOSE=UNVERIFIED_CANVAS');
          entry.notes.push('APPBAR_HEIGHT=UNVERIFIED_CANVAS');
        }

        if (route === '/tools/compound-interest') {
          entry.notes.push('CALCULATOR_INPUT=UNVERIFIED_CANVAS_OR_PARTIAL');
        }
        if (route === '/search') {
          entry.notes.push('SEARCH_FILTER=UNVERIFIED_CANVAS_OR_PARTIAL');
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

  // Aggregate route HTTP across largest desktop
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
  console.log('HTTP_FAIL_ROUTES=' + failHttp);
  await browser.close();
  process.exit(failHttp > 0 ? 1 : 0);
}

run().catch((e) => {
  console.error('FATAL=' + e.message);
  process.exit(2);
});
