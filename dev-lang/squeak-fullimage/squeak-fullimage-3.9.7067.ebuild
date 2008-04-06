# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-fullimage/squeak-fullimage-3.8.6665.ebuild,v 1.3 2007/02/06 09:05:08 genone Exp $

MY_P="Squeak3.9-final-7067"
DESCRIPTION="Squeak full image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://ftp.squeak.org/current_stable/${MY_P}.zip
		http://ftp.squeak.org/current_stable/SqueakV39.sources.gz"

LICENSE="Apple"
SLOT="3.8"
KEYWORDS="~x86"
IUSE=""
PROVIDE="virtual/squeak-image"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	einfo "Compressing image/changes files."
	gzip ${MY_P}.image
	gzip ${MY_P}.changes
	einfo "done."
}

src_install() {
	einfo 'Installing Image/Sources/Changes files.'
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	# install full image and changes file.
	doins ${MY_P}.image.gz
	doins ${MY_P}.changes.gz
	# install sources
	doins SqueakV39.sources
	# create symlinks to the changes and image files.
	dosym /usr/lib/squeak/${MY_P}.changes.gz \
		/usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/${MY_P}.image.gz \
		/usr/lib/squeak/squeak.image.gz
}

pkg_postinst() {
	elog "Squeak ${PV} image, changes and sources files installed in /usr/lib/squeak"
}
