# -*- python -*-

# Copyright (C) 1998-2006 by the Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
# USA.

"""Distributed default settings for significant Mailman config variables."""

# NEVER make site configuration changes to this file.  ALWAYS make them in
# mm_cfg.py instead, in the designated area.  See the comments in that file
# for details.


import os

def seconds(s): return s
def minutes(m): return m * 60
def hours(h): return h * 60 * 60
def days(d): return d * 60 * 60 * 24

# Some convenient constants
try:
    True, False
except NameError:
    True = 1
    False = 0

Yes = yes = On = on = True
No = no = Off = off = False



#####
# General system-wide defaults
#####

# Should image logos be used?  Set this to 0 to disable image logos from "our
# sponsors" and just use textual links instead (this will also disable the
# shortcut "favicon").  Otherwise, this should contain the URL base path to
# the logo images (and must contain the trailing slash)..  If you want to
# disable Mailman's logo footer altogther, hack
# Mailman/htmlformat.py:MailmanLogo(), which also contains the hardcoded links
# and image names.
IMAGE_LOGOS = '/icons/'

# The name of the Mailman favicon
SHORTCUT_ICON = 'mm-icon.png'

# Don't change MAILMAN_URL, unless you want to point it at one of the mirrors.
MAILMAN_URL = 'http://www.gnu.org/software/mailman/index.html'
#MAILMAN_URL = 'http://www.list.org/'
#MAILMAN_URL = 'http://mailman.sf.net/'

# Mailman needs to know about (at least) two fully-qualified domain names
# (fqdn); 1) the hostname used in your urls, and 2) the hostname used in email
# addresses for your domain.  For example, if people visit your Mailman system
# with "http://www.dom.ain/mailman" then your url fqdn is "www.dom.ain", and
# if people send mail to your system via "yourlist@dom.ain" then your email
# fqdn is "dom.ain".  DEFAULT_URL_HOST controls the former, and
# DEFAULT_EMAIL_HOST controls the latter.  Mailman also needs to know how to
# map from one to the other (this is especially important if you're running
# with virtual domains).  You use "add_virtualhost(urlfqdn, emailfqdn)" to add
# new mappings.
#
# If you don't need to change DEFAULT_EMAIL_HOST and DEFAULT_URL_HOST in your
# mm_cfg.py, then you're done; the default mapping is added automatically.  If
# however you change either variable in your mm_cfg.py, then be sure to also
# include the following:
#
#     add_virtualhost(DEFAULT_URL_HOST, DEFAULT_EMAIL_HOST)
#
# because otherwise the default mappings won't be correct.
DEFAULT_EMAIL_HOST = 'localhost.localdomain'
DEFAULT_URL_HOST = 'localhost.localdomain'
DEFAULT_URL_PATTERN = 'http://%s/mailman/'

# DEFAULT_HOST_NAME has been replaced with DEFAULT_EMAIL_HOST, however some
# sites may have the former in their mm_cfg.py files.  If so, we'll believe
# that, otherwise we'll believe DEFAULT_EMAIL_HOST.  Same for DEFAULT_URL.
DEFAULT_HOST_NAME = None
DEFAULT_URL = None

HOME_PAGE         = 'index.html'
MAILMAN_SITE_LIST = 'mailman'

# Normally when a site administrator authenticates to a web page with the site
# password, they get a cookie which authorizes them as the list admin.  It
# makes me nervous to hand out site auth cookies because if this cookie is
# cracked or intercepted, the intruder will have access to every list on the
# site.  OTOH, it's dang handy to not have to re-authenticate to every list on
# the site.  Set this value to Yes to allow site admin cookies.
ALLOW_SITE_ADMIN_COOKIES = No

# Command that is used to convert text/html parts into plain text.  This
# should output results to standard output.  %(filename)s will contain the
# name of the temporary file that the program should operate on.
HTML_TO_PLAIN_TEXT_COMMAND = '/usr/bin/lynx -dump %(filename)s'



#####
# Virtual domains
#####

# Set up your virtual host mappings here.  This is primarily used for the
# thru-the-web list creation, so its effects are currently fairly limited.
# Use add_virtualhost() call to add new mappings.  The keys are strings as
# determined by Utils.get_domain(), the values are as appropriate for
# DEFAULT_HOST_NAME.
VIRTUAL_HOSTS = {}

# When set to Yes, the listinfo and admin overviews of lists on the machine
# will be confined to only those lists whose web_page_url configuration option
# host is included within the URL by which the page is visited - only those
# "on the virtual host".  When set to No, all advertised (i.e. public) lists
# are included in the overview.
VIRTUAL_HOST_OVERVIEW = On


# Helper function; use this in your mm_cfg.py files.  If optional emailhost is
# omitted it defaults to urlhost with the first name stripped off, e.g.
#
# add_virtualhost('www.dom.ain')
# VIRTUAL_HOST['www.dom.ain']
# ==> 'dom.ain'
#
def add_virtualhost(urlhost, emailhost=None):
    DOT = '.'
    if emailhost is None:
        emailhost = DOT.join(urlhost.split(DOT)[1:])
    VIRTUAL_HOSTS[urlhost.lower()] = emailhost.lower()

# And set the default
add_virtualhost(DEFAULT_URL_HOST, DEFAULT_EMAIL_HOST)

# Note that you will want to run bin/fix_url.py to change the domain of an
# existing list.  bin/fix_url.py must be run within the bin/withlist script,
# like so: bin/withlist -l -r bin/fix_url.py <listname>



#####
# Spam avoidance defaults
#####

# This variable contains a list of 2-tuple of the format (header, regex) which
# the Mailman/Handlers/SpamDetect.py module uses to match against the current
# message.  If the regex matches the given header in the current message, then
# it is flagged as spam.  header is case-insensitive and should not include
# the trailing colon.  regex is always matched with re.IGNORECASE.
#
# Note that the more searching done, the slower the whole process gets.  Spam
# detection is run against all messages coming to either the list, or the
# -owners address, unless the message is explicitly approved.
KNOWN_SPAMMERS = []



#####
# Web UI defaults
#####

# Almost all the colors used in Mailman's web interface are parameterized via
# the following variables.  This lets you easily change the color schemes for
# your preferences without having to do major surgery on the source code.  Note
# that in general, the template colors are not included here since it is easy
# enough to override the default template colors via site-wide, vdomain-wide,
# or list-wide specializations.
#
# This section is been moved to CSS (Common Style Sheets).  
#	- /error/includes/common.css
#	- /error/includes/mailman.css
#
# The HTML output layout is been modified too in order to fit the W3C's XHTML
# 1.0 standard. You may use the following variables but they may be deprecated
# in the near feautre.
#
# For more information about the standards used, see:
#  - http://www.w3.org/TR/xhtml1
#  - http://www.w3.org/TR/CSS21 

WEB_BG_COLOR = 'white'                            # Page background
WEB_HEADER_COLOR = '#99ccff'                      # Major section headers
WEB_SUBHEADER_COLOR = '#fff0d0'                   # Minor section headers
WEB_ADMINITEM_COLOR = '#dddddd'                   # Option field background
WEB_ADMINPW_COLOR = '#99cccc'                     # Password box color
WEB_ERROR_COLOR = 'red'                           # Error message foreground
WEB_LINK_COLOR = ''                               # If true, forces LINK=
WEB_ALINK_COLOR = ''                              # If true, forces ALINK=
WEB_VLINK_COLOR = ''                              # If true, forces VLINK=
WEB_HIGHLIGHT_COLOR = '#dddddd'                   # If true, alternating rows
                                                  # in listinfo & admin display


