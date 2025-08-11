/* Placeholder for theme-min.js */
/* Main theme JavaScript */

jQuery(document).ready(function($) {
    // Basic theme initialization
    console.log('Beacon theme initialized');
    
    // Handle lazy loading
    $('.beacon-lazy-load').each(function() {
        var $img = $(this);
        var src = $img.data('lazy-load-img-src') || $img.data('src');
        if (src) {
            $img.attr('src', src);
        }
    });
});