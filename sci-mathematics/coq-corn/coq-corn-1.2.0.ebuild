# Copyright 2018 Franz Brausse

EAPI="6"

inherit coqmake

DESCRIPTION="Constructive Real Numbers in Coq."
HOMEPAGE="http://corn.cs.ru.nl"
SRC_URI="https://github.com/c-corn/corn/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

DEPEND=">=sci-mathematics/coq-8.6:=[ocamlopt?]
	sci-mathematics/coq-math-classes:=[ocamlopt?]"
RDEPEND="${DEPEND}"

# strip "coq-" prefix
S="${WORKDIR}/${P#coq-}"
