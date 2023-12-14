# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
PYTHON_COMPAT=( python3_{7,8,9,10,11} )
inherit cmake python-any-r1

DESCRIPTION="Automatic theorem prover for satisfiability modulo theories (SMT) problems"
HOMEPAGE="https://cvc5.github.io/"
SRC_URI="https://github.com/cvc5/cvc5/archive/refs/tags/${P}.tar.gz
         https://github.com/martin-cs/symfpu/archive/refs/heads/CVC4.tar.gz -> SymFPU.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cln poly proofs readline replay +statistics"

RDEPEND="dev-libs/antlr-c
	dev-java/antlr:3
	dev-libs/boost
	readline? ( sys-libs/readline:0= )
	cln? ( sci-libs/cln )
	!cln? ( dev-libs/gmp:= )
	poly? ( >sci-mathematics/libpoly-0.1.11 )
	sci-mathematics/cadical
	dev-cpp/gtest"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}"/${PN}-${P}

PATCHES=(
	"${FILESDIR}"/${P}-gentoo.patch
#	"${FILESDIR}"/${P}-cmake-findgmp.patch
)

src_prepare() {
	cmake_src_prepare
	mkdir -p "${WORKDIR}/root/include"
	ln -rs "${WORKDIR}/symfpu-CVC4" "${WORKDIR}/root/include/symfpu"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_GPL=ON
		#-DENABLE_OPTIMIZED=ON
		-DUSE_CLN="$(usex cln ON OFF)"
		#-DUSE_READLINE="$(usex readline ON OFF)"
		-DENABLE_STATISTICS="$(usex statistics ON OFF)"
		#-DENABLE_PROOFS="$(usex proofs ON OFF)"
		#-DENABLE_REPLAY="$(usex replay ON OFF)"
		-DSymFPU_INCLUDE_DIR="${WORKDIR}/root/include"
		-DANTLR3_COMMAND=/usr/bin/antlr3
		-DCMAKE_SKIP_INSTALL_RPATH=ON
		-DUSE_POLY="$(usex poly ON OFF)"
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
	sed -i 's:${_IMPORT_PREFIX}/lib/:${_IMPORT_PREFIX}/'"$(get_libdir)"'/:g' \
		"${D}"/usr/$(get_libdir)/cmake/cvc5/cvc5Targets-gentoo.cmake
	#rm -r "${D}"/usr/lib/objects-Gentoo
	# + kill them in usr/lib/cmake/cvc5/cvc5Targets-gentoo.cmake
	#mv "${D}"/usr/{lib,$(get_libdir)}
}
