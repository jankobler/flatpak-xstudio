# flatpak-xstudio

Build **xstudio** https://github.com/AcademySoftwareFoundation/xstudio  as flatpak application.

## Flatpak Manifest

The flatpak manifest is the file io.aswf.xstudio.yml

Manifests are described on the page https://docs.flatpak.org/en/latest/manifests.html

The build process for the xstudio flatpak application is based on the xstudio build guides 
in the folder https://github.com/AcademySoftwareFoundation/xstudio/tree/main/docs/build_guides

In order to build the flatpak application successfully some changes have been necessary in the software packages:

* pybind11
* pystring
* OpenColorIO
* xstudio

The intention was to build it at first, with a minimum of source code changes.


## Flatpak Bundle

The resulting flatpak application has been released as flatpak single-file bundle, which can be installed and started using the flatpak tool.

Bundles are described on the page https://docs.flatpak.org/en/latest/single-file-bundles.html

When the xstudio application is started 
* the The GUI of xstudio should appear and
* the Dialog Help -> About can be displayed.

No further tests have been made with the xstudio flatpak application.

## Install Flatpak Tools

You need to install the tools.

* flatpak
* flatpak-builder


 On ubuntu-22.04 install them by the commands:

```bash
apt-get install flatpak
apt-get install flatpak-builder
```

Flatpak Command Reference:      https://docs.flatpak.org/en/latest/flatpak-command-reference.html

Flatpak Builder Command Reference:      https://docs.flatpak.org/en/latest/flatpak-builder-command-reference.html


The build process of xstudio needs the **bzip2** tool. Install it, if it is not yet installed. On ubuntu-22.04 install it by the command:

```bash
apt-get install bzip2
```

To use the Makefile you need the **make** tool. Install it, if it is not yet installed. On ubuntu-22.04 install it by the command:

```bash
apt-get install make
```

## Makefile

The file Makefile contains a lot of useful make targets, predefined macros and commands.

Show the make targets and the predefined macros

```bash
make help
```

Show the commands to build the flatpak application

```bash
make -n flatpak-all-01-build
```

Show  the commands to install the released flatpak single-file bundle

```bash
make -n flatpak-all-02-bundle
```

You should be able to use the makefile without any changes to the predefined paths.
But if necessary adjust the paths in the makefile.

Show links to useful docs

```bash
make doc-01
```


## Build the flatpak application

You can try to build the flatpak application for the first time just by calling

```bash
make flatpak-all-01-build
```

If any problem occurs you have to look into the makefile and call the missing make targets separately.

If you want to build the flatpak application again, you have to look into the makefile and call the appropriate make targets separately.

## Install the flatpak single-file bundle

Instead of building the flatpak application on your machine, you can try to install the flatpak single-file bundle, which has been released, just by calling

```bash
make flatpak-all-02-bundle
```

If any problem occurs you have to look into the makefile and call the missing make targets separately.

## Flatpak Infos

Further infos about **flatpak**:

* home page https://www.flatpak.org/
* Docs https://docs.flatpak.org/en/latest/index.html

