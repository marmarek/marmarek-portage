# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Nagios Check SNMP Plugins"
HOMEPAGE="http://www.nagiosexchange.org/"
SRC_URI="file://${P}.tar.gz"

RESTRICT="fetch"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-analyzer/nagios"
RDEPEND="net-analyzer/nagios"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd src
	exeinto /usr/nagios/libexec 
	doexe check_snmp_disk check_snmp_process check_snmp_load || die
}
