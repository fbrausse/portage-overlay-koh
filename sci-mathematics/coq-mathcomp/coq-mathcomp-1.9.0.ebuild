# Copyright 2018 Franz Brausse

EAPI="6"

inherit coqmake

DESCRIPTION="The Mathematical Components Library is an extensive and coherent repository of formalized mathematical theories."
HOMEPAGE="http://math-comp.github.io/math-comp/"
SRC_URI="https://github.com/math-comp/math-comp/archive/mathcomp-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CeCILL-B"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

#PATCHES=( "${FILESDIR}/mathcomp-Makefile-remove-override-makeflags.patch" )

# sci-mathematics/coq-8.10beta1 also supported
DEPEND="
	>=sci-mathematics/coq-8.7:=[ocamlopt?] <sci-mathematics/coq-8.10:=[ocamlopt?]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/math-comp-mathcomp-${PV}"

src_prepare() {
	(cd mathcomp && make Makefile.coq)
	default
}

src_compile() {
	(cd mathcomp && MAKEOPTS="$MAKEOPTS -f Makefile.coq" coqmake_src_compile)
}

src_install() {
	(cd mathcomp && MAKEOPTS="$MAKEOPTS -f Makefile.coq" coqmake_src_install)
	einstalldocs
}
