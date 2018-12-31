# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

COQPN=Flocq

inherit remake

DESCRIPTION="A floating-point formalization for the Coq system"
HOMEPAGE="http://flocq.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/37454/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (
	=sci-mathematics/coq-8.4*:=
	( >=sci-mathematics/coq-8.5:= <sci-mathematics/coq-8.9:= )
)"
RDEPEND="${DEPEND}"
