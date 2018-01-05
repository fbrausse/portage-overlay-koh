# Copyright 2017-2018 Franz Brausse
#
# 20180105: update to EAPI=6

EAPI=6

inherit gkrellm-plugin

DESCRIPTION="Replacement for GKrellM battery meter based on ThinkPad SMAPI"
HOMEPAGE="http://www.100acrewood.org/~rasto/thinkbat/"
SRC_URI="http://www.100acrewood.org/~rasto/thinkbat/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-admin/gkrellm:2[X]
	app-laptop/tp_smapi"
DEPEND="${RDEPEND}"
