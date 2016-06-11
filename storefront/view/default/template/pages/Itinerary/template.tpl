<style>
	.itinerary_day {
		margin-bottom:30px;
	}
	
	.itinerary_activity {
		margin-top:15px;
	}
	
	.itinerary_list { 
		width: 100%;
		padding: 6px 0px;
		font-size:14px;
		display:inline-block;
	}
	
	.itinerary_day_title {
		border-top: 1px solid #999; 
		border-bottom: 1px solid #999;
		color:#666;
	}
	
	.wordwrap { 
	   white-space: nowrap;
	   text-overflow: ellipsis;
	   overflow:hidden;
	   height:100px;
	   display:block;
	}
}
</style>
    
<div class="row">
    <div class="col-xs-12 text-primary" style="font-size:24px;"><?php echo $template_name; ?></div>
</div>
<div class="row margin-top">
    <div class="col-xs-6"><span><?php echo $days_count; ?> DAYS</span></div>
    <div class="col-xs-6 text-right"><a class="btn btn-primary" onclick="confirm_set_template();">Set as Template</a></div>
</div>

<div class="margin-top">
    <ul>
        <?php foreach ($days as $day) { ?>
        <li>
        	<div class="itinerary_day"><ul>
                <li>
                    <div class="itinerary_list itinerary_day_title">
                    <?php if($day["date"] != "0000-00-00") { ?>
                        <span class="col-xs-6 col-sm-4 col-lg-3">Day <?php echo $day['sortable']; ?> (<?php echo date( "D", strtotime($day["date"])); ?>)</span>
                        <span class="col-xs-6 col-sm-8 col-lg-9"><?php echo date( "M d", strtotime($day["date"])); ?>&nbsp;</span>
                    <?php } else { ?>
                        <span class="col-xs-12">Day <?php echo $day['sortable']; ?></span>
                    <?php } ?>
                    </div>
                </li>
                <?php if($activities[$day['day_id']]) { ?>
                    <?php 
                    foreach ($activities[$day['day_id']] as $activity) {
                        $id = $activity['trip_activity_id']; ?>
                        <li class="itinerary_activity">
                            <div class="row">
                                <div class="col-xs-6 col-sm-4 col-lg-3"><?php echo $activity['thumbnail']['thumb_html']; ?></div>
                                <div class="col-xs-6 col-sm-8 col-lg-9 wordwrap"><a href="<?php echo $activity['link'];?>" ><?php echo $activity['name']; ?></a><br /><br /><?php echo $activity['blurb']; ?></div>
                            </div>
                        </li>
                    <?php } ?>
                <?php } else { ?>
                    <li class="itinerary_list"><div>Free & Easy</div></li>
                <?php } ?>
            </ul></div>
        </li>
        <?php } ?>
    </ul>
</div>