# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A Car Navigation System for Linux and UNIX"
HOMEPAGE="http://roadmap.digitalomaha.net/"
SRC_URI="http://roadmap.digitalomaha.net/roadmap/${P//[.-]/_}_src.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt gtk gtk2"

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${S}/src
	if use qt; then
		MK_OPTS="qt"
	fi
	if use gtk; then
		MK_OPTS="gtk"
	fi
	if use gtk2; then
		MK_OPTS="gtk2"
	fi
	sed -e 's/GUICFLAGS=/GUICFLAGS=-I\/usr\/qt\/3\/include /' -i.bak qt/Makefile
	sed -e 's/GUILDFLAGS=/GUILDFLAGS=-L\/usr\/qt\/3\/lib /' -i.bak qt/Makefile
	emake  || die "emake failed"
}
									  

src_install() {
	cd ${S}/src
	make INSTALLDIR=/usr DESTDIR=${D} install || die "einstall failed"
	prepall || die "prepall failed"
}
