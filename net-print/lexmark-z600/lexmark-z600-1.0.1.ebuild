# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# this ebuild can be named:
# /usr/portage/net-print/lexmark-z35/lexmark-z35-2.0.1.ebuild
# /usr/portage/net-print/lexmark-z55/lexmark-z55-1.0.1.ebuild
# /usr/portage/net-print/lexmark-z65/lexmark-z65-1.0.1.ebuild
# /usr/portage/net-print/lexmark-z600/lexmark-z600-1.0.1.ebuild

inherit versionator rpm multilib

ZX=${PN/lexmark-z/Z}
MY_PV=$(replace_version_separator 2 -)
[ ${ZX} = "Z600" ] && gz="gz" || gz="GZ"

DESCRIPTION="${ZX} CUPS Printer Driver"
HOMEPAGE="http://downloads.lexmark.com/"
SRC_URI="http://www.downloaddelivery.com/srfilecache/CJL${ZX}LE-CUPS-${MY_PV}.TAR.${gz}"
RESTRICT="mirror"

LICENSE="Lexmark"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="net-print/cups
    virtual/ghostscript
    =virtual/libstdc++-3.3"

S=${WORKDIR}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	tar -xzf ${DISTDIR}/${A} || die "unpack failed"
	if [ -d CJLZ*LE-CUPS-* ]; then
	    mv CJLZ*LE-CUPS-*/* .
	fi
	tail -n +143 *.gz.sh | tar --wildcards -xzf - '*.rpm'

	for f in *.rpm; do
	    rpm_unpack $f
	done

	gunzip usr/share/cups/model/*.ppd.gz

	chmod 755 usr/local/z*llpddk
	chmod 755 usr/local/z*llpddk/utility
	chmod 755 usr/include/lexmark
	chmod 644 usr/include/lexmark/*.h
	chmod 644 usr/share/cups/model/*.ppd
}

src_compile() {
	einfo "This is a binary package"
}

src_install() {
	mv usr ${D}/ || die "could not move /usr"

	dodoc COPYING README
}

pkg_postinst() {
	einfo ""
	einfo "For installing a printer:"
	einfo " * Restart CUPS: /etc/init.d/cupsd restart"
	einfo " * Go to http://127.0.0.1:631/"
	einfo "   -> Printers -> Add Printer"
	einfo ""
	einfo "In case of trouble, check"
	einfo "  http://gentoo-wiki.com/Lexmark_Printers"
	einfo ""
}

# 
