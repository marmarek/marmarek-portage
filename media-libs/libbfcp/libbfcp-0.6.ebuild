# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="An open source BFCP (Binary Floor Control Protocol, RFC4582)
library."
HOMEPAGE="http://sourceforge.net/projects/libbfcp"
SRC_URI="mirror://sourceforge/libbfcp/libbfcpmsg-CONFIANCE-06.tar.gz
	mirror://sourceforge/libbfcp/libbfcpsrvclt-CONFIANCE-06.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${WORKDIR}/bfcpmsg-${PV}
	emake || die "emake failed"

	cd ${WORKDIR}/bfcpsrvclt-06/bfcpclt-06
	emake || die "emake failed"

	cd ${WORKDIR}/bfcpsrvclt-06/bfcpsrv-06
	sed -i -e 's/$(CC) -ggdb -c $< -o $@ $(OPTS)/$(CC) -fPIC -ggdb -c $< -o $@ $(OPTS)/' Makefile
	emake || die "emake failed"
}

src_install() {
	dodir /usr/include /usr/lib

	cd ${WORKDIR}/bfcpmsg-${PV}
#	sed -e "s/^PREFIX.*/PREFIX = ${D}\/usr/" Makefile
	einstall PREFIX=${D}/usr || die "einstall failed"

	cd ${WORKDIR}/bfcpsrvclt-06/bfcpclt-06
#	sed -e "s/^PREFIX.*/PREFIX = ${D}\/usr/" Makefile
	dodir /usr/include /usr/lib
	einstall PREFIX=${D}/usr || die "einstall failed"

	cd ${WORKDIR}/bfcpsrvclt-06/bfcpsrv-06
#	sed -e "s/^PREFIX.*/PREFIX = ${D}\/usr/" Makefile
	dodir /usr/include /usr/lib
	einstall PREFIX=${D}/usr || die "einstall failed"
}
