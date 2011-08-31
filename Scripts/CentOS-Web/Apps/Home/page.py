"""Support module for page layout inside `Home' web application.

"""
from Apps import page

app = page.Layout()


def page_navibar():
    """Returns application main pages.
    
    The application main pages are organized as tabs in the
    application navigation bar. There is one tab for each main page
    inside the application.
    
    """
    names = ['Page1', 'Page2', 'Page3']
    attrs = []

    for i in names:
        attrs.append({'href': '/centos-web/?p=' + i.lower()})

    if 'p' in app.qs.keys():
        focus = app.qs['p'][0].lower()
    else:
        focus = ''

    return app.page_navibar(names, attrs, focus)


def page_content():
    """Returns page content.
    
    The page content is determined from the query string, specifically
    from the value of `p' variable.
    
    """
    if 'p' in app.qs.keys():
        p = app.qs['p'][0].lower()
    else:
        p = ''

    if p == 'page1':
        output = app.tag_p('', [12, 1], 'Page Empty.')
    elif p == 'page2':
        output = app.tag_p('', [12, 1], 'Page Empty.')
    elif p == 'page3':
        output = app.tag_p({}, [12, 1], 'Page Empty' )
    else:
        output = app.content_list_2cols()

    return output


def main():
    """Returns final output."""

    # Define page name. This value is used as reference to determine
    # which application to load and what tab in the navigation bar to
    # focus on.
    app.name = 'Home'

    # Define page title. This value is dislayed on the browser's title
    # bar. Notice that we concatenated the page class default value
    # here.
    app.title += ' :: Home'

    # Define page header. This is the information displayed
    # between the page top and page content.
    app.header = app.logo()
    app.header += app.google()
    app.header += app.navibar()
    app.header += app.releases()
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
