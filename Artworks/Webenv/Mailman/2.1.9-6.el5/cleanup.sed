#!/bin/sed

# Convert HTML tags from upper case to lowercase.
s!<([[:alnum:]]+)!<\L\1!g
s!([[:alnum:]]+)>!\L\1>!g
s!<mm-!<MM-!g
s!([[:alnum:]]+)="([[:alnum:]%#+-]+)"!\L\1="\L\2"!g

# Remove HTML definition related to black colors.
s/[[:space:]]*color="#000000"//g

# Turn table data backgrounds colors into title class.
s!bgcolor="#99ccff"!class="h1"!g
s!bgcolor="#fff0d0"!class="h2"!g
s!bgcolor="#dddddd"!class="description"!g
s!bgcolor="#cccccc"!class="description"!g

# Add CentOS css style sheet and favicon.
s/(<\/title>)/\1\n/g
/<\/title>/a\
    <link rel="stylesheet" type="text/css" href="/webenv/mailman/stylesheet.css" />\
    <link rel="shortcut icon" href="/webenv/images/favicon.ico" type="image/x-icon" />

# Add CentOS tags.
s/(<body.*)/\n\1\n/
/<body/a\
\
<div id="wrap">\
<div id="header">\
    <div id="logo">\
        <a title="The CentOS Lists" href="/mailman"><img src="/webenv/mailman/images/logo.png" alt="The CentOS Lists"></a>\
    </div>\
    <div class="pageline blue"><hr style="display:none;"></div>\
</div>\
<div id="page">

# These Mailman comments must appear one per line.
s/(<!--(beginarticle|endarticle|threads)-->)/\n\1\n/
s/(<hr\/>)/\n\1\n/

# Cloase CentOS tags.
s/(<\/body>)/\n\1\n/g
/<\/body>/i\
</div>\
<div id="footer">\
<div class="pageline blue"></div>\
<div id="credits">\
<p><a href="/mailman/">The CentOS Lists</a></p>\
<p>&copy; 2013 <a href="/">The CentOS Project</a></p>\
</div>\
</div>\
</div>\
