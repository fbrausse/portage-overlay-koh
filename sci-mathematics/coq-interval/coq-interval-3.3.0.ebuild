# Copyright 2018 Franz Brausse

EAPI="6"

inherit remake

COQPN="interval"

DESCRIPTION="Provides tactics for simplifying the proofs of inequalities on expressions of real numbers for the Coq proof assistant."
HOMEPAGE="http://coq-interval.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/37077/${COQPN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DEPEND="
	>=sci-mathematics/coq-8.5:=[ocamlopt?] <sci-mathematics/coq-8.9:=[ocamlopt?]
	>=sci-mathematics/flocq-2.5
	>=sci-mathematics/coq-mathcomp-1.6:=[ocamlopt?]
	>=sci-mathematics/coquelicot-3.0[ocamlopt?]
	sci-mathematics/coq-bignums[ocamlopt?]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${COQPN}-${PV}"
