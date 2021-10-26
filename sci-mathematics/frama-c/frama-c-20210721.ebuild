# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools eutils

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
NAME="Vanadium"
MY_PV=23.1
SRC_URI="http://git.frama-c.com/pub/${PN}/-/archive/${MY_PV}/${PN}-${MY_PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-frama_c_plugin_aorai doc gmp gtk +ocamlopt coq why3"
RESTRICT="strip"

DEPEND="
	>=dev-lang/ocaml-4.02.3[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.5[gtk?,ocamlopt?]
	>=dev-ml/zarith-1.5[ocamlopt?]
	>=dev-ml/yojson-1.4.1[ocamlopt?]
	coq? ( >=sci-mathematics/coq-8.5[ocamlopt?] <sci-mathematics/coq-8.8[ocamlopt?] )
	frama_c_plugin_aorai? ( sci-mathematics/ltl2ba )
	sci-mathematics/alt-ergo
	gtk? (
		>=x11-libs/gtksourceview-2.8:2.0
		>=gnome-base/libgnomecanvas-2.26
		>=dev-ml/lablgtk-2.18.5[sourceview,gnomecanvas,ocamlopt?]
		|| ( <dev-ml/ocamlgraph-2[gtk,ocamlopt?] >=dev-ml/ocamlgraph_gtk-2[ocamlopt?] )
	)
	gmp? ( dev-ml/gmp-ocaml )
	why3? ( >=sci-mathematics/why3-1.4.0[lib,ocamlopt?] )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

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
		$(use_enable coq wp-coq)
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
