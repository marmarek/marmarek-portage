# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Library for roadnav"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.6.1"
RDEPEND="${DEPEND}"

src_compile() {
	econf --with-wx-config=/usr/bin/wx-config-2.6 || die "econf failed"
	emake || die "emake failed"
	}

src_install() {
	einstall
	prepall
}
