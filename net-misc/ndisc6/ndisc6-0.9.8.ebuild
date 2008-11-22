# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NDisc6 is a small collection of useful tools for IPv6 networking"
HOMEPAGE="http://www.remlab.net/ndisc6/"
SRC_URI="http://www.remlab.net/files/ndisc6/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dosbin rdnssd/rdnssd
	doman doc/*.{1,8}
	cd ${S}/src
	dosbin ndisc6 rdisc6 || die "sbin failed"
	dobin tracert6 tcptraceroute6 tcpspray rltraceroute6 || die "bin failed"
	dobin addr2name dnssort name2addr || die "misc bin failed"

}
