# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit multiprocessing

DESCRIPTION="A floating-point formalization for the Coq system"
HOMEPAGE="http://flocq.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/37477/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	( >=sci-mathematics/coq-8.7:= <sci-mathematics/coq-8.9:= )
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i Remakefile.in \
		-e "s:mkdir -p @libdir@:mkdir -p \${DESTDIR}@libdir@:g" \
		-e "s:cp \$f @libdir@:cp \$f \${DESTDIR}@libdir@:g"
}

src_configure() {
	econf --libdir="`coqc -where`/user-contrib/Flocq"
}

src_compile() {
	./remake -j$(makeopts_jobs) || die "emake failed"
}

src_install() {
	DESTDIR="${D}" ./remake install || die
	dodoc NEWS README AUTHORS ChangeLog
}
