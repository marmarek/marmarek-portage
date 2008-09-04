# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Alpine is a fast, easy to use email client that is suitable for
both the inexperienced email user as well as for the most demanding of power
users."
HOMEPAGE="http://www.washington.edu/alpine/"
SRC_URI="ftp://ftp.cac.washington.edu/alpine/alpine.tar.bz2
	http://staff.washington.edu/chappa/alpine/patches/alpine-2.00/maildir.patch.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="ldap kerberos ssl smime maildir"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}
	!mail-client/pine"

src_unpack() {
	unpack "alpine.tar.bz2"

	cd ${S}

	if use maildir; then
		epatch "${DISTDIR}/maildir.patch.gz" || die "patch failed"
	fi

}

src_compile() {
	econf \
		--with-system-pinerc=/etc/pine.conf \
		--with-system-fixed-pinerc=/etc/pine.conf.fixed \
		$(use_with ldap) \
		$(use_with kerberos krb5) \
		$(use_with ssl) \
		$(use_with smime) || die "econf failed."
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	ln -s alpine ${D}/usr/bin/pine
	ln -s alpine.1 ${D}/usr/share/man/man1/pine.1
}

