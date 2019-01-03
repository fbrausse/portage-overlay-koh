
EAPI="6"

WANT_AUTOCONF=latest
WANT_AUTOMAKE=none
WANT_LIBTOOL=none

inherit autotools findlib

DESCRIPTION="A simple parser and type-checker for polomorphic extension of the SMT-LIB 2 language"
HOMEPAGE="https://github.com/Coquera/${PN}"
SRC_URI="https://github.com/Coquera/psmt2-frontend/archive/0.1.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
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
