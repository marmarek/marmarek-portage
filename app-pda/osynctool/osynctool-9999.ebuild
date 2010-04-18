# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/msynctool/msynctool-0.36.ebuild,v 1.1 2008/01/27 17:41:00 peper Exp $

inherit cmake-utils subversion

DESCRIPTION="OpenSync msync tool"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

ESVN_REPO_URI="http://svn.opensync.org/osynctool/trunk"

DEPEND="=app-pda/libopensync-${PV}*"
RDEPEND="${DEPEND}"
