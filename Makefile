RELEASE_PATH=/opt/release/bk_iam
VENV_PATH=/tmp/venv
release:
	rm -Rf $(RELEASE_PATH)
	mkdir -p $(RELEASE_PATH)

	cd ./frontend  && npm install  && npm run build:ce

	cp ./saas/resources/bk_iam.png $(RELEASE_PATH)/logo.png
	cp ./saas/app.yml $(RELEASE_PATH)

	cp -Rf ./saas $(RELEASE_PATH)
	mkdir -p $(RELEASE_PATH)/saas/staticfiles
	cp -Rf ./frontend/dist/static/* $(RELEASE_PATH)/saas/staticfiles/

	cp -Rf ./frontend/dist/index.html $(RELEASE_PATH)/saas/resources/templates
	cp -Rf ./frontend/dist/login_success.html $(RELEASE_PATH)/saas/resources/templates

	sed -i "s/https:\/\/bk.tencent.com\/docs\//https:\/\/bk.tencent.com\/docs\/markdown/" $(RELEASE_PATH)/saas/resources/templates/index.html

	mv $(RELEASE_PATH)/saas $(RELEASE_PATH)/src

	mkdir $(RELEASE_PATH)/pkgs
	virtualenv $(VENV_PATH) -p python3
	$(VENV_PATH)/bin/pip3 install setuptools==57.5.0
	$(VENV_PATH)/bin/pip3 download -r $(RELEASE_PATH)/src/requirements.txt --dest $(RELEASE_PATH)/pkgs
	rm -Rf $(VENV_PATH)