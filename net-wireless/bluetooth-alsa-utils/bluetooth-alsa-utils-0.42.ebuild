# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

SPKG="btsco"
DESCRIPTION="A userspace daemon to send audio to a BT headset via ALSA"
HOMEPAGE="http://bluetooth-alsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/bluetooth-alsa/${SPKG}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="alsa ao skype"

DEPEND="${DEPEND}
	>=net-wireless/bluez-libs-2.19
	alsa? (media-libs/alsa-lib)
	ao? (>=media-libs/libao-0.8.5)
	sys-apps/gawk"

RDEPEND="${RDEPEND}
	>=net-wireless/bluez-utils-2.19
	skype? ( net-im/skype
		sys-apps/dbus )
	media-sound/alsa-utils
	>=net-wireless/bluetooth-alsa-kernel-${PV}"

S="${WORKDIR}/${SPKG}-${PV}"
MY_S_SKYPE="${S}/contrib/skype_bt_hijacker"
MY_D_SKYPE="/usr/libexec/${PN}"

src_compile() {
	cd ${S}
	export WANT_AUTOMAKE="1.9.6"
	eautoreconf || die "autotools failed"
	econf \
		$(use_enable alsa alsaplugin) \
		$(use_enable ao ) || die "econf failed"
	emake CFLAGS="${CFLAGS} -I${S}/sbc -fPIC" LDFLAGS="${LDFLAGS} -L${S}/sbc" || die "emake failed"
	if use skype; then
		cd ${MY_S_SKYPE}
		emake || die "emake failed"
	fi
}

src_install() {
	cd ${S}
	make install DESTDIR="${D}" || die "make install failed"

	dobin btsco btsco2 a2play a2recv avrecv avsnd \
		sbc/rcplay sbc/sbcdec sbc/sbcenc sbc/sbcinfo

	dodoc AUTHORS COPYING* ChangeLog NEWS README
	use alsa && newdoc bt/BUILD README.alsaplugin

	if use skype; then
		cd ${MY_S_SKYPE}
		dodir ${MY_D_SKYPE}

		make install PREFIX=${D}/${MY_D_SKYPE}
		dosym ${MY_D_SKYPE}/skype_bt_hijacker /usr/bin

		docinto Skype
		dodoc ${MY_S_SKYPE}/README  ${MY_S_SKYPE}/ChangeLog
	fi
}
