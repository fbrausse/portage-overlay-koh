# Copyright 2017 Franz Brausse

EAPI=5

inherit gkrellm-plugin

DESCRIPTION="Replacement for GKrellM battery meter based on /proc/acpi/battery"
HOMEPAGE="http://www.100acrewood.org/~rasto/hwmonbat.html"
SRC_URI="http://www.100acrewood.org/~rasto/hwmonbat/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	gkrellm-plugin_src_install
}
