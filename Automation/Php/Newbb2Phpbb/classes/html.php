<?php
/***
 * HTML - Used to htmlblock html code.
 */

class HTML
{

   /***
    * Format html htmlblock
    */
    function format_htmlblock( $htmlblock = array() )
    {
        $html_formatted = '';

        // Define amount of tabs
        $tabs = array(0 => '',
                      1 => "\t",
                      2 => "\t\t",
                      3 => "\t\t\t",
                      4 => "\t\t\t\t",
                      5 => "\t\t\t\t\t");

        // Define indententaion level by tags
        $levels = array('/<\/?html/'                                                     => 0,
                        '/<\/?(body|head)( .+|>)/'                                       => 1,
                        '/<\/?(title)( .+|>)/'                                           => 2,
                        '/<\/?(br|hr) \/>/'                                              => 2,
                        '/<\/?(p|pre|table|dl|ul|ol|div|h[1-9]|form|link)( .+|>)/'       => 3,
                        '/<\/?(li|dt|dd|span|select|option|tr)( .+|>)/'                  => 4,
                        '/<\/?(th|td)( .+|>)/'                                           => 5);

        // Set line level, line by line
        foreach ( $htmlblock as $line )
        {
            foreach ( $levels as $tag => $level )
            {
                if ( preg_match( $tag, $line ) )
                {
                    $html_formatted .= $tabs[$level] . $line . "\n";
                }
            
            }
        }

        return $html_formatted;
    }

   /***
    * Format messages
    *
    * $message  : the message text itself.
    * $color    : grey|green|orange|blue|violet|red
    *             if no color is specified grey color is assumed as default
    */
    function format_message( $message = 'Empty', $color = '' )
    {
        // Validate color to be used
        $valid_colors = array('grey', 'green', 'orange', 'violet', 'blue', 'red');
        if ( ! in_array( $color, $valid_colors ) )
        {
            $color = ''; 
        }

        // Build message html
        $html = '<div class="message lm ' . $color . '">' . strtoupper($message) . '</div>';

        return $html;
    }

   /***
    * Where is my position in the migration ?
    * ----------------------------------------------------
    * It is somehow a breadcrumb of where you are in the migration process.
    */
    function get_stepPosition()
    {
        // Define migration process stepts
        $steps = array(0 => 'Configuration',
                       1 => 'Verification',
                       2 => 'Migration', 
                       3 => 'Reset Passwords');

        $position = isset( $_POST['step'] )?$_POST['step']:0;
   
        $htmlblock = array('<ul class="sublinks">');

        foreach ( $steps as $key => $value )
        {
            if ( $position == $key)
            {
                array_push($htmlblock,'<li class="current">'. $value.'</li>'); 
            }
            else
            {
                array_push($htmlblock,'<li>'. $value.'</li>'); 
            }
        }
        
        array_push( $htmlblock, '</ul>');

        return $htmlblock;
    }

   /***
    * Navibar
    */
    function get_navibar()
    {
        global $db;

        $htmlblock = array('<ul class="navibar">');

        if ( isset($_GET['p']) && $_GET['p'] == 'help' )
        {
            array_push($htmlblock, '<li><a href="index.php">Main</a></li>');
            array_push($htmlblock, '<li class="current"><a href="?p=help">Help</a></li>');
        }
        else
        {
            array_push($htmlblock, '<li class="current"><a href="index.php">Main</a></li>');
            array_push($htmlblock, '<li><a href="?p=help">Help</a></li>');
        }

        array_push( $htmlblock, '</ul>');

        return $htmlblock;
    }
}

$html = new HTML;
?>
