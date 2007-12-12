# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="ClamAV anti-virus scanner for Squid"
HOMEPAGE="http://www.samse.fr"
SRC_URI="http://www.samse.fr/GPL/squidclamav/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="net-proxy/squid"

src_compile() {
	cd ${WORKDIR}/${PN}
	econf || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	cd ${WORKDIR}/${PN}
	einstall || die "einstall failed"
	dodoc INSTALL README ChangeLog COPYING
	insinto /etc
	doins squidclamav.conf.dist
	dodoc clwarn.cgi*
}
