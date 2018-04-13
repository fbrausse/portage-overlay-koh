# Copyright 2018 Franz Brausse

EAPI="6"

inherit coqmake

DESCRIPTION="Coq library of arbitrary large numbers. Provides BigN, BigZ, BigQ that used to be part of Coq standard library."
HOMEPAGE="https://github.com/coq/bignums"
SRC_URI="https://github.com/coq/bignums/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

DEPEND="=sci-mathematics/coq-${PV/\.0/*}:=[ocamlopt?]"
RDEPEND="${DEPEND}"

# strip "coq-" prefix
S="${WORKDIR}/${P#coq-}"
