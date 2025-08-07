#!/bin/bash

echo "Creating directories for wedding gallery images..."
mkdir -p files/2014/{04,05}
mkdir -p files/2015/{03,06,12}
mkdir -p files/2016/01
mkdir -p files/2017/{06,08}
mkdir -p files/2020/10
mkdir -p wp-content/blogs.dir/5794/files/2017/08
mkdir -p wp-content/blogs.dir/30705/files/2018/03

echo "Downloading wedding gallery images..."

# Function to download with retry
download_image() {
    local url=$1
    local output=$2
    echo "Downloading: $output"
    wget -q --no-check-certificate "$url" -O "$output" || echo "Failed: $output"
}

# Joshua and Teri Gallery
download_image "https://rumrivermn.com/files/2014/04/Kliewer-6226667.jpg" "files/2014/04/Kliewer-6226667.jpg"
download_image "https://rumrivermn.com/files/2014/04/Kliewer-6226667-1.jpg" "files/2014/04/Kliewer-6226667-1.jpg"
download_image "https://rumrivermn.com/files/2014/04/Kliewer-6227075.jpg" "files/2014/04/Kliewer-6227075.jpg"
download_image "https://rumrivermn.com/files/2014/04/Kliewer-6227225.jpg" "files/2014/04/Kliewer-6227225.jpg"
download_image "https://rumrivermn.com/files/2014/04/Kliewer-6227270.jpg" "files/2014/04/Kliewer-6227270.jpg"

# Casey and Garret Gallery
download_image "https://rumrivermn.com/files/2015/12/2.jpg" "files/2015/12/2.jpg"
download_image "https://rumrivermn.com/files/2015/12/3.jpg" "files/2015/12/3.jpg"
download_image "https://rumrivermn.com/files/2015/12/4.jpg" "files/2015/12/4.jpg"
download_image "https://rumrivermn.com/files/2015/12/5.jpg" "files/2015/12/5.jpg"
download_image "https://rumrivermn.com/files/2015/12/6.jpg" "files/2015/12/6.jpg"
download_image "https://rumrivermn.com/files/2015/12/7.jpg" "files/2015/12/7.jpg"

# Allison and Will Gallery
download_image "https://rumrivermn.com/files/2014/05/6lv2R9KqOr5T8Fpw-9U8rYtPJA1X2DNeIpVVJbT7NtE.jpg" "files/2014/05/6lv2R9KqOr5T8Fpw-9U8rYtPJA1X2DNeIpVVJbT7NtE.jpg"
download_image "https://rumrivermn.com/files/2014/05/dsRoPx0RtUzzhx0F9RWKe4XBoz04Xm1E2e0aj2j3zPs.jpg" "files/2014/05/dsRoPx0RtUzzhx0F9RWKe4XBoz04Xm1E2e0aj2j3zPs.jpg"
download_image "https://rumrivermn.com/files/2014/05/sVXDyxfSxt68XOQy6PYCGz3GaAE5a7AD5dmaR1yefLA.jpg" "files/2014/05/sVXDyxfSxt68XOQy6PYCGz3GaAE5a7AD5dmaR1yefLA.jpg"
download_image "https://rumrivermn.com/files/2014/05/xcJybCFRH0Sqx7ZShp5YHedTmaZidm90Gk28Xk5Uk7Y.jpg" "files/2014/05/xcJybCFRH0Sqx7ZShp5YHedTmaZidm90Gk28Xk5Uk7Y.jpg"
download_image "https://rumrivermn.com/files/2014/05/2a3TKYGNFdtpc4qhWt8JeMtC68n7ocFQQbEnMfPh9mI.jpg" "files/2014/05/2a3TKYGNFdtpc4qhWt8JeMtC68n7ocFQQbEnMfPh9mI.jpg"
download_image "https://rumrivermn.com/files/2014/05/b-tvd-vR-OBGsGbkkQvkToMD0txTBtyL813N8UOnZgc.jpg" "files/2014/05/b-tvd-vR-OBGsGbkkQvkToMD0txTBtyL813N8UOnZgc.jpg"
download_image "https://rumrivermn.com/files/2014/05/CFeixI2Hh_2Pnk-cLyoQ34_itCy5-r0QYnT1fkP2Y70.jpg" "files/2014/05/CFeixI2Hh_2Pnk-cLyoQ34_itCy5-r0QYnT1fkP2Y70.jpg"
download_image "https://rumrivermn.com/files/2014/05/TDhKqaphA29jSJ8rUxZjcGXzCwqvN3d3AfDA7cyoxtg.jpg" "files/2014/05/TDhKqaphA29jSJ8rUxZjcGXzCwqvN3d3AfDA7cyoxtg.jpg"
download_image "https://rumrivermn.com/files/2014/05/uyyKXswbLBcjBplMknGvLzQUX_VT73CkkS69V3RD3ko.jpg" "files/2014/05/uyyKXswbLBcjBplMknGvLzQUX_VT73CkkS69V3RD3ko.jpg"

# Featured Weddings thumbnails
download_image "https://rumrivermn.com/files/2020/10/107077166_309436900423851_4033228928268606074_n-1.jpg" "files/2020/10/107077166_309436900423851_4033228928268606074_n-1.jpg"
download_image "https://rumrivermn.com/files/2016/01/Rum_river_barn_MN_Wedding_Event_Venue_Premier_11.jpg" "files/2016/01/Rum_river_barn_MN_Wedding_Event_Venue_Premier_11.jpg"
download_image "https://rumrivermn.com/files/2014/04/94.jpg" "files/2014/04/94.jpg"
download_image "https://rumrivermn.com/files/2017/06/Theuerkauf-TLE-0173-7-21-12.jpg" "files/2017/06/Theuerkauf-TLE-0173-7-21-12.jpg"
download_image "https://rumrivermn.com/files/2015/06/JV5A7086.jpg" "files/2015/06/JV5A7086.jpg"
download_image "https://rumrivermn.com/files/2015/03/Sitz-Wedding.jpg" "files/2015/03/Sitz-Wedding.jpg"
download_image "https://rumrivermn.com/files/2017/08/22.jpg" "files/2017/08/22.jpg"

echo "Download complete!"