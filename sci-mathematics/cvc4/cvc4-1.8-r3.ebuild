# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
PYTHON_COMPAT=( python3_11 )
inherit cmake python-any-r1

DESCRIPTION="Automatic theorem prover for satisfiability modulo theories (SMT) problems"
HOMEPAGE="https://cvc4.github.io/"
SRC_URI="https://github.com/CVC4/CVC4-archived/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
         https://github.com/martin-cs/symfpu/archive/refs/heads/CVC4.tar.gz -> SymFPU.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cln proofs readline +statistics"

RDEPEND="dev-libs/antlr-c
	dev-java/antlr:3
	dev-libs/boost
	readline? ( sys-libs/readline:0= )
	cln? ( sci-libs/cln )
	!cln? ( dev-libs/gmp:= )"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}"/${PN^^}-archived-${PV}

PATCHES=(
	"${FILESDIR}"/${P}-gentoo.patch
	"${FILESDIR}"/${P}-replace-python-toml-with-tomllib.patch
	"${FILESDIR}"/${P}-fix-shell-escaping-problem-in-mkmetakind.patch
)

src_prepare() {
	cmake_src_prepare
	mkdir -p "${WORKDIR}/root/include"
	ln -rs "${WORKDIR}/symfpu-CVC4" "${WORKDIR}/root/include/symfpu"
}

src_configure() {
	local mycmakeargs=(
		-DANTLR_BINARY=/usr/bin/antlr3
		-DENABLE_GPL=ON
		-DUSE_CLN="$(usex cln ON OFF)"
		-DUSE_READLINE="$(usex readline ON OFF)"
		-DENABLE_STATISTICS="$(usex statistics ON OFF)"
		-DENABLE_PROOFS="$(usex proofs ON OFF)"
		-DUSE_SYMFPU=ON
		-DSYMFPU_DIR="${WORKDIR}/root/include"
	)
	cmake_src_configure
}

src_test() {
	emake -C "${BUILD_DIR}" \
		systemtests
	cmake_src_test
}

src_install() {
	cmake_src_install
	cp -rL "${WORKDIR}"/root/include/symfpu "${D}"/usr/include &&
	rm "${D}"/usr/include/symfpu/{LICENSE,.gitignore}
}
