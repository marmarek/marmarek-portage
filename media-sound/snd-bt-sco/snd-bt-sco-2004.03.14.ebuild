# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Bluetooth alsa headset driver"
HOMEPAGE="http://www.dcs.gla.ac.uk/~jp/snd-bt-sco"
SRC_URI="http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/${P//./-}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd ../${PN}*
	export S=${PWD}
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
