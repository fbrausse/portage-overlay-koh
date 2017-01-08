# Copyright 2017 Franz Brausse <brausse@informatik.uni-trier.de>

EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="Library implementing fast exact real arithmetic."
HOMEPAGE="http://irram.uni-trier.de"

EGIT_REPO_URI="https://github.com/norbert-mueller/iRRAM.git https://github.com/fbrausse/iRRAM.git"
EGIT_MIN_CLONE_TYPE="single"
EGIT_COMMIT="a4d2409b9591227f1bbba93557989d0a2ba29d26"

LICENSE="LGPL-2"
SLOT="2014"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="static-libs doc examples"

DEPEND=">=dev-libs/gmp-4.1.0
	dev-libs/mpfr"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || prune_libtool_files
	use doc && dodoc doc/irram.ps doc/iRRAM.html
	if use examples; then
		# demo files
		insinto /usr/share/${PN}
		doins -r examples
		rm -f "${ED}"/usr/share/${PN}/examples/Makefile*
	fi
}
