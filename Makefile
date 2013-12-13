NAME=tcar
DATADIR=/usr/share
BINDIR=/usr/bin

install:
	for i in scripts brushes fonts palettes;do \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/$$i; \
	    cp -rp ${NAME}-$$i/* ${DESTDIR}${DATADIR}/${NAME}/$$i/; \
	done; \
	mkdir -p ${DESTDIR}${BINDIR}; \
	ln -s ${DATADIR}/${NAME}/scripts/${NAME}.sh ${DESTDIR}${BINDIR}/${NAME}; \
	for i in hello prepare render locale tuneup;do \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/scripts/modules/$$i; \
		cp -rp ${NAME}-scripts-$$i/* ${DESTDIR}${DATADIR}/${NAME}/scripts/modules/$$i/ ; \
	done; \
	for i in brands dist docs icons promo webenv;do \
	    mkdir -p ${DESTDIR}${DATADIR}/${NAME}/models/$$i ; \
	    cp -rp ${NAME}-models-$$i/* ${DESTDIR}${DATADIR}/${NAME}/models/$$i/ ;\
	done;
