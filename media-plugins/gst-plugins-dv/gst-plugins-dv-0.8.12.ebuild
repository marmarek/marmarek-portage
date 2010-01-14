# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/media-plugins/gst-plugins-dv/Attic/gst-plugins-dv-0.8.12.ebuild,v 1.2 2007/09/29 10:48:52 drac dead $

inherit gst-plugins

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

GST_PLUGINS_BUILD="libdv"
DESCRIPTION="GStreamer plugin to decode DV"

IUSE=""
RDEPEND=">=media-libs/libdv-0.100"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"