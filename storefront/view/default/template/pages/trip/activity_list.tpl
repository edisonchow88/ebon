<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<style>
	.sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
	.sortable li { margin: 0; padding: 3px 0px; overflow:hidden;}
	.sortable li:hover { background-color:white; }
	.sortable li span { display:inline-block; }
	.highlight:hover { background-color:#FFC; }
	.disabled { color:#666; }
	.margin-top { margin-top:20px; }
	.margin-top-half { margin-top:10px; }
	.margin-bottom { margin-bottom:20px; }
	.padding-top { padding-top:7px; }
	.padding-bottom { padding-bottom:7px; }
	
	.itinerary_list { 
		width: 100%;
		padding: 6px 0px;
		font-size:14px;
		display:inline-block;
	}
	
	.itinerary_day {
		border-top: 1px solid #999; 
		border-bottom: 1px solid #999;
		margin-top:14px;
		color:#666;
	}
	
	.wordwrap { 
	   white-space: pre-wrap;      /* CSS3 */   
	   white-space: -moz-pre-wrap; /* Firefox */    
	   white-space: -pre-wrap;     /* Opera <7 */   
	   white-space: -o-pre-wrap;   /* Opera 7 */    
	   word-wrap: break-word;      /* IE */
	}
}
</style>
<div style="background-color:#CCC; text-align:center; display:none;">
	<form id="form_trip" action="" method="post">
    	<label style="width:50%;" for="input_conn">Connect</label><input style="width:50%;"  type="text" id="input_conn" name="conn" value="connection"></input>
        <label style="width:50%;" for="input_action">Action</label><input style="width:50%;"  type="text" id="input_action" name="action" value=""></input>
        <label style="width:50%;" for="input_visit">Visit</label><input style="width:50%;"  type="text" id="input_visit" name="visit" value="<?php echo $visit; ?>"></input>
        <label style="width:50%;" for="input_view">View</label><input style="width:50%;" type="text" id="input_view" name="view" value="<?php echo $view; ?>"></input>
        <label style="width:50%;" for="input_customer_id">Customer Id</label><input style="width:50%;"  type="text" id="input_customer_id" name="customer_id" value="<?php echo $customer_id; ?>"></input>
        <label style="width:50%;" for="input_draft_id">Draft Id</label><input style="width:50%;"  type="text" id="input_draft_id" name="draft_id" value="<?php echo $draft_id; ?>"></input>
        <label style="width:50%;" for="input_trip_id">Trip Id</label><input style="width:50%;" type="text" id="input_trip_id" name="trip_id" value="<?php echo $trip_id; ?>"></input>
        <label style="width:50%;" for="input_day_id">Day Id</label><input style="width:50%;" type="text" id="input_day_id" name="day_id" value="<?php echo $day_id; ?>"></input>
        <label style="width:50%;" for="input_activity_id">Activity Id</label><input style="width:50%;" type="text" id="input_activity_id" name="activity_id" value="<?php echo $activity_id; ?>"></input>
    </form>
</div>
    
<!-- Day View -->
<div id="day_view" class="content-box margin-top" style="<?php if($view=="activity") { echo 'display:none;'; }?>">
    
    <div class="row">
        <div class="col-xs-6"><h3><?php echo $block_title; ?></h3></div>
        <div class="col-xs-6 text-right"><h4><span class="small">Itinerary Number</span><br /><span class="text-success"><?php echo $itinerary_code; ?></span></h4></div>
    </div>
    
    <!-- Day Status-->
    <div id="day_status" class="margin-top"><span><?php echo $days_count; ?> Days</span></div>
    <!-- Day List-->
    <div id="day_list" class="margin-top">
        <ul id="sortable_day" class="sortable">
            <?php 
                foreach ($days as $day) {
                $id = $day['day_id']; ?>
                <li>
                    <div class="itinerary_list itinerary_day">
                    <?php if($day["date"] != "0000-00-00") { ?>
                        <span class="col-xs-4">Day <?php echo $day['sortable']; ?> (<?php echo date( "D", strtotime($day["date"])); ?>)</span>
                        <span class="col-xs-8"><?php echo date( "M d", strtotime($day["date"])); ?>&nbsp;</span>
                    <?php } else { ?>
                    	<span class="col-xs-12">Day <?php echo $day['sortable']; ?></span>
                    <?php } ?>
                    </div>
                </li>
                <?php if($activities[$day['day_id']]) { ?>
                    <?php 
                    foreach ($activities[$day['day_id']] as $activity) {
                        $id = $activity['trip_activity_id']; ?>
                        <li>
                            <div style="width:100%;">
                                <div class="col-xs-12"><span class="wordwrap"><b><?php echo $activity['name']; ?></b></span></div>
                                <div class="col-xs-12 small"> 
                                    <?php 
                                        foreach($activity['hours'] as $hour) {
                                            
                                            
                                            echo "<div class='row'>";
                                            echo "<div class='col-xs-4'><i class='fa fa-clock-o'></i> ".$hour['date']."</div>";
                                            echo "<div class='col-xs-3'>".$hour['day']."</div>";
                                            echo "<div class='col-xs-3'>".$hour['description']."</div>";
                                            echo "<div class='col-xs-2 text-right'>".$hour['time']."</div>";
                                            echo "</div>";
                                        }
                                    ?>
                                </div>
                                <div class="col-xs-12 small"> 
                                    <?php if(!empty($activity['prices'])) { ?>
                                        <div class="col-xs-12">
                                            <?php 
                                            foreach($activity['prices'] as $price) {
                                                echo "<div class='row'>";
                                                echo "<div class='col-xs-4'><i class='fa fa-ticket'></i> ".$price['name']."</div>";
                                                echo "<div class='col-xs-4'>".$price['condition']."</div>";
                                                echo "<div class='col-xs-4 text-right'>".$price['amount']."</div>";
                                                echo "</div>";
                                                echo "<br/>";
                                            }
                                            ?>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </li>
                    <?php } ?>
                <?php } else { ?>
                    <li class="itinerary_list"><div>Free & Easy</div></li>
                <?php } ?>
            <?php } ?>
        </ul>
    </div>
</div>