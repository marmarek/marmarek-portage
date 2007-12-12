# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-filter/pecl-filter-0.10.0-r1.ebuild,v 1.1 2006/10/21 13:12:18 chtekk Exp $

PHP_EXT_NAME="mnogosearch"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="Extension for searching."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="www-apps/mnogosearch"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	has_php

	my_conf="--with-mnogosearch=/usr"

	php-ext-pecl-r1_src_compile
}

