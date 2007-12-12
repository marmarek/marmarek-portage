#Copyright 1999-2004 Gentoo Technologies, Inc. 

DESCRIPTION="Polska binarka pakietu openoffice przygotowany przez firmê ux-System posiadj±ca wiele ulepszeñ."
HOMEPAGE="http://www.ux.org/openoffice/"

MY_P="OOo-1.1.2-1-linux-ux.pl.tgz"

SRC_URI="ftp://sunsite.icm.edu.pl/packages/OpenOffice/ux/${MY_P}"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-apps/findutils
        virtual/glibc
        >=dev-lang/perl-5.0
        virtual/x11
        app-arch/zip
        app-arch/unzip
        || ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
        !app-office/openoffice"
	
RDEPEND="virtual/glibc
	 >=dev-lang/perl-5.0
         virtual/x11
         app-arch/zip
         app-arch/unzip
         || ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
         !app-office/openoffice"

src_unpack()
{
unpack "${MY_P}" 
}

src_compile()
{
    einfo "Nie ma nic do kompilowania :D"
}

src_install()
{
  # Sandbox issues; bug #11838
    addpredict "/user"
    addpredict "/share"
    addpredict "/dev/dri"
    addpredict "/usr/bin/soffice"
    addpredict "/pspfontcache"
    addpredict "/opt/OpenOffice.org/foo.tmp"
    addpredict "/opt/OpenOffice.org/delme"
    
    cd    ${WORKDIR}/normal
    ./install --prefix=${D}/opt
}

pkg_postinst() {

    einfo "Aby dokoñczyæ instalacji nale¿y z konta ka¿dego u¿ytkownika ko¿ystaj±cego"
    einfo "z pakietu OpenOffice uruchomiæ /opt/OpenOffice.org1.1.2/setup"
    einfo "Dok³adny opis instalacji znajdziemy na stronie:"
    einfo "http://openoffice.pl/forum.php?a=tree&id=24&PHPSESSID=c8ff0de9c259c5c5c0081d7b25dfce57"
    einfo ""
    einfo "Opis problemów wystêpuj±cych z drukowaniem polskich czcionek znajdziemy miedzy innymi na"
    einfo "forum: http://openoffice.pl/forum.php"
    einfo ""
    einfo "Strona firmy która skompilowa³a pakiet: http://www.ux.pl/openoffice/"
    einfo ""
    einfo ""
}
