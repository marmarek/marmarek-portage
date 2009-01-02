# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="libdlna aims at being the reference open-source implementation of
DLNA (Digital Living Network Alliance) standards"
HOMEPAGE="http://libdlna.geexbox.org/"
SRC_URI="http://libdlna.geexbox.org/releases/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e \
		's#ffmpeg/avformat.h#libavformat/avformat.h#g;
		s#ffmpeg/avcodec.h#libavcodec/avcodec.h#g' configure src/*
	}

src_compile() {
	cd ${S}
	./configure \
		--prefix=/usr \
		--enable-shared \
		|| die "configure failed"
	emake -j1 || die "emake failed"
}
	


src_install() {
	dolib src/libdlna.so.0.2.3 src/libdlna.a

	insinto /usr/lib/pkgconfig
	doins libdlna.pc

	insinto /usr/include
	doins src/dlna.h

	dodoc README ChangeLog AUTHORS
}
