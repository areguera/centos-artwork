Pasos a dar para soportar un nuevo idioma
-----------------------------------------
Supongamos que vamos a soportar el idioma idioma Portugu�s (pt)
- Traducir las plantillas de $prefix/templates/en/*, aunque le resulte m�s �til traducir $prefix/templates/es/* dada la similitud de los idiomas.
- Seleccionar los ficheros que tienen cadenas a traducir, es decir, aquellos que tienen _("...") en el c�digo fuente.
   $ find $prefix -exec grep -l "_(" {} \; > $prefix/messages/pygettext.files
- Quitar todos los ficheros de pygettext.files que no correspondan, *.pyc *.py~...
- Generar el cat�logo, para ello se debe ejecutar:
   $ cd $prefix/messages
   $ $prefix/bin/pygettext.py -v `cat pygettext.files`
   $ mkdir -p pt/LC_MESSAGES
   #
   # No ser�a mala idea (en este caso) traducir README.es a README.pt :-)
   #
   $ mv messages.pot pt/LC_MESSAGES/catalog.pt
- traducir catalog.pt
- Generar mailman.mo:
   $ cd $prefix/messages/pt/LC_MESSAGES
   $ msgfmt -o mailman.mo catalog.pt
- Insertar en Defaults.py una l�nea en la variable LC_DESCRIPTIONS:
LC_DESCRIPTIONS = { 'es':     [_("Spanish (Spain)"),  'iso-8859-1'],
		    'pt':     [_("Portuguese"),       'iso-8859-1'], <----
                    'en':     [_("English (USA)"),    'us-ascii']
		   }
- Almacenar las plantillas del nuevo idioma en $prefix/templates/pt
- A partir de ahora podemos a�adir a una lista el nuevo idioma:
   $ $prefix/bin/addlang -l <lista> pt


Pasos para sincronizar el cat�logo
----------------------------------
- Generar el nuevo cat�logo tal y como se describe antes y compararlo con el
que ya tenemos. Para compararlo tendremos que ejecutar:
   $ cd $prefix/messages
   $ $prefix/bin/pygettext.py -v `cat pygettext.files`
   $ mv messages.pot pt/LC_MESSAGES
   $ cd pt/LC_MESSAGES
   # Hay otra utilidad relacionada que hace los mismo: 'msgmerge'
   $ tupdate messages.pot catalog.pt > tmp
# Los mensajes antiguos quedan comentados al final del fichero tmp
# Los mensajes nuevos quedan sin traducir.
   $ vi tmp
# Traducir los mensajes nuevos
   $ mv tmp catalog.pt; rm messages.pot
   $ msgfmt -o mailman.mo catalog.pt

Para donar la traducci�n de un nuevo idioma
-------------------------------------------
      Apreciamos la donaci�n de cualquier traducci�n al proyecto mailman,
      de manera que cualquiera pueda beneficiarse de tu esfuerzo. Por
      supuesto, cualquier labor realizada ser� reconocida p�blicamente,
      dentro de la documentaci�n de Mailman. Esto es lo que hay que hacer
      para donar cualquier traducci�n, ya sea la primera vez que se haga o
      cualquier actualizaci�n posterior.

      Lo mejor que se puede hacer es mandar un fichero en formato 'tar' a
      <barry@zope.com> que se pueda desempaquetar en la parte superior 
      donde empieza la jerarqu�a de directorios del CVS.

      Tu fichero 'tar' deber�a tener dos directorios, donde est�n contenidos
      los ficheros pertenecientes a la traducci�n del lenguaje 'xx':
 
      templates/xx
      messages/xx
 
      En templates/xx deber�an estar las plantillas, todos los ficheros .txt y
      .html traducidas en tu idioma, a partir de las plantillas en Ingl�s (que
      siempre son las copias primarias).

      En messages/xx solo deber�a haber un �nico directorio llamado
      LC_MESSAGES y dentro de �l un fichero llamado mailman.po, que es el
      cat�logo perteneciente a tu idioma. No env�es el fichero mailman.mo
      porque de eso me encargo yo.

      Pr�cticamente eso es todo. Si necesitas incluir un fichero README, por
      favor n�mbralo como README.xx y m�telo en el directorio messages/xx.
      README.xx deber�a estar en tu idioma.

      Puedes mandarme el fichero 'tar' por correo electr�nico. Si es la
      primera vez que mandas la traducci�n, por favor, dime que debo poner en
      la invocaci�n de add_language() dentro del fichero Defaults.py para
      incorporar tu idioma.
