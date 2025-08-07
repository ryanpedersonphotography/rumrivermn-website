const https = require('https');

const galleries = [
  'kristine-leuze-rum-river',
  'kyle-carrie', 
  'mattea-courtney-photo-gallery',
  'senior',
  'engagement',
  'loria-and-jason-rolstad-agape',
  'kage',
  'jenna-and-steven-tschirgi',
  'emily-and-barron-nixon',
  'nick-and-kayla',
  'reins-wedding',
  'anthony-and-linnea'
];

async function fetchPage(url) {
  return new Promise((resolve) => {
    https.get(url, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        resolve({ status: res.statusCode, data });
      });
    }).on('error', (err) => {
      resolve({ error: err.message });
    });
  });
}

async function checkGallery(galleryName) {
  const url = `https://rumriverold.netlify.app/${galleryName}`;
  const result = await fetchPage(url);
  
  if (result.error) {
    console.log(`\n❌ ${galleryName}: ERROR - ${result.error}`);
    return false;
  }
  
  const data = result.data;
  
  // Extract image URLs (handle both single and double quotes)
  const imageMatches = data.match(/data-lazy-load-img-src=['"]([^'"]+)['"]/g) || [];
  const imageUrls = imageMatches.map(m => m.replace(/data-lazy-load-img-src=['"](.+)['"]/, '$1'));
  
  // Check various aspects
  const hasLazyLoadClass = data.includes('beacon-lazy-load');
  const imageCount = imageUrls.length;
  const hasPlaceholder = data.includes('lazy-load-placeholder.png');
  const hasLazyScript = data.includes('beacon-lazy-load.min.js');
  
  // Check if actual images load
  let workingImages = 0;
  if (imageUrls.length > 0) {
    // Test first 3 images
    for (let i = 0; i < Math.min(3, imageUrls.length); i++) {
      let imgUrl = imageUrls[i];
      // Convert to absolute URL
      if (imgUrl.startsWith('/')) {
        imgUrl = 'https://rumriverold.netlify.app' + imgUrl;
      } else if (imgUrl.startsWith('../')) {
        imgUrl = 'https://rumriverold.netlify.app/' + imgUrl.substring(3);
      } else if (!imgUrl.startsWith('http')) {
        imgUrl = 'https://rumriverold.netlify.app/' + imgUrl;
      }
      
      const imgResult = await fetchPage(imgUrl);
      if (imgResult.status === 200) {
        workingImages++;
      }
    }
  }
  
  const isWorking = result.status === 200 && imageCount > 0 && hasLazyScript && workingImages > 0;
  
  console.log(`\n${isWorking ? '✅' : '❌'} ${galleryName}:`);
  console.log(`  Status: ${result.status}`);
  console.log(`  Images found: ${imageCount}`);
  console.log(`  Sample images working: ${workingImages}/3`);
  console.log(`  Has lazy script: ${hasLazyScript}`);
  
  if (!isWorking) {
    if (imageCount === 0) console.log(`  ⚠️  No images found in HTML`);
    if (!hasLazyScript) console.log(`  ⚠️  Missing lazy load script`);
    if (workingImages === 0 && imageCount > 0) {
      console.log(`  ⚠️  Images not accessible`);
      console.log(`  Sample URL: ${imageUrls[0]}`);
    }
  }
  
  return isWorking;
}

async function validateAll() {
  console.log('Validating all gallery pages on Netlify...\n');
  console.log('Checking page load, image references, and actual image accessibility...');
  
  let workingCount = 0;
  let brokenGalleries = [];
  
  for (const gallery of galleries) {
    const isWorking = await checkGallery(gallery);
    if (isWorking) {
      workingCount++;
    } else {
      brokenGalleries.push(gallery);
    }
    await new Promise(resolve => setTimeout(resolve, 300));
  }
  
  console.log('\n' + '='.repeat(60));
  console.log(`\nSUMMARY: ${workingCount}/${galleries.length} galleries working`);
  
  if (brokenGalleries.length > 0) {
    console.log('\nBroken galleries:');
    brokenGalleries.forEach(g => console.log(`  - ${g}`));
  } else {
    console.log('\n🎉 ALL GALLERIES WORKING!');
  }
}

validateAll();