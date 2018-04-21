
# Copyright 2018 Franz Brausse

# @ECLASS: remake.eclass
# @DESCRIPTION:
# Common src_{prepare,configure,compile,install}() for Coq packages built using Remake.

# @ECLASS-VARIABLE: COQPN
# @REQUIRED
# @DESCRIPTION: Name of the package in Coq's user-contrib directory

# for makeopts_jobs
inherit multiprocessing

IUSE="doc"

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install

remake_src_prepare() {
	default
	sed -i Remakefile.in \
		-e 's:@libdir@:${DESTDIR}@libdir@:g'
}

remake_src_compile() {
	./remake -j$(makeopts_jobs) || die "remake failed"
	use doc && ./remake -j$(makeopts_jobs) doc
}

remake_src_configure() {
	econf --libdir="`coqc -where`/user-contrib/${COQPN}"
}

remake_src_install() {
	DESTDIR="${D}" ./remake install || die
	if use doc; then
		local docdir=$(coqc -config | grep -E ^DOCDIR= | cut -d= -f2-)
		local tgt="${D}/${docdir}/user-contrib/${COQPN}"
		mkdir -p "${tgt}" && cp -r html "${tgt}"
	fi
	einstalldocs
}
