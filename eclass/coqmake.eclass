
# Copyright 2018 Franz Brausse

# Common src_compile() and src_install() for packages with built using
# coq_makefile-generated Makefiles

EXPORT_FUNCTIONS src_compile src_install

coqmake_src_compile() {
        local tgt
        if use ocamlopt; then tgt=opt; else tgt=byte; fi
        emake VERBOSE=1 "${tgt}"
        use doc && emake VERBOSE=1 gallinahtml
}

coqmake_src_install() {
        tgts=( install )
        use doc && tgts+=( install-doc )
        emake VERBOSE=1 DSTROOT="${D}" "${tgts[@]}"
        dodoc README.md
}

