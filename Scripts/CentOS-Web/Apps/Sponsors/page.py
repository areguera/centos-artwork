"""Support module for page layout inside `Sponsors' web application.

"""
from Apps import page

app = page.Layout()


def page_navibar():
    """Returns application's main pages.
    
    The application's main pages are organized as tabs in the
    application navigation bar. There is one tab for each main page
    inside the application.
    
    """
    names = ['Hardware', 'Hosting', 'Others']
    attrs = []

    for i in names:
        if 'app' in app.qs.keys():
            attrs.append({'href': '/centos-web/?app=' + app.qs['app'][0].lower() + '&p=' + i.lower()})
        else:
            attrs.append({'href': '/centos-web/?p=' + i.lower()})

    if 'p' in app.qs.keys():
        focus = app.qs['p'][0].lower()
    else:
        focus = names[0].lower()

    return app.page_navibar(names, attrs, focus)


def page_content():
    """Returns page content.
    
    The page content to show is determined from the query string,
    specifically from the value of `p' variable.
    
    """
    if 'p' in app.qs.keys():
        p = app.qs['p'][0].lower()
    else:
        p = 'hardware'

    if p == 'hardware':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Hardware Sponsors' )
    elif p == 'hosting':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Hosting Sponsors' )
    elif p == 'others':
        output = app.tag_h1({'class': 'title'}, [12, 1], 'Other Sponsors' )
    else:
        output = app.tag_p('', [12, 1], 'Page empty.')

    return output


def main():
    """Returns final output."""

    # Define page name. This value is used as reference to determine
    # which application to load and what tab in the navigation bar to
    # focus on.
    app.name = 'Sponsors'

    # Define page title. This value is dislayed on the browser's title
    # bar. Notice that we concatenated the page class default value
    # here.
    app.title += ' :: Sponsors'

    # Define page header. This is the information displayed
    # between the page top and the page content.
    app.header = app.logo()
    app.header += app.google()
    app.header += app.navibar()
    app.header += app.page_links()
    app.header += page_navibar()

    # Define page body. This is the information displayed between the
    # page header and page footer.
    app.body = page_content()

    # Define page footer. This is the information displayed between
    # the page bottom and the page content, the last information
    # displayed in the page.
    app.footer = app.credits()

    # Define page final layout. 
    html = app.page()

    return html
