<style>
	.mobile-form label {
		background-color:#FFF;
		color:#777;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #CCC;
		outline:none;
		font-weight:normal;
	}
	.mobile-form input, .mobile-form select {
		background-color:#FFF;
		color:#000;
		height:50px;
		width:100%;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		-webkit-appearance: none;
	}
	.mobile-form input:disabled {
		color:#999;
	}
	.mobile-form select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
	
	.css-tools-or-with-line {
		width: 100%; 
		text-align: center; 
		border-bottom: 1px solid #CCC; 
		line-height: 0.1em;
		margin: 10px 0 20px; 
	}
	
	.css-tools-or-with-line span {
    	padding:0 20px; 
		background:#eee; 
		color:#777;
	}
</style>

<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-modal">
        <div class="col-xs-3 text-left">
            <a class="btn" href="javascript:history.back();">Back</a>
        </div>
        <div class="col-xs-6 text-center">
        	<h1>Select Template</h1>
        </div>
        <div class="col-xs-3 text-right">
        </div>
    </div>
</div>
<!--
<div class="content-body-loading fixed-width">
    <div class="col-xs-12">
        <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
    </div>
</div>
<div class="content-body-empty fixed-width">
    <div class="col-xs-12">
    	<div><b>No Available Template</b></div>
        <div>Click to <a href="<?php echo $link['trip/new']; ?>">create own itinerary</a></div>
    </div>
</div>
-->
<div class="content-body fixed-width background-empty">
	<div class="navbar navbar-shadow"></div>
    <form class="mobile-form" id="modal-trip-new-form">
        <input type="hidden" name="action" value="new_trip" />
        <input type="hidden" name="user_id" value="<?php echo $this->user->getUserId(); ?>" />
        <input type="hidden" name="role_id" value="<?php echo $this->user->getRoleId(); ?>" />
        <input type="hidden" name="language_id" value="<?php echo $this->language->getLanguageId(); ?>" />
        <div class="row">
            <div class="col-xs-4"><label for="country_id" selected>Destination</label></div>
            <div class="col-xs-8">
                <select name="country_id">
                	<option value="0">Any</option>
                    <?php
                        $c = $this->request->get_or_post('c');
                        foreach($country as $key => $value) {
                            if($c) {
                                 if($value['country_id'] == $c) { $selected = 'selected'; } else { $selected = ''; }
                            }else{
                                if($value['iso_code_2'] == 'MY') { $selected = 'selected'; } else { $selected = ''; }
                            }
                            echo '<option value="'.$value['country_id'].'" '.$selected.'>'.$value['name'].'</option>';
                            
                        }
                    ?>
                </select>
            </div>
        </div>
        <div class="hidden">
            <div class="row">
                <div class="col-xs-4"><label for="month" selected>Month</label></div>
                <div class="col-xs-8">
                    <select name="month">
                    <option value="0" selected>Any</option>
                        <?php
                            $t = $this->request->get_or_post('month');
                            foreach($month as $key => $value) {
                                if($c) {
                                     if($value['tag_id'] == $t) { $selected = 'selected'; } else { $selected = ''; }
                                }
                                echo '<option value="'.$value['tag_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4"><label for="mode_id" selected>Transport</label></div>
                <div class="col-xs-8">
                    <select name="mode_id">
                        <option value="0">Any</option>
                        <?php
                            $t = $this->request->get_or_post('t');
                            foreach($mode as $key => $value) {
                                if($c) {
                                     if($value['mode_id'] == $t) { $selected = 'selected'; } else { $selected = ''; }
                                }
                                echo '<option value="'.$value['mode_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4"><label for="num_of_day" selected>Duration</label></div>
                <div class="col-xs-8">
                    <select name="num_of_day">
                    <option value="0" selected>Any</option>
                        <?php
                            for($i=1;$i<31;$i++) {
                                if($i == 1) { $unit = 'day'; } else { $unit = 'days'; }
                                echo '<option value="'.$i.'" '.$selected.'>'.$i.' '.$unit.'</option>';
                            }
                        ?>
                    </select>
                </div>
            </div>
        </div>
    </form>
    <div class="row navbar navbar-transparent">
        <div class="col-xs-6 text-left">
            <span class="text-sub hidden btn-create-from-scratch"><a>Create From Scratch</a></span>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-set-filter" data-toggle="modal" data-target="#modal-set-filter">More Filters <i class="fa fa-caret-down"></i></a>
        </div>
    </div>
        <div class="css-tools-or-with-line"><span>OR</span></div>
        <div class="row text-center padding">
        	<div class="text-sub padding">Can't find any template?</div>
            <a class="btn btn-block btn-primary box-shadow rounded fixed-height-5" onclick="verify_new_trip_condition();">Create My Own</a>
        </div>
    <div class="content-body-alert"></div>
    <div class="content-body-result la la-70 la-border noselect">
    </div>
</div>

<script>
	function hideCreateFromScratchButton() {
		var height = $('.content-body').css('height');
		height = parseInt(height, 10);
		if(height > window.innerHeight + 100) {
			$('.btn-create-from-scratch').removeClass('hidden');
		}
	}
	hideCreateFromScratchButton();
</script>