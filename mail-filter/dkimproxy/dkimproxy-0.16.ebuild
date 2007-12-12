# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="SMTP proxy that sign and/or verifies emails using Mail::DKIM"
HOMEPAGE="http://jason.long.name/dkimproxy/"
SRC_URI="http://jason.long.name/dkimproxy/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/Crypt-OpenSSL-RSA
		dev-perl/Digest-SHA
		dev-perl/Digest-SHA1
		dev-perl/Error
		dev-perl/Email-Address
		perl-core/MIME-Base64
		dev-perl/Net-DNS"
RDEPEND=""

src_compile() {
	econf || die
	emake || die

	sed -i -e 's:#!/usr/bin/perl -I../lib:#!/usr/bin/perl:' \
		scripts/*

}

src_install() {
	cd ${S}
	
	for f in dkim_responder.pl dkimsign.pl dkimverify.pl; do
		dobin scripts/$f
	done

	for f in dkimproxy.in dkimproxy.out; do
		dosbin scripts/$f
	done

	insinto /usr/lib/perl5/site_perl
	doins lib/MySmtpServer.pm lib/MySmtpProxyServer.pm
	insinto /usr/lib/perl5/site_perl/MSDW/SMTP
	doins lib/MSDW/SMTP/Client.pm lib/MSDW/SMTP/Server.pm

	newinitd ${FILESDIR}/dkimproxy.out.init dkimproxy.out
	newinitd ${FILESDIR}/dkimproxy.in.init dkimproxy.in
	newconfd ${FILESDIR}/dkimproxy.out.conf dkimproxy.out
	newconfd ${FILESDIR}/dkimproxy.in.conf dkimproxy.in
}

pkg_postinst() {
	enewuser dkfilter 28
	einfo "Now you must generate key for signing mails"
	einfo "  openssl genrsa -out private.key 1024"
	einfo "  openssl rsa -in private.key -out public.key"
	einfo ""
	einfo "And store public key in dns: "
	einfo "  selector._domainkey IN TXT \"k=rsa; p=......; t=y\""
}
