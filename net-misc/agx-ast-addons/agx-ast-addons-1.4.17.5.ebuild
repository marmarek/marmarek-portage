# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

DESCRIPTION="Maintained version of old asterisk 1.2 applications now ported to 1.4"
HOMEPAGE="http://sourceforge.net/projects/agx-ast-addons/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=media-libs/spandsp-0.0.4_pre15
	=net-misc/asterisk-1.4*
	>=media-libs/tiff-3.8"

S="${WORKDIR}/${PN}"

#src_compile() {
#	cmake "." -DCMAKE_INSTALL_PREFIX=/usr
#	emake || die "emake failed"
#}

#src_install() {
#	einstall || die "einstall failed"
#}
