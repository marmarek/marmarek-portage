# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod

DESCRIPTION="ACPI kernel driver to support hot-swapping of common 'bay' type
peripherals on laptops"
HOMEPAGE="http://sourceforge.net/projects/lths"
SRC_URI="mirror://sourceforge/lths/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

	BUILD_TARGETS="clean default"
	MODULE_NAMES="lt_hotswap()"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -ie 's/linux\/config.h/linux\/autoconf.h/' lt_hotswap.c

}
