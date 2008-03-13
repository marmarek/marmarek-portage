#!/sbin/runscript

depend() {
	need net
	use jabber-server
}

start() {
	ebegin "Starting MU Conference Jabber Transport"
	if [ -f ${PIDFILE} ]; then
		if [ -z $(ps ax | grep `cat ${PIDFILE}` | grep -v grep ) ]
		then
			rm -f ${PIDFILE}
		fi
	fi

	start-stop-daemon --start \
		--pidfile ${PIDFILE} \
		--chuid jabber \
		--exec /usr/sbin/mu-conference -- -B -c ${CONFIG} >/dev/null 2>&1
	eend $?
}

stop() {
	ebegin "Stoping MU Conference Jabber Transport"

	start-stop-daemon --stop \
		--pidfile ${PIDFILE} \
		--exec /usr/sbin/mu-conference
	eend $?
}
