# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://${PN}.inria.fr/distrib/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc"

RDEPEND="
	>=dev-lang/ocaml-3.11.2:=[ocamlopt?]
	>=dev-ml/camlp5-6.02.3:=[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.10.1:=[sourceview,ocamlopt?] )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	doc? (
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
	"${FILESDIR}/${P}-gares-fix-7233-COQMF_WINDRIVE_empty.patch"
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
	use doc || myconf+=( -with-doc no )

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
	local tgts=( world )
	use ocamlopt || tgts+=( byte )
	use doc && tgts+=( doc-html )
	emake STRIP="true" "${tgts[@]}" VERBOSE=1
}

src_test() {
	emake STRIP="true" check VERBOSE=1
}

src_install() {
	local tgts=( install )
	use ocamlopt || tgts+=( install-byte )
	use doc && tgts+=( install-doc-html )
	emake STRIP="true" COQINSTALLPREFIX="${D}" "${tgts[@]}" VERBOSE=1
	einstalldocs

	use gtk && make_desktop_entry "coqide" "Coq IDE" "${EPREFIX}/usr/share/coq/coq.png"
}
