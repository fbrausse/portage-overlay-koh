# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

GFORGE_ID=38367

DESCRIPTION="Why3 is a platform for deductive program verification"
HOMEPAGE="http://why3.lri.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/${GFORGE_ID}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="float frama-c doc examples emacs gzip coq alt-ergo isabelle gtk"

REQUIRED_USE="float? ( coq )"

DEPEND=">=dev-lang/ocaml-4.02.3
	dev-ml/zarith
	coq? ( >=sci-mathematics/coq-8.5:= <sci-mathematics/coq-8.10:= )
	frama-c? ( =sci-mathematics/frama-c-20171101:= )
	float? ( >=sci-mathematics/flocq-3.1:= )
	doc? ( dev-tex/rubber
               media-gfx/graphviz
               dev-python/sphinx
               dev-python/sphinxcontrib-bibtex
               dev-tex/latexmk
             )
	>=dev-ml/menhir-20151112
	gzip? ( dev-ml/camlzip )
	alt-ergo? ( >=sci-mathematics/alt-ergo-2.0.0
                     <sci-mathematics/alt-ergo-2.3 )
	isabelle? ( >=sci-mathematics/isabelle-2017
                     <sci-mathematics/isabelle-2019 )
	gtk? ( dev-ml/lablgtk:= )
"
RDEPEND="${DEPEND}"

DOCS=( CHANGES.md README.md )

src_prepare() {
	mv doc/why.1 doc/why3.1 || die
	sed -i configure.in -e "s/\"pvs\"/\"sri-pvs\"/g" || die
#	epatch "${FILESDIR}"/fix-configure-menhir-absent.patch
	epatch "${FILESDIR}"/${PN}-1.0.0-configure-enable-coq-fp-libs.patch
	eautoconf
#	sed -i configure -e "s/\"pvs\"/\"sri-pvs\"/g" || die
	sed -i Makefile.in -e "s:DESTDIR =::g" \
		-e "s:\$(RUBBER) --warn all --pdf manual.tex:makeindex manual.tex; \$(RUBBER) --warn all --pdf manual.tex; cd ..:g" || die
}

src_configure() {
	econf $(use_enable frama-c) \
	      $(use_enable gzip zip) \
	      $(use_enable emacs emacs-compilation) \
	      $(use_enable coq coq-libs) \
	      $(use_enable float coq-fp-libs) \
	      --disable-pvs-libs \
	      $(use_enable isabelle isabelle-libs)
}

src_compile() {
	default
	if use doc; then
		emake doc
	fi
}

src_install(){
	default

	doman doc/why3.1
	if use doc; then
		dodoc doc/latex/manual.pdf
		insinto /usr/share/doc/${PF}
		doins -r doc/html
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
