# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="An open source MSRP (Message Session Relay Protocol) library"
HOMEPAGE="http://sourceforge.net/projects/libmsrp"
SRC_URI="mirror://sourceforge/libmsrp/libmsrp-CONFIANCE-02.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/msrp-${PV}"
src_compile() {
	cd ${S}
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	dodir /usr/include /usr/lib
	einstall PREFIX=${D}/usr || die "einstall failed"
}

