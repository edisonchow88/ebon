<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
    <head>
        <?php echo $head; ?>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    </head>
    <body>
		<div class="popover-alert-wrapper" onclick="$(this).hide();">
            <div class="popover-alert"></div>
        </div>
        <div class="popover-hint-wrapper" onclick="$(this).hide();">
            <div class="popover-hint"></div>
        </div>
        <div class="popover-load"></div>
        <div class="container-fluid-shadow fixed-width"></div>
        <div class="container-fluid">
            <?php echo $content; ?>
        </div>
        <div class="script">
            <?php echo ${$footer}; ?>
        </div>
    </body>
</html>