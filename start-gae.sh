#!/bin/sh -x

readonly C9D=$HOME/workspace/.c9
readonly GAE=$C9D/go_appengine

readonly VER="go_appengine_sdk_linux_amd64-1.9.30.zip"
readonly SDK="https://storage.googleapis.com/appengine-sdks/featured/${VER}"

#
# Download SDK
#
cd $C9D && wget $SDK && unzip -q $VER
export PATH=$GAE:$PATH

#
# Build goenv
#
export GOENVTARGET=$GAE
cd $C9D && curl -L https://bitbucket.org/ymotongpoo/goenv/raw/master/shellscripts/fast-install.sh | sh

#
# Create Project
#
if [ $# -eq 1 ]; then
   project=$1
else
   project="sample"
fi

cd $HOME/workspace
goenv -gae -go $GAE/goroot -deps $GAE/gopath $project

readonly ORG_PATH='"$GOBIN":"$GOROOT/bin":$_OLD_PATH'
echo "export PATH=${GAE}:${ORG_PATH}" >> $project/activate

# git add . && git commit -m "Add generated files for GAE." && git push
# cd $project && goapp serve -host 0.0.0.0 sample/src/app.yaml

exit