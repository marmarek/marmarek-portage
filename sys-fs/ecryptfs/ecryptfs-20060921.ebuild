# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-7.ebuild,v 1.1 2006/12/13 00:24:59 masterdriverz Exp $

inherit eutils libtool autotools

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://www.ecryptfs.org"
SRC_URI="mirror://sourceforge/ecryptfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-apps/keyutils
	dev-libs/libgcrypt"

RESTRICT="confcache"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ecryptfs-tpm_pki-0927.patch || die
	sed -ie 's/SLAB_KERNEL/GFP_KERNEL/;s/SLAB_USER/GFP_USER/' \
		ecryptfs-kernel/*/*.c
	epatch "${FILESDIR}/ecryptfs-crypto-md5.patch"
	elibtoolize
	cd ecryptfs-util
	eautoreconf
}

src_compile() {
	cd ${S}
	cd ecryptfs-kernel
	econf --with-kernelver=2.6.18-rc6-mm1 --with-modulesdir="/lib/modules/`uname -r`" || die "Error configuring kernel module"

	ARCH=i386 make || die "Error building kernel module"
#make install || { echo "Error installing kernel module" && exit 1; }
	cd ..
	cd ecryptfs-util
	econf || die "Error configuring user space"
	emake || die "Error building user space"
#make install || { echo "Error installing user space" && exit 1; }
}

src_install()  {
	cd ${S}
	cd ecryptfs-kernel
	insinto "/lib/modules/`uname -r`/kernel/fs/ecryptfs/"
	doins src/ecryptfs.ko
	cd ..
	cd ecryptfs-util
	#makefile workaround
	mkdir -p ${D}/usr/sbin
	mkdir -p ${D}/usr/share/aclocal
	make install DESTDIR=${D} || die
	dodoc README
}
