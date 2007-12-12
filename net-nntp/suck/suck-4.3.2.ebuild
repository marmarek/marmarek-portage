# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/suck/suck-4.3.2.ebuild,v 1.1 2005/01/17 20:17:31 swegener Exp $

DESCRIPTION="Grab news from a remote NNTP server and feed them to another"
HOMEPAGE="http://home.comcast.net/~bobyetman/"
SRC_URI="http://home.comcast.net/~bobyetman/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="ssl perl"

DEPEND="sys-libs/db
	perl? ( sys-devel/libperl )
	ssl? ( dev-libs/openssl )"

LDFLAGS="$LDFLAGS -L/usr/lib/news/lib"
CFLAGS="$LDFLAGS -I/usr/lib/news/include -DNO_CONFIGDATA"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix paths to the locations in Gentoo
	sed -i \
		-e 's:/usr/lib/news/rnews:/usr/lib/news/bin/rnews:' \
		-e 's:/usr/news/db/history:/var/spool/news/db/history:' \
		suck_config.h
	sed -i -e 's/<config.h>/"config.h"/' *.c *.h */*.c
}

src_compile() {
	use ssl || sed -i -e 's/^SSL_/#SSL_/' Makefile.in
	use perl || sed -i -e 's/^PERL_/#PERL_/' Makefile.in

	econf || die "econf failed"

	emake phrases.h || die "emake phrases.h failed"
	emake all lpost || die "emake failed"
}

src_install() {
	dobin lmove lpost rpost suck testhost
	doman man/*
	dodoc CHANGELOG CONTENTS README*
	docinto java
	dodoc java/*
	docinto perl
	dodoc perl/*
	docinto sample
	dodoc sample/*
}
