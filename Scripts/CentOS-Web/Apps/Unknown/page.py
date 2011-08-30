"""Support module for page layout inside `Unknown' web application.

"""
from Apps import page

app = page.Layout()


def page_content():
    """Returns page content."""
    output = app.tag_p('', [12,1], 'The page you tried to open was not found in this server. Try one of the links above to start over.')
    output = app.admonition('Warning', 'Page not found.', output)
    return output


def main():
    """Returns final output."""

    # Define page name. This value is used as reference to determine
    # which application to load and what tab in the navigation bar to
    # focus on.
    app.name = 'Unknown'

    # Define page title. This value is dislayed on the browser's title
    # bar. Notice that we concatenated the page class default value
    # here.
    app.title += ' :: Page not found'

    # Define page header. This is the information displayed
    # between the page top and the page content.
    app.header = app.logo()
    app.header += app.google()
    app.header += app.navibar()

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
