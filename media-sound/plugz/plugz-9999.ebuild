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
RDEPEND="media-sound/sbc"

ECVS_SERVER="bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa"
ECVS_MODULE="plugz"
ECVS_BRANCH="plugz_0"

S="${WORKDIR}/${PN}"

src_compile() {
	cd ${S} || die
	eautoreconf || die
	econf || die 
	echo '#define NDEBUG 1' >> config.h
	emake || die
}

src_install() {
	einstall || die
}
