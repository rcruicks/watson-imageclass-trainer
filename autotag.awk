## pass a list of image URLs for tagging
NR < 10 {
		a="./autotag.sh " $1 " curl";
		system(a);
	}
