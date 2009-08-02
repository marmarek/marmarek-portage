# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/media-plugins/gst-plugins-speex/Attic/gst-plugins-speex-0.8.12.ebuild,v 1.2 2007/09/29 11:14:41 drac dead $

inherit gst-plugins

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"

IUSE=""
RDEPEND=">=media-libs/speex-1.1.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
