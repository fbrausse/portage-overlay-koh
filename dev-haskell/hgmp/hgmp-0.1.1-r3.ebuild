# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell interface to GMP"
HOMEPAGE="https://code.mathr.co.uk/hgmp"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
        >=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
	test? ( >=dev-haskell/quickcheck-2.8 <dev-haskell/quickcheck-2.13 )
"

HACKAGE_REV=3

src_prepare() {
	# idea from <https://github.com/gentoo-haskell/gentoo-haskell/issues/861#issuecomment-428454736>
	# but less intrusive
	rm ${S}/${PN}.cabal || die
	cp ${FILESDIR}/hackage-rev-${HACKAGE_REV}.cabal ${S}/${PN}.cabal || die
	default
}
