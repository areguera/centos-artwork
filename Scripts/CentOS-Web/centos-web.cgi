#!/usr/bin/python

import os
import cgi
import cgitb; cgitb.enable()

def main():
    qs = cgi.parse(os.environ['QUERY_STRING'])
    if 'app' in qs.keys():
        app = qs['app'][0].lower()
    else:
        app = 'home'

    if app == 'home':
        from Apps.Home import page
    elif app == 'sponsors':
        from Apps.Sponsors import page
    else:
        from Apps.Home import page

    print 'Content-type: text/html' + "\n"
    print page.main()

if __name__ == '__main__': main()
