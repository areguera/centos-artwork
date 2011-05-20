#!/usr/bin/perl 
#
# repository.init -- This file initializes Texi2HTML program to
# produce the repository documentation manual using the CentOS Web
# Environment XHTML and CSS standard definition.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#  
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

# -iso
# if set, ISO8859 characters are used for special symbols (like copyright, etc)
$USE_ISO = 1;

# -I
# add a directory to the list of directories where @include files are
# searched for (besides the directory of the file). additional '-I'
# args are appended to this list.  (APA: Don't implicitely search .,
# to conform with the docs!) my @INCLUDE_DIRS = (".");
@INCLUDE_DIRS = ("/home/centos/artwork");

# Extension used on output files.
$EXTENSION = "xhtml";

# Horizontal rules.
$DEFAULT_RULE = '<div class="page-line white"><hr style="display:none;" /></div>';
$SMALL_RULE = $DEFAULT_RULE;
$MIDDLE_RULE = $DEFAULT_RULE;
$BIG_RULE = $DEFAULT_RULE;

# -split section|chapter|node|none
# if $SPLIT is set to 'section' (resp. 'chapter') one html file per
# section (resp. chapter) is generated. If $SPLIT is set to 'node' one
# html file per node or sectionning element is generated. In all these
# cases separate pages for Top, Table of content (Toc), Overview and
# About are generated.  Otherwise a monolithic html file that contains
# the whole document is created.
$SPLIT = 'section';

# -sec-nav|-nosec-nav
# if this is set then navigation panels are printed at the beginning
# of each section.  If the document is split at nodes then navigation
# panels are printed at the end if there were more than $WORDS_IN_PAGE
# words on page.
#
# If the document is split at sections this is ignored.
#
# This is most useful if you do not want to have section navigation
# with -split chapter. There will be chapter navigation panel at the
# beginning and at the end of chapters anyway.
$SECTION_NAVIGATION = 1;

# Layout control
$print_page_head	= \&T2H_XHTML_print_page_head;
$print_page_foot	= \&T2H_XHTML_print_page_foot;
$print_frame        = \&T2H_XHTML_print_frame;
$button_icon_img    = \&T2H_XHTML_button_icon_img;
$print_navigation   = \&T2H_XHTML_print_navigation;

#FIXME update once it is more stabilized in texi2html.init
sub T2H_XHTML_print_page_head
{
    my $fh = shift;
    my $longtitle = "$Texi2HTML::THISDOC{'title_unformatted'}";
    $longtitle .= ": $Texi2HTML::UNFORMATTED{'This'}" if exists $Texi2HTML::UNFORMATTED{'This'};
    $T2H_LANG='en';
    print $fh <<EOT;
<?xml version="1.0"?>
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="$T2H_LANG" lang="$T2H_LANG">
<head>

    <title>$longtitle</title>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="description" content="$longtitle" />
    <meta name="keywords" content="$longtitle" />
    <meta name="resource-type" content="document" />
    <meta name="distribution" content="global" />
    <meta name="generator" content="$Texi2HTML::THISDOC{program}" />
    <meta name="copyright" content="2009, 2010, 2011 The CentOS Project" />

    <link href="/home/centos/artwork/trunk/Manuals/Texinfo/repository.css" rel="stylesheet" type="text/css" media="screen projection" />

</head>

<body>

<a name="top" />

<div id="wrap">

    <div id="page-body">

        <div id="content">

<!-- Created on $Texi2HTML::THISDOC{today} by $Texi2HTML::THISDOC{program} -->
EOT
}

sub T2H_XHTML_print_page_foot
{
    my $fh = shift;
    my @date=localtime(time);
    my $year=$date[5] += 1900;
    my $program_string = program_string();
    print $fh <<EOT;

        <p class="credits">$program_string</p>

        </div>

    </div>


</div>

</body>

</html>
EOT
}

