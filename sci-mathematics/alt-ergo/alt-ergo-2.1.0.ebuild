# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Alt-Ergo is an automatic theorem prover"
HOMEPAGE="http://alt-ergo.ocamlpro.com"
SRC_URI="https://alt-ergo.ocamlpro.com/http/${P}/${P}.tar.gz"

LICENSE="OCamlPro-NCPL-1+Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt gtk"

DEPEND=">=dev-lang/ocaml-4.04.0[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.2[gtk?,ocamlopt?]
	dev-ml/zarith
	gtk? ( >=dev-ml/lablgtk-2.14[sourceview,ocamlopt?] )
	dev-ml/camlzip
	>=dev-ml/ocplib-simplex-0.4"
RDEPEND="${DEPEND}"

#src_prepare(){
#	sed \
#		-e "s:^DESTDIR[ \t]=[ \t]:DESTDIR=${D}:g" \
#		-i ${S}/Makefile.in || die
#}
src_compile(){
	emake || die "emake failed"
	use gtk && emake gui || die "emake gui failed"
}

src_install(){
	emake 'DESTDIR="${D}"' install || die "emake install failed"
	dodoc README.md CHANGES
}
