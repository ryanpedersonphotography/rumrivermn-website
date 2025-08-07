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

async function checkGallery(galleryName) {
  return new Promise((resolve) => {
    const url = `https://rumriverold.netlify.app/${galleryName}/`;
    
    https.get(url, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        // Check if page loads
        const hasContent = data.includes('beacon-lazy-load');
        const hasImages = (data.match(/data-lazy-load-img-src/g) || []).length;
        const hasPlaceholder = data.includes('lazy-load-placeholder.png');
        const hasLazyScript = data.includes('beacon-lazy-load.min.js');
        
        console.log(`\n${galleryName}:`);
        console.log(`  URL: ${url}`);
        console.log(`  Status: ${res.statusCode}`);
        console.log(`  Has lazy load class: ${hasContent}`);
        console.log(`  Image references: ${hasImages}`);
        console.log(`  Has placeholder: ${hasPlaceholder}`);
        console.log(`  Has lazy script: ${hasLazyScript}`);
        
        resolve({
          gallery: galleryName,
          status: res.statusCode,
          hasContent,
          hasImages,
          hasPlaceholder,
          hasLazyScript
        });
      });
    }).on('error', (err) => {
      console.error(`Error checking ${galleryName}:`, err.message);
      resolve({
        gallery: galleryName,
        error: err.message
      });
    });
  });
}

async function validateAll() {
  console.log('Validating all gallery pages on Netlify...\n');
  
  for (const gallery of galleries) {
    await checkGallery(gallery);
    await new Promise(resolve => setTimeout(resolve, 500)); // Small delay between requests
  }
  
  console.log('\n\nValidation complete\!');
}

validateAll();
