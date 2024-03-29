# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs gkrellm-plugin

DESCRIPTION="Displays CPU's current frequencies in gkrellm2"
HOMEPAGE="https://github.com/fbrausse/gkrellm-gkfreq"
SRC_URI="https://github.com/fbrausse/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/gkrellm:2[X]"
