NAME=tcar
DATADIR=/usr/share
BINDIR=/usr/bin

install:
	for i in scripts brushes fonts palettes;do \
        DIRNAME=$$(echo $$i | sed -r "s/($$i)/\u\1/"); \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/$$DIRNAME; \
	    cp -rp ${NAME}-$$i/* ${DESTDIR}${DATADIR}/${NAME}/$$DIRNAME/; \
	done; \
	mkdir -p ${DESTDIR}${BINDIR}; \
	ln -s ${DATADIR}/${NAME}/Scripts/${NAME}.sh ${DESTDIR}${BINDIR}/${NAME}; \
	for i in hello prepare render locale tuneup;do \
        DIRNAME=$$(echo $$i | sed -r "s/($$i)/\u\1/"); \
		mkdir -p ${DESTDIR}${DATADIR}/${NAME}/Scripts/Modules/$$DIRNAME; \
		cp -rp ${NAME}-scripts-$$i/* ${DESTDIR}${DATADIR}/${NAME}/Scripts/Modules/$$DIRNAME/; \
	done; \
	for i in brands dist docs icons promo webenv;do \
        DIRNAME=$$(echo $$i | sed -r "s/($$i)/\u\1/"); \
	    mkdir -p ${DESTDIR}${DATADIR}/${NAME}/Models/$$DIRNAME ; \
	    cp -rp ${NAME}-models-$$i/* ${DESTDIR}${DATADIR}/${NAME}/Models/$$DIRNAME/ ;\
	done;
