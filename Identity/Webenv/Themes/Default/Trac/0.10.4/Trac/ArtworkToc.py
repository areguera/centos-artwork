# -*- coding: utf-8 -*-
"""
This macro shows the CentOS Artwork Table of Content.
"""

TOC = [('Identity',	   		                '<h3>1. Identity:</h3>'),
       ('IdentityConcept',                  '1.1. Concept'),
       ('IdentityLogo',			            '1.2. Logo'),
       ('IdentityTypography',	            '1.3. Typography'),
       ('IdentityColors',                   '1.4. Colors'),
       ('IdentityNewIdeas',		            '1.5. New Ideas'),
       ('Anaconda',	   		                '<h3>2. Anaconda:</h3>'),
       ('AnacondaPrompt',   	    	    '2.1. Prompt'),
       ('AnacondaHeader',	                '2.2. Header'),
       ('AnacondaSplash',		            '2.3. Spalsh'),
       ('AnacondaProgress', 		        '2.4. Progress'),
       ('AnacondaProgressSlides', 		    '2.4.1. Slides'),
       ('AnacondaFirstboot', 		        '2.5. First Boot'),
       ('BootUp',			                '<h3>3. Boot Up:</h3>'),
       ('BootUpGRUB',			            '3.1. GRUB'),
       ('BootUpRHGB',			            '3.2. RHGB'),
       ('BootUpGDM',			            '3.3. GDM'),
       ('BootUpGnomeSplash',		        '3.3. GnomeSplash'),
       ('HighVisibility',		            '<h3>4. High Visibility:</h3>'),
       ('HighVisibilityWallpapers',	        '4.1. Wallpapers'),
       ('Promo',			                '<h3>5. Promotion:</h3>'),
       ('PromoMedia',			            '5.1.  Media'),
       ('PromoPosters',			            '5.2. Posters'),
       ('PromoTShirts',			            '5.3. T-Shirts'),
       ('PromoOOoTemplates',		        '5.5. OOo Templates'),
       ('Repo',				                '<h3>6. Image Repositories:</h3>'),
       ('RepoWidgets',			            '6.1. Widgets'),
       ('Theming',			                '<h3>7. Theming:</h3>'),
       ('ThemingApache',		            '7.1. Apache Web Server'),
       ('ThemingSquid',		                '7.2. Squid Cache Proxy'),
       ('ThemingBrowserDefaultPage',        '7.3. Browser Default Page'),
       ('ThemingMantis',		            '7.4. Mantis'),
       ('ThemingMoin',		                '7.5. Moin'),
       ('ThemingTrac',		                '7.5. Trac'),
       ('ThemingPunbb',		                '7.5. Punbb'),
       ('ThemingPuntal',		            '7.5. Puntal'),
       ]

def execute(hdf, args, env):
    html = '<div class="wiki-toc">' \
           '<h4>Table of Contents</h4>' \
           '<ul>'
    curpage = '%s' % hdf.getValue('wiki.page_name', '')
    lang, page = '/' in curpage and curpage.split('/', 1) or ('', curpage)
    for ref, title in TOC:
        if page == ref:
            cls =  ' class="active"'
        else:
            cls = ''
        html += '<li%s><a href="%s">%s</a></li>' \
                % (cls, env.href.wiki(lang+ref), title)
    return html + '</ul></div>'
