i18n_all: i18n_po i18n_mo

# make messages of python file and django template file to django.po
i18n_po:
	python manage.py makemessages -d django -l en -e html,part -e py
	python manage.py makemessages -d django -l zh_Hans -e html,part -e py

# compile django.po and djangojs.po to django.mo and djangojs.mo
i18n_mo:
	python manage.py compilemessages

# 虽然使用了poetry，但是由于蓝鲸Smart应用还是依赖requirements，所以需要导出
export_requirements:
	poetry export -f requirements.txt --output requirements.txt --without-hashes
	poetry export --dev -f requirements.txt --output requirements_dev.txt --without-hashes

release:
	cd ../frontend  &&\
	npm install  &&\
	yarn run build:ce &&\
	cd ../saas  &&\
	rm -Rf /opt/bk_iam &&\
	mkdir -p /opt/bk_iam &&\
	cp -Rf ../saas /opt/bk_iam/src &&\
	mkdir -p /opt/bk_iam/pkgs &&\
	pip3 download -r ./requirements.txt -i https://mirrors.cloud.tencent.com/pypi/simple -d  /opt/bk_iam/pkgs  &&\
	pip3 download cffi==1.14.6  -i https://mirrors.cloud.tencent.com/pypi/simple -d /opt/bk_iam/pkgs  &&\
	pip3 download idna==2.1  -i https://mirrors.cloud.tencent.com/pypi/simple -d /opt/bk_iam/pkgs  &&\
	pip3 download pycparser==2.2  -i https://mirrors.cloud.tencent.com/pypi/simple -d /opt/bk_iam/pkgs  &&\
	mkdir -p /opt/bk_iam/src/staticfiles &&\
	cp -Rf ../frontend/dist/static /opt/bk_iam/src/staticfiles/  &&\
	cp -Rf ../frontend/dist/*.html /opt/bk_iam/src/resources/templates/ &&\
	cp -Rf ./app.yml /opt/bk_iam/  &&\
	cp -Rf ./resources/bk_iam.png /opt/bk_iam/ &&\
	cd /opt  &&\
	tar -zcvf bk_iam_V1.8.24-bkofficial.tar.gz bk_iam/
