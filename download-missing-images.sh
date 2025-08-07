#\!/bin/bash

echo "Downloading missing images for anthony-and-linnea gallery..."

# Missing images from anthony-and-linnea
images=(
"files/2014/05/LCB_6592-2.jpg"
"files/2014/05/LCB_6592.jpg"
"files/2014/05/LCB_6613-2.jpg"
"files/2014/05/LCB_6613.jpg"
"files/2014/05/LCB_6621.jpg"
"files/2014/05/LCB_6649-2.jpg"
"files/2014/05/LCB_6649.jpg"
"files/2014/05/LCB_6652.jpg"
"files/2014/05/LCB_6661.jpg"
"files/2014/05/LCB_6697.jpg"
"files/2014/05/LCB_6705.jpg"
"files/2014/05/LCB_6710.jpg"
"files/2014/05/LCB_6715.jpg"
"files/2014/05/LCB_6725.jpg"
"files/2014/05/LCB_6726.jpg"
"files/2014/05/LCB_6728.jpg"
"files/2014/05/LCB_6733-2.jpg"
"files/2014/05/LCB_6737-2.jpg"
"files/2014/05/vineyards.jpg"
"files/2014/05/LB1_6430-2.jpg"
"files/2014/05/LB1_7342-2.jpg"
"files/2014/05/LB1_7349.jpg"
"files/2014/05/LB2_6412.jpg"
"files/2014/05/LB2_6424.jpg"
"files/2014/05/LB2_6440.jpg"
"files/2014/05/LB2_6449.jpg"
"files/2014/05/LB2_6454.jpg"
)

for img in "${images[@]}"; do
  if [ \! -f "$img" ]; then
    echo "Downloading $img..."
    dir=$(dirname "$img")
    mkdir -p "$dir"
    curl -s -L "https://rumrivermn.com/$img" -o "$img" || echo "Failed: $img"
  fi
done

echo "Done\!"
