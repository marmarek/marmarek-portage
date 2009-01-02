# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="uShare is a UPnP (TM) A/V & DLNA Media Server"
HOMEPAGE="http://ushare.geexbox.org/"
SRC_URI="http://ushare.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dlna"

DEPEND="dev-util/pkgconfig "
RDEPEND="net-libs/libupnp >=media-libs/libdlna-0.2.1"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-libavcodec.patch
}

src_compile() {
	cd ${S}
	LD_FLAGS=-lavcodec ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		$(use_enable dlna) \
		|| die "configure failed"
	emake -j1 || die "emake failed"
}


src_install() {
	einstall DESTDIR=${D} || die "einstall failed"
}
