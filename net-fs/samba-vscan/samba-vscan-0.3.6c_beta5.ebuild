# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="On-access virus scanning with Samba"
HOMEPAGE="http://www.openantivirus.org/projects.php#samba-vscan"
SRC_URI="http://www.openantivirus.org/download/${P/_/-}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P/_/-}"
