##

BEGIN { FS="\t"; }
NR>1 {
	if ($5 == "" ){
		print "-" $5 "-" $4;
		next
	}
	else {
	 ## generate a tag entry for each of the 3 attributes
		print NR, $4;
		tagset($3,$5,$1);
		tagset($3,$6,$1);
		tagset($3,$7,$1);
	}
}
function tagset(pfx,tag,img,		d,p,q) {
		d = gensub("[ /&]","-","g",tag);  ## remove invalid chars
		p = pfx "-" d ;
		## create directory for positive examples - brute force - ignore mkdir errors
		q = "mkdir " p " && mkdir " p "/pos"
		system(q);
		## assumes all images are jpegs -- need something more sophisticated to handle png properly
		q = "ln -s /dressipi/" img ".jpg " p "/pos/" img ".jpg"
		system(q);
		}
