
if [ $# -lt 1 ]; then
        echo "usage: $0 <project_root_dir>"
        exit -1
fi

project_root_dir=$1
mkdir -p $project_root_dir
cd $project_root_dir

pre()
{
	sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
	build-essential chrpath socat  -y

	sudo apt-get install libsdl1.2-dev xterm sed cvs subversion coreutils texi2html \
	docbook-utils python-pysqlite2 help2man make gcc g++ desktop-file-utils \
	libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff curl lzop asciidoc -y

	sudo apt-get install u-boot-tools -y
}

##curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo


init_repo()
{
	mkdir ~/qh
        curl "https://mirrors.tuna.tsinghua.edu.cn/git/git-repo" > ~/qh/repo  && chmod a+x ~/qh/repo
#	curl "http://PHP.webtutor.pl/en/wp-content/uploads/2011/09/repo" > ~/bin/repo  && chmod a+x ~/bin/repo 
	
	git config --global user.name "ocj"
	git config --global user.email "oucaijun.happy@163.com"
	git config --list
	~/qh/repo init -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-3.14.28-1.0.0_ga --repo-url='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'
	~/qh/repo sync
}

pre
init_repo

