# Copyright 1999-2007 Gentoo Foundation
# Copyright 2017-2018 Franz Brausse
# Distributed under the terms of the GNU General Public License v2
#
# 20180105: update to EAPI=6

EAPI=6

inherit gkrellm-plugin eutils

DESCRIPTION="Displays CPU's current speed in gkrellm2"
HOMEPAGE="http://www.peakunix.net/gkfreq/"
SRC_URI="http://www.peakunix.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

PLUGIN_SO=( gkfreq.so )

PATCHES=(
	"${FILESDIR}/${P}-gdk_string_width.patch"
)
