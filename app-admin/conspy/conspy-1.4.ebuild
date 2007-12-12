# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Conspy allows a user to see what is displayed on a Linux virtual console, and to send keystrokes to it"
HOMEPAGE="http://www.stuart.id.au/russell/files/conspy/"
SRC_URI="http://www.stuart.id.au/russell/files/conspy/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}
src_install() {
	einstall || die "einstall failed"
}
