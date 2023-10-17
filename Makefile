# Building xstudio with flatpak builder

DEV_01:=${HOME}/develop-01-xstudio

DOWNLOAD_01:=${DEV_01}/download-01

STATE_01:=${DEV_01}/flatpak-builder-01
APP_01:=${DEV_01}/build-01
APP_02_NAME:=xstudio

# Version of the flatpak
APP_03_VER:=v0.11.2-fp1

# location
REPO_01_DIR:=${DEV_01}/repo-01-xstudio

# name of repo when adding to flatpak
REPO_02_NAME:=repo-01

MANIFEST_02_ID:=io.aswf.xstudio
MANIFEST_01:=${MANIFEST_02_ID}.yml

BUNDLE_01_FILE:=${APP_02_NAME}-${APP_03_VER}.flatpak

BUNDLE_04_URL:=https://github.com/jankobler/flatpak-xstudio/releases/download/v0.11.2-fp1/${BUNDLE_01_FILE}
BUNDLE_05_PATH:=${DOWNLOAD_01}/${BUNDLE_01_FILE}


help: \
	help-head \
	help-target \
	help-var

PHONY: help

flatpak-build-05-repo:
	flatpak-builder --force-clean  --state-dir=${STATE_01} --repo=${REPO_01_DIR} ${APP_01} ${MANIFEST_01}

PHONY: flatpak-build-05-repo

flatpak-remotes-01:
	flatpak remotes --show-details

PHONY: flatpak-remotes-01

flatpak-remote-add-01:
	flatpak --user remote-add --no-gpg-verify ${REPO_02_NAME} ${REPO_01_DIR}

PHONY: flatpak-remote-add-01

flatpak-remote-add-02-flathub-sudo:
	@ echo "# Administrator rights are needed to add the flathub repository to system wide flatpak"
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

PHONY: flatpak-remote-add-02-flathub-sudo

flatpak-list-01:
	flatpak list

PHONY: flatpak-list-01

flatpak-install-01-sdk:
	@ echo "# Administrator rights are needed to add the necessary sdk to system wide flatpak"
	sudo flatpak install org.kde.Sdk//5.15-22.08

PHONY: flatpak-install-01-sdk

flatpak-install-02-app:
	flatpak --user install ${REPO_02_NAME} ${MANIFEST_02_ID}

PHONY: flatpak-install-02-app

flatpak-install-03-runtime:
	@ echo "# Administrator rights are needed to add the necessary runtime to system wide flatpak"
	sudo flatpak install org.kde.Platform//5.15-22.08

PHONY: flatpak-install-03-runtime

flatpak-run-01:
	flatpak run ${MANIFEST_02_ID}

PHONY: flatpak-run-01

download-bundle-01:
	mkdir -p ${DOWNLOAD_01}
	cd ${DOWNLOAD_01}; wget ${BUNDLE_04_URL}

PHONY: download-bundle-01

flatpak-install-04-bundle:
	flatpak install --user --bundle ${BUNDLE_05_PATH}

PHONY: flatpak-install-04-bundle

flatpak-all-01-build: \
	flatpak-remote-add-02-flathub-sudo \
	flatpak-install-01-sdk \
	flatpak-install-03-runtime \
	git_config_01 \
	flatpak-build-05-repo \
	flatpak-remote-add-01 \
	flatpak-install-02-app \
	flatpak-run-01

PHONY: flatpak-all-01-build

flatpak-all-02-bundle: \
	download-bundle-01 \
	flatpak-install-03-runtime \
	flatpak-install-04-bundle \
	flatpak-run-01

PHONY: flatpak-all-02-bundle

doc-01:
	@echo "Flatpak Builder Command Reference:	https://docs.flatpak.org/en/latest/flatpak-builder-command-reference.html"
	@echo "Flatpak Command Reference:	https://docs.flatpak.org/en/latest/flatpak-command-reference.html"
	@echo "Flatpak Docs: 	https://docs.flatpak.org/en/latest/index.html"
	@echo "Flatpak Quick Setup:	https://www.flatpak.org/setup/"

PHONY: doc-01

git_config_01:
	git config --global protocol.file.allow always

PHONY: git_config_01

help-head:
	@echo "Build xstudio for flatpak"
	@echo

PHONY: help-head

help-target:
	@echo "Targets all: "
	@echo
	@echo "  flatpak-all-01-build	Call all necessary make targets to build and install "
	@echo "  		the application ${APP_02_NAME} for the first time "
	@echo "  		and start it at the end"
	@echo
	@echo "  flatpak-all-02-bundle	Call all necessary make targets to downlaod a flatpak bundle"
	@echo "  		and install the application ${APP_02_NAME} "
	@echo "  		and start it at the end"
	@echo
	@echo "Targets single steps: "
	@echo
	@echo "  flatpak-build-05-repo	Build again, with downloads, install in local repo"
	@echo
	@echo "  flatpak-remotes-01	list remote flatpak repositories"
	@echo "  flatpak-remote-add-01	add the local repository to local flatpak"
	@echo "  flatpak-remote-add-02-runtime-sudo	add the flathub repository to local flatpak as administrator"
	@echo "  flatpak-remote-add-01-runtime-user	add the flathub repository  to local flatpak as user"
	@echo "  flatpak-install-01-runtime	install runtime  to local flatpak"
	@echo "  flatpak-install-02-app	install application ${APP_02_NAME} to local flatpak"
	@echo "  flatpak-run-01	start application ${APP_02_NAME}"
	@echo
	@echo "  flatpak-build-test-05	Build again, default state dir,  without downloads"
	@echo "  flatpak-build-test-06-repo	Build again, default state dir,  without downloads"
	@echo
	@echo "  doc-01	Show links to useful docs"
	@echo

PHONY: help-target

help-var:
	@echo "Variables"
	@echo "APP_01	${APP_01}"
	@echo "APP_02_NAME	${APP_02_NAME}"
	@echo "APP_03_VER	${APP_03_VER}"
	@echo "BUNDLE_01_FILE	${BUNDLE_01_FILE}"
	@echo "BUNDLE_04_URL	${BUNDLE_04_URL}"
	@echo "BUNDLE_05_PATH	${BUNDLE_05_PATH}"
	@echo "DEV_01	${DEV_01}"
	@echo "DOWNLOAD_01	${DOWNLOAD_01}"
	@echo "MANIFEST_01	${MANIFEST_01}"
	@echo "MANIFEST_02_ID	${MANIFEST_02_ID}"
	@echo "REPO_01_DIR	${REPO_01_DIR}"
	@echo "REPO_02_NAME	${REPO_02_NAME}"
	@echo "STATE_01	${STATE_01}"

PHONY: help-var

