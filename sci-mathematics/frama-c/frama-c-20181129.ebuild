# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools eutils

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
NAME="Argon"
MY_PV=18.0
SRC_URI="http://frama-c.com/download/${PN}-${MY_PV}-${NAME}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-frama_c_plugin_aorai doc gmp gtk +ocamlopt coq why3"
RESTRICT="strip"

# known to work according to website:
# =sci-mathematics/why3-0.88.3
# =sci-mathematics/alt-ergo-1.30 =sci-mathematics/alt-ergo-2.0
# sci-mathematics/coq-8.7.2
DEPEND="
	>=dev-lang/ocaml-4.02.3[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.5[gtk?,ocamlopt?]
	=dev-ml/zarith-1.7*
	coq? ( >=sci-mathematics/coq-8.5[ocamlopt?] <sci-mathematics/coq-8.8[ocamlopt?] )
	frama_c_plugin_aorai? ( sci-mathematics/ltl2ba )
	sci-mathematics/alt-ergo
	gtk? (
		>=x11-libs/gtksourceview-2.8:2.0
		>=gnome-base/libgnomecanvas-2.26
		>=dev-ml/lablgtk-2.18.5[sourceview,gnomecanvas,ocamlopt?]
	)
	why3? ( =sci-mathematics/why3-0.88* )
	gmp? ( dev-ml/gmp-ocaml )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}-${NAME}"

src_prepare(){
	touch config_file || die
	rm -f ocamlgraph.tar.gz || die
#	epatch "${FILESDIR}/ocamlgraph185_compat.patch"
	eautoreconf
}

src_configure(){
	econf \
		--enable-verbosemake \
		$(use_enable gtk gui) \
		$(use_enable coq wp-coq) \
		$(use_enable why3 wp-why3)
}

src_compile(){
	# dependencies can not be processed in parallel,
	# this is the intended behavior.
	emake -j1 depend
	emake all top DESTDIR="/"

	if use doc; then
		emake -j1 doc doc-tgz
		tar -xzf frama-c-api.tar.gz -C doc/
	fi
}

src_install(){
	default

	if use doc; then
		dohtml -A svg -r doc/frama-c-api/*
	fi
}
