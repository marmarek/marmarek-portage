# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtirpc/libtirpc-0.2.1-r1.ebuild,v 1.1 2010/09/12 21:41:47 flameeyes Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Transport Independent RPC library (SunRPC replacement)"
HOMEPAGE="http://libtirpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="kerberos"

#RDEPEND="kerberos? ( net-libs/libgssglue )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fortify.patch
	epatch "${FILESDIR}"/libtirpc-0.2.1-heimdal.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable kerberos gss) --disable-static
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	insinto /etc
	newins doc/etc_netconfig netconfig || die

	# makes sure that the linking order for nfs-utils is proper, as
	# libtool would inject a libgssglue dependency in the list.
	find "${D}" -name '*.la' -delete
}
