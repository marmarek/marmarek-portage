# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mu-conference/mu-conference-0.6.0-r2.ebuild,v 1.11 2008/01/08 08:30:42 nelchael Exp $

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Multi-User Chat for jabberd"
HOMEPAGE="http://mu-conference.jabberstudio.org/"
SRC_URI="http://download.gna.org/mu-conference/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"

DEPEND="|| ( net-im/jabberd net-im/jabberd2 )
		>=dev-libs/glib-2.2.1"

IUSE=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/src
}

src_compile() {
	emake || die
}

src_install() {
	dodir /etc/jabber /usr/lib/jabberd /var/log/muc /var/spool/muc
	keepdir /var/log/muc /var/spool/muc

	dosbin src/mu-conference

	insinto /etc/jabber
	doins  ${FILESDIR}/muc-default.xml muc-default.xml

	newconfd ${FILESDIR}/mu-conference-conf.d mu-conference

	newinitd ${FILESDIR}/mu-conference-init.d mu-conference

	dodoc README FAQ README.jcr ${FILESDIR}/README.Gentoo README.sql
	dodoc mu-conference.sql 

	fowners jabber:jabber /var/log/muc
	fperms g-x /var/log/muc
	fperms g+rw /var/log/muc

	fowners jabber:jabber /var/spool/muc
	fperms g-x /var/spool/muc
	fperms g+rw /var/spool/muc
}

pkg_postinst() {
	elog
	elog "Please read /usr/share/doc/${PF}/README.Gentoo.gz"
	elog "And please notice that now muc-transport comes with a init.d script"
	elog "dont forget to add it to your runlevel."
	elog
}