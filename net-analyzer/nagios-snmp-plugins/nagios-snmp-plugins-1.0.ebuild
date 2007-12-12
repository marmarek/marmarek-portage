# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Nagios SNMP Plugins"
HOMEPAGE="ftp://ftp.hometree.net/pub/nagios-snmp-plugins/index.html"
SRC_URI="ftp://ftp.hometree.net/pub/nagios-snmp-plugins/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-analyzer/nagios"
RDEPEND="net-analyzer/nagios"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/${P}-compilefix.patch || die
}

src_compile() {
	aclocal || die
	autoheader || die
	automake -a || die
	autoconf || die
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd src
	exeinto /usr/nagios/libexec
	doexe check_snmp_disk check_snmp_proc || die
}
