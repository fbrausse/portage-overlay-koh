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

PATCHES=( "${FILESDIR}/mathcomp-Makefile-remove-override-makeflags.patch" )

DEPEND="
	>=sci-mathematics/coq-8.5:=[ocamlopt?] <sci-mathematics/coq-8.8:=[ocamlopt?]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/math-comp-mathcomp-${PV}"

src_compile() {
	(cd mathcomp && coqmake_src_compile)
}

src_install() {
	(cd mathcomp && coqmake_src_install)
	einstalldocs
}