# / in <img>
sub T2H_XHTML_button_icon_img
{
    my $button = shift;
    my $icon = shift;
    my $name = shift;
    return '' if (!defined($icon));
    if (defined($name) && $name)
    {
        $name = ": $name";
    }
    else
    {
        $name = '';
    }
    $button = "" if (!defined ($button));
    return qq{<img src="$icon" border="0" alt="$button$name" align="middle" />};
}

$simple_map{'*'} = '<br />';

# formatting functions

$def_line	       = \&t2h_xhtml_def_line;
$index_summary     = \&t2h_xhtml_index_summary;
$image             = \&t2h_xhtml_image;

# need / in <img>
sub t2h_xhtml_image($$$)
{
   my $file = shift;
   my $base = shift;
   my $preformatted = shift;
   return "[ $base ]" if ($preformatted);
   return "<img src=\"$file\" alt=\"$base\" />";
}

# process definition commands line @deffn for example
# <u> replaced by <span>
sub t2h_xhtml_def_line($$$$$)
{
   my $category = shift;
   my $name = shift;
   my $type = shift;
   my $arguments = shift;
   my $index_label = shift;
   $index_label = '' if (!defined($index_label));
   $name = '' if (!defined($name) or ($name =~ /^\s*$/));
   $type = '' if (!defined($type) or $type =~ /^\s*$/);
   if (!defined($arguments) or $arguments =~ /^\s*$/)
   {
       $arguments = '';
   }
   else
   {
       $arguments = '<i>' . $arguments . '</i>';
   }
   my $type_name = '';
   $type_name = " $type" if ($type ne '');
   $type_name .= ' <b>' . $name . '</b>' if ($name ne '');
   $type_name .= $arguments . "\n";
   if (! $DEF_TABLE)
   {
       return '<dt>'. '<span style="text-decoration: underline">' . $category . ':</span>' . $type_name . $index_label . "</dt>\n";
   }
   else
   {
       
       return "<tr>\n<td align=\"left\">" . $type_name . 
       "</td>\n<td align=\"right\">" . $category . $index_label . "</td>\n" . "</tr>\n";
   }
}

# There is a br which needs / 
sub t2h_xhtml_index_summary($$)
{
    my $alpha = shift;
    my $nonalpha = shift;
    my $join = '';
    my $nonalpha_text = '';
    my $alpha_text = '';
    $join = " &nbsp; \n<br />\n" if (@$nonalpha and @$alpha);
    if (@$nonalpha)
    {
       $nonalpha_text = join("\n &nbsp; \n", @$nonalpha) . "\n";
    }
    if (@$alpha)
    {
       $alpha_text = join("\n &nbsp; \n", @$alpha) . "\n &nbsp; \n";
    }
    #I18n
    return "<table><tr><th valign=\"top\">Jump to: &nbsp; </th><td>" .
    $nonalpha_text . $join . $alpha_text . '</td></tr></table>';
}

