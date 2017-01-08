# Copyright 2017 Franz Brausse

EAPI=5

inherit gkrellm-plugin

DESCRIPTION="Replacement for GKrellM battery meter based ThinkPad SMAPI"
HOMEPAGE="http://www.100acrewood.org/~rasto/thinkbat/"
SRC_URI="http://www.100acrewood.org/~rasto/thinkbat/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-laptop/tp_smapi"
RDPEND="${DEPEND}"

src_install() {
	gkrellm-plugin_src_install
}
