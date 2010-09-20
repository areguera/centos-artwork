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


"""Routines for presentation of list-specific HTML text."""

import time
import re

from Mailman import mm_cfg
from Mailman import Utils
from Mailman import MemberAdaptor
from Mailman.htmlformat import *

from Mailman.i18n import _


EMPTYSTRING = ''
COMMASPACE = ', '



class HTMLFormatter:
    def GetMailmanFooter(self):
        ownertext = COMMASPACE.join([Utils.ObscureEmail(a, 1)
                                     for a in self.owner])
        # Remove the .Format() when htmlformat conversion is done.
        realname = self.real_name
        hostname = self.host_name
        listinfo_link = Link(self.GetScriptURL('listinfo'), realname).Format()
        owner_link = Link('mailto:' + self.GetOwnerEmail(), ownertext).Format()
        innertext = _('%(listinfo_link)s list run by %(owner_link)s')
        return Container(
            '<p>',
            #Address(
                Container(
                   innertext,
                    '<br />',
                    Link(self.GetScriptURL('admin'),
                         _('%(realname)s administrative interface')),
                    _(' (requires authorization)'),
                    '<br />',
                    Link(Utils.ScriptURL('listinfo'),
                         _('Overview of all %(hostname)s mailing lists')),
                    '</p>', MailmanLogo())).Format()

    def FormatUsers(self, digest, lang=None):
        if lang is None:
            lang = self.preferred_language
        conceal_sub = mm_cfg.ConcealSubscription
        people = []
        if digest:
            digestmembers = self.getDigestMemberKeys()
            for dm in digestmembers:
                if not self.getMemberOption(dm, conceal_sub):
                    people.append(dm)
            num_concealed = len(digestmembers) - len(people)
        else:
            members = self.getRegularMemberKeys()
            for m in members:
                if not self.getMemberOption(m, conceal_sub):
                    people.append(m)
            num_concealed = len(members) - len(people)
        if num_concealed == 1:
            concealed = _('<em>(1 private member not shown)</em>')
        elif num_concealed > 1:
           concealed = _(
               '<em>(%(num_concealed)d private members not shown)</em>')
        else:
            concealed = ''
        items = []
        people.sort()
        obscure = self.obscure_addresses
        for person in people:
            id = Utils.ObscureEmail(person)
            url = self.GetOptionsURL(person, obscure=obscure)
            if obscure:
                showing = Utils.ObscureEmail(person, for_text=1)
            else:
                showing = person
            got = Link(url, showing)
            if self.getDeliveryStatus(person) <> MemberAdaptor.ENABLED:
                got = Italic('(', got, ')')
            items.append(got)
        # Just return the .Format() so this works until I finish
        # converting everything to htmlformat...
        return concealed + UnorderedList(*tuple(items)).Format()

    def FormatOptionButton(self, option, value, user):
        if option == mm_cfg.DisableDelivery:
            optval = self.getDeliveryStatus(user) <> MemberAdaptor.ENABLED
        else:
            optval = self.getMemberOption(user, option)
        if optval == value:
            checked = ' checked="checked"'
        else:
            checked = ''
        name = {mm_cfg.DontReceiveOwnPosts      : 'dontreceive',
                mm_cfg.DisableDelivery          : 'disablemail',
                mm_cfg.DisableMime              : 'mime',
                mm_cfg.AcknowledgePosts         : 'ackposts',
                mm_cfg.Digests                  : 'digest',
                mm_cfg.ConcealSubscription      : 'conceal',
                mm_cfg.SuppressPasswordReminder : 'remind',
                mm_cfg.ReceiveNonmatchingTopics : 'rcvtopic',
                mm_cfg.DontReceiveDuplicates    : 'nodupes',
                }[option]
        return '<input type="radio" name="%s" value="%d"%s />' % (
            name, value, checked)

    def FormatDigestButton(self):
        if self.digest_is_default:
            checked = ' checked="checked"'
        else:
            checked = ''
        return '<input type="radio" name="digest" value="1"%s />' % checked

    def FormatDisabledNotice(self, user):
        status = self.getDeliveryStatus(user)
        reason = None
        info = self.getBounceInfo(user)
        if status == MemberAdaptor.BYUSER:
            reason = _('; it was disabled by you')
        elif status == MemberAdaptor.BYADMIN:
            reason = _('; it was disabled by the list administrator')
        elif status == MemberAdaptor.BYBOUNCE:
            date = time.strftime('%d-%b-%Y',
                                 time.localtime(Utils.midnight(info.date)))
            reason = _('''; it was disabled due to excessive bounces.  The
            last bounce was received on %(date)s''')
        elif status == MemberAdaptor.UNKNOWN:
            reason = _('; it was disabled for unknown reasons')
        if reason:
            note = Header(3, _('Your list delivery is currently disabled%(reason)s.')).Format()
            link = Link('#mdelivery', _('Mail delivery')).Format()
            mailto = Link('mailto:' + self.GetOwnerEmail(),
                          _('the list administrator')).Format()
	    note = Div(note, Paragraph(_('''You may have disabled list delivery intentionally, or it may have been triggered by bounces from your email address. In either case, to re-enable delivery, change the %(link)s option below. Contact %(mailto)s if you have any questions or need assistance.'''))).Format(css='class="message warning"')
	    return note
        elif info and info.score > 0:
            # Provide information about their current bounce score.  We know
            # their membership is currently enabled.
            score = info.score
            total = self.bounce_score_threshold
	    note = Div(Paragraph(_('''
            We have received some recent bounces from your
            address.  Your current <em>bounce score</em> is %(score)s out of a
            maximum of %(total)s.  Please double check that your subscribed
            address is correct and that there are no problems with delivery to
            this address.  Your bounce score will be automatically reset if
            the problems are corrected soon.
	    '''))).Format(css='class="message warning"')
	    return note
        else:
            return ''

    def FormatUmbrellaNotice(self, user, type):
        addr = self.GetMemberAdminEmail(user)
        if self.umbrella_list:
	    msg = Paragraph(_('''
            You are subscribing to a list of mailing 
	    lists, so the %(type)s notice will be sent to 
	    the admin address for your membership, %(addr)s.
	    ''')).Format()
	    return msg 
        else:
            return ""

    def FormatSubscriptionMsg(self):
        msg = ''
        also = ''
        if self.subscribe_policy == 1:
            msg += _('''
	    You will be sent email requesting confirmation, to
            prevent others from gratuitously subscribing you.
	    ''')
        elif self.subscribe_policy == 2:
            msg += _('''
	    This is a closed list, which means your subscription
            will be held for approval. You will be notified of the list
            moderator's decision by email.
	    ''')
            also = _('also')
        elif self.subscribe_policy == 3:
            msg += _('''
	    You will be sent email requesting confirmation, to
            prevent others from gratuitously subscribing you.  Once
            confirmation is received, your request will be held for approval
            by the list moderator.  You will be notified of the moderator's
            decision by email.
	    ''')
            also = _("also ")
        if msg:
            msg += ' '
        if self.private_roster == 1:
            msg += _('''
	    This is %(also)s a private list, which means that the
            list of members is not available to non-members.
	    ''')
        elif self.private_roster:
            msg += _('''
	    This is %(also)s a hidden list, which means that the
            list of members is available only to the list administrator.
	    ''')
        else:
            note = _('''
	    This is %(also)s a public list, which means that the
            list of members list is available to everyone.
	    ''')
            if self.obscure_addresses:
                note += _('''
	        (But we obscure the addresses so they are not
                easily recognizable by spammers).
	        ''')
	    msg += Paragraph(note).Format()

        if self.umbrella_list:
            sfx = self.umbrella_member_suffix
            msg += Paragraph(_('''
	    Note that this is an umbrella list, intended to
            have only other mailing lists as members.  Among other things,
            this means that your confirmation request will be sent to the
            `%(sfx)s' account for your address.
	    ''')).Format()
        return msg

    def FormatUndigestButton(self):
        if self.digest_is_default:
            checked = ''
        else:
            checked = ' checked="checked"'
        return '<input type="radio" name="digest" value="0"%s />' % checked

    def FormatMimeDigestsButton(self):
        if self.mime_is_default_digest:
            checked = ' checked="checked"'
        else:
            checked = ''
        return '<input type="radio" name="mime" value="1"%s />' % checked

    def FormatPlainDigestsButton(self):
        if self.mime_is_default_digest:
            checked = ''
        else:
            checked = ' checked="checked"'
        return '<input type="radio" name="plain" value="1"%s />' % checked

    def FormatEditingOption(self, lang):
        realname = self.real_name
        if self.private_roster == 0:
            either = _('<strong><em>either</em></strong> ')
        else:
            either = ''

	# Text used in this section
	text = _('''To unsubscribe from %(realname)s, get a password reminder, or change your subscription options %(either)senter your subscription email address:''')
        if self.private_roster == 0:
            text += Paragraph(_('''... <strong><em>or</em></strong> select your entry from the subscribers list (see above).''')).Format()

	# Build table where texts will be shown. 
	table = Table()
	table.AddRow([text,
                      TextBox('email', size=30)
		      ])
	table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
	table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')


	table.AddRow([Paragraph(_('''If you leave the field blank, you will be prompted for your email address.''')).Format(css='class="center"') +
		      Hidden('language', lang).Format() +  
		      SubmitButton('UserOptions',
                               _('Unsubscribe or edit options')).Format()
		      ])
	table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2, css='class="mm_submit"')
        return table.Format()

    def RestrictedListMessage(self, which, restriction):
        if not restriction:
            return ''
        elif restriction == 1:
            return Paragraph(_('''(%(which)s is only available to the list members.)''')).Format()
        else:
            return Paragraph(_('''(%(which)s is only available to the list administrator.)''')).Format()

    def FormatRosterOptionForUser(self, lang):
        return self.RosterOption(lang).Format()

    def RosterOption(self, lang):
        container = Container()
        if not self.private_roster:
            container.AddItem(Paragraph(_("Click here for the list of ")
                              + self.real_name
                              + _(" subscribers: ")
			      + SubmitButton('SubscriberRoster',
                                           _("Visit Subscriber list"))).Format())
        else:
            if self.private_roster == 1:
                only = _('members')
                whom = _('Address:')
            else:
                only = _('the list administrator')
                whom = _('Admin address:')

            # Solicit the user and password.
	    table = Table()
            container.AddItem(self.RestrictedListMessage(_('The subscribers list'),
                                           self.private_roster))
	    container.AddItem(Paragraph(_('Enter your ')
                              + whom[:-1].lower()
                              + _(" and password to visit"
                              "  the subscribers list:")).Format())
	    table.AddRow([whom,
	    		  self.FormatBox('roster-email')])
	    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
  	    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')
	    table.AddRow([_("Password: "),
                              self.FormatSecureBox('roster-pw')])
	    table.AddCellInfo(table.GetCurrentRowIndex(), 0, css='class="description"')
  	    table.AddCellInfo(table.GetCurrentRowIndex(), 1, css='class="value"')
	    table.AddRow([
			SubmitButton('SubscriberRoster', _("Visit Subscriber list")).Format() +
        		Hidden('language', lang).Format()
			])
	    table.AddCellInfo(table.GetCurrentRowIndex(), 0, colspan=2, css='class="mm_submit"')
	    container.AddItem(table)
        return container

    def FormatFormStart(self, name, extra=''):
        base_url = self.GetScriptURL(name)
        if extra:
            full_url = "%s/%s" % (base_url, extra)
        else:
            full_url = base_url
        return ('<form method="post" action="%s">' % full_url)

    def FormatArchiveAnchor(self):
        return '<a href="%s">' % self.GetBaseArchiveURL()

    def FormatFormEnd(self):
        return '</form>'

    def FormatBox(self, name, size=20, value=''):
        if isinstance(value, str):
            safevalue = Utils.websafe(value)
        else:
            safevalue = value
        return '<input type="text" name="%s" size="%d" value="%s" />' % (
            name, size, safevalue)

    def FormatSecureBox(self, name):
        return '<input type="password" name="%s" size="20" />' % name

    def FormatButton(self, name, text='Submit'):
        return '<input type="submit" name="%s" value="%s" />' % (name, text)

    def FormatReminder(self, lang):
        if self.send_reminders:
            return _('Once a month, your password will be emailed to you as'
                     ' a reminder.')
        return ''

    def ParseTags(self, template, replacements, lang=None):
        if lang is None:
            charset = 'us-ascii'
        else:
            charset = Utils.GetCharSet(lang)
        text = Utils.maketext(template, raw=1, lang=lang, mlist=self)
        parts = re.split('(</?[Mm][Mm]-[^>]*>)', text)
        i = 1
        while i < len(parts):
            tag = parts[i].lower()
            if replacements.has_key(tag):
                repl = replacements[tag]
                if isinstance(repl, type(u'')):
                    repl = repl.encode(charset, 'replace')
                parts[i] = repl
            else:
                parts[i] = ''
            i = i + 2
        return EMPTYSTRING.join(parts)

    # This needs to wait until after the list is inited, so let's build it
    # when it's needed only.
    def GetStandardReplacements(self, lang=None):
        dmember_len = len(self.getDigestMemberKeys())
        member_len = len(self.getRegularMemberKeys())
        # If only one language is enabled for this mailing list, omit the
        # language choice buttons.
        if len(self.GetAvailableLanguages()) == 1:
            listlangs = _(Utils.GetLanguageDescr(self.preferred_language))
        else:
            listlangs = self.GetLangSelectBox(lang).Format()
	# If no info is available for the mailing list, omit the info texts.
	if self.info:
	    listabout = '<p>' + self.info.replace('\n', '<br />') + '</p>'
	else:
	    listabout = ''
        d = {
            '<mm-mailman-footer>' : self.GetMailmanFooter(),
            '<mm-list-name>' : self.real_name,
            '<mm-email-user>' : self._internal_name,
            '<mm-list-info>' : listabout,
            '<mm-form-end>'  : self.FormatFormEnd(),
            '<mm-archive>'   : self.FormatArchiveAnchor(),
            '</mm-archive>'  : '</a>',
            '<mm-list-subscription-msg>' : self.FormatSubscriptionMsg(),
            '<mm-restricted-list-message>' : \
                self.RestrictedListMessage(_('The current archive'),
                                           self.archive_private),
            '<mm-num-reg-users>' : `member_len`,
            '<mm-num-digesters>' : `dmember_len`,
            '<mm-num-members>' : (`member_len + dmember_len`),
            '<mm-posting-addr>' : '%s' % self.GetListEmail(),
            '<mm-request-addr>' : '%s' % self.GetRequestEmail(),
            '<mm-owner>' : self.GetOwnerEmail(),
            '<mm-reminder>' : self.FormatReminder(self.preferred_language),
            '<mm-host>' : self.host_name,
            '<mm-list-langs>' : listlangs,
            }

        if mm_cfg.IMAGE_LOGOS:
            d['<mm-favicon>'] = mm_cfg.IMAGE_LOGOS + mm_cfg.SHORTCUT_ICON

	# To avoid empty tags we redifine description here.
	if self.description:
		d['<mm-list-description>'] = Paragraph(self.description).Format()
	else:
		d['<mm-list-description>'] = ''

        return d

    def GetAllReplacements(self, lang=None):
        """
        returns standard replaces plus formatted user lists in
        a dict just like GetStandardReplacements.
        """
        if lang is None:
            lang = self.preferred_language
        d = self.GetStandardReplacements(lang)
        d.update({"<mm-regular-users>": self.FormatUsers(0, lang),
                  "<mm-digest-users>": self.FormatUsers(1, lang)})
        return d

    def GetLangSelectBox(self, lang=None, varname='language'):
        if lang is None:
            lang = self.preferred_language
        # Figure out the available languages
        values = self.GetAvailableLanguages()
        legend = map(_, map(Utils.GetLanguageDescr, values))
        try:
            selected = values.index(lang)
        except ValueError:
            try:
                selected = values.index(self.preferred_language)
            except ValueError:
                selected = mm_cfg.DEFAULT_SERVER_LANGUAGE
        # Return the widget
        return SelectOptions(varname, values, legend, selected)
