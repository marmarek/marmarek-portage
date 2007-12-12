# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cvs autotools

DESCRIPTION="bluetooth-alsa"
HOMEPAGE="http://bluetooth-alsa.sourceforge.net/"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

ECVS_SERVER="sbc.cvs.sourceforge.net:/cvsroot/sbc"
ECVS_MODULE="sbc"

S="${WORKDIR}/${PN}"

src_compile() {
	cd ${S} || die
	eautoreconf || die
	econf || die 
	emake || die
}

src_install() {
	einstall || die
}
