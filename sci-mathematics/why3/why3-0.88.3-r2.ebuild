# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="Why3 is a platform for deductive program verification"
HOMEPAGE="http://why3.lri.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/37313/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="float frama-c doc examples emacs menhir gzip coq alt-ergo"

DEPEND=">=dev-lang/ocaml-3.12.1
	dev-ml/zarith
	coq? ( || (
		=sci-mathematics/coq-8.4*:=
		( >=sci-mathematics/coq-8.5:= <sci-mathematics/coq-8.8:= )
	) )
	frama-c? ( =sci-mathematics/frama-c-20150201 )
	float? ( >=sci-mathematics/flocq-2.5:= )
	doc? ( dev-tex/rubber )
	menhir? ( >=dev-ml/menhir-20161115 )
	gzip? ( dev-ml/camlzip )
	alt-ergo? ( >=sci-mathematics/alt-ergo-0.95.2
                    <=sci-mathematics/alt-ergo-2.0.0 )
"
RDEPEND="${DEPEND}"

DOCS=( CHANGES.md README.md Version )

src_prepare() {
	mv doc/why.1 doc/why3.1 || die
	sed -i configure.in -e "s/\"pvs\"/\"sri-pvs\"/g" || die
	epatch "${FILESDIR}"/fix-configure-menhir-absent.patch
	eautoconf
#	sed -i configure -e "s/\"pvs\"/\"sri-pvs\"/g" || die
	sed -i Makefile.in -e "s:DESTDIR =::g" \
		-e "s:\$(RUBBER) --warn all --pdf manual.tex:makeindex manual.tex; \$(RUBBER) --warn all --pdf manual.tex; cd ..:g" || die
}

src_configure() {
	econf $(use_enable frama-c) \
	      $(use_enable menhir menhirLib) \
	      $(use_enable gzip zip) \
	      $(use_enable emacs emacs-compilation)
}

src_compile() {
#	MAKEOPTS+=" -j1"

	default
	if use doc; then
		emake doc/manual.pdf
	fi
}

src_install(){
	default

	doman doc/why3.1
	if use doc; then
		dodoc doc/manual.pdf
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
