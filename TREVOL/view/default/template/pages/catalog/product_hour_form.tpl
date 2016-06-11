<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>

<?php echo $product_tabs; ?>

<div id="content" class="panel panel-default">
    
    <div class="contentpanel">
        <h1><?php echo $heading_title; ?></h1>
        
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" role="form" data-confirm-exit="true" class="aform form-horizontal">
        	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
            	<div class="form-group">
                    <label class="col-sm-2 col-xs-11">Status <span class="required">*</span></label>
                    <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <select name="status" class="form-control col-sm-7 col-xs-12">
                            <option value="1" <?php if($form['fields']['status']['value']==1) { echo 'selected="selected"'; } ?>>Open</option>
                            <option value="0" <?php if($form['fields']['status']['value']==0) { echo 'selected="selected"'; } ?>>Closed</option>
                            <option value="2" <?php if($form['fields']['status']['value']==2) { echo 'selected="selected"'; } ?>>Temporary Closed</option>
                        </select>                    
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 col-xs-11">Condition <span class="required">*</span></label>
                    <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <select name="general" id="entry_general" onchange="javascript:CheckCondition();" class="form-control col-sm-7 col-xs-12">
                            <option value="1" <?php if($form['fields']['general']['value']==1) { echo 'selected="selected"'; } ?>>Normal days</option>
                            <option value="2" <?php if($form['fields']['general']['value']==2) { echo 'selected="selected"'; } ?>>Specific months</option>
                            <option value="3" <?php if($form['fields']['general']['value']==3) { echo 'selected="selected"'; } ?>>Specific dates</option>
                        </select>
                        <div id="block_specific_date" <?php if($form['fields']['general']['value']!=3) { echo 'style="display:none;"'; } ?> >
                        	<br /><br />
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; padding-left:10px; text-align:left;">From</span>
                        	<input name="date_from" class="form-control" type="date" value="<?php echo $form['fields']['date_from']['value']; ?>" style="width:40%;" />
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:center;">To</span>
                            <input name="date_to" class="form-control" type="date" value="<?php echo $form['fields']['date_to']['value']; ?>" style="width:40%;" />
                        </div>
                        <div id="block_specific_month" <?php if($form['fields']['general']['value']!=2) { echo 'style="display:none;"'; } ?>>
                        	<br /><br />
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; padding-left:10px; text-align:left;">From</span>
                            <select name="month_eml_from" class="form-control" style="width:40%">
                            	<option value="first" <?php if($form['fields']['month_eml_from']['value']=='first') { echo 'selected="selected"'; } ?>>First day</option>
                                <option value="early" <?php if($form['fields']['month_eml_from']['value']=='early') { echo 'selected="selected"'; } ?>>Early (between 1-10)</option>
                                <option value="mid" <?php if($form['fields']['month_eml_from']['value']=='mid') { echo 'selected="selected"'; } ?>>Mid (between 11-20)</option>
                                <option value="late" <?php if($form['fields']['month_eml_from']['value']=='late') { echo 'selected="selected"'; } ?>>Late (between 21-30)</option>
                                <option value="last" <?php if($form['fields']['month_eml_from']['value']=='last') { echo 'selected="selected"'; } ?>>Last day</option>
                            </select>
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:center;">of</span>
                        	<select name="month_from" class="form-control" style="width:40%">
                                <option value="1" <?php if($form['fields']['month_from']['value']==1) { echo 'selected="selected"'; } ?>>January</option>
                                <option value="2" <?php if($form['fields']['month_from']['value']==2) { echo 'selected="selected"'; } ?>>February</option>
                                <option value="3" <?php if($form['fields']['month_from']['value']==3) { echo 'selected="selected"'; } ?>>March</option>
                                <option value="4" <?php if($form['fields']['month_from']['value']==4) { echo 'selected="selected"'; } ?>>April</option>
                                <option value="5" <?php if($form['fields']['month_from']['value']==5) { echo 'selected="selected"'; } ?>>May</option>
                                <option value="6" <?php if($form['fields']['month_from']['value']==6) { echo 'selected="selected"'; } ?>>June</option>
                                <option value="7" <?php if($form['fields']['month_from']['value']==7) { echo 'selected="selected"'; } ?>>July</option>
                                <option value="8" <?php if($form['fields']['month_from']['value']==8) { echo 'selected="selected"'; } ?>>August</option>
                                <option value="9" <?php if($form['fields']['month_from']['value']==9) { echo 'selected="selected"'; } ?>>September</option>
                                <option value="10" <?php if($form['fields']['month_from']['value']==10) { echo 'selected="selected"'; } ?>>October</option>
                                <option value="11" <?php if($form['fields']['month_from']['value']==11) { echo 'selected="selected"'; } ?>>November</option>
                                <option value="12" <?php if($form['fields']['month_from']['value']==12) { echo 'selected="selected"'; } ?>>December</option>
                            </select>
                            <br /><br />
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; padding-left:10px; text-align:left;">To</span>
                            <select name="month_eml_to" class="form-control" style="width:40%">
                            	<option value="first" <?php if($form['fields']['month_eml_to']['value']=='first') { echo 'selected="selected"'; } ?>>First day</option>
                                <option value="early" <?php if($form['fields']['month_eml_to']['value']=='early') { echo 'selected="selected"'; } ?>>Early (between 1-10)</option>
                                <option value="mid" <?php if($form['fields']['month_eml_to']['value']=='mid') { echo 'selected="selected"'; } ?>>Mid (between 11-20)</option>
                                <option value="late" <?php if($form['fields']['month_eml_to']['value']=='late') { echo 'selected="selected"'; } ?>>Late (between 21-30)</option>
                                <option value="last" <?php if($form['fields']['month_eml_to']['value']=='last') { echo 'selected="selected"'; } ?>>Last day</option>
                            </select>
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:center;">of</span>
                        	<select name="month_to" class="form-control" style="width:40%">
                                <option value="1" <?php if($form['fields']['month_to']['value']==1) { echo 'selected="selected"'; } ?>>January</option>
                                <option value="2" <?php if($form['fields']['month_to']['value']==2) { echo 'selected="selected"'; } ?>>February</option>
                                <option value="3" <?php if($form['fields']['month_to']['value']==3) { echo 'selected="selected"'; } ?>>March</option>
                                <option value="4" <?php if($form['fields']['month_to']['value']==4) { echo 'selected="selected"'; } ?>>April</option>
                                <option value="5" <?php if($form['fields']['month_to']['value']==5) { echo 'selected="selected"'; } ?>>May</option>
                                <option value="6" <?php if($form['fields']['month_to']['value']==6) { echo 'selected="selected"'; } ?>>June</option>
                                <option value="7" <?php if($form['fields']['month_to']['value']==7) { echo 'selected="selected"'; } ?>>July</option>
                                <option value="8" <?php if($form['fields']['month_to']['value']==8) { echo 'selected="selected"'; } ?>>August</option>
                                <option value="9" <?php if($form['fields']['month_to']['value']==9) { echo 'selected="selected"'; } ?>>September</option>
                                <option value="10" <?php if($form['fields']['month_to']['value']==10) { echo 'selected="selected"'; } ?>>October</option>
                                <option value="11" <?php if($form['fields']['month_to']['value']==11) { echo 'selected="selected"'; } ?>>November</option>
                                <option value="12" <?php if($form['fields']['month_to']['value']==12) { echo 'selected="selected"'; } ?>>December</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 col-xs-11">Day <span class="required">*</span></label>
                    <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                    <div class="col-sm-7 col-xs-12">
                    	<div style="height:32px;">
                        	<a class="btn" onclick="javascript:SelectAllDays();">Select All</a> | 
                            <a class="btn" onclick="javascript:DeselectAllDays();">Deselect All</a>
                            <a class="btn" onclick="javascript:SelectWeekdays();">Weekdays</a> | 
                            <a class="btn" onclick="javascript:SelectWeekend();">Weekend</a>
                        </div>
                        <div style="height:32px;"><input id="entry_day_mon" name="day_mon" type="checkbox" value="1" <?php if($form['fields']['day_mon']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Monday</span></div>
                        <div style="height:32px;"><input id="entry_day_tue" name="day_tue" type="checkbox" value="1" <?php if($form['fields']['day_tue']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Tuesday</span></div>
                        <div style="height:32px;"><input id="entry_day_wed" name="day_wed" type="checkbox" value="1" <?php if($form['fields']['day_wed']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Wednesday</span></div>
                        <div style="height:32px;"><input id="entry_day_thu"  name="day_thu" type="checkbox" value="1" <?php if($form['fields']['day_thu']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Thursday</span></div>
                        <div style="height:32px;"><input id="entry_day_fri"  name="day_fri" type="checkbox" value="1" <?php if($form['fields']['day_fri']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Friday</span></div>
                        <div style="height:32px;"><input id="entry_day_sat"  name="day_sat" type="checkbox" value="1" <?php if($form['fields']['day_sat']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Saturday</span></div>
                        <div style="height:32px;"><input id="entry_day_sun"  name="day_sun" type="checkbox" value="1" <?php if($form['fields']['day_sun']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Sunday</span></div>
                        <div style="height:32px;"><input id="entry_day_holiday"  name="day_holiday" type="checkbox" value="1" <?php if($form['fields']['day_holiday']['value']==1) {echo 'checked';} ?>/><span>&nbsp;Holidays</span><span>&nbsp;(Customise the list of holidays)</span></div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 col-xs-11">Time <span class="required">*</span></label>
                    <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <div id="block_time_24hour">
                            <select id="entry_time" name="time"onchange="javascript:CheckTime();" class="form-control">
                                <option value="0" <?php if($form['fields']['time']['value']==0) { echo 'selected="selected"'; } ?> >24 hours</option>
                                <option value="1" <?php if($form['fields']['time']['value']==1) { echo 'selected="selected"'; } ?>>Specific time</option>
                            </select>
                        </div>
                        <div id="block_time" <?php if($form['fields']['time']['value']==1) {} else { echo 'style="display:none;"'; } ?> >
                        	<br /><br />
                            <input id="entry_time_from" name="time_from" class="form-control" type="time" value="<?php echo $form['fields']['time_from']['value'];?>" style="width:45%;"/>
                            <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:center;">to</span>
                            <input id="entry_time_to" name="time_to" class="form-control" type="time" value="<?php echo $form['fields']['time_to']['value'];?>" style="width:45%;"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Description</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <input name="description" class="form-control atext" type="text" value="<?php echo $form['fields']['description']['value'];?>"/>
                    </div>
                    <span class="help-block field_err">Help</span>
                </div>
            </div>
            <div class="panel-footer col-xs-12">
                <div class="text-center">
                    <button class="btn btn-primary lock-on-click" type="submit">
                    <?php if (!isset($this->request->get['product_hour_id'])) { ?>
                        <i class="fa fa-plus fa-fw"></i> <?php echo $form['submit']->text; ?>
                    <?php } else { ?>
                        <i class="fa fa-save fa-fw"></i> <?php echo $button_save; ?>
                    <?php } ?>
                    </button>
                    <button class="btn btn-default" type="reset">
                    <i class="fa fa-refresh fa-fw"></i> <?php echo $button_reset; ?>
                    </button>
                    <a class="btn btn-default" href="<?php echo $cancel; ?>">
                    <i class="fa fa-arrow-left fa-fw"></i> <?php echo $form['cancel']->text; ?>
                    </a>
                </div>
            </div>
        </form>  
    </div>
</div>

<script type="text/javascript">
function CheckCondition() {
	if(document.getElementById('entry_general').value == 1) {
		document.getElementById('block_specific_date').style.display = 'none';
		document.getElementById('block_specific_month').style.display = 'none';
	}
	else if(document.getElementById('entry_general').value == 2) {
		document.getElementById('block_specific_date').style.display = 'none';
		document.getElementById('block_specific_month').style.display = 'block';
	}
	else {
		document.getElementById('block_specific_date').style.display = 'block';
		document.getElementById('block_specific_month').style.display = 'none';
	}
}

function CheckTime() {
	if(document.getElementById('entry_time').value == 0) {
		document.getElementById('block_time').style.display = 'none';
		document.getElementById('entry_time_from').value = '00:00:00';
		document.getElementById('entry_time_to').value = '00:00:00';
	}
	else {
		document.getElementById('block_time').style.display = 'block';
	}
}

function SelectAllDays() {
	document.getElementById('entry_day_mon').checked = true;
	document.getElementById('entry_day_tue').checked = true;
	document.getElementById('entry_day_wed').checked = true;
	document.getElementById('entry_day_thu').checked = true;
	document.getElementById('entry_day_fri').checked = true;
	document.getElementById('entry_day_sat').checked = true;
	document.getElementById('entry_day_sun').checked = true;
	document.getElementById('entry_day_holiday').checked = true;
}

function DeselectAllDays() {
	document.getElementById('entry_day_mon').checked = false;
	document.getElementById('entry_day_tue').checked = false;
	document.getElementById('entry_day_wed').checked = false;
	document.getElementById('entry_day_thu').checked = false;
	document.getElementById('entry_day_fri').checked = false;
	document.getElementById('entry_day_sat').checked = false;
	document.getElementById('entry_day_sun').checked = false;
	document.getElementById('entry_day_holiday').checked = false;
}

function SelectWeekdays() {
	document.getElementById('entry_day_mon').checked = true;
	document.getElementById('entry_day_tue').checked = true;
	document.getElementById('entry_day_wed').checked = true;
	document.getElementById('entry_day_thu').checked = true;
	document.getElementById('entry_day_fri').checked = true;
	document.getElementById('entry_day_sat').checked = false;
	document.getElementById('entry_day_sun').checked = false;
	document.getElementById('entry_day_holiday').checked = false;
}

function SelectWeekend() {
	document.getElementById('entry_day_mon').checked = false;
	document.getElementById('entry_day_tue').checked = false;
	document.getElementById('entry_day_wed').checked = false;
	document.getElementById('entry_day_thu').checked = false;
	document.getElementById('entry_day_fri').checked = false;
	document.getElementById('entry_day_sat').checked = true;
	document.getElementById('entry_day_sun').checked = true;
	document.getElementById('entry_day_holiday').checked = false;
}
</script>