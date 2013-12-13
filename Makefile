NAME=tcar
DATADIR=/usr/share
BINDIR=/usr/bin

GITREPO=gitolite@centos.org.cu
GITREPO_ARTWORK=${GITREPO}:centos-artwork.git
GITREPO_PACKAGES=${GITREPO}:centos-packages.git

archive:
	git archive --format=tar --remote=${GITREPO_PACKAGES} ${NAME} \
		| tar -x -C $$HOME/rpmbuild/SPECS/; \
	export SPEC="$$HOME/rpmbuild/SPECS/${NAME}/${NAME}.spec"; \
	export VERSION=`gawk '/^Version/ { print $$2 }' $$SPEC`; \
	export TAG="${NAME}-$$VERSION"; \
	export SOURCE="$$HOME/rpmbuild/SOURCES/$$TAG.tar.bz2"; \
	git archive --format=tar --remote=${GITREPO_ARTWORK} ${NAME} \
	    --prefix=$$TAG/ | bzip2 > $$SOURCE; \
	rpmlint $$SPEC && rpmbuild --sign -ba $$SPEC;

install:
	for i in scripts brushes fonts palettes;do \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/$i; \
	    cp -rp ${NAME}-$i/* ${DESTDIR}${DATADIR}/${NAME}/$i/; \
	done; \
	mkdir -p ${DESTDIR}${BINDIR}; \
	ln -s ${DATADIR}/${NAME}/scripts/${NAME}.sh ${DESTDIR}${BINDIR}/${NAME}; \
	for i in hello prepare render locale tuneup;do \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/scripts/modules/$i; \
		cp -rp ${NAME}-scripts-$i/* ${DESTDIR}${DATADIR}/${NAME}/scripts/modules/$i/ ; \
	done; \
	for i in brands dist docs icons promo webenv;do \
	    mkdir -p ${DESTDIR}${DATADIR}/${NAME}/models/$i ; \
	    cp -rp ${NAME}-models-$i/* ${DESTDIR}${DATADIR}/${NAME}/models/$i/ ;\
	done;
