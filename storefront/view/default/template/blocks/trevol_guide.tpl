<div id="builder-wrapper-guide">
    <div id="builder-wrapper-guide-title" class="bar">
        <span class="txt">Guide</span>
    </div>
    <div id="builder-wrapper-guide-dropdown" class="bar">
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    	<div class="dropdown-button">
                        	<i class="fa fa-fw fa-map-marker"></i><i class="fa fa-fw"></i><span class="txt">Destination</span>
                        	<span class="pull-right txt"><i class="fa fa-fw fa-chevron-down"></i></span>
                        </div>
                    </a>
                    <ul class="dropdown-menu">
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-plane"></i><i class="fa fa-fw"></i>
                                <span>Airport</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-calendar"></i><i class="fa fa-fw"></i>
                                <span>Calendar</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-camera"></i><i class="fa fa-fw"></i>
                                <span>Attraction</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-child"></i><i class="fa fa-fw"></i>
                                <span>Activity</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-cutlery"></i><i class="fa fa-fw"></i>
                                <span>Restaurant</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-building"></i><i class="fa fa-fw"></i>
                                <span>Accommodation</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-map-marker"></i><i class="fa fa-fw"></i>
                                <span>Surrounding</span>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#" class="text-left">
                                <i class="fa fa-fw fa-star"></i><i class="fa fa-fw"></i>
                                <span>Event</span>
                            </a>
                        </li>
                    </ul>
                </li>
    </div>
    <div id="builder-wrapper-guide-content">
        <div id="builder-wrapper-guide-filter" class="bar" style="display:none;">
        </div>
        <div>
        	<?php if ($destinations) { ?>
                <div class="row">
                    <?php
                    foreach ($destinations as $destination) {
                        $item = $destination;
                        $item['image'] = !is_array($destination['thumb']) ? '<img alt="'.$destination['name'].'" src="' . $destination['thumb'] . '"/>' : $destination['thumb']['thumb_html'];
                        ?>
                        <div id="builder-wrapper-guide-item-<?php echo $item['id']; ?>" class="col-xs-12 builder-wrapper-guide-item-row" onmouseover="focusMapMarker(<?php echo $item['id']; ?>)" onmouseout="defocusMapMarker(<?php echo $item['id']; ?>)">
                            <div class="builder-wrapper-guide-item">
                                <a href="<?php echo $item['url'] ?>">
                                    <?php echo $item['image']?>
                                    <div class="builder-wrapper-guide-item-text"><?php echo $item['name']?></div>
                                </a>
                            </div>
                        </div>
                    <?php } ?>
                </div>
            <?php } ?>
        </div>
    </div>
</div>

<script>
<?php foreach ($destinations as $destination) { ?>
	marker_id = <?php echo $destination['id']; ?>;
	marker_name = "<?php echo $destination['name']; ?>";
	marker_url = "<?php echo $destination['url']; ?>";
	marker_lat = <?php echo $destination['lat']; ?>;
	marker_lng = <?php echo $destination['lng']; ?>;
	addMapMarker(marker_id, marker_name, marker_url, marker_lat, marker_lng);
<?php } ?>
</script>