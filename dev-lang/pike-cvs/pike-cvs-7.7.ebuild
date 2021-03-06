# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pike/pike-7.6.50.ebuild,v 1.2 2006/01/22 17:32:24 genone Exp $

inherit cvs

DESCRIPTION="Pike programming language and runtime"
HOMEPAGE="http://pike.ida.liu.se/"
SRC_URI=""

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bzip2 crypt debug doc fftw gdbm gif gmp gtk hardened jpeg kerberos mime mmx mysql opengl pcre pdf scanner sdl ssl svg tiff truetype zlib"

ECVS_AUTH="pserver"
ECVS_SERVER="cvs.roxen.com:/cvs"
ECVS_MODULE="Pike/${PV}"
ECVS_USER="anon"
ECVS_PASS=""

DEPEND="bzip2? ( app-arch/bzip2 )
	crypt? ( dev-libs/nettle )
	fftw? ( sci-libs/fftw )
	gdbm? ( sys-libs/gdbm )
	gif? ( media-libs/giflib )
	gmp? ( dev-libs/gmp )
	gtk? ( =x11-libs/gtk+-1.2* )
	jpeg? ( media-libs/jpeg )
	kerberos? ( virtual/krb5 )
	mysql? ( dev-db/mysql )
	opengl? ( virtual/opengl virtual/glut )
	pcre? ( dev-libs/libpcre )
	pdf? ( media-libs/pdflib )
	scanner? ( media-gfx/sane-backends )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	ssl? ( dev-libs/openssl )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype )
	zlib? ( sys-libs/zlib )"

S=${WORKDIR}/Pike/${PV}


src_compile() {
	local myconf=""
	# ffmpeg is broken atm #110136
	myconf="${myconf} --without-_Ffmpeg"
	# on hardened, disable runtime-generated code
	# otherwise let configure work it out for itself
	use hardened && myconf="${myconf} --without-machine-code"
	# prevent rpath's from being encoded in the binary #116795
	export pike_cv_run_path_method=ld_library_path
	emake \
		CONFIGUREARGS=" \
			--prefix=/usr \
			--disable-make_conf \
			--disable-noopty-retry \
			--without-cdebug \
			$(use_with bzip2 Bz2) \
			$(use_with debug rtldebug) \
			$(use_with crypt nettle) \
			$(use_with fftw) \
			$(use_with gdbm) \
			$(use_with gif) \
			$(use_with gmp) \
			$(use_with gmp bignums) \
			$(use_with gtk GTK) \
			$(use_with jpeg jpeglib) \
			$(use_with kerberos Kerberos) \
			$(use_with mime MIME) \
			$(use_with mmx) \
			$(use_with mysql) \
			$(use_with opengl GL) \
			$(use_with opengl GLUT) \
			$(use_with pcre _Regexp_PCRE) \
			$(use_with pdf libpdf) \
			$(use_with scanner sane) \
			$(use_with sdl SDL) \
			$(use_with sdl SDL_mixer) \
			$(use_with ssl ssleay) \
			$(use_with svg) \
			$(use_with tiff tifflib) \
			$(use_with truetype ttflib) \
			$(use_with truetype freetype) \
			$(use_with zlib) \
			${myconf} \
			${EXTRA_ECONF} \
			" || die

	if use doc; then
		PATH="${S}/bin:${PATH}" make doc || die "doc failed"
	fi
}

src_install() {
	# the installer should be stopped from removing files, to prevent sandbox issues
	sed -i s/rm\(mod\+\"\.o\"\)\;/\{\}/ ${S}/bin/install.pike || die "Failed to modify install.pike"
		
	if use doc ; then
		make INSTALLARGS="--traditional" buildroot="${D}" install || die
		einfo "Installing 60MB of docs, this could take some time ..."
		dohtml -r "${S}"/refdoc/traditional_manual "${S}"/refdoc/modref
	else
		make INSTALLARGS="--traditional" buildroot="${D}" install_nodoc || die
	fi
	
	x=`echo ${WORKDIR} | sed s/./_/g`
	find ${D} -type f -exec sed -i s%${WORKDIR}%${x}% {} \;
			
}
