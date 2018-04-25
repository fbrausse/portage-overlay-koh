# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Evolution of Minisat"
HOMEPAGE="http://www.labri.fr/perso/lsimon/glucose/"
NAME=syrup-4.1
SRC_URI="http://www.labri.fr/perso/lsimon/downloads/softwares/${PN}-${NAME}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

IUSE="debug"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

#DOCS=( README )
#PATCHES=( "${FILESDIR}"/${P}-header_fix.patch )

S=${WORKDIR}/${PN}-${NAME}

src_prepare() {
	default
	# Remove makefile silencing
	sed -i -e 's:@\(\$\|ln\|rm\|for\):\1:g'	mtl/template.mk || die
}

src_configure() {
	myconf=$(usex debug d r)
	myext=$(usex debug debug release)
	mydir=simp

	tc-export CXX
}

src_compile() {
	emake -C $mydir MROOT="$S" $myconf
	LIB="${PN}" emake -C $mydir MROOT="$S" lib$myconf
}

src_install() {
	insinto /usr/include/${PN}2/mtl
	doins mtl/*.h

	insinto /usr/include/${PN}2/core
	doins core/Solver*.h

	insinto /usr/include/${PN}2/simp
	doins simp/Simp*.h

	insinto /usr/include/${PN}2/utils
	doins utils/*.h

	newbin ${mydir}/${PN}_${myext} ${PN}
	newlib.a ${mydir}/lib${PN}_${myext}.a lib${PN}.a

	einstalldocs
}
