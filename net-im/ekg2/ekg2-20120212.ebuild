# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg2/ekg2-20061202.ebuild,v 1.6 2007/01/09 21:09:02 swegener Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils perl-module autotools

DESCRIPTION="Text based Instant Messenger and IRC client that supports protocols like Jabber and Gadu-Gadu"
HOMEPAGE="http://www.ekg2.org/"
SRC_URI="http://pl.ekg2.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="gpm jabber ssl spell jpeg gpg gsm python unicode sqlite sqlite3 gif nogg
gtk perl xosd debug expat static"

DEPEND="jabber? ( >=dev-libs/expat-1.95.6 )
	expat? ( >=dev-libs/expat-1.95.6 )
	gpm? ( >=sys-libs/gpm-1.20.1 )
	ssl? ( >=dev-libs/openssl-0.9.6m \
		jabber? ( >=net-libs/gnutls-1.0.17 ) )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	spell? ( >=app-text/aspell-0.50.5 )
	!nogg? ( >=net-libs/libgadu-1.7.0 )
	gpg? ( app-crypt/gnupg )
	gsm? ( >=media-sound/gsm-1.0.10 )
	python? ( >=dev-lang/python-2.3.3 )
	perl? ( >=dev-lang/perl-5.2 )
	sqlite? ( !sqlite3? ( =dev-db/sqlite-2* ) )
	sqlite3? ( >=dev-db/sqlite-3 )
	gif? ( media-libs/giflib )
	gtk? ( >=x11-libs/gtk+-2.4 )
	xosd? ( x11-libs/xosd )
	virtual/libintl"

pkg_setup() {
	if use unicode && ! built_with_use sys-libs/ncurses unicode; then
		eerror "Ekg2 requires ncurses built with unicode support for unicode"
		die
	fi
}

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Ekg2 has no debug configure option
	# Instead it features a runtime option which defaults to on
	#! use debug && epatch ${FILESDIR}/${PN}-20061202-no-default-debug.patch

	epatch ${FILESDIR}/ekg2-sim-cp1250.patch

	# disable icq plugin - poor code quality
	sed -i -e 's# plugins/icq/Makefile##;s#icq ##' configure.ac

	NOCONFIGURE=yes ./autogen.sh
}

src_compile() {

	econf \
		--with-pthread \
		`use_with !nogg libgadu` \
		`use_with expat` \
		`use_with jabber expat` \
		`use_with gpm gpm-mouse` \
		`use_with ssl openssl` \
		`use_with jpeg libjpeg` \
		`use_with spell aspell` \
		`use_with gsm libgsm` \
		`use_with gif libgif` \
		`use_with xosd libxosd` \
		`use_with python` \
		`use_with gpg` \
		`use_with perl` \
		`use_with sqlite` \
		`use_with sqlite3` \
		`use_enable unicode` \
		`use_enable static` \
		`use jabber && use ssl && echo --with-gnutls` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Install plugins into proper directory
	if use amd64; then
		CONF_LIBDIR=$(getlib)/lib/ekg2/plugins
	fi

	# einstall messes up perl
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc docs/*

	use perl && fixlocalpod
}

pkg_postinst() {
	if use gtk; then
		ewarn "Ekg2 GTK2 frontend is highly experimental."
		ewarn "Please do not file bugs about it."
	fi

	use perl && updatepod
}
