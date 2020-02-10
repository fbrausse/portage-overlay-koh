# Copyright 2020 Franz Brausse <brausse@informatik.uni-trier.de>
#

EAPI=6

inherit autotools eutils

DESCRIPTION="Yices 2 is an SMT solver supporting both linear and nonlinear arithmetic."
HOMEPAGE="http://yices.csl.sri.com/"
SRC_URI="http://yices.csl.sri.com/releases/${PV}/${P}-src.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mcsat"

DEPEND="dev-libs/gmp
	dev-util/gperf
	mcsat? ( >=sci-mathematics/libpoly-0.1.3 )
"

src_prepare() {
	eautoreconf	# work-around stale libcudd dependency in distributed configure script
	default
}

src_configure() {
	econf \
		$(use_enable mcsat)
}