# Layout of navigation panel
sub T2H_XHTML_print_navigation
{
    my $fh = shift;
    my $buttons = shift;
    my $vertical = shift;
    print $fh '<table class="navibar">' . "\n";

    print $fh "<tr>" unless $vertical;
    for my $button (@$buttons)
    {
        print $fh qq{<tr>\n} if $vertical;
        print $fh qq{<td>};

        if (ref($button) eq 'CODE')
        {
            &$button($fh, $vertical);
        }
        elsif (ref($button) eq 'SCALAR')
        {
            print $fh "$$button" if defined($$button);
        }
        elsif (ref($button) eq 'ARRAY')
        {
            my $text = $button->[1];
            my $button_href = $button->[0];
            if (defined($button_href) and !ref($button_href) 
               and defined($text) and (ref($text) eq 'SCALAR') and defined($$text))
            {             # use given text
                if ($Texi2HTML::HREF{$button_href})
                {
                  print $fh "" .
                        &$anchor('',
                                    $Texi2HTML::HREF{$button_href},
                                    $$text
                                   ) 
                                    ;
                }
                else
                {
                  print $fh $$text;
                }
            }
        }
        elsif ($button eq ' ')
        {                       # handle space button
            print $fh
                $ICONS && $ACTIVE_ICONS{' '} ?
                    &$button_icon_img($button, $ACTIVE_ICONS{' '}) :
                        $NAVIGATION_TEXT{' '};
            #next;
        }
        elsif ($Texi2HTML::HREF{$button})
        {                       # button is active
            my $btitle = $BUTTONS_GOTO{$button} ?
                'title="' . ucfirst($BUTTONS_GOTO{$button}) . '"' : '';
            if ($ICONS && $ACTIVE_ICONS{$button})
            {                   # use icon
                print $fh '' .
                    &$anchor('',
                        $Texi2HTML::HREF{$button},
                        &$button_icon_img($button,
                                   $ACTIVE_ICONS{$button},
                                   #$Texi2HTML::NAME{$button}),
                                   $Texi2HTML::NO_TEXI{$button}),
                        $btitle
                      );
            }
            else
            {                   # use text
                print $fh
                    '[' .
                        &$anchor('',
                                    $Texi2HTML::HREF{$button},
                                    $NAVIGATION_TEXT{$button},
                                    $btitle
                                   ) .
                                       ']';
            }
        }
        else
        {                       # button is passive
            print $fh
                $ICONS && $PASSIVE_ICONS{$button} ?
                    &$button_icon_img($button,
                                          $PASSIVE_ICONS{$button},
                                          #$Texi2HTML::NAME{$button}) :
                                          $Texi2HTML::NO_TEXI{$button}) :

                                              "[" . $NAVIGATION_TEXT{$button} . "]";
        }
        print $fh "</td>\n";
        print $fh "</tr>\n" if $vertical;
    }
    print $fh "</tr>" unless $vertical;
    print $fh "</table>\n";
}

# Use icons for navigation.
$ICONS = 0;

# insert here name of icon images for buttons
# Icons are used, if $ICONS and resp. value are set
%ACTIVE_ICONS =
    (
     'Top',         'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-top.png',
     'Contents',    'file:///usr/share/icons/Bluecurve/24x24/stock/help-contents.png',
     'Overview',    '',
     'Index',       'file:///usr/share/icons/Bluecurve/24x24/stock/stock-find.png',
     'This',        '',
     'Back',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'FastBack',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-first.png',
     'Prev',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'Up',          'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-up.png',
     'Next',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'NodeUp',      'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-up.png',
     'NodeNext',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'NodePrev',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'Following',   'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'Forward',     'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'FastForward', 'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-last.png',
     'About' ,      'file:///usr/share/icons/Bluecurve/24x24/stock/gtk-about.png',
     'First',       'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-first.png',
     'Last',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-last.png',
     ' ',           ''
    );

# Insert here name of icon images for these, if button is inactive
%PASSIVE_ICONS =
    (
     'Top',         'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-top.png',
     'Contents',    'file:///usr/share/icons/Bluecurve/24x24/stock/help-contents.png',
     'Overview',    '',
     'Index',       'file:///usr/share/icons/Bluecurve/24x24/stock/stock-find.png',
     'This',        '',
     'Back',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'FastBack',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-first.png',
     'Prev',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'Up',          'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-up.png',
     'Next',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'NodeUp',      'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-up.png',
     'NodeNext',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'NodePrev',    'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-back.png',
     'Following',   'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'Forward',     'file:///usr/share/icons/Bluecurve/24x24/stock/stock-go-forward.png',
     'FastForward', 'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-last.png',
     'About' ,      'file:///usr/share/icons/Bluecurve/24x24/stock/gtk-about.png',
     'First',       'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-first.png',
     'Last',        'file:///usr/share/icons/Bluecurve/24x24/stock/stock-goto-last.png',
     ' ',           ''
    );
