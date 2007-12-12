# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info linux-mod

SPKG="btsco"

DESCRIPTION="BlueTooth headset driver for ALSA (snd-bt-sco)"
HOMEPAGE="http://bluetooth-alsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/bluetooth-alsa/${SPKG}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="${DEPEND}
	!media-sound/alsa-driver
	!=virtual/linux-sources-2.4*
	>=virtual/linux-sources-2.6"

RDEPEND=""

S="${WORKDIR}/${SPKG}-${PV}/kernel"

pkg_setup() {
	# The wording below is checked for linux-2.6.14.4
	CONFIG_CHECK="BT_SCO BT_HCIUSB_SCO SND_HWDEP"
	ERROR_BT_SCO="BT_SCO is not set! \n\
		Please select 'L2CAP protocol support' and 'SCO links support' under \n\
		Networking|Bluetooth subsystem support|SCO links support"
	ERROR_BT_HCIUSB_SCO="BT_HCIUSB_SCO is not set! \n\
		Please select 'HCI USB driver' under \n\
		Networking|Bluetooth subsystem support|Bluetooth device drivers|SCO (voice) support"
	ERROR_SND_HWDEP="SND_HWDEP is not set! \n\
		Please select a config like SND_USB_AUDIO or SND_EMU10K1; \n\
		look under Device drivers|Sound|ALSA|PCI"

	linux-mod_pkg_setup
}

src_compile() {
	BUILD_TARGETS="default"
	MODULE_NAMES="snd-bt-sco()"
	BUILD_PARAMS="-j1"
	BUILD_TARGETS="default"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
