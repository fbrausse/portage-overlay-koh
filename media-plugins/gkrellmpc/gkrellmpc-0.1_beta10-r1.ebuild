# Copyright 1999-2012 Gentoo Foundation
# Copyright 2017-2018 Franz Brausse
# Distributed under the terms of the GNU General Public License v2
#
# 20180105: port to EAPI=6

EAPI=6

inherit eutils gkrellm-plugin toolchain-funcs

DESCRIPTION="A gkrellm plugin to control the MPD (Music Player Daemon)"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:GKrellMPC"
SRC_URI="http://mina.naguib.ca/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-admin/gkrellm:2[X]
	net-misc/curl"
DEPEND="${RDEPEND}"

# Patches from Debian package
PATCHES=(
	"${FILESDIR}"/fix-makefile-install.patch
	"${FILESDIR}"/fix-makefile-flags.patch
	"${FILESDIR}"/fix-fd-leak.patch
	"${FILESDIR}"/fix-memleaks.patch
	"${FILESDIR}"/fix-crash.patch
)

# Will open gkrellm in X11 display
RESTRICT="test"

src_prepare() {
	default
	sed -i -e 's:gkrellm2 -p:gkrellm -p:' Makefile || die
}

src_configure() {
	tc-export CC
}
