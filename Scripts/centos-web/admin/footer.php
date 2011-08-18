<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php">this instead</a>.</h3>';
        exit;
    }
?>
        </div>

    </div>

    <div id="footer">

        <?php echo show_sublinks(); ?>

        <?php echo show_mainlinks(); ?>

        <div class="pageline_dark"> </div>

        <div class="credits"> 

            <p class="right"></p>

            <p><?php echo ucfirst(translate('credits_on_footer_1')); ?></p>

        </div>

    </div>

    </body>

</html>
