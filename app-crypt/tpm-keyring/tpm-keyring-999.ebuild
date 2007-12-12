# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cvs autotools

DESCRIPTION="TPM key managment software"
HOMEPAGE="http://trousers.sf.net"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

ECVS_SERVER="trousers.cvs.sourceforge.net:/cvsroot/trousers"
ECVS_MODULE="applications/tpm_keyring2"

S=${WORKDIR}/${ECVS_MODULE}
src_compile() {
	cd ${S}
	sed -ie 's#/python#/python2.4#' Makefile
	emake || die
}

src_install() {
	insinto /usr/lib/python2.4/site-packages
	doins _tpm_keyring_util.so
	doins tpm_keyring_util.py
	dobin tpm_keyring
	dodoc README BUGS ChangeLog TODO ecryptfs-tpm_pki-0927.patch LICENSE doc/*
}
