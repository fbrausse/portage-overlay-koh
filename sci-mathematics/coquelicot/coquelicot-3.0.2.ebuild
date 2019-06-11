# Copyright 2018 Franz Brausse

EAPI="6"

inherit remake

DESCRIPTION="A user-friendly Coq library for real analysis."
HOMEPAGE="http://coquelicot.saclay.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/37523/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc"

DEPEND="
	>=sci-mathematics/coq-8.5:=[ocamlopt?] <sci-mathematics/coq-8.9:=[ocamlopt?]
	sci-mathematics/coq-mathcomp:=[ocamlopt?]
"
RDEPEND="${DEPEND}"

COQPN="Coquelicot"
