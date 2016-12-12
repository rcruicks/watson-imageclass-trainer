##------------------------------
##  invoke:  Classifier-name  [curl|echo]
##  e.g.:  train.sh Tops curl
## batch size should be 2+ -- need full-plan to update existing trainer
##------------------------------

bsz=50  ## batch size - number of class files to feed into a training cycle
exec=${2:-echo}  ## command to run  -- curl to execute, echo to test

url="https://watson-api-explorer.mybluemix.net/visual-recognition/api/v3/classifiers"
key="api_key=?????????????????????????????"  ## from bluemix service credentials
ver="version=2016-05-19"

cmd="-X POST"
name="-F name=$1"   ## Classifier name for initial training cycle
classifier=""
file=""
fcnt=0

for i in ${1}*.zip
do
 x=${i#${1}-}  ## remove leading Classifier name from zip-name
 y=${x%.zip}   ## remove file-type extension
 z=${y//-/}    ## remove illegal class-name characters

 ## build list of training zps for curl POST
 files="${files} -F ${z}_positive_examples=@$i"
 fcnt=$(( fcnt + 1 ))

 echo $fcnt $bsz $i

 if [ $fcnt -ge ${bsz} ]; then
	train="$exec $cmd $files ${name} ${url}${classifier}?${key}&${ver}"
	echo ${train}
  ## run command and capture response JSON
	p=`${train}`
echo ${p}
  ## first-time through, capture classifier_id to pass to subsequent cycles
	if [ -z ${classifier} ]; then
		q=${p#*:}   ## remove leading header -- assumes first tag is for classifier_id
		r=${q%%,*}  ## drop everything past classifier name
		s=${r//\"/} ## remove quotes
		t=${s// /}  ## trim
		classifier="/${t}"
echo $classifier
		name=""     ## don't pass classifier name for subsequent cycles - use classifier_id
	fi
	fcnt=0
	files=""
 fi
done
## remaining files in last batch
if [ ${#files} -gt 0 ] ; then
	train="$exec $cmd $files ${name} ${url}${classifier}${key}${ver}"
	echo ${train}
	${train}
fi
