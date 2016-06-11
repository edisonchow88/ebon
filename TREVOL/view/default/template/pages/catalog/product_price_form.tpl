<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>


<?php print_r(($currencies)); ?>

<?php echo $product_tabs; ?>

<div id="content" class="panel panel-default">
    
    <div class="contentpanel">
        <h1><?php echo $heading_title; ?></h1>
        
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" role="form" data-confirm-exit="true" class="aform form-horizontal">
        	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Name <span class="required">*</span></label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <input name="name" class="form-control atext" type="text" value="<?php echo $form['fields']['name']['value'];?>"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Amount <span class="required">*</span></label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                        <input name="amount" class="form-control atext" type="text"  style="width:30%;" value="<?php echo $form['fields']['amount']['value'];?>"/>
                        <select name="currency_code" class="form-control" style="width:35%;">
                        	<?php echo $currency_options; ?>
                        </select>
                        <select name="unit" class="form-control" style="width:35%;">
                        	<?php echo $unit_options; ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12"><b>Condition</b></label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Time</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<select name="product_hour_id" class="form-control">
                        	<?php echo $time_options; ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Gender</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<select name="gender" class="form-control">
                        	<?php echo $gender_options; ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Age</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<select id="entry_age" name="age" class="form-control" onchange="javascript:CheckAge();">
                        	<?php echo $age_options; ?>
                        </select>
                        <div id="block_age" style="display:none;">
                        	<br /><br />
                            <div id="block_age_min" style="display:none;">
                                <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:left;">Min</span>
                                <input name="min_age" class="form-control atext" type="text"  style="width:37.5%;" value="<?php echo $form['fields']['min_age']['value'];?>"/>
                                <span style="width:5%; float:left; vertical-align:middle; padding-top:7px; text-align:center;"></span>
                            </div>
                            <div id="block_age_max" style="display:none;">
                                <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:left;">Max</span>
                                <input name="max_age" class="form-control atext" type="text"  style="width:37.5%;" value="<?php echo $form['fields']['max_age']['value'];?>"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Pax</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<select id="entry_pax" name="pax" class="form-control" onchange="javascript:CheckPax();">
                        	<?php echo $pax_options; ?>
                        </select>
                        <div id="block_pax" style="display:none;">
                        	<br /><br />
                            <div id="block_pax_min" style="display:none;">
                                <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:left;">Min</span>
                                <input name="min_pax" class="form-control atext" type="text"  style="width:37.5%;" value="<?php echo $form['fields']['min_pax']['value'];?>"/>
                                <span style="width:5%; float:left; vertical-align:middle; padding-top:7px; text-align:center;"></span>
                            </div>
                            <div id="block_pax_max" style="display:none;">
                                <span style="width:10%; float:left; vertical-align:middle; padding-top:7px; text-align:left;">Max</span>
                                <input name="max_pax" class="form-control atext" type="text"  style="width:37.5%;" value="<?php echo $form['fields']['max_pax']['value'];?>"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Duration</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<input name="duration" class="form-control atext" type="text"  style="width:50%;" value="<?php echo $form['fields']['duration']['value'];?>"/>
                    	<select name="duration_unit" class="form-control" style="width:50%;">
                        	<?php echo $duration_unit_options; ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-xs-12">Early Booking</label>
                    <div class="input-group afield col-sm-7 col-xs-12">
                    	<input name="early_booking" class="form-control atext" type="text"  style="width:50%;" value="<?php echo $form['fields']['early_booking']['value'];?>"/>
                        <span style="width:50%; float:left; vertical-align:middle; padding-top:7px; text-align:left;">&nbsp; days before visit</span>
                    </div>
                </div>
            </div>
            <div class="panel-footer col-xs-12">
                <div class="text-center">
                    <button class="btn btn-primary lock-on-click" type="submit">
                    <?php if (!isset($this->request->get['product_price_id'])) { ?>
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
function CheckAge() {
	if(document.getElementById('entry_age').value == '') {
		document.getElementById('block_age').style.display = 'none';
		document.getElementById('block_age_min').style.display = 'none';
		document.getElementById('block_age_max').style.display = 'none';
	}
	else if(document.getElementById('entry_age').value == 1) {
		document.getElementById('block_age').style.display = 'block';
		document.getElementById('block_age_min').style.display = 'block';
		document.getElementById('block_age_max').style.display = 'none';
	}
	else if(document.getElementById('entry_age').value == 2) {
		document.getElementById('block_age').style.display = 'block';
		document.getElementById('block_age_min').style.display = 'none';
		document.getElementById('block_age_max').style.display = 'block';
	}
	else if(document.getElementById('entry_age').value == 3) {
		document.getElementById('block_age').style.display = 'block';
		document.getElementById('block_age_min').style.display = 'block';
		document.getElementById('block_age_max').style.display = 'block';
	}
}

function CheckPax() {
	if(document.getElementById('entry_pax').value == '') {
		document.getElementById('block_pax').style.display = 'none';
		document.getElementById('block_pax_min').style.display = 'none';
		document.getElementById('block_pax_max').style.display = 'none';
	}
	else if(document.getElementById('entry_pax').value == 1) {
		document.getElementById('block_pax').style.display = 'block';
		document.getElementById('block_pax_min').style.display = 'block';
		document.getElementById('block_pax_max').style.display = 'none';
	}
	else if(document.getElementById('entry_pax').value == 2) {
		document.getElementById('block_pax').style.display = 'block';
		document.getElementById('block_pax_min').style.display = 'none';
		document.getElementById('block_pax_max').style.display = 'block';
	}
	else if(document.getElementById('entry_pax').value == 3) {
		document.getElementById('block_pax').style.display = 'block';
		document.getElementById('block_pax_min').style.display = 'block';
		document.getElementById('block_pax_max').style.display = 'block';
	}
}

function init() {
	CheckAge();
	CheckPax();
}

window.onload = init;
</script>