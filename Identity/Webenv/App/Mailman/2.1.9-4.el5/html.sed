s!<img src="/error/include/img/lists.png" alt="Lists">!<img src="/error/include/img/lists.png" alt="Lists" />!
s!<p>Description here ... </p>!<p><a href="%(listinfo)s">Overview</a> | <a href="%(admin)s">Administration</a> </p>!

s/<META/<meta/g
s/<LINK/<link/g

/<meta http-equiv="Content-Type"/d
/<meta name="robots"/d
/<link rel="Index"/d
/<link rel="made"/d

s!SHORTCUT ICON!shortcut icon!g
/<link rel="shortcut icon"/d
/<title>/a\
    <link rel="shortcut icon" href="<mm-favicon>" />

s!<H([1-9])>!<h\1>!g
s!</H([1-9])>!</h\1>!g

s!<TABLE!<table!g
s!</TABLE>!</table>!g
s!<FORM!<form!g
s!</FORM>!</form>!g
s!<TR!<tr!g
s!TR>!tr>!g
s!<TD!<td!g
s!TD>!td>!g
s!BORDER=!border=!
s!CELLSPACING="!cellspacing="!g
s!CELLPADDING="!cellpadding="!
s!WIDTH="!width="!g
s!HEIGHT="!height="!g
s!HEIGHT= "!height="!g
s!COLSPAN="!colspan="!g
s!COLSPAN=([A-Za-z0-9]+)!colspan="\1"!g
s!colspan=([A-Za-z0-9]+)!colspan="\1"!g
s!METHOD=([A-Za-z0-9]+)!method="\1"!g
s!ACTION=([A-Za-z0-9]+)!action="\1"!g
s!COLS=([A-Za-z0-9]+)!cols="\&1"!g
s!BGCOLOR=!bgcolor=!g

s!="POST"!="post"!g

s!<FONT!<font!
s!</FONT!</font!
s!COLOR=!color=!

s!<INPUT!<input!g
s!<strong>!<strong>!g
s!</strong>!</strong>!g

s!TYPE="password"!type="password"!g
s!TYPE="!type="!g
s!NAME=!name=!g
s!TITLE=!title=!g
s!SIZE=!size=!g
s!SUBMIT!submit!g

s!<LI>!<li>!g
s!</LI>!</li>!g
s!<UL>!<ul>!g
s!</UL>!</ul>!g
s!<hr />!<hr />!g
s!<br />!<br />!g
s!<br />!<br />!g

s!<P>!<p>!g
s!</P>!</p>!g
s!<[pP]> *$!</p>!g

s!ALIGN="Right"!align="right"!

s!</A>!</a>!g
s!<A HREF="!<a href="!g
s!<A name="!<a name="!g
s!<strong>!<strong>!g
s!</strong>!</strong>!g
s!<em>!<em>!g
s!</em>!</em>!g
s!<em>!<em>!g
s!</em>!</em>!g

s!<BODY>!<body>!g
s!</BODY>!</body>!g

s!<HTML>!<html>!g
s!</HTML>!</html>!g


