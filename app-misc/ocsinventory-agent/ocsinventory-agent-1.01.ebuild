# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="OCS inventory Linux agent"
HOMEPAGE="http://www.ocsinventory-ng.org/"
SRC_URI="mirror://sourceforge/ocsinventory/OCSNG_LINUX_AGENT_${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/dmidecode-2.2
	>=dev-perl/XML-Simple-2.12
	>=dev-perl/Compress-Zlib-1.33
	>=dev-perl/Net-IP-1.21
	>=perl-core/Digest-MD5-2.33
	>=dev-perl/Net-SSLeay-1.25"

S="${WORKDIR}/OCSNG_LINUX_AGENT_${PV}"

src_compile() {
	cd ${S}

	epatch ${FILESDIR}/${P}-download.patch
	emake ipdiscover || die

	cd Ocsinventory
	perl Makefile.PL || die
	emake || die

}

src_install() {
	cd ${S}
	dosbin ipdiscover || die
	cd Ocsinventory 
	einstall DESTDIR=${D} || die
	cd ..
#	dosbin Ocsinventory/ocsinventory-client.pl
	insinto /etc/ocsinventory-client || die
	doins ${FILESDIR}/ocsinv.conf || die
	doins ${FILESDIR}/ocsinv.adm || die
	dodir /var/log/ocsinventory-client
	dodir /etc/cron.hourly
	ln -s /usr/sbin/ocsinventory-client.pl ${D}/etc/cron.hourly/
}
