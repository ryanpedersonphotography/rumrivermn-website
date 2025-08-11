const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  // Set viewport
  await page.setViewport({ width: 1920, height: 1080 });
  
  console.log('Loading page...');
  await page.goto('https://689a6b09c619e06344706dfc--rumriverold.netlify.app/joshua-and-teri/index.html', {
    waitUntil: 'networkidle2',
    timeout: 30000
  });
  
  // Wait a bit for lazy loading
  await page.waitForTimeout(3000);
  
  // Scroll to trigger lazy loading
  await page.evaluate(() => {
    window.scrollTo(0, document.body.scrollHeight);
  });
  
  await page.waitForTimeout(2000);
  
  // Check image sizes and containers
  const imageInfo = await page.evaluate(() => {
    const images = document.querySelectorAll('.the_list_item_image img');
    const containers = document.querySelectorAll('.the_list_item_image');
    const listBlocks = document.querySelectorAll('.list_block');
    
    const results = {
      totalImages: images.length,
      imagesInfo: [],
      containerInfo: [],
      listBlockClasses: [],
      cssRules: []
    };
    
    // Get info about list blocks
    listBlocks.forEach(block => {
      results.listBlockClasses.push(block.className);
    });
    
    // Get info about images
    images.forEach((img, index) => {
      const rect = img.getBoundingClientRect();
      const computedStyle = window.getComputedStyle(img);
      results.imagesInfo.push({
        index: index,
        src: img.src,
        naturalWidth: img.naturalWidth,
        naturalHeight: img.naturalHeight,
        displayWidth: rect.width,
        displayHeight: rect.height,
        className: img.className,
        style: img.getAttribute('style'),
        computedWidth: computedStyle.width,
        computedHeight: computedStyle.height,
        objectFit: computedStyle.objectFit,
        position: computedStyle.position
      });
    });
    
    // Get info about containers
    containers.forEach((container, index) => {
      const rect = container.getBoundingClientRect();
      const computedStyle = window.getComputedStyle(container);
      results.containerInfo.push({
        index: index,
        width: rect.width,
        height: rect.height,
        overflow: computedStyle.overflow,
        position: computedStyle.position,
        paddingBottom: computedStyle.paddingBottom
      });
    });
    
    // Check if gallery-fix.css is loaded
    const stylesheets = Array.from(document.styleSheets);
    const galleryFixLoaded = stylesheets.some(sheet => {
      try {
        return sheet.href && sheet.href.includes('gallery-fix.css');
      } catch(e) {
        return false;
      }
    });
    
    results.galleryFixCSSLoaded = galleryFixLoaded;
    
    return results;
  });
  
  console.log('\n=== Gallery Analysis ===');
  console.log('Gallery Fix CSS Loaded:', imageInfo.galleryFixCSSLoaded);
  console.log('Total Images Found:', imageInfo.totalImages);
  console.log('\nList Block Classes:');
  imageInfo.listBlockClasses.forEach(classes => {
    console.log('  -', classes);
  });
  
  console.log('\n=== First 3 Images ===');
  imageInfo.imagesInfo.slice(0, 3).forEach(img => {
    console.log(`\nImage ${img.index}:`);
    console.log('  Natural size:', img.naturalWidth, 'x', img.naturalHeight);
    console.log('  Display size:', Math.round(img.displayWidth), 'x', Math.round(img.displayHeight));
    console.log('  Computed size:', img.computedWidth, 'x', img.computedHeight);
    console.log('  Classes:', img.className);
    console.log('  Position:', img.position);
    console.log('  Object-fit:', img.objectFit);
  });
  
  console.log('\n=== First 3 Containers ===');
  imageInfo.containerInfo.slice(0, 3).forEach(container => {
    console.log(`\nContainer ${container.index}:`);
    console.log('  Size:', Math.round(container.width), 'x', Math.round(container.height));
    console.log('  Overflow:', container.overflow);
    console.log('  Position:', container.position);
    console.log('  Padding-bottom:', container.paddingBottom);
  });
  
  // Take a screenshot
  await page.screenshot({ 
    path: 'gallery-check.png',
    fullPage: false
  });
  console.log('\nScreenshot saved as gallery-check.png');
  
  await browser.close();
})();