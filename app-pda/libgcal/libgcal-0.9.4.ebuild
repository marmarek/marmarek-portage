# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Library that does allow communication with google calendar and
contacts"
HOMEPAGE="http://code.google.com/p/libgcal/"
SRC_URI="http://libgcal.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	einstall || die "einstall failed"
}
