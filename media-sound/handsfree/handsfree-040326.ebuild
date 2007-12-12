# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Handsfree driver for BlueZ"
HOMEPAGE="http://www.soft.uni-linz.ac.at/~vogl/bluez/"
SRC_URI="http://www.soft.uni-linz.ac.at/~vogl/bluez/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	export S=${WORKDIR}/${PN}
	cd ${S}
	emake || die "emake failed"
}

src_install() {
	export S=${WORKDIR}/${PN}
	dobin ${S}/handsfree
}