#####
# Archive defaults
#####

# The url template for the public archives.  This will be used in several
# places, including the List-Archive: header, links to the archive on the
# list's listinfo page, and on the list's admin page.
#
# This should be a string with "%(listname)s" somewhere in it.  Mailman will
# interpolate the name of the list into this.  You can also include a
# "%(hostname)s" in the string, into which Mailman will interpolate
# the host name (usually DEFAULT_URL_HOST).
PUBLIC_ARCHIVE_URL = 'http://%(hostname)s/pipermail/%(listname)s'

# Are archives on or off by default?
DEFAULT_ARCHIVE = On

# Are archives public or private by default?
# 0=public, 1=private
DEFAULT_ARCHIVE_PRIVATE = 0

# ARCHIVE_TO_MBOX
#-1 - do not do any archiving
# 0 - do not archive to mbox, use builtin mailman html archiving only
# 1 - archive to mbox to use an external archiving mechanism only
# 2 - archive to both mbox and builtin mailman html archiving -
#     use this to make both external archiving mechanism work and
#     mailman's builtin html archiving.  the flat mail file can be
#     useful for searching, external archivers, etc.
ARCHIVE_TO_MBOX = 2

# 0 - yearly
# 1 - monthly
# 2 - quarterly
# 3 - weekly
# 4 - daily
DEFAULT_ARCHIVE_VOLUME_FREQUENCY = 1
DEFAULT_DIGEST_VOLUME_FREQUENCY = 1

# These variables control the use of an external archiver.  Normally if
# archiving is turned on (see ARCHIVE_TO_MBOX above and the list's archive*
# attributes) the internal Pipermail archiver is used.  This is the default if
# both of these variables are set to No.  When either is set, the value should
# be a shell command string which will get passed to os.popen().  This string
# can contain the following substitution strings:
#
#     %(listname)s -- gets the internal name of the list
#     %(hostname)s -- gets the email hostname for the list
#
# being archived will be substituted for this.  Please note that os.popen() is
# used.
#
# Note that if you set one of these variables, you should set both of them
# (they can be the same string).  This will mean your external archiver will
# be used regardless of whether public or private archives are selected.
PUBLIC_EXTERNAL_ARCHIVER = No
PRIVATE_EXTERNAL_ARCHIVER = No

# A filter module that converts from multipart messages to "flat" messages
# (i.e. containing a single payload).  This is required for Pipermail, and you
# may want to set it to 0 for external archivers.  You can also replace it
# with your own module as long as it contains a process() function that takes
# a MailList object and a Message object.  It should raise
# Errors.DiscardMessage if it wants to throw the message away.  Otherwise it
# should modify the Message object as necessary.
ARCHIVE_SCRUBBER = 'Mailman.Handlers.Scrubber'

# Control parameter whether Mailman.Handlers.Scrubber should use message
# attachment's filename as is indicated by the filename parameter or use
# 'attachement-xxx' instead.  The default is set True because the applications
# on PC and Mac begin to use longer non-ascii filenames.  Historically, it
# was set False in 2.1.6 for backward compatiblity but it was reset to True
# for safer operation in mailman-2.1.7.
SCRUBBER_DONT_USE_ATTACHMENT_FILENAME = True

# Use of attachment filename extension per se is may be dangerous because
# virus fakes it. You can set this True if you filter the attachment by
# filename extension
SCRUBBER_USE_ATTACHMENT_FILENAME_EXTENSION = False

# This variable defines what happens to text/html subparts.  They can be
# stripped completely, escaped, or filtered through an external program.  The
# legal values are:
# 0 - Strip out text/html parts completely, leaving a notice of the removal in
#     the message.  If the outer part is text/html, the entire message is
#     discarded.
# 1 - Remove any embedded text/html parts, leaving them as HTML-escaped
#     attachments which can be separately viewed.  Outer text/html parts are
#     simply HTML-escaped.
# 2 - Leave it inline, but HTML-escape it
# 3 - Remove text/html as attachments but don't HTML-escape them. Note: this
#     is very dangerous because it essentially means anybody can send an HTML
#     email to your site containing evil JavaScript or web bugs, or other
#     nasty things, and folks viewing your archives will be susceptible.  You
#     should only consider this option if you do heavy moderation of your list
#     postings.
#
# Note: given the current archiving code, it is not possible to leave
# text/html parts inline and un-escaped.  I wouldn't think it'd be a good idea
# to do anyway.
#
# The value can also be a string, in which case it is the name of a command to
# filter the HTML page through.  The resulting output is left in an attachment
# or as the entirety of the message when the outer part is text/html.  The
# format of the string must include a "%(filename)s" which will contain the
# name of the temporary file that the program should operate on.  It should
# write the processed message to stdout.  Set this to
# HTML_TO_PLAIN_TEXT_COMMAND to specify an HTML to plain text conversion
# program.
ARCHIVE_HTML_SANITIZER = 1

# Set this to Yes to enable gzipping of the downloadable archive .txt file.
# Note that this is /extremely/ inefficient, so an alternative is to just
# collect the messages in the associated .txt file and run a cron job every
# night to generate the txt.gz file.  See cron/nightly_gzip for details.
GZIP_ARCHIVE_TXT_FILES = No

# This sets the default `clobber date' policy for the archiver.  When a
# message is to be archived either by Pipermail or an external archiver,
# Mailman can modify the Date: header to be the date the message was received
# instead of the Date: in the original message.  This is useful if you
# typically receive messages with outrageous dates.  Set this to 0 to retain
# the date of the original message, or to 1 to always clobber the date.  Set
# it to 2 to perform `smart overrides' on the date; when the date is outside
# ARCHIVER_ALLOWABLE_SANE_DATE_SKEW (either too early or too late), then the
# received date is substituted instead.
ARCHIVER_CLOBBER_DATE_POLICY = 2
ARCHIVER_ALLOWABLE_SANE_DATE_SKEW = days(15)

# Pipermail archives contain the raw email addresses of the posting authors.
# Some view this as a goldmine for spam harvesters.  Set this to Yes to
# moderately obscure email addresses, but note that this breaks mailto: URLs
# in the archives too.
ARCHIVER_OBSCURES_EMAILADDRS = Yes

# Pipermail assumes that messages bodies contain US-ASCII text.
# Change this option to define a different character set to be used as
# the default character set for the archive.  The term "character set"
# is used in MIME to refer to a method of converting a sequence of
# octets into a sequence of characters.  If you change the default
# charset, you might need to add it to VERBATIM_ENCODING below.
DEFAULT_CHARSET = None

# Most character set encodings require special HTML entity characters to be
# quoted, otherwise they won't look right in the Pipermail archives.  However
# some character sets must not quote these characters so that they can be
# rendered properly in the browsers.  The primary issue is multi-byte
# encodings where the octet 0x26 does not always represent the & character.
# This variable contains a list of such characters sets which are not
# HTML-quoted in the archives.
VERBATIM_ENCODING = ['iso-2022-jp']

