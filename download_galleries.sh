#\!/bin/bash
# Comprehensive gallery and image download script

echo 'Downloading gallery: 2014-2'
wget --no-check-certificate -O 2014-2-downloaded.html https://rumrivermn.com/2014-2/

echo 'Downloading gallery: joshua-and-teri'
wget --no-check-certificate -O joshua-and-teri-downloaded.html https://rumrivermn.com/joshua-and-teri/

echo 'Downloading gallery: allison-and-will'
wget --no-check-certificate -O allison-and-will-downloaded.html https://rumrivermn.com/allison-and-will/

echo 'Downloading gallery: anthony-and-linnea'
wget --no-check-certificate -O anthony-and-linnea-downloaded.html https://rumrivermn.com/anthony-and-linnea/

echo 'Downloading gallery: reins-wedding'
wget --no-check-certificate -O reins-wedding-downloaded.html https://rumrivermn.com/reins-wedding/

echo 'Downloading gallery: nick-and-kayla'
wget --no-check-certificate -O nick-and-kayla-downloaded.html https://rumrivermn.com/nick-and-kayla/

echo 'Downloading gallery: emily-and-barron-nixon'
wget --no-check-certificate -O emily-and-barron-nixon-downloaded.html https://rumrivermn.com/emily-and-barron-nixon/

echo 'Downloading gallery: jenna-and-steven-tschirgi'
wget --no-check-certificate -O jenna-and-steven-tschirgi-downloaded.html https://rumrivermn.com/jenna-and-steven-tschirgi/

echo 'Downloading gallery: kage'
wget --no-check-certificate -O kage-downloaded.html https://rumrivermn.com/kage/

echo 'Downloading gallery: loria-and-jason-rolstad-agape'
wget --no-check-certificate -O loria-and-jason-rolstad-agape-downloaded.html https://rumrivermn.com/loria-and-jason-rolstad-agape/

echo 'Downloading gallery: engagement'
wget --no-check-certificate -O engagement-downloaded.html https://rumrivermn.com/engagement/

echo 'Downloading gallery: senior'
wget --no-check-certificate -O senior-downloaded.html https://rumrivermn.com/senior/

echo 'Downloading gallery: mattea-courtney-photo-gallery'
wget --no-check-certificate -O mattea-courtney-photo-gallery-downloaded.html https://rumrivermn.com/mattea-courtney-photo-gallery/

echo 'Downloading gallery: casey-garret'
wget --no-check-certificate -O casey-garret-downloaded.html https://rumrivermn.com/casey-garret/

# Download images from the files directory structure
mkdir -p files/2014/04 files/2015/12 files/2016/01 files/2017/06 wp-content/blogs.dir/5794/files/2017/08

wget --no-check-certificate -P $(dirname "./files/2015/12/centralmnbride_gown_rum_barn-0040.png") https://rumrivermn.com/files/2015/12/centralmnbride_gown_rum_barn-0040.png
wget --no-check-certificate -P $(dirname "./files/2014/04/Kliewer-6226667-1-Best-100-88.jpg") https://rumrivermn.com/files/2014/04/Kliewer-6226667-1-Best-100-88.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/6lv2R9KqOr5T8Fpw-9U8rYtPJA1X2DNeIpVVJbT7NtE.jpg") https://rumrivermn.com/files/2014/04/6lv2R9KqOr5T8Fpw-9U8rYtPJA1X2DNeIpVVJbT7NtE.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/LB1_6983.jpg") https://rumrivermn.com/files/2014/04/LB1_6983.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/Reins-Wedding_4-158-2.jpg") https://rumrivermn.com/files/2014/04/Reins-Wedding_4-158-2.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/IMG_0353.jpg") https://rumrivermn.com/files/2014/04/IMG_0353.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/IMG_8376.jpg") https://rumrivermn.com/files/2014/04/IMG_8376.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/544891_10200893595083623_1517515594_n.jpg") https://rumrivermn.com/files/2014/04/544891_10200893595083623_1517515594_n.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/Kage0213.jpg") https://rumrivermn.com/files/2014/04/Kage0213.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/Loria-Jason-wedding-2-0026.jpg") https://rumrivermn.com/files/2014/04/Loria-Jason-wedding-2-0026.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/GyyM3E4OvpDA3NFV1xT4o-P6aFTqpbdbMJatL5km6FgDD3zkKlXtlvS2J_iLrkARn3wmYp1kLA5Rt7T-mP-9vg.jpg") https://rumrivermn.com/files/2014/04/GyyM3E4OvpDA3NFV1xT4o-P6aFTqpbdbMJatL5km6FgDD3zkKlXtlvS2J_iLrkARn3wmYp1kLA5Rt7T-mP-9vg.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/pNnjyotrDkm48N3Gf1PvlEHyZKlvUgciU5IQIlN3o6U5_tBnd1o1ZagutwzdFaKEMDqTZ5KTxz7xV-veAteQio.jpg") https://rumrivermn.com/files/2014/04/pNnjyotrDkm48N3Gf1PvlEHyZKlvUgciU5IQIlN3o6U5_tBnd1o1ZagutwzdFaKEMDqTZ5KTxz7xV-veAteQio.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/Studio220_2015_0203.jpg") https://rumrivermn.com/files/2014/04/Studio220_2015_0203.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/35.jpg") https://rumrivermn.com/files/2014/04/35.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/8-13-726.png") https://rumrivermn.com/files/2014/04/8-13-726.png
wget --no-check-certificate -P $(dirname "./files/2014/04/19055531_10154372718686116_3135018614407032156_o.jpg") https://rumrivermn.com/files/2014/04/19055531_10154372718686116_3135018614407032156_o.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/rum-river.jpg") https://rumrivermn.com/files/2014/04/rum-river.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/allen-2e.jpg") https://rumrivermn.com/files/2014/04/allen-2e.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/wedding-32.jpg") https://rumrivermn.com/files/2014/04/wedding-32.jpg
wget --no-check-certificate -P $(dirname "./wp-content/blogs.dir/5794/files/2017/08/k9-1e4.png") https://rumrivermn.com/wp-content/blogs.dir/5794/files/2017/08/k9-1e4.png
wget --no-check-certificate -P $(dirname "./files/2014/04/rumriverbarn-couple.jpg") https://rumrivermn.com/files/2014/04/rumriverbarn-couple.jpg
wget --no-check-certificate -P $(dirname "./files/2014/04/d14.jpg") https://rumrivermn.com/files/2014/04/d14.jpg
