# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/media-plugins/gst-plugins-raw1394/Attic/gst-plugins-raw1394-0.8.12.ebuild,v 1.2 2007/09/29 11:17:13 drac dead $

inherit gst-plugins

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DESCRIPTION="GStreamer plugin to capture firewire video"

IUSE=""
RDEPEND="sys-libs/libraw1394
	sys-libs/libavc1394"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
