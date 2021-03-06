REXEC = R
export REXEC

# Uncomment the next line to build fat binaries (32 and 64) for Windows
BUILDARGS = --force-biarch --dsym
#BUILDARGS = --dsym

TESTFILE = tools/testModels.R

# subdirectories
RSOURCE = R
RDOCUMENTS = man
RDATA = data

# file types
#RFILES = $(wildcard R/*.R)

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo ""
	@echo "INSTALL"
	@echo ""
	@echo "  install       install dynr"
	@echo ""
	@echo "CLEANING"
	@echo ""
	@echo "  clean      remove all files from the build directory"
	@echo ""
	@echo "TESTING"
	@echo ""	
	@echo "  test               run the test suite"
	@echo "  torture            run the test suite with gctorture(TRUE)"
	@echo "  cran-test          build dynr and run CRAN check"
	@echo "  cran-test-cran     build dynr and run CRAN check with --as-cran"
	@echo "  slow-test          run the test suite with gctorture(TRUE)"
	@echo ""
	@echo "BUILDS"
	@echo ""
	@echo "  build         create a dynr binary for the local system"
	@echo "  srcbuild      create a dynr source release"
	@echo "  cran-build    create a dynr CRAN release"



r-libs-user-dir:
	sh ./inst/tools/mk-r-libs-user-dir

build-prep:
	@if [ $$(git status --short --untracked-files=no 2> /dev/null | wc -l) != 0 ]; then \
	  echo '***'; echo "*** UNCOMMITTED CHANGES IGNORED ***"; \
	  echo '***'; echo "*** Use 'git diff' to see what is uncommitted"; \
          echo '***'; fi
	-[ -d build ] && rm -r ./build
	mkdir build
	git archive --format=tar HEAD | (cd build; tar -xf -)

build: build-prep
	cd build && sh ./tools/prep && $(REXEC) CMD INSTALL $(BUILDARGS) --build .
	grep -v '@[A-Z]+@' DESCRIPTION.in > DESCRIPTION

srcbuild: build-prep
	cd build && sh ./tools/prep && $(REXEC) CMD build .
	grep -v '@[A-Z]+@' DESCRIPTION.in > DESCRIPTION
	@echo 'To generate a PACKAGES file, use:'
	@echo '  echo "library(tools); write_PACKAGES('"'.', type='source'"')" | R --vanilla'

cran-build: build-prep
	cd build && sh ./tools/prep && rm Makefile DESCRIPTION.in && $(REXEC) CMD build .
	grep -v '@[A-Z]+@' DESCRIPTION.in > DESCRIPTION

install:
	sh ./tools/prep
	MAKEFLAGS="$(INSTALLMAKEFLAGS)" $(REXEC) CMD INSTALL $(BUILDARGS) .
	grep -v '@[A-Z]+@' DESCRIPTION.in > DESCRIPTION

#MAKEFLAGS="$(INSTALLMAKEFLAGS)" $(REXEC) CMD SHLIB $(BUILDARGS) src/wrappernegloglike.c src/estimation_nloptR.c src/PANAmodel.c src/functions/*.c

clean:
	mkdir -p build
	-rm -f build/dynr_*.tar.gz build/dynr_*.zip
	-rm -f src/*.*o src/*.dll
	-rm -f src-i386/*.*o src-i386/*.dll
	-rm -f src-x64/*.*o src-x64/*.dll
	-rm -f inst/models/passing/*.*o inst/models/passing/*.dll
	-find demo -type f ! -name '*.R' ! -name 00Index | xargs rm -f
	-find inst/models/passing -type f ! -name '*.R' | xargs rm -f
	-rm -f src/Makevars
	-rm -f config.log config.status
	-grep -l 'Generated by roxygen2' man/*.Rd | xargs rm -f
	grep -v '@[A-Z]+@' DESCRIPTION.in > DESCRIPTION

test:
	$(REXEC) --vanilla --slave -f $(TESTFILE)

torture:
	$(REXEC) --vanilla --slave -f $(TESTFILE) --args gctorture

slow-test:
	$(REXEC) --vanilla --slave -f $(TESTFILE) --args slow

cran-test-cran: cran-build
	$(REXEC) CMD check --as-cran build/dynr_*.tar.gz | tee cran-test.log
	wc -l dynr.Rcheck/00check.log
	@if [ $$(wc -l dynr.Rcheck/00check.log | cut -d ' ' -f 1) -gt 59 ]; then echo "CRAN check problems have grown; see cran-check.log" ; false; fi

cran-test: cran-build
	$(REXEC) CMD check build/dynr_*.tar.gz | tee cran-test.log
	wc -l dynr.Rcheck/00check.log
	@if [ $$(wc -l dynr.Rcheck/00check.log | cut -d ' ' -f 1) -gt 59 ]; then echo "CRAN check problems have grown; see cran-check.log" ; false; fi

