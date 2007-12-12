# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="FDMF - find duplicate music files"
HOMEPAGE="http://www.w140.com/audio/"
SRC_URI="http://www.w140.com/audio/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sci-libs/fftw-3
		sys-libs/gdbm
		media-sound/mpg321
		dev-lang/perl
		media-libs/plotutils"
DEPEND="${RDEPEND}"

src_install() {
	dobin cleanup_dups 
	dobin fdmf 
	dobin fdmf_bench 
	dobin optparam 
	dobin sonic_reducer 
	dobin vector_pairs

	dodoc CHANGES COPYING INSTALL README
}
