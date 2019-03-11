# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Haskell interface library to MPFR"
HOMEPAGE="https://github.com/ekmett/rounded"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-haskell/hgmp-0.1.1:=[profile?]
	>=dev-haskell/singletons-2.1:=[profile?]
	>=dev-haskell/reflection-2.1.2:=[profile?]
	=dev-haskell/long-double-0.1*:=[profile?]
        >=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}"
