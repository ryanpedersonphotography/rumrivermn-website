#!/usr/bin/env node

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function checkSiteCSS() {
  console.log('🔍 Checking CSS loading on rumrivermn.com...\n');
  
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  
  try {
    const page = await browser.newPage();
    
    // Set viewport
    await page.setViewport({ width: 1280, height: 800 });
    
    // Track CSS resources
    const cssFiles = [];
    const failedResources = [];
    
    // Monitor network requests
    page.on('response', response => {
      const url = response.url();
      const status = response.status();
      
      if (url.includes('.css')) {
        cssFiles.push({
          url: url,
          status: status,
          ok: status >= 200 && status < 400
        });
        
        if (status >= 400) {
          failedResources.push({
            url: url,
            status: status,
            type: 'CSS'
          });
        }
      }
    });
    
    page.on('requestfailed', request => {
      if (request.url().includes('.css')) {
        failedResources.push({
          url: request.url(),
          error: request.failure().errorText,
          type: 'CSS'
        });
      }
    });
    
    console.log('📱 Loading homepage...');
    const startTime = Date.now();
    
    try {
      await page.goto('https://rumrivermn.com', {
        waitUntil: 'networkidle2',
        timeout: 30000
      });
    } catch (error) {
      console.log('⚠️ Page load timeout or error:', error.message);
    }
    
    const loadTime = Date.now() - startTime;
    console.log(`⏱️ Page loaded in ${loadTime}ms\n`);
    
    // Take screenshot
    const screenshotPath = 'homepage-screenshot.png';
    await page.screenshot({ 
      path: screenshotPath,
      fullPage: false 
    });
    console.log(`📸 Screenshot saved: ${screenshotPath}\n`);
    
    // Check for CSS files
    console.log('📋 CSS Files Loaded:');
    console.log('-------------------');
    
    if (cssFiles.length === 0) {
      console.log('❌ No CSS files were loaded!');
    } else {
      cssFiles.forEach(css => {
        const status = css.ok ? '✅' : '❌';
        console.log(`${status} [${css.status}] ${css.url.substring(0, 100)}...`);
      });
    }
    
    // Check for failed resources
    if (failedResources.length > 0) {
      console.log('\n⚠️ Failed Resources:');
      console.log('-------------------');
      failedResources.forEach(resource => {
        console.log(`❌ ${resource.type}: ${resource.url}`);
        if (resource.status) console.log(`   Status: ${resource.status}`);
        if (resource.error) console.log(`   Error: ${resource.error}`);
      });
    }
    
    // Check if specific CSS files are applied
    console.log('\n🎨 Checking CSS Application:');
    console.log('----------------------------');
    
    // Check for beacon theme
    const beaconThemeLoaded = await page.evaluate(() => {
      const links = document.querySelectorAll('link[rel="stylesheet"]');
      return Array.from(links).some(link => 
        link.href.includes('beacon-theme') || link.href.includes('cms_custom_css')
      );
    });
    
    console.log(beaconThemeLoaded ? '✅ Theme CSS is linked' : '❌ Theme CSS not found');
    
    // Check computed styles on key elements
    const styles = await page.evaluate(() => {
      const results = {};
      
      // Check header
      const header = document.querySelector('#the_header');
      if (header) {
        const headerStyle = window.getComputedStyle(header);
        results.header = {
          background: headerStyle.backgroundColor,
          display: headerStyle.display,
          hasStyles: headerStyle.backgroundColor !== 'rgba(0, 0, 0, 0)'
        };
      }
      
      // Check body
      const bodyStyle = window.getComputedStyle(document.body);
      results.body = {
        fontFamily: bodyStyle.fontFamily,
        backgroundColor: bodyStyle.backgroundColor,
        color: bodyStyle.color
      };
      
      // Check for form styles
      const form = document.querySelector('.gform_wrapper');
      if (form) {
        const formStyle = window.getComputedStyle(form);
        results.form = {
          display: formStyle.display,
          hasStyles: formStyle.display !== 'none'
        };
      }
      
      return results;
    });
    
    console.log('\n📊 Computed Styles Check:');
    console.log('------------------------');
    console.log('Body:');
    console.log(`  Font: ${styles.body.fontFamily}`);
    console.log(`  Background: ${styles.body.backgroundColor}`);
    console.log(`  Text Color: ${styles.body.color}`);
    
    if (styles.header) {
      console.log('Header:');
      console.log(`  Background: ${styles.header.background}`);
      console.log(`  Has Styles: ${styles.header.hasStyles ? '✅' : '❌'}`);
    }
    
    if (styles.form) {
      console.log('Forms:');
      console.log(`  Display: ${styles.form.display}`);
      console.log(`  Has Styles: ${styles.form.hasStyles ? '✅' : '❌'}`);
    }
    
    // Check other pages
    console.log('\n📄 Checking Other Pages:');
    console.log('------------------------');
    
    const pagesToCheck = [
      '/contact-us.html',
      '/schedule-a-tour.html',
      '/the-property.html'
    ];
    
    for (const pagePath of pagesToCheck) {
      try {
        await page.goto(`https://rumrivermn.com${pagePath}`, {
          waitUntil: 'networkidle2',
          timeout: 10000
        });
        
        const hasCSS = await page.evaluate(() => {
          const links = document.querySelectorAll('link[rel="stylesheet"]');
          return links.length > 0;
        });
        
        console.log(`${hasCSS ? '✅' : '❌'} ${pagePath}: CSS ${hasCSS ? 'loaded' : 'missing'}`);
        
      } catch (error) {
        console.log(`⚠️ ${pagePath}: Failed to load (${error.message})`);
      }
    }
    
    // DNS and CDN propagation check
    console.log('\n🌐 DNS/CDN Status:');
    console.log('------------------');
    console.log('During DNS propagation, you may experience:');
    console.log('• Intermittent CSS loading issues');
    console.log('• Mixed content from old/new servers');
    console.log('• Temporary 404s for some resources');
    console.log('• Cache inconsistencies');
    console.log('\nThis is NORMAL and should resolve within 24-48 hours.');
    
    // Summary
    console.log('\n📋 SUMMARY:');
    console.log('===========');
    
    if (failedResources.length === 0 && cssFiles.length > 0) {
      console.log('✅ CSS is loading properly');
    } else if (cssFiles.length === 0) {
      console.log('❌ No CSS files loaded - major issue');
    } else if (failedResources.length > 0) {
      console.log('⚠️ Some CSS resources failed to load');
      console.log('   This may be due to DNS propagation');
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await browser.close();
  }
}

// Run the check
checkSiteCSS().catch(console.error);