# When the archive is public, should Mailman also make the raw Unix mbox file
# publically available?
PUBLIC_MBOX = No



#####
# Delivery defaults
#####

# Final delivery module for outgoing mail.  This handler is used for message
# delivery to the list via the smtpd, and to an individual user.  This value
# must be a string naming a module in the Mailman.Handlers package.
#
# WARNING: Sendmail has security holes and should be avoided.  In fact, you
# must read the Mailman/Handlers/Sendmail.py file before it will work for
# you.
#
#DELIVERY_MODULE = 'Sendmail'
DELIVERY_MODULE = 'SMTPDirect'

# MTA should name a module in Mailman/MTA which provides the MTA specific
# functionality for creating and removing lists.  Some MTAs like Exim can be
# configured to automatically recognize new lists, in which case the MTA
# variable should be set to None.  Use 'Manual' to print new aliases to
# standard out (or send an email to the site list owner) for manual twiddling
# of an /etc/aliases style file.  Use 'Postfix' if you are using the Postfix
# MTA -- but then also see POSTFIX_STYLE_VIRTUAL_DOMAINS.
MTA = 'Manual'

# If you set MTA='Postfix', then you also want to set the following variable,
# depending on whether you're using virtual domains in Postfix, and which
# style of virtual domain you're using.  Set this flag to false if you're not
# using virtual domains in Postfix, or if you're using Sendmail-style virtual
# domains (where all addresses are visible in all domains).  If you're using
# Postfix-style virtual domains, where aliases should only show up in the
# virtual domain, set this variable to the list of host_name values to write
# separate virtual entries for.  I.e. if you run dom1.ain, dom2.ain, and
# dom3.ain, but only dom2 and dom3 are virtual, set this variable to the list
# ['dom2.ain', 'dom3.ain'].  Matches are done against the host_name attribute
# of the mailing lists.  See README.POSTFIX for details.
POSTFIX_STYLE_VIRTUAL_DOMAINS = []

# These variables describe the program to use for regenerating the aliases.db
# and virtual-mailman.db files, respectively, from the associated plain text
# files.  The file being updated will be appended to this string (with a
# separating space), so it must be appropriate for os.system().
POSTFIX_ALIAS_CMD = '/usr/sbin/postalias'
POSTFIX_MAP_CMD = '/usr/sbin/postmap'

# Ceiling on the number of recipients that can be specified in a single SMTP
# transaction.  Set to 0 to submit the entire recipient list in one
# transaction.  Only used with the SMTPDirect DELIVERY_MODULE.
SMTP_MAX_RCPTS = 500

# Ceiling on the number of SMTP sessions to perform on a single socket
# connection.  Some MTAs have limits.  Set this to 0 to do as many as we like
# (i.e. your MTA has no limits).  Set this to some number great than 0 and
# Mailman will close the SMTP connection and re-open it after this number of
# consecutive sessions.
SMTP_MAX_SESSIONS_PER_CONNECTION = 0

# Maximum number of simultaneous subthreads that will be used for SMTP
# delivery.  After the recipients list is chunked according to SMTP_MAX_RCPTS,
# each chunk is handed off to the smptd by a separate such thread.  If your
# Python interpreter was not built for threads, this feature is disabled.  You
# can explicitly disable it in all cases by setting MAX_DELIVERY_THREADS to
# 0.  This feature is only supported with the SMTPDirect DELIVERY_MODULE.
#
# NOTE: This is an experimental feature and limited testing shows that it may
# in fact degrade performance, possibly due to Python's global interpreter
# lock.  Use with caution.
MAX_DELIVERY_THREADS = 0

# SMTP host and port, when DELIVERY_MODULE is 'SMTPDirect'.  Make sure the
# host exists and is resolvable (i.e., if it's the default of "localhost" be
# sure there's a localhost entry in your /etc/hosts file!)
SMTPHOST = 'localhost'
SMTPPORT = 0                                      # default from smtplib

# Command for direct command pipe delivery to sendmail compatible program,
# when DELIVERY_MODULE is 'Sendmail'.
SENDMAIL_CMD = '/usr/lib/sendmail'

# Set these variables if you need to authenticate to your NNTP server for
# Usenet posting or reading.  If no authentication is necessary, specify None
# for both variables.
NNTP_USERNAME = None
NNTP_PASSWORD = None

# Set this if you have an NNTP server you prefer gatewayed lists to use.
DEFAULT_NNTP_HOST = ''

# These variables controls how headers must be cleansed in order to be
# accepted by your NNTP server.  Some servers like INN reject messages
# containing prohibited headers, or duplicate headers.  The NNTP server may
# reject the message for other reasons, but there's little that can be
# programmatically done about that.  See Mailman/Queue/NewsRunner.py
#
# First, these headers (case ignored) are removed from the original message.
NNTP_REMOVE_HEADERS = ['nntp-posting-host', 'nntp-posting-date', 'x-trace',
                       'x-complaints-to', 'xref', 'date-received', 'posted',
                       'posting-version', 'relay-version', 'received']

# Next, these headers are left alone, unless there are duplicates in the
# original message.  Any second and subsequent headers are rewritten to the
# second named header (case preserved).
NNTP_REWRITE_DUPLICATE_HEADERS = [
    ('to', 'X-Original-To'),
    ('cc', 'X-Original-Cc'),
    ('content-transfer-encoding', 'X-Original-Content-Transfer-Encoding'),
    ('mime-version', 'X-MIME-Version'),
    ]

# All `normal' messages which are delivered to the entire list membership go
# through this pipeline of handler modules.  Lists themselves can override the
# global pipeline by defining a `pipeline' attribute.
GLOBAL_PIPELINE = [
    # These are the modules that do tasks common to all delivery paths.
    'SpamDetect',
    'Approve',
    'Replybot',
    'Moderate',
    'Hold',
    'MimeDel',
    'Scrubber',
    'Emergency',
    'Tagger',
    'CalcRecips',
    'AvoidDuplicates',
    'Cleanse',
    'CleanseDKIM',
    'CookHeaders',
    # And now we send the message to the digest mbox file, and to the arch and
    # news queues.  Runners will provide further processing of the message,
    # specific to those delivery paths.
    'ToDigest',
    'ToArchive',
    'ToUsenet',
    # Now we'll do a few extra things specific to the member delivery
    # (outgoing) path, finally leaving the message in the outgoing queue.
    'AfterDelivery',
    'Acknowledge',
    'ToOutgoing',
    ]

# This is the pipeline which messages sent to the -owner address go through
OWNER_PIPELINE = [
    'SpamDetect',
    'Replybot',
    'CleanseDKIM',
    'OwnerRecips',
    'ToOutgoing',
    ]


