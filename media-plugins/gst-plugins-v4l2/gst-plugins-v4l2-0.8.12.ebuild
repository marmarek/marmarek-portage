# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/media-plugins/gst-plugins-v4l2/Attic/gst-plugins-v4l2-0.8.12.ebuild,v 1.5 2007/09/29 11:09:37 drac dead $

inherit gst-plugins

DESCRIPION="plugin to allow capture from video4linux2 devices"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="x11-libs/libXv
	>=sys-kernel/linux-headers-2.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
