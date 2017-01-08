# Copyright 1999-2012 Gentoo Foundation
# Copyright 2017      Franz Brausse
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils gkrellm-plugin toolchain-funcs

DESCRIPTION="A gkrellm plugin to control the MPD (Music Player Daemon)"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:GKrellMPC"
SRC_URI="http://mina.naguib.ca/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

# Patches from Debian package
PATCHES=( "${FILESDIR}"/fix-makefile-install.patch "${FILESDIR}"/fix-makefile-flags.patch "${FILESDIR}"/fix-fd-leak.patch "${FILESDIR}"/fix-memleaks.patch "${FILESDIR}"/fix-crash.patch )

# Will open gkrellm in X11 display
RESTRICT="test"

src_prepare() {
	epatch "${PATCHES[@]}"
	sed -i -e 's:gkrellm2 -p:gkrellm -p:' Makefile || die
#	use threads && epatch "${FILESDIR}"/${PN}-0.1_beta10-mt.patch
}

src_compile() {
	tc-export CC
	emake || die
}

#pkg_postinst() {
#	if use threads; then
#		elog "If you can't connect MPD, please unset USE threads."
#		elog "See, https://bugs.gentoo.org/276970 for information."
#	fi
#}
