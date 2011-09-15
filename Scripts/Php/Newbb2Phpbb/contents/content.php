<?php

    // Content
    $action = isset($_GET['p'])?$_GET['p']:'';
    $action = strtolower( $action );
    switch ( $action )
    {
        case 'help';
            $page = 'p_help.php';
            break;
    
        default: 
            $page = 'p_main.php';
     }
    
     require_once('contents/' . $page);
?>
