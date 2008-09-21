#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors/files/fancontrol-init.d,v 1.1 2007/05/17 07:31:41 phreak Exp $

CONFIG=/etc/fancontrol
PID=/var/run/fancontrol.pid

depend() {
	after lm_sensors
}

checkconfig() {
	if [ ! -f ${CONFIG} ]; then
		eerror "Configuration file ${CONFIG} not found"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting fancontrol"
	start-stop-daemon --start --quiet --background --pidfile ${PID} \
		--exec /usr/sbin/fancontrol -- ${CONFIG}
	eend ${?}
}

stop() {
	ebegin "Stopping fancontrol"
	start-stop-daemon --stop --pidfile ${PID}
	eend ${?}
}
