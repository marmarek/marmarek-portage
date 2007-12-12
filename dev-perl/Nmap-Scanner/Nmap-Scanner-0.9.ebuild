# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet/Net-Telnet-3.03-r1.ebuild,v 1.18 2006/08/05 19:32:52 mcummings Exp $

inherit perl-module

DESCRIPTION="A Nmap Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Nmap/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MA/MAXSCHUBE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="
	dev-lang/perl
	net-analyzer/nmap"
RDEPEND="${DEPEND}"

