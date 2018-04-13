# Copyright 2018 Franz Brausse

EAPI="6"

DESCRIPTION="Coq library of arbitrary large numbers. Provides BigN, BigZ, BigQ that used to be part of Coq standard library."
HOMEPAGE="https://github.com/coq/bignums"
SRC_URI="https://github.com/coq/bignums/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

DEPEND="=sci-mathematics/coq-${PV/\.0/*}:=[ocamlopt?]"
RDEPEND="${DEPEND}"

# strip "coq-" prefix
S="${WORKDIR}/${P#coq-}"

src_compile() {
	local tgt
	if use ocamlopt; then tgt=opt; else tgt=byte; fi
	emake VERBOSE=1 "${tgt}"
	use doc && emake VERBOSE=1 gallinahtml
}

src_install() {
	tgts=( install )
	use doc && tgts+=( install-doc )
	emake VERBOSE=1 DSTROOT="${D}" "${tgts[@]}"
	dodoc README.md
}
