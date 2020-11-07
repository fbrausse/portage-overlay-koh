# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit remake

DESCRIPTION="A floating-point formalization for the Coq system"
HOMEPAGE="http://flocq.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/38301/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	( >=sci-mathematics/coq-8.7:= <sci-mathematics/coq-8.13:= )
"
RDEPEND="${DEPEND}"

DOCS=( NEWS.md README.md AUTHORS ChangeLog )

COQPN="Flocq"
