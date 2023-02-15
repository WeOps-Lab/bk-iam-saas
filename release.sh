RELEASE_PATH=/opt/release/bk_iam
rm -Rf $RELEASE_PATH
mkdir -p $RELEASE_PATH

cd ./frontend
npm install
npm run build:ee

cd ..
cp ./saas/resources/bk_iam.png $RELEASE_PATH/logo.png
cp ./saas/resources/app.yml $RELEASE_PATH

cp -Rf ./saas $RELEASE_PATH
mkdir -p $RELEASE_PATH/saas/staticfiles
cp -Rf ./frontend/dist/static/* $RELEASE_PATH/saas/staticfiles/

cp -Rf ./frontend/dist/index.html $RELEASE_PATH/saas/resources/templates
cp -Rf ./frontend/dist/login_success.html $RELEASE_PATH/saas/resources/templates

sed -i "s/https:\/\/bk.tencent.com\/docs\//https:\/\/bk.tencent.com\/docs\/markdown/" $RELEASE_PATH/saas/resources/templates/index.html

# 改名
cd $RELEASE_PATH
mv saas src

mkdir ./pkgs
virtualenv venv -p python3
./venv/bin/pip3 install setuptools==57.5.0
./venv/bin/pip3 download -r ./src/requirements.txt --dest ./pkgs
rm -Rf ./venv