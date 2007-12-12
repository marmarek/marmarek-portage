# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="NSS module for name lookups using LDAP"
HOMEPAGE="http://ch.tudelft.nl/~arthur/nss-ldapd/"
SRC_URI="http://ch.tudelft.nl/~arthur/nss-ldapd/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="net-nds/openldap
		dev-libs/cyrus-sasl"

src_compile() {
	export LDFLAGS=-lsasl2
	econf || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	mkdir -p ${D}/lib
	cp -a nss/nss_ldap.so ${D}/lib/libnss_ldap.so.2
	dosbin nslcd/nslcd
	doman man/{nss-ldapd.conf.5,nslcd.8}
	
	insinto /etc
	doins nss-ldapd.conf

	dodoc README NEWS HACKING AUTHORS ChangeLog TODO nss-ldapd.conf 

	doinitd ${FILESDIR}/nslcd

	keepdir /var/run/nslcd
}
