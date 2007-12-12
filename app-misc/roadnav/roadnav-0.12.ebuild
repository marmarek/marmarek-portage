# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Roadnav is an in-car navigation system"
HOMEPAGE="http://roadnav.sourceforge.net/"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gps"

DEPEND="=app-misc/libroadnav-$PVR
		gps? (sci-geosciences/gpsd)"
RDEPEND="${DEPEND}"

src_install() {
	mkdir -p ${D}/usr/share/pixmaps
	mkdir -p ${D}/usr/share/applications
	make DESTDIR=${D} install || die "install failed"
	prepall || die "prepall failed"
}
