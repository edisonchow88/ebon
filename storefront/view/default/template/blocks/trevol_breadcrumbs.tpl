<div id="builder-wrapper-center-top">
    <div id="builder-wrapper-breadcrumbs">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <a href="<?php echo $breadcrumb['href']; ?>">
                Back to <?php echo $breadcrumb['text']; ?>
            </a>
        <?php } ?>
    </div>
    <div id="builder-wrapper-page-title">
        <span><?php echo $title; ?></span>
    </div>
</div>