# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librpcsecgss/librpcsecgss-0.19-r1.ebuild,v 1.1 2010/07/27 10:02:30 flameeyes Exp $

EAPI=2

inherit eutils flag-o-matic multilib autotools

DESCRIPTION="implementation of rpcsec_gss (RFC 2203) for secure rpc communication"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="|| ( net-libs/libgssglue >=app-crypt/heimdal-1.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/librpcsecgss-0.18-heimdal.patch
	eautoreconf
}

src_configure() {
	# No need to install static libraries, as it uses non-static dependencies
	econf --disable-static
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${D}" -name '*.la' -delete || die

	dodoc AUTHORS ChangeLog NEWS README
}
