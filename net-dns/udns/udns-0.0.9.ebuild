# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A stub DNS resolver library with ability to perform both syncronous
and asyncronous DNS queries."
HOMEPAGE="http://www.corpit.ru/mjt/udns.html"
SRC_URI="http://www.corpit.ru/mjt/udns/${P/-/_}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="ipv6"

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${S}

	./configure $(use_enable ipv6) || die "configure failed"
	emake staticlib sharedlib rblcheck_s dnsget_s || die "emake failed"

	mv -f dnsget_s dnsget
	mv -f rblcheck_s rblcheck
	mv -f libudns_s.so libudns.so
}

src_install() {
	dolib libudns.so.0
	dolib libudns.a
	insinto /usr/include
	doins udns.h
	doman udns.3
	dodoc TODO NOTES
	dodoc ex-rdns.c
	dobin dnsget rblcheck
	doman dnsget.1 rblcheck.1
}
