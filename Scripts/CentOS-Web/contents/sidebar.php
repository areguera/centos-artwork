<div class="columnr">

    <div class="row_promo first center"><a href=""><img src="contents/images/release-promo.png" alt="promo"></a></div>

    <div class="row">

        <h4><?php echo strtoupper(translate('categories'))?></h4>
        <?php echo get_category_tree() ?>
    </div>

    <div class="row">
        <h4><?php echo strtoupper(translate('archive'))?></h4>
        <ul>
            <li><a href="">2009</a></li>
            <li><a href="">2008</a></li>
            <li><a href="">2007</a></li>
        </ul>
    </div>

    <div class="row">
        <h4><?php echo strtoupper(translate('links'))?></h4>
        <ul>
            <li><a href="">...</a></li>
            <li><a href="">...</a></li>
            <li><a href="">...</a></li>
        </ul>
    </div>

    <div class="row">
        <?php echo get_auth_userlinks(); ?>
    </div>

    <div class="last"></div>

</div>