# This defines syslog() format strings for the SMTPDirect delivery module (see
# DELIVERY_MODULE above).  Valid %()s string substitutions include:
#
#     time -- the time in float seconds that it took to complete the smtp
#     hand-off of the message from Mailman to your smtpd.
#
#     size -- the size of the entire message, in bytes
#
#     #recips -- the number of actual recipients for this message.
#
#     #refused -- the number of smtp refused recipients (use this only in
#     SMTP_LOG_REFUSED).
#
#     listname -- the `internal' name of the mailing list for this posting
#
#     msg_<header> -- the value of the delivered message's given header.  If
#     the message had no such header, then "n/a" will be used.  Note though
#     that if the message had multiple such headers, then it is undefined
#     which will be used.
#
#     allmsg_<header> - Same as msg_<header> above, but if there are multiple
#     such headers in the message, they will all be printed, separated by
#     comma-space.
#
#     sender -- the "sender" of the messages, which will be the From: or
#     envelope-sender as determeined by the USE_ENVELOPE_SENDER variable
#     below.
#
# The format of the entries is a 2-tuple with the first element naming the
# file in logs/ to print the message to, and the second being a format string
# appropriate for Python's %-style string interpolation.  The file name is
# arbitrary; qfiles/<name> will be created automatically if it does not
# exist.

# The format of the message printed for every delivered message, regardless of
# whether the delivery was successful or not.  Set to None to disable the
# printing of this log message.
SMTP_LOG_EVERY_MESSAGE = (
    'smtp',
    '%(msg_message-id)s smtp to %(listname)s for %(#recips)d recips, completed in %(time).3f seconds')

# This will only be printed if there were no immediate smtp failures.
# Mutually exclusive with SMTP_LOG_REFUSED.
SMTP_LOG_SUCCESS = (
    'post',
    'post to %(listname)s from %(sender)s, size=%(size)d, message-id=%(msg_message-id)s, success')

# This will only be printed if there were any addresses which encountered an
# immediate smtp failure.  Mutually exclusive with SMTP_LOG_SUCCESS.
SMTP_LOG_REFUSED = (
    'post',
    'post to %(listname)s from %(sender)s, size=%(size)d, message-id=%(msg_message-id)s, %(#refused)d failures')

# This will be logged for each specific recipient failure.  Additional %()s
# keys are:
#
#     recipient -- the failing recipient address
#     failcode  -- the smtp failure code
#     failmsg   -- the actual smtp message, if available
SMTP_LOG_EACH_FAILURE = (
    'smtp-failure',
    'delivery to %(recipient)s failed with code %(failcode)d: %(failmsg)s')

# These variables control the format and frequency of VERP-like delivery for
# better bounce detection.  VERP is Variable Envelope Return Path, defined
# here:
#
# http://cr.yp.to/proto/verp.txt
#
# This involves encoding the address of the recipient as we (Mailman) know it
# into the envelope sender address (i.e. the SMTP `MAIL FROM:' address).
# Thus, no matter what kind of forwarding the recipient has in place, should
# it eventually bounce, we will receive an unambiguous notice of the bouncing
# address.
#
# However, we're technically only "VERP-like" because we're doing the envelope
# sender encoding in Mailman, not in the MTA.  We do require cooperation from
# the MTA, so you must be sure your MTA can be configured for extended address
# semantics.
#
# The first variable describes how to encode VERP envelopes.  It must contain
# these three string interpolations:
#
# %(bounces)s -- the list-bounces mailbox will be set here
# %(mailbox)s -- the recipient's mailbox will be set here
# %(host)s    -- the recipient's host name will be set here
#
# This example uses the default below.
#
# FQDN list address is: mylist@dom.ain
# Recipient is:         aperson@a.nother.dom
#
# The envelope sender will be mylist-bounces+aperson=a.nother.dom@dom.ain
#
# Note that your MTA /must/ be configured to deliver such an addressed message
# to mylist-bounces!
VERP_FORMAT = '%(bounces)s+%(mailbox)s=%(host)s'

# The second describes a regular expression to unambiguously decode such an
# address, which will be placed in the To: header of the bounce message by the
# bouncing MTA.  Getting this right is critical -- and tricky.  Learn your
# Python regular expressions.  It must define exactly three named groups,
# bounces, mailbox and host, with the same definition as above.  It will be
# compiled case-insensitively.
VERP_REGEXP = r'^(?P<bounces>[^+]+?)\+(?P<mailbox>[^=]+)=(?P<host>[^@]+)@.*$'

# VERP format and regexp for probe messages
VERP_PROBE_FORMAT = '%(bounces)s+%(token)s'
VERP_PROBE_REGEXP = r'^(?P<bounces>[^+]+?)\+(?P<token>[^@]+)@.*$'
# Set this Yes to activate VERP probe for disabling by bounce
VERP_PROBES = No

# A perfect opportunity for doing VERP is the password reminders, which are
# already addressed individually to each recipient.  Set this to Yes to enable
# VERPs on all password reminders.
VERP_PASSWORD_REMINDERS = No

# Another good opportunity is when regular delivery is personalized.  Here
# again, we're already incurring the performance hit for addressing each
# individual recipient.  Set this to Yes to enable VERPs on all personalized
# regular deliveries (personalized digests aren't supported yet).
VERP_PERSONALIZED_DELIVERIES = No

# And finally, we can VERP normal, non-personalized deliveries.  However,
# because it can be a significant performance hit, we allow you to decide how
# often to VERP regular deliveries.  This is the interval, in number of
# messages, to do a VERP recipient address.  The same variable controls both
# regular and digest deliveries.  Set to 0 to disable occasional VERPs, set to
# 1 to VERP every delivery, or to some number > 1 for only occasional VERPs.
VERP_DELIVERY_INTERVAL = 0

# For nicer confirmation emails, use a VERP-like format which encodes the
# confirmation cookie in the reply address.  This lets us put a more user
# friendly Subject: on the message, but requires cooperation from the MTA.
# Format is like VERP_FORMAT above, but with the following substitutions:
#
# %(addr)s -- the list-confirm mailbox will be set here
# %(cookie)s  -- the confirmation cookie will be set here
VERP_CONFIRM_FORMAT = '%(addr)s+%(cookie)s'

# This is analogous to VERP_REGEXP, but for splitting apart the
# VERP_CONFIRM_FORMAT.  MUAs have been observed that mung
# From: local_part@host
# into
# To: "local_part" <local_part@host>
# when replying, so we skip everything up to '<' if any.
VERP_CONFIRM_REGEXP = r'^(.*<)?(?P<addr>[^+]+?)\+(?P<cookie>[^@]+)@.*$'

# Set this to Yes to enable VERP-like (more user friendly) confirmations
VERP_CONFIRMATIONS = No

# This is the maximum number of automatic responses sent to an address because
# of -request messages or posting hold messages.  This limit prevents response
# loops between Mailman and misconfigured remote email robots.  Mailman
# already inhibits automatic replies to any message labeled with a header
# "Precendence: bulk|list|junk".  This is a fallback safety valve so it should
# be set fairly high.  Set to 0 for no limit (probably useful only for
# debugging).
MAX_AUTORESPONSES_PER_DAY = 10



#####
# Qrunner defaults
#####

# Which queues should the qrunner master watchdog spawn?  This is a list of
# 2-tuples containing the name of the qrunner class (which must live in a
# module of the same name within the Mailman.Queue package), and the number of
# parallel processes to fork for each qrunner.  If more than one process is
# used, each will take an equal subdivision of the hash space.

# BAW: Eventually we may support weighted hash spaces.
# BAW: Although not enforced, the # of slices must be a power of 2

