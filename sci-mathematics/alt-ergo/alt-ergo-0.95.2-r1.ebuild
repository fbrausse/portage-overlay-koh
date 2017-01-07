# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Alt-Ergo is an automatic theorem prover"
HOMEPAGE="http://alt-ergo.ocamlpro.com"
SRC_URI="http://dev.gentoo.org/~jauhien/distfiles/${P}.tar.gz"

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt gtk"

DEPEND=">=dev-lang/ocaml-3.12.1[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.2[gtk?,ocamlopt?]
		dev-ml/zarith
		gtk? ( >=x11-libs/gtksourceview-2.8
				>=dev-ml/lablgtk-2.14[sourceview,ocamlopt?] )"
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
