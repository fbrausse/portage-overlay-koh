# Copyright 2017 Franz Brausse <brausse@informatik.uni-trier.de>
#

EAPI=7

DESCRIPTION="The CUDD package is a package written in C for the manipulation of decision diagrams."
HOMEPAGE="https://github.com/ivmai/${PN}"
SRC_URI="https://github.com/ivmai/${PN}/archive/refs/tags/${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pic static-libs"

#DEPEND="dev-libs/gmp"

src_unpack() {
	default
	mv -v ${WORKDIR}/{${PN}-,}${P}
}

src_configure() {
	econf \
		$(use_with pic) \
		--enable-static=$(usex static-libs yes no) \
		--enable-shared=yes
}
