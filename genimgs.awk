## retrieve images by URL to local folder - use record-id as name
## assumes all URLs retrieve jpegs -- prob need mime-type check
## if $5 is blank (no tags) don't pull image

BEGIN {
		FS="\t";
	}
$5 != "" {
		cmd = "curl --fail --output " $1 ".jpg " $4;
		system(cmd)
	}
