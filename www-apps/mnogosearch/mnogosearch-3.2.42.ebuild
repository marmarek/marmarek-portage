# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic autotools

DESCRIPTION="mnoGoSearch^tm web search engine software"
HOMEPAGE="http://www.mnogosearch.org/"
SRC_URI="http://www.mnogosearch.org/Download/${P}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE="postgres mysql zlib"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-paths.patch
	AT_M4DIR=build/m4
	eautoreconf
}


src_compile() {
	MY_CONF="--prefix=/usr 
		--host=${CHOST}" 
	MY_CONF="${MY_CONF} --mandir=/usr/share/man"
	MY_CONF="${MY_CONF} --infodir=/usr/share/info"
	MY_CONF="${MY_CONF} --sysconfdir=/etc/mnogosearch"
	MY_CONF="${MY_CONF} --localstatedir=/var/lib"
	MY_CONF="${MY_CONF} --build=${CHOST}"
#	MY_CONF="${MY_CONF} --datadir=/usr/share/mnogosearch"
	MY_CONF="${MY_CONF} $(use_with postgres pgsql) 
		$(use_with zlib) 
		$(use_with mysql)"
	einfo ./configure $MY_CONF
	./configure $MY_CONF || die "econf failed"
	emake
}

src_install() {
	make install DESTDIR=${D} || die "einstall failed"
}
