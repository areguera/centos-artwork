<?php
/***
 * Login page
 *
 */

require_once('../config.php');
require_once('../includes/translations/' . LANGUAGE . '.php');
require_once('includes/functions/auth.php');

// If session is active redirect back to baseurl. 
if (isset($_SESSION['employeetype']))
{
    header('Location: ' . BASEURL );
}


/* Check Login */
$message = '';
if (isset($_POST['username']) && isset($_POST['password']) && !isset($_SESSION['employeetype']))
{
    $message = login();

    if ($message <> 0)
    {
        $message = '<div class="message lm orange">' . ucfirst(translate($message)) . '</div>';
    }
    else
    {
        header('Location: index.php');
    }
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>Admin :: <?php echo HTML_TITLE ?></title>
    <link rel="stylesheet" type="text/css" charset="utf-8" media="all" href="style.css">
    <script type="text/javascript">
        function focusit() {
            document.getElementById('username').focus();
        }
         window.onload = focusit;
    </script>

</head>

<body>

    <div id="header">
    <div id="logo">

        <a href="<?php echo BASEURL ?>">

        <img src="../contents/images/logo.png" alt="">
        <span class="logo_text"><?php echo ucfirst(translate(LANGUAGE))?></span>

        </a>

    </div>
    </div>

    <div class="pageline" style="border-color: #6FA4DF;"></div>

    <div id="content" style="padding-left: 1em;">
        
        <h1><?php echo ucfirst(translate('login')) ?></h1>

        <?php if (isset($message) && $message <> '') {; echo $message; } ?>

        <form name="login" method="post" action="">
        <table style="border: 0;">
        <tr>
            <td style="border:none; width: 1%; text-align: right;"><strong><?php echo ucfirst(translate('username')); ?>:</strong></td>
                <td style="border:none"><input id="username" type="text" name="username" size="30"> (<?php echo ucfirst(translate('ex')); ?>. john@example.com)</td>
        </tr>
        <tr>
                <td style="border: none;"><strong><?php echo ucfirst(translate('password'));?>:</strong></td>
            <td style="border: none;"><input type="password" name="password" size="30"></td>
        </tr>
            <tr>
            <td style="border: none;"></td>
            <td style="border: none;"><input type="submit" name="submit" value="<?php echo ucfirst(translate('login')) ?>"></td>
        </tr>
        </table>
        </form>

        </div>
    </div>


    <div id="footer">

        <div class="pageline" style="border-color: #6FA4DF;"></div>
        <div class="credits">

            <p class="right"></p>

            <p><?php echo ucfirst(translate('credits_on_footer_1'))?></p>

        </div>

    </div>

<body>
</html>
