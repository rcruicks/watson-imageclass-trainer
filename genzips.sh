## invoke:  Classifier-name
##  e.g.  Tops  (with only one classifier, just leave blank, that works too)
##
## imgmin - minimum number of images per class training set
## imgmax - maximum number of images per class training set - 10-500
##
##  looks for Classifier-name prefixed directories
##   creates zip for each directory, ensuring min/max sizes
##
##  assumes all images are jpegs -- need more work to support png


imgmin=10
zipmin=$(( $imgmin + 5 ))
imgmax=40

for i in $( ls $1 )
do
if [ -d $i ]  ## directories only
then
	echo "Zipping" $i
	## assumes all image links in the /pos subdir
	ls $i/pos/*.jpg | awk -v max=$imgmax '{if ( NR < max) print}' > ${i}.inc
	fcnt=`cat ${i}.inc | wc -l`
	if [ ${fcnt} -gt $imgmin ] ; then
		zip -q ${i}.zip -@ < ${i}.inc
		fcnt=`unzip -l ${i}.zip | wc -l`
		if [ ${fcnt} -lt  $zipmin ]; then
			rm ${i}.zip
		else
			echo $i $fcnt
		fi
	fi
fi
done
