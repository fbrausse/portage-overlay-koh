# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Haskell package providing a LongDouble type"
HOMEPAGE="https://code.mathr.co.uk/long-double"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="
        >=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"

HACKAGE_REV=1

src_prepare() {
	# idea from <https://github.com/gentoo-haskell/gentoo-haskell/issues/861#issuecomment-428454736>
	# but less intrusive
	rm ${S}/${PN}.cabal || die
	cp ${FILESDIR}/hackage-rev-${HACKAGE_REV}.cabal ${S}/${PN}.cabal || die
	default
}
