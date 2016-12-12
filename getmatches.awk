## generate subset list of image-URLs from untagged list
BEGIN { FS="\t" }
{if ($5 == "") {print $4}}
