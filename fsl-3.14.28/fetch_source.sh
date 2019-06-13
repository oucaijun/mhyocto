

if [ $# -lt 1 ]; then
	echo "usage: $0 <project_root_dir>"
	exit -1
fi

project_root_dir=$1
mkdir -p $project_root_dir
cd $project_root_dir

#source setup-environment
#MACHINE=<machine name> source fsl-setup-release.sh -b <build dir> -e <backend>

if [ -e build-x11 ]; then
	. setup-environment build-x11
else
	MACHINE=imx6solosabresd source fsl-setup-release.sh -b build-x11 -e x11
fi

set_conf()
{
	#echo "UBOOT_CONFIG = \"emmc\"" >> conf/local.conf
	echo "GLIBC_GENERATE_LOCALES = \"en_GB.UTF-8 en_US.UTF-8 zh_CN.UTF-8\"" >> conf/local.conf
	echo "IMAGE_LINGUAS = \"en-gb en-us zh-cn\"" >> conf/local.conf
	echo "IMAGE_INSTALL_APPEND = \" cmake autoconf automake  ccache chkconfig protobuf boost curl c-ares expect lighttpd \"" >> conf/local.conf
	echo "SDKIMAGE_FEATURES_append = \"staticdev-pkgs\"" >> conf/local.conf
}

bitbake fsl-image-qt5 
bitbake fsl-image-qt5 -c populate_sdk


