# Copyright 2018 Franz Brausse

EAPI="6"

inherit coqmake

DESCRIPTION="A library of abstract interfaces for mathematical structures in Coq."
HOMEPAGE="https://math-classes.github.io"
SRC_URI="https://github.com/math-classes/math-classes/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

DEPEND=">=sci-mathematics/coq-8.6:=[ocamlopt?]
	sci-mathematics/coq-bignums:=[ocamlopt?]"
RDEPEND="${DEPEND}"

# strip "coq-" prefix
S="${WORKDIR}/${P#coq-}"
