# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3
inherit eutils

DESCRIPTION="Daemon for file scanning for samba"
HOMEPAGE="http://olivier.sessink.nl/scannedonly/"
SRC_URI="http://olivier.sessink.nl/scannedonly/${PF}.tar.bz2"

LICENSE="gpl-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=net-fs/samba-3.5.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fileopen.patch"
}

src_configure() {
	econf
	emake || die "Emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Emake install failed"
}