QRUNNERS = [
    ('ArchRunner',     1), # messages for the archiver
    ('BounceRunner',   1), # for processing the qfile/bounces directory
    ('CommandRunner',  1), # commands and bounces from the outside world
    ('IncomingRunner', 1), # posts from the outside world
    ('NewsRunner',     1), # outgoing messages to the nntpd
    ('OutgoingRunner', 1), # outgoing messages to the smtpd
    ('VirginRunner',   1), # internally crafted (virgin birth) messages
    ('RetryRunner',    1), # retry temporarily failed deliveries
    ]

# Set this to Yes to use the `Maildir' delivery option.  If you change this
# you will need to re-run bin/genaliases for MTAs that don't use list
# auto-detection.
#
# WARNING: If you want to use Maildir delivery, you /must/ start Mailman's
# qrunner as root, or you will get permission problems.
#
# NOTE: Maildir delivery is experimental for Mailman 2.1.
USE_MAILDIR = No
# NOTE: If you set USE_MAILDIR = Yes, add the following line to your mm_cfg.py
# file (uncommented of course!)
# QRUNNERS.append(('MaildirRunner', 1))

# After processing every file in the qrunner's slice, how long should the
# runner sleep for before checking the queue directory again for new files?
# This can be a fraction of a second, or zero to check immediately
# (essentially busy-loop as fast as possible).
QRUNNER_SLEEP_TIME = seconds(1)

# When a message that is unparsable (by the email package) is received, what
# should we do with it?  The most common cause of unparsable messages is
# broken MIME encapsulation, and the most common cause of that is viruses like
# Nimda.  Set this variable to No to discard such messages, or to Yes to store
# them in qfiles/bad subdirectory.
QRUNNER_SAVE_BAD_MESSAGES = Yes

# This flag causes Mailman to fsync() its data files after writing and
# flushing its contents.  While this ensures the data is written to disk,
# avoiding data loss, it may be a performance killer.  Note that this flag
# affects both message pickles and MailList config.pck files.
SYNC_AFTER_WRITE = No



#####
# General defaults
#####

# The default language for this server.  Whenever we can't figure out the list
# context or user context, we'll fall back to using this language.  See
# LC_DESCRIPTIONS below for legal values.
DEFAULT_SERVER_LANGUAGE = 'en'

# When allowing only members to post to a mailing list, how is the sender of
# the message determined?  If this variable is set to Yes, then first the
# message's envelope sender is used, with a fallback to the sender if there is
# no envelope sender.  Set this variable to No to always use the sender.
#
# The envelope sender is set by the SMTP delivery and is thus less easily
# spoofed than the sender, which is typically just taken from the From: header
# and thus easily spoofed by the end-user.  However, sometimes the envelope
# sender isn't set correctly and this will manifest itself by postings being
# held for approval even if they appear to come from a list member.  If you
# are having this problem, set this variable to No, but understand that some
# spoofed messages may get through.
USE_ENVELOPE_SENDER = No

# Membership tests for posting purposes are usually performed by looking at a
# set of headers, passing the test if any of their values match a member of
# the list.  Headers are checked in the order given in this variable.  The
# value None means use the From_ (envelope sender) header.  Field names are
# case insensitive.
SENDER_HEADERS = ('from', None, 'reply-to', 'sender')

# How many members to display at a time on the admin cgi to unsubscribe them
# or change their options?
DEFAULT_ADMIN_MEMBER_CHUNKSIZE = 30

# how many bytes of a held message post should be displayed in the admindb web
# page?  Use a negative number to indicate the entire message, regardless of
# size (though this will slow down rendering those pages).
ADMINDB_PAGE_TEXT_LIMIT = 4096

# Set this variable to Yes to allow list owners to delete their own mailing
# lists.  You may not want to give them this power, in which case, setting
# this variable to No instead requires list removal to be done by the site
# administrator, via the command line script bin/rmlist.
OWNERS_CAN_DELETE_THEIR_OWN_LISTS = No

# Set this variable to Yes to allow list owners to set the "personalized"
# flags on their mailing lists.  Turning these on tells Mailman to send
# separate email messages to each user instead of batching them together for
# delivery to the MTA.  This gives each member a more personalized message,
# but can have a heavy impact on the performance of your system.
OWNERS_CAN_ENABLE_PERSONALIZATION = No

# Should held messages be saved on disk as Python pickles or as plain text?
# The former is more efficient since we don't need to go through the
# parse/generate roundtrip each time, but the latter might be preferred if you
# want to edit the held message on disk.
HOLD_MESSAGES_AS_PICKLES = Yes

# This variable controls the order in which list-specific category options are
# presented in the admin cgi page.
ADMIN_CATEGORIES = [
    # First column
    'general', 'passwords', 'language', 'members', 'nondigest', 'digest',
    # Second column
    'privacy', 'bounce', 'archive', 'gateway', 'autoreply',
    'contentfilter', 'topics',
    ]

# See "Bitfield for user options" below; make this a sum of those options, to
# make all new members of lists start with those options flagged.  We assume
# by default that people don't want to receive two copies of posts.  Note
# however that the member moderation flag's initial value is controlled by the
# list's config variable default_member_moderation.
DEFAULT_NEW_MEMBER_OPTIONS = 256

# Specify the type of passwords to use, when Mailman generates the passwords
# itself, as would be the case for membership requests where the user did not
# fill in a password, or during list creation, when auto-generation of admin
# passwords was selected.
#
# Set this value to Yes for classic Mailman user-friendly(er) passwords.
# These generate semi-pronounceable passwords which are easier to remember.
# Set this value to No to use more cryptographically secure, but harder to
# remember, passwords -- if your operating system and Python version support
# the necessary feature (specifically that /dev/urandom be available).
USER_FRIENDLY_PASSWORDS = Yes
# This value specifies the default lengths of member and list admin passwords
MEMBER_PASSWORD_LENGTH = 10 
ADMIN_PASSWORD_LENGTH = 10



#####
# List defaults.  NOTE: Changing these values does NOT change the
# configuration of an existing list.  It only defines the default for new
# lists you subsequently create.
#####

# Should a list, by default be advertised?  What is the default maximum number
# of explicit recipients allowed?  What is the default maximum message size
# allowed?
DEFAULT_LIST_ADVERTISED = Yes
DEFAULT_MAX_NUM_RECIPIENTS = 10
DEFAULT_MAX_MESSAGE_SIZE = 40           # KB

# These format strings will be expanded w.r.t. the dictionary for the
# mailing list instance.
DEFAULT_SUBJECT_PREFIX  = "[%(real_name)s] "
# DEFAULT_SUBJECT_PREFIX = "[%(real_name)s %%d]" # for numbering
DEFAULT_MSG_HEADER = ""
DEFAULT_MSG_FOOTER = """_______________________________________________
%(real_name)s mailing list
%(real_name)s@%(host_name)s
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
"""

# Where to put subject prefix for 'Re:' messages:
#
#     old style: Re: [prefix] test
#     new style: [prefix 123] Re: test ... (number is optional)
#
# Old style is default for backward compatibility.  New style is forced if a
# list owner set %d (numbering) in prefix.  If the site owner had applied new
# style patch (from SF patch area) before, he/she may want to set this No in
# mm_cfg.py.
OLD_STYLE_PREFIXING = Yes

# Scrub regular delivery
DEFAULT_SCRUB_NONDIGEST = False

