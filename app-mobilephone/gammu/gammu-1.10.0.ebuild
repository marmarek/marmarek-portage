# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.09.00.ebuild,v 1.3 2007/01/14 15:00:12 mrness Exp $

inherit eutils

MY_MAJOR_VER=${PV:0:3}

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="http://dl.cihar.com/gammu/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~x86"
IUSE="debug bluetooth irda mysql"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-sim_backup.patch"
}

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	use bluetooth && myconf="${myconf} --with-bluedir=/usr/lib" \
		|| myconf="${myconf} --disable-bluetooth"
	use mysql || myconf="${myconf} --disable-mysql"
	use irda || myconf="${myconf} --disable-irda"
	econf \
		--prefix=/usr \
		--enable-cb \
		--enable-7110incoming \
		${myconf} || die "configure failed"

	emake shared || die "make failed"
}

src_install () {
	make DESTDIR="${D}" installshared || die "install failed"
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}"
}
