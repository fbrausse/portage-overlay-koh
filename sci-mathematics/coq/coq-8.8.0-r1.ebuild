# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="https://github.com/coq/coq/archive/V8.8.0.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc-stdlib"

RDEPEND="
	>=dev-lang/ocaml-4.02.3:=[ocamlopt?]
	>=dev-ml/camlp5-6.14:=[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.18.3:=[sourceview,ocamlopt?] )"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-1.4.1
	doc-stdlib? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		|| ( dev-texlive/texlive-mathscience dev-texlive/texlive-mathextra )
		dev-texlive/texlive-latexextra
		media-gfx/xfig
		)"

S=${WORKDIR}/${MY_P}

DOCS=(
	README.md
	CREDITS
	CHANGES
)

PATCHES=(
)

src_configure() {
	ocaml_lib=$(ocamlc -where)
	local myconf=(
		-prefix /usr
		-bindir /usr/bin
		-libdir /usr/$(get_libdir)/coq
		-mandir /usr/share/man
		-emacslib /usr/share/emacs/site-lisp
		-coqdocdir /usr/$(get_libdir)/coq/coqdoc
		-docdir /usr/share/doc/${PF}
		-configdir /etc/xdg/${PN}
		-lablgtkdir ${ocaml_lib}/lablgtk2
		)

	use debug && myconf+=( -debug )
	use doc-stdlib || myconf+=( -with-doc no )

	if use gtk; then
		if use ocamlopt; then
			myconf+=( -coqide opt )
		else
			myconf+=( -coqide byte )
		fi
	else
		myconf+=( -coqide no )
	fi

	use ocamlopt || myconf+=( -byte-only )

	myconf+=( -camlp5dir ${ocaml_lib}/camlp5 )

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure ${myconf[@]} || die "configure failed"
}

src_compile() {
	emake STRIP="true" VERBOSE=1
#	use ocamlopt || emake STRIP="true" VERBOSE=1 byte
	use doc-stdlib && {
		emake VERBOSE=1 stdlib
		emake VERBOSE=1 tutorial
		emake VERBOSE=1 rectutorial
	}
}

src_test() {
	emake STRIP="true" check VERBOSE=1
}

src_install() {
	local tgts=( install )
	use ocamlopt || tgts+=( install-byte )
	use doc-stdlib && tgts+=( install-doc-html )
	emake STRIP="true" COQINSTALLPREFIX="${D}" "${tgts[@]}" VERBOSE=1
	einstalldocs

	use gtk && make_desktop_entry "coqide" "Coq IDE" "${EPREFIX}/usr/share/coq/coq.png"
}
