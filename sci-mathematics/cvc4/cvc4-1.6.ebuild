# Copyright 2017 Franz Brausse <brausse@informatik.uni-trier.de>
#

EAPI=6

inherit autotools eutils

DESCRIPTION="CVC4 is an efficient open-source automatic theorem prover for SMT problems."
HOMEPAGE="http://cvc4.cs.stanford.edu/web/"
SRC_URI="http://cvc4.cs.stanford.edu/downloads/builds/src/${P}.tar.gz"

LICENSE="MIT cln? ( GPL-3 ) readline? ( GPL-3 ) BSD3-mod-cvc4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cln doc profile readline swig threads"

DEPEND="!cln? ( >=dev-libs/gmp-4.2.0 )
	dev-libs/antlr-c
	dev-libs/boost[threads?]
	readline? ( sys-libs/readline )
	cln? ( >=sci-libs/cln-1.3 )
	swig? ( >=dev-lang/swig-2 )
	doc? ( app-doc/doxygen )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local license_switch=--bsd
	if use readline || use cln; then
		license_switch=--enable-gpl
	fi
	econf \
		${license_switch} \
		$(use_enable profile profiling) \
		$(use_enable doc doxygen-doc) \
		$(use_enable threads thread-support) \
		$(use_with cln) \
		$(use_with !cln gmp) \
		$(use_with swig) \
		$(use_with readline) \
		--without-abc \
		--without-cadical \
		--without-cryptominisat \
		--without-lfsc \
		--without-symfpu
}

src_install() {
	default
}