# Mail command processor will ignore mail command lines after designated max.
DEFAULT_MAIL_COMMANDS_MAX_LINES = 25

# Is the list owner notified of admin requests immediately by mail, as well as
# by daily pending-request reminder?
DEFAULT_ADMIN_IMMED_NOTIFY = Yes

# Is the list owner notified of subscribes/unsubscribes?
DEFAULT_ADMIN_NOTIFY_MCHANGES = No

# Discard held messages after this days
DEFAULT_MAX_DAYS_TO_HOLD = 0

# Should list members, by default, have their posts be moderated?
DEFAULT_DEFAULT_MEMBER_MODERATION = No

# Should non-member posts which are auto-discarded also be forwarded to the
# moderators?
DEFAULT_FORWARD_AUTO_DISCARDS = Yes

# What shold happen to non-member posts which are do not match explicit
# non-member actions?
# 0 = Accept
# 1 = Hold
# 2 = Reject
# 3 = Discard
DEFAULT_GENERIC_NONMEMBER_ACTION = 1

# Bounce if 'To:', 'Cc:', or 'Resent-To:' fields don't explicitly name list?
# This is an anti-spam measure
DEFAULT_REQUIRE_EXPLICIT_DESTINATION = Yes

# Alternate names acceptable as explicit destinations for this list.
DEFAULT_ACCEPTABLE_ALIASES ="""
"""
# For mailing lists that have only other mailing lists for members:
DEFAULT_UMBRELLA_LIST = No

# For umbrella lists, the suffix for the account part of address for
# administrative notices (subscription confirmations, password reminders):
DEFAULT_UMBRELLA_MEMBER_ADMIN_SUFFIX = "-owner"

# This variable controls whether monthly password reminders are sent.
DEFAULT_SEND_REMINDERS = Yes

# Send welcome messages to new users?
DEFAULT_SEND_WELCOME_MSG = Yes

# Send goodbye messages to unsubscribed members?
DEFAULT_SEND_GOODBYE_MSG = Yes

# Wipe sender information, and make it look like the list-admin
# address sends all messages
DEFAULT_ANONYMOUS_LIST = No

# {header-name: regexp} spam filtering - we include some for example sake.
DEFAULT_BOUNCE_MATCHING_HEADERS = """
# Lines that *start* with a '#' are comments.
to: friend@public.com
message-id: relay.comanche.denmark.eu
from: list@listme.com
from: .*@uplinkpro.com
"""

# Mailman can be configured to "munge" Reply-To: headers for any passing
# messages.  One the one hand, there are a lot of good reasons not to munge
# Reply-To: but on the other, people really seem to want this feature.  See
# the help for reply_goes_to_list in the web UI for links discussing the
# issue.
# 0 - Reply-To: not munged
# 1 - Reply-To: set back to the list
# 2 - Reply-To: set to an explicit value (reply_to_address)
DEFAULT_REPLY_GOES_TO_LIST = 0

# Mailman can be configured to strip any existing Reply-To: header, or simply
# extend any existing Reply-To: with one based on the above setting.
DEFAULT_FIRST_STRIP_REPLY_TO = No

# SUBSCRIBE POLICY
# 0 - open list (only when ALLOW_OPEN_SUBSCRIBE is set to 1) **
# 1 - confirmation required for subscribes
# 2 - admin approval required for subscribes
# 3 - both confirmation and admin approval required
#
# ** please do not choose option 0 if you are not allowing open
# subscribes (next variable)
DEFAULT_SUBSCRIBE_POLICY = 1

# Does this site allow completely unchecked subscriptions?
ALLOW_OPEN_SUBSCRIBE = No

# The default policy for unsubscriptions.  0 (unmoderated unsubscribes) is
# highly recommended!
# 0 - unmoderated unsubscribes
# 1 - unsubscribes require approval
DEFAULT_UNSUBSCRIBE_POLICY = 0

# Private_roster == 0: anyone can see, 1: members only, 2: admin only.
DEFAULT_PRIVATE_ROSTER = 1

# When exposing members, make them unrecognizable as email addrs, so
# web-spiders can't pick up addrs for spam purposes.
DEFAULT_OBSCURE_ADDRESSES = Yes

# RFC 2369 defines List-* headers which are added to every message sent
# through to the mailing list membership.  These are a very useful aid to end
# users and should always be added.  However, not all MUAs are compliant and
# if a list's membership has many such users, they may clamor for these
# headers to be suppressed.  By setting this variable to Yes, list owners will
# be given the option to suppress these headers.  By setting it to No, list
# owners will not be given the option to suppress these headers (although some
# header suppression may still take place, i.e. for announce-only lists, or
# lists with no archives).
ALLOW_RFC2369_OVERRIDES = Yes

# Defaults for content filtering on mailing lists.  DEFAULT_FILTER_CONTENT is
# a flag which if set to true, turns on content filtering.
DEFAULT_FILTER_CONTENT = No

# DEFAULT_FILTER_MIME_TYPES is a list of MIME types to be removed.  This is a
# list of strings of the format "maintype/subtype" or simply "maintype".
# E.g. "text/html" strips all html attachments while "image" strips all image
# types regardless of subtype (jpeg, gif, etc.).
DEFAULT_FILTER_MIME_TYPES = []

# DEFAULT_PASS_MIME_TYPES is a list of MIME types to be passed through.
# Format is the same as DEFAULT_FILTER_MIME_TYPES
DEFAULT_PASS_MIME_TYPES = ['multipart/mixed',
                           'multipart/alternative',
                           'text/plain']

# DEFAULT_FILTER_FILENAME_EXTENSIONS is a list of filename extensions to be
# removed. It is useful because many viruses fake their content-type as
# harmless ones while keep their extension as executable and expect to be
# executed when victims 'open' them.
DEFAULT_FILTER_FILENAME_EXTENSIONS = [
    'exe', 'bat', 'cmd', 'com', 'pif', 'scr', 'vbs', 'cpl'
    ]

# DEFAULT_PASS_FILENAME_EXTENSIONS is a list of filename extensions to be
# passed through. Format is the same as DEFAULT_FILTER_FILENAME_EXTENSIONS.
DEFAULT_PASS_FILENAME_EXTENSIONS = []

# Replace multipart/alternative with its first alternative.
DEFAULT_COLLAPSE_ALTERNATIVES = Yes

# Whether text/html should be converted to text/plain after content filtering
# is performed.  Conversion is done according to HTML_TO_PLAIN_TEXT_COMMAND
DEFAULT_CONVERT_HTML_TO_PLAINTEXT = Yes

# Default action to take on filtered messages.
# 0 = Discard, 1 = Reject, 2 = Forward, 3 = Preserve
DEFAULT_FILTER_ACTION = 0

# Whether to allow list owners to preserve content filtered messages to a
# special queue on the disk.
OWNERS_CAN_PRESERVE_FILTERED_MESSAGES = Yes

# Check for administrivia in messages sent to the main list?
DEFAULT_ADMINISTRIVIA = Yes



#####
# Digestification defaults.  Same caveat applies here as with list defaults.
#####

# Will list be available in non-digested form?
DEFAULT_NONDIGESTABLE = Yes

# Will list be available in digested form?
DEFAULT_DIGESTABLE = Yes
DEFAULT_DIGEST_HEADER = ""
DEFAULT_DIGEST_FOOTER = DEFAULT_MSG_FOOTER

