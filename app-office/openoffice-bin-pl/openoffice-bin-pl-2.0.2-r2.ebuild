# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-2.0.2.ebuild,v 1.3 2006/03/16 19:43:39 wolf31o2 Exp $

inherit eutils fdo-mime rpm multilib

IUSE="gnome java"

MY_P="OOo-${PV}-1-rpm-linux-ux.pl.tar.bz2"
MY_PV="${PV}rc4"
MY_PV2="${MY_PV}_060227"
MY_PV3="${PV}-5"
MILESTONE="OOB680_m5"
PACKED="${MILESTONE}_native_packed-1"
BUILDID="9011"
S="${WORKDIR}/rpm/RPMS"
DESCRIPTION="OpenOffice productivity suite"

LANGPACK="OOo_${MY_PV2}_LinuxIntel_langpack"
LANGPACKPATH="http://oootranslation.services.openoffice.org/pub/OpenOffice.org/${MY_PV}/${LANGPACK}"
LANGSUFFIX="${MY_PV3}.i586.tar.gz"

SRC_URI="ftp://sunsite.icm.edu.pl/packages/OpenOffice/ux/${MY_P}"

HOMEPAGE="http://www.openoffice.org/ http://ux.pl/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="!app-office/openoffice
	|| ( x11-libs/libXaw virtual/x11 )
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	java? ( !amd64? ( >=virtual/jre-1.4.1 )
		amd64? ( app-emulation/emul-linux-x86-java ) )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	!app-office/openoffice"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

src_unpack() {

	unpack ${A}

	for i in base calc core01 core02 core03 core03u core04 core04u core05 core05u core06 core07 core08 core09 core10 draw emailmerge impress math writer graphicfilter pyuno spellcheck testtool xsltfilter ; do
		rpm_unpack ${S}/openoffice.ux.pl-${i}-${MY_PV3}.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.ux.pl-freedesktop-menus-${MY_PV3}.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.ux.pl-gnome-integration-${MY_PV3}.i586.rpm
	use java && rpm_unpack ${S}/openoffice.ux.pl-javafilter-${MY_PV3}.i586.rpm

}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv ${WORKDIR}/opt/openoffice.ux.pl2.0.2/* ${D}${INSTDIR}

	#Menu entries, icons and mime-types
	cd ${D}${INSTDIR}/share/xdg/
	sed -i -e s/'Exec=openoffice.ux.pl-2.0-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop || die

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.ux.pl-2.0-${desk}.desktop
		sed -i -e s/openoffice.ux.pl-2.0/ooffice2/g openoffice.ux.pl-2.0-${desk}.desktop || die
		sed -i -e s/openofficeuxpl-20-${desk}/ooo-${desk}2/g openoffice.ux.pl-2.0-${desk}.desktop || die
		domenu openoffice.ux.pl-2.0-${desk}.desktop
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeuxpl-20-${desk}.png ooo-${desk}2.png
	done

	insinto /usr/share/mime/packages
	doins ${WORKDIR}/usr/share/mime/packages/openoffice.org.xml

	# Install wrapper script
	newbin ${FILESDIR}/${PV}/ooo-wrapper2 ooffice2
	sed -i -e s/PV/${PV}/g ${D}/usr/bin/ooffice2 || die
	sed -i -e "s|INSTDIR|${INSTDIR}|g" ${D}/usr/bin/ooffice2 || die

	# Component symlinks
	for app in base calc draw fromtemplate impress math web writer; do
		dosym ooffice2 /usr/bin/oo${app}2
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/oopadmin2

	# Change user install dir
	sed -i -e s/.openoffice.ux.pl2/.ooo-2.0/g ${D}${INSTDIR}/program/bootstraprc || die

	# Non-java weirdness see bug #99366
	use !java && rm -f ${D}${INSTDIR}/program/javaldx
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	[ -x /sbin/chpax ] && [ -e /usr/lib/openoffice/program/soffice.bin ] && chpax -zm /usr/lib/openoffice/program/soffice.bin

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
}
