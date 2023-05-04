
EAPI=8

inherit cmake

DESCRIPTION="KTX (Khronos texture) library and tools ktx2check, ktx2ktx2, ktxinfo, ktxsc and toktx"
HOMEPAGE="https://github.com/KhronosGroup/KTX-Software"
SRC_URI="https://github.com/KhronosGroup/KTX-Software/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_sse4_1"

S=${WORKDIR}/KTX-Software-${PV}

src_configure() {
	local mycmakeargs=(
		#-DBASISU_SUPPORT_SSE=$(usex cpu_flags_x86_sse4_1 ON OFF)
		-DBASISU_SUPPORT_SSE=OFF
	)
	cmake_src_configure
}
