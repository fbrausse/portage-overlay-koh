# Copyright 2017 Franz Brausse <brausse@informatik.uni-trier.de>
#

EAPI=6

inherit cmake-utils

DESCRIPTION="LibPoly is a C library for manipulating polynomials."
HOMEPAGE="https://github.com/SRI-CSL/${PN}"
SRC_URI="https://github.com/SRI-CSL/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs python"

DEPEND="dev-libs/gmp"

src_configure() {
	local mycmakeargs=(
		-DLIBPOLY_BUILD_STATIC_PIC=$(usex static-libs ON OFF)
		-DLIBPOLY_BUILD_STATIC=$(usex static-libs ON OFF)
		-DLIBPOLY_BUILD_PYTHON_API=$(usex python ON OFF)
	)
	cmake-utils_src_configure "$@"
}

src_install() {
	cmake-utils_src_install "$@"

	# <https://bugs.gentoo.org/628362#c7>
	# Do not violate multilib strict
	mv "${ED}/usr/lib" "${ED}/usr/$(get_libdir)" || die "mv failed"
}