DEFAULT_DIGEST_IS_DEFAULT = No
DEFAULT_MIME_IS_DEFAULT_DIGEST = No
DEFAULT_DIGEST_SIZE_THRESHHOLD = 30     # KB
DEFAULT_DIGEST_SEND_PERIODIC = Yes

# Headers which should be kept in both RFC 1153 (plain) and MIME digests.  RFC
# 1153 also specifies these headers in this exact order, so order matters.
MIME_DIGEST_KEEP_HEADERS = [
    'Date', 'From', 'To', 'Cc', 'Subject', 'Message-ID', 'Keywords',
    # I believe we should also keep these headers though.
    'In-Reply-To', 'References', 'Content-Type', 'MIME-Version',
    'Content-Transfer-Encoding', 'Precedence', 'Reply-To',
    # Mailman 2.0 adds these headers
    'Message',
    ]

PLAIN_DIGEST_KEEP_HEADERS = [
    'Message', 'Date', 'From',
    'Subject', 'To', 'Cc',
    'Message-ID', 'Keywords',
    'Content-Type',
    ]



#####
# Bounce processing defaults.  Same caveat applies here as with list defaults.
#####

# Should we do any bounced mail response at all?
DEFAULT_BOUNCE_PROCESSING = Yes

# How often should the bounce qrunner process queued detected bounces?
REGISTER_BOUNCES_EVERY = minutes(15)

# Bounce processing works like this: when a bounce from a member is received,
# we look up the `bounce info' for this member. If there is no bounce info,
# this is the first bounce we've received from this member.  In that case, we
# record today's date, and initialize the bounce score (see below for initial
# value).
#
# If there is existing bounce info for this member, we look at the last bounce
# receive date.  If this date is farther away from today than the `bounce
# expiration interval', we throw away all the old data and initialize the
# bounce score as if this were the first bounce from the member.
#
# Otherwise, we increment the bounce score.  If we can determine whether the
# bounce was soft or hard (i.e. transient or fatal), then we use a score value
# of 0.5 for soft bounces and 1.0 for hard bounces.  Note that we only score
# one bounce per day.  If the bounce score is then greater than the `bounce
# threshold' we disable the member's address.
#
# After disabling the address, we can send warning messages to the member,
# providing a confirmation cookie/url for them to use to re-enable their
# delivery.  After a configurable period of time, we'll delete the address.
# When we delete the address due to bouncing, we'll send one last message to
# the member.

# Bounce scores greater than this value get disabled.
DEFAULT_BOUNCE_SCORE_THRESHOLD = 5.0

# Bounce information older than this interval is considered stale, and is
# discarded.
DEFAULT_BOUNCE_INFO_STALE_AFTER = days(7)

# The number of notifications to send to the disabled/removed member before we
# remove them from the list.  A value of 0 means we remove the address
# immediately (with one last notification).  Note that the first one is sent
# upon change of status to disabled.
DEFAULT_BOUNCE_YOU_ARE_DISABLED_WARNINGS = 3

# The interval of time between disabled warnings.
DEFAULT_BOUNCE_YOU_ARE_DISABLED_WARNINGS_INTERVAL = days(7)

# Does the list owner get messages to the -bounces (and -admin) address that
# failed to match by the bounce detector?
DEFAULT_BOUNCE_UNRECOGNIZED_GOES_TO_LIST_OWNER = Yes

# Notifications on bounce actions.  The first specifies whether the list owner
# should get a notification when a member is disabled due to bouncing, while
# the second specifies whether the owner should get one when the member is
# removed due to bouncing.
DEFAULT_BOUNCE_NOTIFY_OWNER_ON_DISABLE = Yes
DEFAULT_BOUNCE_NOTIFY_OWNER_ON_REMOVAL = Yes



#####
# General time limits
#####

# Default length of time a pending request is live before it is evicted from
# the pending database.
PENDING_REQUEST_LIFE = days(3)

# How long should messages which have delivery failures continue to be
# retried?  After this period of time, a message that has failed recipients
# will be dequeued and those recipients will never receive the message.
DELIVERY_RETRY_PERIOD = days(5)

# How long should we wait before we retry a temporary delivery failure?
DELIVERY_RETRY_WAIT = hours(1)



#####
# Lock management defaults
#####

# These variables control certain aspects of lock acquisition and retention.
# They should be tuned as appropriate for your environment.  All variables are
# specified in units of floating point seconds.  YOU MAY NEED TO TUNE THESE
# VARIABLES DEPENDING ON THE SIZE OF YOUR LISTS, THE PERFORMANCE OF YOUR
# HARDWARE, NETWORK AND GENERAL MAIL HANDLING CAPABILITIES, ETC.

# Set this to On to turn on MailList object lock debugging messages, which
# will be written to logs/locks.  If you think you're having lock problems, or
# just want to tune the locks for your system, turn on lock debugging.
LIST_LOCK_DEBUGGING = Off

# This variable specifies how long the lock will be retained for a specific
# operation on a mailing list.  Watch your logs/lock file and if you see a lot
# of lock breakages, you might need to bump this up.  However if you set this
# too high, a faulty script (or incorrect use of bin/withlist) can prevent the
# list from being used until the lifetime expires.  This is probably one of
# the most crucial tuning variables in the system.
LIST_LOCK_LIFETIME = hours(5)

# This variable specifies how long an attempt will be made to acquire a list
# lock by the incoming qrunner process.  If the lock acquisition times out,
# the message will be re-queued for later delivery.
LIST_LOCK_TIMEOUT = seconds(10)

# Set this to On to turn on lock debugging messages for the pending requests
# database, which will be written to logs/locks.  If you think you're having
# lock problems, or just want to tune the locks for your system, turn on lock
# debugging.
PENDINGDB_LOCK_DEBUGGING = Off



#####
# Nothing below here is user configurable.  Most of these values are in this
# file for internal system convenience.  Don't change any of them or override
# any of them in your mm_cfg.py file!
#####

# These directories are used to find various important files in the Mailman
# installation.  PREFIX and EXEC_PREFIX are set by configure and should point
# to the installation directory of the Mailman package.
PYTHON          = '/usr/bin/python'
PREFIX          = '/usr/lib/mailman'
EXEC_PREFIX     = '${prefix}'
VAR_PREFIX      = '/var/lib/mailman'

# Work around a bogus autoconf 2.12 bug
if EXEC_PREFIX == '${prefix}':
    EXEC_PREFIX = PREFIX

# CGI extension, change using configure script
CGIEXT = ''

# Group id that group-owns the Mailman installation
MAILMAN_USER = 'mailman'
MAILMAN_GROUP = 'mailman'

# Enumeration for Mailman cgi widget types
Toggle      = 1
Radio       = 2
String      = 3
Text        = 4
Email       = 5
EmailList   = 6
Host        = 7
Number      = 8
FileUpload  = 9
Select      = 10
Topics      = 11
Checkbox    = 12
# An "extended email list".  Contents must be an email address or a ^-prefixed
# regular expression.  Used in the sender moderation text boxes.
EmailListEx = 13
# Extended spam filter widget
HeaderFilter  = 14

