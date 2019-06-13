
if [ $# -lt 1 ]; then
        echo "usage: $0 <project_root_dir>"
        exit -1
fi

project_root_dir=$1
mkdir -p $project_root_dir
cd $project_root_dir

### mh yocto fsl3.14
#Essential Yocto Project host packages:
install_pkgs()
{
	sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
	build-essential chrpath socat \
	libsdl1.2-dev xterm sed cvs subversion coreutils texi2html \
	docbook-utils python-pysqlite2 help2man make gcc g++ desktop-file-utils \
	libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff curl lzop asciidoc \
	-y

	#i.MX layers host packages for a Ubuntu 12.04 host setup only:
	#$ sudo apt-get install uboot-mkimage
	#i.MX layers host packages for a Ubuntu 14.04 host setup only:
	sudo apt-get install u-boot-tools -y
}
install_pkgs

###To install the “repo” utility, perform these steps:
#1. Create a bin folder in the home directory.
#2. Add the following line to the .bashrc file to ensure that the ~/bin folder is in your PATH variable.
fetch_repo()
{
	mkdir ~/bin #(this step may not be needed if the bin folder already exists)
	curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	chmod a+x ~/bin/repo
	export PATH=~/bin:$PATH
}
fetch_repo

###Yocto Project Setup
init_repo()
{
	git config --global user.name "oucaijun"
	git config --global user.email "oucaijun.happy@163.com"
	git config --list
	repo init -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-3.14.28-1.0.0_ga
	##Enable color display in this user account (y/N)? y
}
init_repo

sync_repo()
{
	repo sync
}

sync_repo

