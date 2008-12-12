# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Flash for Linux - SQF editor"
HOMEPAGE="http://f4l.sourceforge.net"
SRC_URI="mirror://sourceforge/f4l/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/qt"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's#/usr/share/qt3/mkspecs/default/qmake.conf#/usr/qt/3/mkspecs/linux-g++/qmake.conf#' -i Makefile
}


src_compile() {

emake || die "emake failed"
}

src_install() {
cd ${S}
dobin bin/f4l
dodoc bin/deneme.swf
prepall
}