# Actions
DEFER = 0
APPROVE = 1
REJECT = 2
DISCARD = 3
SUBSCRIBE = 4
UNSUBSCRIBE = 5
ACCEPT = 6
HOLD = 7

# Standard text field width
TEXTFIELDWIDTH = 40 

# Bitfield for user options.  See DEFAULT_NEW_MEMBER_OPTIONS above to set
# defaults for all new lists.
Digests             = 0 # handled by other mechanism, doesn't need a flag.
DisableDelivery     = 1 # Obsolete; use set/getDeliveryStatus()
DontReceiveOwnPosts = 2 # Non-digesters only
AcknowledgePosts    = 4
DisableMime         = 8 # Digesters only
ConcealSubscription = 16
SuppressPasswordReminder = 32
ReceiveNonmatchingTopics = 64
Moderate = 128
DontReceiveDuplicates = 256

# A mapping between short option tags and their flag
OPTINFO = {'hide'    : ConcealSubscription,
           'nomail'  : DisableDelivery,
           'ack'     : AcknowledgePosts,
           'notmetoo': DontReceiveOwnPosts,
           'digest'  : 0,
           'plain'   : DisableMime,
           'nodupes' : DontReceiveDuplicates
           }

# Authentication contexts.
#
# Mailman defines the following roles:

# - User, a normal user who has no permissions except to change their personal
#   option settings
# - List creator, someone who can create and delete lists, but cannot
#   (necessarily) configure the list.
# - List moderator, someone who can tend to pending requests such as
#   subscription requests, or held messages
# - List administrator, someone who has total control over a list, can
#   configure it, modify user options for members of the list, subscribe and
#   unsubscribe members, etc.
# - Site administrator, someone who has total control over the entire site and
#   can do any of the tasks mentioned above.  This person usually also has
#   command line access.

UnAuthorized = 0
AuthUser = 1          # Joe Shmoe User
AuthCreator = 2       # List Creator / Destroyer
AuthListAdmin = 3     # List Administrator (total control over list)
AuthListModerator = 4 # List Moderator (can only handle held requests)
AuthSiteAdmin = 5     # Site Administrator (total control over everything)

# Useful directories
LIST_DATA_DIR   = os.path.join(VAR_PREFIX, 'lists')
LOG_DIR         = '/var/log/mailman'
LOCK_DIR        = '/var/lock/mailman'
CONFIG_DIR      = '/etc/mailman'
DATA_DIR        = os.path.join(VAR_PREFIX, 'data')
PID_DIR         = '/var/run/mailman'
SPAM_DIR        = os.path.join(VAR_PREFIX, 'spam')
WRAPPER_DIR     = os.path.join(EXEC_PREFIX, 'mail')
BIN_DIR         = os.path.join(PREFIX, 'bin')
SCRIPTS_DIR     = os.path.join(PREFIX, 'scripts')
TEMPLATE_DIR    = os.path.join(PREFIX, 'templates')
MESSAGES_DIR    = os.path.join(PREFIX, 'messages')
PUBLIC_ARCHIVE_FILE_DIR  = os.path.join(VAR_PREFIX, 'archives', 'public')
PRIVATE_ARCHIVE_FILE_DIR = os.path.join(VAR_PREFIX, 'archives', 'private')

# Directories used by the qrunner subsystem
QUEUE_DIR       = '/var/spool/mailman'
INQUEUE_DIR     = os.path.join(QUEUE_DIR, 'in')
OUTQUEUE_DIR    = os.path.join(QUEUE_DIR, 'out')
CMDQUEUE_DIR    = os.path.join(QUEUE_DIR, 'commands')
BOUNCEQUEUE_DIR = os.path.join(QUEUE_DIR, 'bounces')
NEWSQUEUE_DIR   = os.path.join(QUEUE_DIR, 'news')
ARCHQUEUE_DIR   = os.path.join(QUEUE_DIR, 'archive')
SHUNTQUEUE_DIR  = os.path.join(QUEUE_DIR, 'shunt')
VIRGINQUEUE_DIR = os.path.join(QUEUE_DIR, 'virgin')
BADQUEUE_DIR    = os.path.join(QUEUE_DIR, 'bad')
RETRYQUEUE_DIR  = os.path.join(QUEUE_DIR, 'retry')
MAILDIR_DIR     = os.path.join(QUEUE_DIR, 'maildir')

# Other useful files
PIDFILE = os.path.join(PID_DIR, 'master-qrunner.pid')
SITE_PW_FILE = os.path.join(CONFIG_DIR, 'adm.pw')
LISTCREATOR_PW_FILE = os.path.join(CONFIG_DIR, 'creator.pw')

# Import a bunch of version numbers
from Version import *

# Vgg: Language descriptions and charsets dictionary, any new supported
# language must have a corresponding entry here. Key is the name of the
# directories that hold the localized texts. Data are tuples with first
# element being the description, as described in the catalogs, and second
# element is the language charset.  I have chosen code from /usr/share/locale
# in my GNU/Linux. :-)
def _(s):
    return s

LC_DESCRIPTIONS = {}

def add_language(code, description, charset):
    LC_DESCRIPTIONS[code] = (description, charset)

add_language('ar',    _('Arabic'),              'utf-8')
add_language('ca',    _('Catalan'),             'iso-8859-1')
add_language('cs',    _('Czech'),               'iso-8859-2')
add_language('da',    _('Danish'),              'iso-8859-1')
add_language('de',    _('German'),              'iso-8859-1')
add_language('en',    _('English (USA)'),       'us-ascii')
add_language('es',    _('Spanish (Spain)'),     'iso-8859-1')
add_language('et',    _('Estonian'),            'iso-8859-15')
add_language('eu',    _('Euskara'),             'iso-8859-15') # Basque
add_language('fi',    _('Finnish'),             'iso-8859-1')
add_language('fr',    _('French'),              'iso-8859-1')
add_language('hr',    _('Croatian'),            'iso-8859-2')
add_language('hu',    _('Hungarian'),           'iso-8859-2')
add_language('ia',    _('Interlingua'),         'iso-8859-15')
add_language('it',    _('Italian'),             'iso-8859-1')
add_language('ja',    _('Japanese'),            'euc-jp')
add_language('ko',    _('Korean'),              'euc-kr')
add_language('lt',    _('Lithuanian'),          'iso-8859-13')
add_language('nl',    _('Dutch'),               'iso-8859-1')
add_language('no',    _('Norwegian'),           'iso-8859-1')
add_language('pl',    _('Polish'),              'iso-8859-2')
add_language('pt',    _('Portuguese'),          'iso-8859-1')
add_language('pt_BR', _('Portuguese (Brazil)'), 'iso-8859-1')
add_language('ro',    _('Romanian'),            'iso-8859-2')
add_language('ru',    _('Russian'),             'koi8-r')
add_language('sr',    _('Serbian'),             'utf-8')
add_language('sl',    _('Slovenian'),           'iso-8859-2')
add_language('sv',    _('Swedish'),             'iso-8859-1')
add_language('tr',    _('Turkish'),             'iso-8859-9')
add_language('uk',    _('Ukrainian'),           'utf-8')
add_language('vi',    _('Vietnamese'),          'utf-8')
add_language('zh_CN', _('Chinese (China)'),     'utf-8')
add_language('zh_TW', _('Chinese (Taiwan)'),    'utf-8')

del _
