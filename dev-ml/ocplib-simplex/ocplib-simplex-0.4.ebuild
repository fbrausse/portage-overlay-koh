
EAPI="6"

WANT_AUTOCONF=latest
WANT_AUTOMAKE=none
WANT_LIBTOOL=none

inherit autotools findlib

DESCRIPTION="A library implementing a simplex algorithm, in a functional style, for solving systems of linear inequalities and optimizing linear objective functions"
HOMEPAGE="https://github.com/OCamlPro-Iguernlala/${PN}"
SRC_URI="http://github.com/OCamlPro-Iguernlala/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE=""
SLOT="0/${PV}"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="CHANGES.md LICENSE README.md"

PATCHES=(
	"${FILESDIR}/${P}-fix-Makefile-ocamlfind.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	findlib_src_install
}
