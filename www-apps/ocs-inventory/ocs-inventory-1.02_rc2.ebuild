# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit webapp perl-module

MY_P="OCSNG_UNIX_SERVER_${PV/rc/RC}"
MY_AGENT_W="OCSNG_WINDOWS_AGENT_${PV/rc/RC}"

DESCRIPTION="Inventory and package deployment system."
HOMEPAGE="http://ocsinventory.sourceforge.net/"
SRC_URI="mirror://sourceforge/ocsinventory/${MY_P}.tar.gz
		 mirror://sourceforge/ocsinventory/${MY_AGENT_W}.zip"
#		 mirror://sourceforge/ocsinventory/OCSNG_LINUX_AGENT_${PV}.tar.gz"

LICENSE="GPL"
#SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Apache-DBI dev-perl/XML-Simple www-apache/mod_perl"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	perl-module_pkg_setup || die
	webapp_pkg_setup || die
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	cd Apache
	perl Makefile.PL || die
	emake

}

src_install() {
	cd ${S}
	cd Apache
	perlinfo
	make install DESTDIR="${D}" || die
	einfo "Cleaning out stray man files"
	for FILE in `find ${D} -type f -name "*.3pm*"`; do
		rm -rf ${FILE}
	done
	find ${D}/usr/share/man -depth -type d 2>/dev/null | xargs -r rmdir 2>/dev/null

	fixlocalpod

	for FILE in `find ${D} -type f |grep -v '.so'`; do
		STAT=`file $FILE| grep -i " text"`
		if [ "${STAT}x" != "x" ]; then
			sed -i -e "s:${D}:/:g" ${FILE}
		fi
	done

	for doc in Change* MANIFEST* README* ${mydoc}; do
		[ -s "$doc" ] && dodoc $doc
	done
	# end of perl module install

	dodoc ocsinventory.conf
	cd ..
	dodoc ipdiscover-util/ipdiscover-util.pl ipdiscover-util/README
	webapp_src_preinst || die
	cd ocsreports || die
	cp -r . "${D}${MY_HTDOCSDIR}" || die
	cp "${WORKDIR}/${MY_AGENT_W}"/* ${D}${MY_HTDOCSDIR}/files/ || die
	webapp_serverowned ${MY_HTDOCSDIR}/ || die
#	webapp_sqlscript mysql ${MY_HTDOCSDIR}/files/ocsbase.sql || die
	webapp_src_install || die
}
