# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.5.20-r13.ebuild,v 1.1 2010/03/11 20:18:28 grobian Exp $

EAPI="3"

inherit eutils flag-o-matic autotools

PATCHSET_REV="-r4"

# note: latest sidebar patches can be found here:
# http://www.lunar-linux.org/index.php?option=com_content&task=view&id=44
SIDEBAR_PATCH_N="patch-1.5.20.sidebar.20090619.txt"

# labels patch source
#LABELS_PATCH_N="patch-1.5.17.dgc.xlabel_ext.5"
#		http://home.uchicago.edu/~dgc/sw/mutt/${LABELS_PATCH_N}

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/${P}.tar.gz
	!vanilla? (
		!sidebar? (
			mirror://gentoo/${P}-gentoo-patches${PATCHSET_REV}.tar.bz2
			http://dev.gentoo.org/~grobian/distfiles/${P}-gentoo-patches${PATCHSET_REV}.tar.bz2
		)
	)
	sidebar? (
		http://www.lunar-linux.org/~tchan/mutt/${SIDEBAR_PATCH_N}
	)"
IUSE="berkdb crypt debug doc gdbm gnutls gpg idn imap labels mbox nls nntp pop qdbm sasl sidebar smime smtp ssl tokyocabinet vanilla"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
RDEPEND=">=sys-libs/ncurses-5.2
	tokyocabinet?  ( dev-db/tokyocabinet )
	!tokyocabinet? (
		qdbm?  ( dev-db/qdbm )
		!qdbm? (
			gdbm?  ( sys-libs/gdbm )
			!gdbm? ( berkdb? ( >=sys-libs/db-4 ) )
		)
	)
	imap?    (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	pop?     (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	smtp?     (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	idn?     ( net-dns/libidn )
	gpg?   ( >=app-crypt/gpgme-0.9.0 )
	smime?   ( >=dev-libs/openssl-0.9.6 )
	app-misc/mime-types"
DEPEND="${RDEPEND}
	net-mail/mailbase
	doc? (
		dev-libs/libxml2
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
		|| ( www-client/lynx www-client/w3m www-client/elinks )
	)"

PATCHDIR="${WORKDIR}"/${P}-gentoo-patches${PATCHSET_REV}

src_unpack() {
	unpack ${A//${SIDEBAR_PATCH_N}}
}

src_prepare() {
	# this patch is non-generic and only works because we use a sysconfdir
	# different from the one used by the mailbase ebuild
	use prefix && epatch "${FILESDIR}"/mutt-1.5.13-prefix-mailcap.patch

	epatch "${FILESDIR}"/mutt-1.5.18-bdb-prefix.patch # fix bdb detection
	epatch "${FILESDIR}"/mutt-1.5.18-interix.patch
	built_with_use sys-libs/ncurses unicode && \
		epatch "${FILESDIR}"/mutt-1.5.18-solaris-ncurses-chars.patch
	epatch "${FILESDIR}"/mutt-1.5.20-gpgme-1.2.0.patch
	epatch "${FILESDIR}"/mutt-1.5.20-dont-reveal-bbc.patch

	# post-release hot-fixes
	epatch "${FILESDIR}"/mutt-1.5.20-imap-port-invalid-d6f88fbf8387.patch
	epatch "${FILESDIR}"/mutt-1.5.20-header-weeding-f40de578e8ed.patch
	epatch "${FILESDIR}"/mutt-1.5.20-display-unsigned-pgp-7f37d0a57d83.patch
	epatch "${FILESDIR}"/mutt-1.5.20-unmailbox-segfault-25e46aad362b.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mbox-new-mail-bd59be56c6b0.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mbox-unchanged-new-mail-9ae13dedb5ed.patch
	epatch "${FILESDIR}"/mutt-1.5.20-imap-start-fatal-fe30f394cbe6.patch
	epatch "${FILESDIR}"/mutt-1.5.20-tab-subject-questionmark-298194c414f0-cff8e8ce4327.patch
	epatch "${FILESDIR}"/mutt-1.5.20-smtp-batch-mode-0a3de4d9a009-f6c6066a5925.patch
	epatch "${FILESDIR}"/mutt-1.5.20-leave-mailbox-no-new-mail-118b8fef8aae.patch
	epatch "${FILESDIR}"/mutt-1.5.20-gpgme-keys-d41e043fa775.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mhs-flags-leak-9f3053f75f27.patch
	epatch "${FILESDIR}"/mutt-1.5.20-hcache-restore-address-848f08512bf3.patch
	epatch "${FILESDIR}"/mutt-1.5.20-ungroup-command-77ac8b5c2be6.patch
	epatch "${FILESDIR}"/mutt-1.5.20-propagate-mh_read_sequences-2fc9348684fe.patch
	epatch "${FILESDIR}"/mutt-1.5.20-hcache-uidvalidity-size-fix-a2a4286491b4.patch
	epatch "${FILESDIR}"/mutt-1.5.20-fix-mh-parsing-14bb498c6a1c.patch
	epatch "${FILESDIR}"/mutt-1.5.20-search-pattern-crash-053ef7bbaa72.patch
	epatch "${FILESDIR}"/mutt-1.5.20-next-invalid-pattern-crash-6a08a5244d60.patch
	epatch "${FILESDIR}"/mutt-1.5.20-ssl-CVE-2009-3765-dc09812e63a3.patch
	epatch "${FILESDIR}"/mutt-1.5.20-ssl-stack-compile-fix-1cf34ea1f128.patch
	epatch "${FILESDIR}"/mutt-1.5.20-no-hcolor-in-hcache-b7d2cb7c7ce1.patch
	epatch "${FILESDIR}"/mutt-1.5.20-off-by-one-mailcap-736b6af3c5f1.patch
	epatch "${FILESDIR}"/mutt-1.5.20-subject-mistruncation-31881f38ca1e.patch
	epatch "${FILESDIR}"/mutt-1.5.20-copy-From-to-imap-b2b97c7a2ae6.patch
	epatch "${FILESDIR}"/mutt-1.5.20-yes-no-non-ascii-a6fddecdc5f5.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mailbox-save-message-double-free-57124ea5592e.patch
	epatch "${FILESDIR}"/mutt-1.5.20-gpgme-case-insensitive-domain-2c78b28027cc.patch
	epatch "${FILESDIR}"/mutt-1.5.20-pop-port-in-url-6b057dc52222.patch
	epatch "${FILESDIR}"/mutt-1.5.20-rfc-2047-decode-before-dequote-2a4ca6917fd0.patch
	epatch "${FILESDIR}"/mutt-1.5.20-abort-prompt-ctrlc-c837ab790d2e.patch
	epatch "${FILESDIR}"/mutt-1.5.20-null-dptr-use-data-817c60d5da7d.patch
	epatch "${FILESDIR}"/mutt-1.5.20-regexp-fail-crash-05cec973f0d9.patch

	epatch "${FILESDIR}"/mutt-1.5.20-smime-encrypt-self.patch

	# patch version string for bug reports
	sed -i -e 's/"Mutt %s (%s)"/"Mutt %s (%s, Gentoo '"${PVR}"')"/' \
		muttlib.c || die "failed patching in Gentoo version"

	if use !vanilla && use !sidebar ; then
		use nntp || rm "${PATCHDIR}"/06-nntp.patch
		for p in "${PATCHDIR}"/*.patch ; do
			epatch "${p}"
		done
	fi

	if use labels; then
		epatch "${FILESDIR}"/mutt-1.5.20-labels.patch
	fi

	if use sidebar ; then
		use vanilla || \
			ewarn "the sidebar patch is only applied to a vanilla mutt tree"
		epatch "${DISTDIR}"/${SIDEBAR_PATCH_N}
	fi

	AT_M4DIR="m4" eautoreconf

	# the configure script contains some "cleverness" whether or not to setgid
	# the dotlock program, resulting in bugs like #278332
	sed -i -e 's/@DOTLOCK_GROUP@//' \
		Makefile.in || die "sed failed"

	# don't just build documentation (lengthy process, with big dependencies)
	if use !doc ; then
		sed -i -e '/SUBDIRS =/s/doc//' Makefile.in || die
	fi
}

src_configure() {
	declare myconf="
		$(use_enable nls) \
		$(use_enable gpg gpgme) \
		$(use_enable imap) \
		$(use_enable pop) \
		$(use_enable smtp) \
		$(use_enable crypt pgp) \
		$(use_enable smime) \
		$(use_enable debug) \
		$(use_with idn) \
		--with-curses \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PN}-${PVR} \
		--with-regex \
		--enable-nfs-fix --enable-external-dotlock \
		$(use_with !nntp mixmaster) \
		--with-exec-shell=${EPREFIX}/bin/sh"

	case $CHOST in
		*-solaris*)
			# Solaris has no flock in the standard headers
			myconf="${myconf} --enable-fcntl --disable-flock"
		;;
		*)
			myconf="${myconf} --disable-fcntl --enable-flock"
		;;
	esac

	# mutt prioritizes gdbm over bdb, so we will too.
	# hcache feature requires at least one database is in USE.
	if use tokyocabinet; then
		myconf="${myconf} --enable-hcache \
			--with-tokyocabinet --without-qdbm --without-gdbm --without-bdb"
	elif use qdbm; then
		myconf="${myconf} --enable-hcache \
			--without-tokyocabinet --with-qdbm --without-gdbm --without-bdb"
	elif use gdbm ; then
		myconf="${myconf} --enable-hcache \
			--without-tokyocabinet --without-qdbm --with-gdbm --without-bdb"
	elif use berkdb; then
		myconf="${myconf} --enable-hcache \
			--without-tokyocabinet --without-qdbm --without-gdbm --with-bdb"
	else
		myconf="${myconf} --disable-hcache \
			--without-tokyocabinet --without-qdbm --without-gdbm --without-bdb"
	fi

	# there's no need for gnutls, ssl or sasl without socket support
	if use pop || use imap || use smtp ; then
		if use gnutls; then
			myconf="${myconf} --with-gnutls"
		elif use ssl; then
			myconf="${myconf} --with-ssl"
		fi
		# not sure if this should be mutually exclusive with the other two
		myconf="${myconf} $(use_with sasl)"
	else
		myconf="${myconf} --without-gnutls --without-ssl --without-sasl"
	fi

	if use mbox; then
		myconf="${myconf} --with-mailpath=${EPREFIX}/var/spool/mail"
	else
		myconf="${myconf} --with-homespool=Maildir"
	fi

	if use !vanilla && use !sidebar ; then
		# rr.compressed patch
		myconf="${myconf} --enable-compressed"

		# nntp patch applied conditionally, so avoid QA warning when doing
		# --disable-nntp while patch not being applied, bug #262069
		use nntp && myconf="${myconf} --enable-nntp"
	fi

	econf ${myconf} || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	find "${ED}"/usr/share/doc -type f | grep -v "html\|manual" | xargs gzip
	if use mbox; then
		insinto /etc/mutt
		newins "${FILESDIR}"/Muttrc.mbox Muttrc
	else
		insinto /etc/mutt
		doins "${FILESDIR}"/Muttrc
	fi

	# A newer file is provided by app-misc/mime-types. So we link it.
	rm "${ED}"/etc/${PN}/mime.types
	dosym /etc/mime.types /etc/${PN}/mime.types

	# A man-page is always handy
	if use !doc; then
		cp doc/mutt.man mutt.1
		cp doc/muttbug.man flea.1
		doman mutt.1 flea.1
	else
		# nuke manpages that should be provided by an MTA, bug #177605
		rm "${ED}"/usr/share/man/man5/{mbox,mmdf}.5 \
			|| ewarn "failed to remove files, please file a bug"
	fi

	if use !prefix ; then
		fowners root:mail /usr/bin/mutt_dotlock
		fperms g+s /usr/bin/mutt_dotlock
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_setup() {
	if ! use gpg &&
		has_version "<${CATEGORY}/${PN}-1.5.20-r2" &&
		built_with_use ${CATEGORY}/${PN} gpgme ;
	then
		ewarn 'The "gpgme" USE-flag has been changed into "gpg".  You'
		ewarn 'previously had "gpgme" set, and you most likely want to'
		ewarn 'enable "gpg" instead, right now, to obtain equivalent behaviour.'
	fi
}

pkg_postinst() {
	echo
	elog "If you are new to mutt you may want to take a look at"
	elog "the Gentoo QuickStart Guide to Mutt E-Mail:"
	elog "   http://www.gentoo.org/doc/en/guide-to-mutt.xml"
	echo
}
