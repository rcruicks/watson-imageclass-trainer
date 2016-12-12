## training sequence:

gawk -f genimgs.awk taglist.tab
gawk -f gentags.awk taglist.tab
./genzips.sh Tops
./train.sh Tops curl
gawk -f getmatches.awk taglist.tab > chklist.tab
gawk -f autotag.awk chklist.tab > autotag.json
