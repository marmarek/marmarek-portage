# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Linux server application to capture live video and audio and stream
it over an IP network"
HOMEPAGE="http://www.litech.org/spook/"
SRC_URI="http://www.litech.org/spook/dist/spook-20050207.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	prepall
}
