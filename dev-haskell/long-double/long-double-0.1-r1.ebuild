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
        >=dev-lang/ghc-7.6.1:= <dev-lang/ghc-8.5:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"
