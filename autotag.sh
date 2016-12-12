##  pass image URL to custom classifier
## invoke: image-url [curl|echo]

exec=${2:-echo}
img=$1
classifier="classifier_ids=Tops_1360136519"

url="https://watson-api-explorer.mybluemix.net/visual-recognition/api/v3/classify"
key="api_key=?????????????????????"  ## from bluemix service credentials
ver="version=2016-05-19"

cmd="-X GET"

train="$exec $cmd $files ${name} ${url}?${key}&${ver}&${classifier}&url=${img}"
echo ${train}
p=`${train}`
echo ${p}
