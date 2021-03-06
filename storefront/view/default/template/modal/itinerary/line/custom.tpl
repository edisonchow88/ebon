<style>
	#modal-line-custom .navbar-white {
	}
	
	#modal-line-custom .navbar-white .btn {
		color:#999;
	}
	
	#modal-line-custom .navbar-white .btn:hover {
		color:#000;
	}
	
	#modal-line-custom .navbar-white .btn.active {
		color:#e93578;
		cursor:default;
		pointer-events:none;
	}
	#modal-line-custom  .modal-body {
		background-color:#EEE;
	}
	#modal-line-custom .tab {
		position:relative;
	}
	
	/* START: map */
		#modal-line-custom .button-left {
			left:0;
		}
		#modal-line-custom .button-recenter {
			right:0;
		}
		#modal-line-custom .button-reset {
			border-radius:5px 0 0 5px;
			color:#000;
		}
		#modal-line-custom .button-remove {
			border-radius:0 5px 5px 0;
			color:#000;
		}
		#modal-line-custom .button-left .disabled {
			pointer-events:none;
			cursor:not-allowed;
			color:#999;
		}
		#modal-line-custom .tab-location .btn-group {
			padding:10px;
			position:absolute;
			z-index:20;
		}
		#modal-line-custom .tab-location .btn {
			height:40px;
			padding:10px;
			border-radius:5px;
		}
		#modal-line-custom  #line-map {
			width:100%;
			height:calc(100vh - 180px);
		}
	/* END */
	#modal-line-custom .form-spacer {
		height:10px;
		border-bottom:solid thin #DDD;
	}
	#modal-line-custom .image {
		background-color:#EEE;
		height:calc(100vh - 130px);
		width:100%;
		text-align:center;
		padding-top:30px;
	}
	#modal-line-custom .image img {
		background-color:#999;
		height:200px;
		width:200px;
		border:solid thin #DDD;
		border-radius:150px;
	}
	#modal-line-custom label {
		background-color:#FFF;
		color:#999;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		font-weight:normal;
	}
	#modal-line-custom input, #modal-line-custom select {
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
	#modal-line-custom input:disabled {
		color:#999;
	}
	#modal-line-custom select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
	#modal-line-custom textarea {
		height:calc(100vh - 130px);
		width:100%;
		padding:15px;
		border:none;
		border-bottom:solid thin #EEE;
		outline:none;
	}
	#modal-line-custom .icon-disabled {
		position:absolute;
		color:#000;
		height:50px;
		padding:15px;
		top:0;
		right:0;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-line-custom" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
            <div class="modal-header fixed-width">
                <div id="modal-line-map-header-add" class="navbar navbar-primary navbar-modal fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Add Activity</span>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom"onclick="saveModalLineCustomForm('add');">Save</a>
                    </div>
                </div>
                <div id="modal-line-map-header-edit" class="navbar navbar-primary navbar-modal fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Edit Activity</span>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom" onclick="saveModalLineCustomForm('edit');">Save</a>
                    </div>
                </div>
                <div class="navbar navbar-white fixed-width">
                	<div class="col-xs-3">
                    	<a class="btn btn-block btn-general" onclick="selectModalLineCustomTab('general');"><i class="fa fa-fw fa-lg fa-pencil"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-time" onclick="selectModalLineCustomTab('time');"><i class="fa fa-fw fa-lg fa-clock-o"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-location" onclick="selectModalLineCustomTab('location');"><i class="fa fa-fw fa-lg fa-map-marker"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-photo" onclick="selectModalLineCustomTab('photo');"><i class="fa fa-fw fa-lg fa-picture-o"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-fee" onclick="selectModalLineCustomTab('fee');"><i class="fa fa-fw fa-lg"><b>&#36;</b></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-more" onclick="selectModalLineCustomTab('more');"><i class="fa fa-fw fa-ellipsis-v"></i></a>
                    </div>
                </div>
            </div>
                    <div class="modal-body fixed-width">
                    	<div class="navbar navbar-shadow"></div>
                        <div class="navbar navbar-shadow"></div>
                    	<form id="modal-line-custom-form">
                        	<input type="hidden" name="line_id"/>
                            <input type="hidden" name="day_id"/>
                            <input type="hidden" name="sort_order"/>
                            <input type="hidden" name="place_id"/>
                        	<div class="tab tab-general">
                            	<div class="row">
                                    <select name="activity">
                                    	<option value="visit">Visit</option>
                                    	<option value="eat">Eat</option>
                                    	<option value="stay">Stay</option>
                                        <option value="fly_out">Fly Out</option>
                                        <option value="fly">Travel by Flight</option>
                                        <option value="fly_in">Fly In</option>
                                    </select>
                                </div>
                                <div class="row">
                                	<div class="col-xs-12"><input type="text" name="title" placeholder="Title" /></div>
                                </div>
                                <textarea name="description" placeholder="Description"></textarea>
                            </div>
                            <div class="tab tab-time">
                                <div class="row hidden">
                                	<div class="col-xs-4"><label for="duration">Duration</label></div>
                                	<div class="col-xs-4"><input type="number" name="duration"/></div>
                                    <div class="col-xs-4"><label class="unit-duration" for="duration">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="hrs">Duration</label></div>
                                	<div class="col-xs-2">
                                    	<select name=hrs>
                                        	<?php
                                            	for($i=0;$i<=23;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="hrs">hrs</label></div>
                                	<div class="col-xs-2">
                                    	<select name=mins>
                                        	<?php
                                            	for($i=0;$i<=59;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="mins">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time">Time (From)</label></div>
                                	<div class="col-xs-8"><input type="time" name="time"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time_to">Time (To)</label></div>
                                	<div class="col-xs-4"><input type="time" name="time_to"/></div>
                                    <div class="col-xs-4"><label class="unit-time-to" for="time_to">+ 1 day</label></div>
                                </div>
                            </div>
                            <div class="tab tab-fee">
                            	<div class="row">
                                </div>
                            </div>
                            <div class="tab tab-location">
                            	<input type="hidden" name="origin_lat"/>
                                <input type="hidden" name="origin_lng"/>
                            	<div class="row">
                                	<div class="col-xs-4"><label for="lat">Latitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lat"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="lng">Longitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lng"/></div>
                                </div>
                                <ul class="pagination btn-group button-left">
                                	<li><a class="button-reset disabled">Reset</a></li>
                                    <li><a class="button-remove">Remove</a></li>
                                </ul>
                                <div class="btn-group button-recenter">
                                    <div class="btn btn-default">
                                        <i class="fa fa-fw fa-bullseye"></i>
                                    </div>
                                </div>
                                <div id="line-map"></div>
                            </div>
                            <div class="tab tab-photo hidden">
                            	<div class="row">
                                	<input type="hidden" name="photo_hidden"/>
                                	<div class="col-xs-12 hidden"><input type="text" name="image_id"/></div>
                                    <?php if($this->session->data['memory'] == 'server') { ?>
                                        <div class="col-xs-12">
                                        	<input type="text" name="photo" placeholder="Place your photo url here"/>
                                        </div>
                                    <?php } else { ?>
                                        <div class="col-xs-12">
                                            <input type="text" name="photo" placeholder="Place your photo url here" disabled/>
                                            <div class="icon-disabled"><i class="fa fa-fw fa-lock"></i></div>
                                        </div>
                                    <?php } ?>
                                </div>
                                <div class="image">
                                	<img src="" onerror="this.onerror = '';this.src = 'resources/image/error/noimage.png';" />
                                </div>
                            </div>
                            <div class="tab tab-contact">
                                <div class="row">
                                	<div class="col-xs-4"><label for="company">Company</label></div>
                                	<div class="col-xs-8"><input type="text" name="company"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="address">Address</label></div>
                                	<div class="col-xs-8"><input type="text" name="address"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="phone">Phone</label></div>
                                	<div class="col-xs-8"><input type="text" name="phone"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="fax">Fax</label></div>
                                	<div class="col-xs-8"><input type="text" name="fax"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="website">Website</label></div>
                                	<div class="col-xs-8"><input type="text" name="website"/></div>
                                </div>
                            </div>
                            <div class="tab tab-more">
                            	<div class="la la-50 la-border la-hover la-pointer noselect">
                                	<div class="la-row hidden" onclick="selectModalLineCustomTab('location');">
                                    	<div class="la-icon">
                                        	<i class="fa fa-fw fa-lg fa-map-marker"></i>
                                        </div>
                                        <div class="la-desc">
                                        	<div class="la-text">
                                            	<span>Location</span>
                                        	</div>
                                        </div>
                                    </div>
                                    <div class="la-row" onclick="selectModalLineCustomTab('contact');">
                                    	<div class="la-icon">
                                        	<i class="fa fa-fw fa-lg fa-phone"></i>
                                        </div>
                                        <div class="la-desc">
                                        	<div class="la-text">
                                            	<span>Contact</span>
                                        	</div>
                                        </div>
                                    </div>
                                    <div class="la-row hidden button-duplicate-activity" data-dismiss="modal" onclick="duplicateLine();">
                                    	<div class="la-icon">
                                        	<i class="fa fa-fw fa-lg fa-clone"></i>
                                        </div>
                                        <div class="la-desc">
                                        	<div class="la-text">
                                            	<span>Duplicate Activity</span>
                                        	</div>
                                        </div>
                                    </div>
                                    <div class="la-row button-delete-activity" data-toggle="modal" data-target="#modal-line-delete">
                                    	<div class="la-icon">
                                        	<i class="fa fa-fw fa-lg fa-trash text-danger"></i>
                                        </div>
                                        <div class="la-desc">
                                        	<div class="la-text text-danger">
                                            	<span>Delete Activity</span>
                                        	</div>
                                        </div>
                                    </div>
                                </div>
                                <!--
                            	<ul class="menu menu-white">
                                	<li onclick="selectModalLineCustomTab('location');">
                                    	<i class="fa fa-fw fa-lg fa-map-marker"></i>
                                        <i class="fa fa-fw"></i>
                                        Location
                                    </li>
                                    <li onclick="selectModalLineCustomTab('contact');">
                                    	<i class="fa fa-fw fa-lg fa-phone"></i>
                                        <i class="fa fa-fw"></i>
                                        Contact
                                    </li>
                                    <li class="hidden" onclick="selectModalLineCustomTab('photo');">
                                    	<i class="fa fa-fw fa-lg fa-picture-o"></i>
                                        <i class="fa fa-fw"></i>
                                        Photo
                                    </li>
                                    <li class="button-duplicate-activity" data-dismiss="modal" onclick="duplicateLine();">
                                    	<i class="fa fa-fw fa-lg fa-clone"></i>
                                        <i class="fa fa-fw"></i>
                                        Duplicate Activity
                                    </li>
                                    <li class="button-delete-activity text-danger" data-toggle="modal" data-target="#modal-line-delete">
                                    	<i class="fa fa-fw fa-lg fa-trash"></i>
                                        <i class="fa fa-fw"></i>
                                        Delete Activity
                                    </li>
                                </ul>
                                -->
                            </div>
                        </form>
                    </div>
        </div>
    </div>
<!--
    <div class="modal modal-fixed-top" id="modal-line-custom" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-map-header-add" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Add Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom"onclick="saveModalLineCustomForm('add');">Save</a>
                    </div>
                </div>
                <div id="modal-line-map-header-edit" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Edit Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom" onclick="saveModalLineCustomForm('edit');">Save</a>
                    </div>
                </div>
                <div class="header header-secondary header-white fixed-bar fixed-width row">
                	<div class="col-xs-3">
                    	<a class="btn btn-block btn-general" onclick="selectModalLineCustomTab('general');"><i class="fa fa-fw fa-lg fa-pencil"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-time" onclick="selectModalLineCustomTab('time');"><i class="fa fa-fw fa-lg fa-clock-o"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-location" onclick="selectModalLineCustomTab('location');"><i class="fa fa-fw fa-lg fa-map-marker"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-photo" onclick="selectModalLineCustomTab('photo');"><i class="fa fa-fw fa-lg fa-picture-o"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-fee" onclick="selectModalLineCustomTab('fee');"><i class="fa fa-fw fa-lg"><b>&#36;</b></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-more" onclick="selectModalLineCustomTab('more');"><i class="fa fa-fw fa-ellipsis-v"></i></a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<form id="modal-line-custom-form">
                        	<input type="hidden" name="line_id"/>
                            <input type="hidden" name="day_id"/>
                            <input type="hidden" name="sort_order"/>
                            <input type="hidden" name="place_id"/>
                        	<div class="tab tab-general">
                            	<div class="row">
                                    <select name="activity">
                                    	<option value="visit">Visit</option>
                                    	<option value="eat">Eat</option>
                                    	<option value="stay">Stay</option>
                                        <option value="fly_out">Fly Out</option>
                                        <option value="fly">Travel by Flight</option>
                                        <option value="fly_in">Fly In</option>
                                    </select>
                                </div>
                                <div class="row">
                                	<div class="col-xs-12"><input type="text" name="title" placeholder="Title" /></div>
                                </div>
                                <textarea name="description" placeholder="Description"></textarea>
                            </div>
                            <div class="tab tab-time">
                                <div class="row hidden">
                                	<div class="col-xs-4"><label for="duration">Duration</label></div>
                                	<div class="col-xs-4"><input type="number" name="duration"/></div>
                                    <div class="col-xs-4"><label class="unit-duration" for="duration">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="hrs">Duration</label></div>
                                	<div class="col-xs-2">
                                    	<select name=hrs>
                                        	<?php
                                            	for($i=0;$i<=23;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="hrs">hrs</label></div>
                                	<div class="col-xs-2">
                                    	<select name=mins>
                                        	<?php
                                            	for($i=0;$i<=59;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="mins">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time">Time (From)</label></div>
                                	<div class="col-xs-8"><input type="time" name="time"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time_to">Time (To)</label></div>
                                	<div class="col-xs-4"><input type="time" name="time_to"/></div>
                                    <div class="col-xs-4"><label class="unit-time-to" for="time_to">+ 1 day</label></div>
                                </div>
                            </div>
                            <div class="tab tab-fee">
                            	<div class="row">
                                </div>
                            </div>
                            <div class="tab tab-location">
                            	<input type="hidden" name="origin_lat"/>
                                <input type="hidden" name="origin_lng"/>
                            	<div class="row">
                                	<div class="col-xs-4"><label for="lat">Latitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lat"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="lng">Longitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lng"/></div>
                                </div>
                                <ul class="pagination btn-group button-left">
                                	<li><a class="button-reset disabled">Reset</a></li>
                                    <li><a class="button-remove">Remove</a></li>
                                </ul>
                                <div class="btn-group button-recenter">
                                    <div class="btn btn-default">
                                        <i class="fa fa-fw fa-bullseye"></i>
                                    </div>
                                </div>
                                <div id="line-map"></div>
                            </div>
                            <div class="tab tab-photo">
                            	<div class="row">
                                	<input type="hidden" name="photo_hidden"/>
                                	<div class="col-xs-12 hidden"><input type="text" name="image_id"/></div>
                                    <?php if($this->session->data['memory'] == 'server') { ?>
                                        <div class="col-xs-12">
                                        	<input type="text" name="photo" placeholder="Place your photo url here"/>
                                        </div>
                                    <?php } else { ?>
                                        <div class="col-xs-12">
                                            <input type="text" name="photo" placeholder="Place your photo url here" disabled/>
                                            <div class="icon-disabled"><i class="fa fa-fw fa-lock"></i></div>
                                        </div>
                                    <?php } ?>
                                </div>
                                <div class="image">
                                	<img src="" onerror="this.onerror = '';this.src = 'resources/image/error/noimage.png';" />
                                </div>
                            </div>
                            <div class="tab tab-contact">
                                <div class="row">
                                	<div class="col-xs-4"><label for="company">Company</label></div>
                                	<div class="col-xs-8"><input type="text" name="company"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="address">Address</label></div>
                                	<div class="col-xs-8"><input type="text" name="address"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="phone">Phone</label></div>
                                	<div class="col-xs-8"><input type="text" name="phone"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="fax">Fax</label></div>
                                	<div class="col-xs-8"><input type="text" name="fax"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="website">Website</label></div>
                                	<div class="col-xs-8"><input type="text" name="website"/></div>
                                </div>
                            </div>
                            <div class="tab tab-more">
                            	<ul class="menu menu-white">
                                	<li onclick="selectModalLineCustomTab('location');">
                                    	<i class="fa fa-fw fa-lg fa-map-marker"></i>
                                        <i class="fa fa-fw"></i>
                                        Location
                                    </li>
                                    <li onclick="selectModalLineCustomTab('contact');">
                                    	<i class="fa fa-fw fa-lg fa-phone"></i>
                                        <i class="fa fa-fw"></i>
                                        Contact
                                    </li>
                                    <li class="hidden" onclick="selectModalLineCustomTab('photo');">
                                    	<i class="fa fa-fw fa-lg fa-picture-o"></i>
                                        <i class="fa fa-fw"></i>
                                        Photo
                                    </li>
                                    <li class="button-duplicate-activity" data-dismiss="modal" onclick="duplicateLine();">
                                    	<i class="fa fa-fw fa-lg fa-clone"></i>
                                        <i class="fa fa-fw"></i>
                                        Duplicate Activity
                                    </li>
                                    <li class="button-delete-activity text-danger" data-toggle="modal" data-target="#modal-line-delete">
                                    	<i class="fa fa-fw fa-lg fa-trash"></i>
                                        <i class="fa fa-fw"></i>
                                        Delete Activity
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
-->
<!-- END -->

<script>
	function initLineMap() {
		$('#modal-line-custom-form .button-reset').addClass('disabled');
		
		var lat = parseFloat($('#modal-line-custom-form input[name=lat]').val())||0;
		var lng = parseFloat($('#modal-line-custom-form input[name=lng]').val())||0;
		var origin_lat = parseFloat($('#modal-line-custom-form input[name=origin_lat]').val())||0;
		var origin_lng = parseFloat($('#modal-line-custom-form input[name=origin_lng]').val())||0;
		
		if(origin_lat == 0 && origin_lng == 0) {
			$('#modal-line-custom-form .button-remove').addClass('disabled');
		}
		else {
			$('#modal-line-custom-form .button-remove').removeClass('disabled');
		}
		
		var myLatLng = {"lat":lat,"lng":lng};
		var originLatLng = {"lat":origin_lat,"lng":origin_lng};
		
		var map = new google.maps.Map(document.getElementById('line-map'), {
			center: myLatLng,
			zoom: 7,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			disableDefaultUI: true
        });
		
		var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
		  draggable:true,
        });
		
		google.maps.event.addListener(marker, 'dragend', function() 
		{
			geocodePosition(marker.getPosition());
			$('#modal-line-custom-form .button-reset').removeClass('disabled');
		});
		
		$("#modal-line-custom-form input[name=lat]").on('change', function() {
			lat = parseFloat($('#modal-line-custom-form input[name=lat]').val());
			if(verifyLat(lat)) {
				myLatLng = {"lat":lat,"lng":lng};
				marker.setPosition( new google.maps.LatLng(myLatLng) );
				map.setCenter(marker.getPosition());
				$('#modal-line-custom-form input[name=lat]').val(lat.toFixed(7));
				$('#modal-line-custom-form .button-reset').removeClass('disabled');
			}
			else {
				showAlert('Latitude must between -90 and 90.');
			}
		});
		
		$("#modal-line-custom-form input[name=lng]").on('change', function() {
			lng = parseFloat($('#modal-line-custom-form input[name=lng]').val());
			if(verifyLng(lng)) {
				myLatLng = {"lat":lat,"lng":lng};
				marker.setPosition( new google.maps.LatLng(myLatLng) );
				map.setCenter(marker.getPosition());
				$('#modal-line-custom-form input[name=lng]').val(lng.toFixed(7));
				$('#modal-line-custom-form .button-reset').removeClass('disabled');
			}
			else {
				showAlert('Longitude must between -180 and 180.');
			}
		});
		
		$("#modal-line-custom .tab-location .button-recenter").off().on('click', function() {
			map.setCenter(marker.getPosition());
		});
		
		$("#modal-line-custom .tab-location .button-reset").off().on('click', function() {
			marker.setPosition( new google.maps.LatLng(originLatLng) );
			map.setCenter(marker.getPosition());
			var reset_lat = origin_lat;
			var reset_lng = origin_lng;
			if(origin_lat == 0) { reset_lat = ''; }
			if(origin_lng == 0) { reset_lng = ''; }
			$('#modal-line-custom-form input[name=lat]').val(reset_lat);
			$('#modal-line-custom-form input[name=lng]').val(reset_lng);
			$('#modal-line-custom-form .button-reset').addClass('disabled');
			if(origin_lat == 0 && origin_lng == 0) {
				$('#modal-line-custom-form .button-remove').addClass('disabled');
			}
			else {
				$('#modal-line-custom-form .button-remove').removeClass('disabled');
			}
		});
		
		$("#modal-line-custom .tab-location .button-remove").off().on('click', function() {
			marker.setPosition( new google.maps.LatLng({"lat":0,"lng":0}) );
			map.setCenter(marker.getPosition());
			$('#modal-line-custom-form input[name=lat]').val('');
			$('#modal-line-custom-form input[name=lng]').val('');
			$('#modal-line-custom-form .button-reset').removeClass('disabled');
			$('#modal-line-custom-form .button-remove').addClass('disabled');
		});	
	}
	
	function geocodePosition(pos) {
	   geocoder = new google.maps.Geocoder();
	   geocoder.geocode
		({
			latLng: pos
		}, 
			function(results, status) 
			{
				if (status == google.maps.GeocoderStatus.OK) 
				{
					$('#modal-line-custom-form input[name=lat]').val(results[0].geometry.location.lat().toFixed(7));
					$('#modal-line-custom-form input[name=lng]').val(results[0].geometry.location.lng().toFixed(7));
				} 
				else 
				{
					$('#modal-line-custom-form input[name=lat]').val('Error');
					$('#modal-line-custom-form input[name=lng]').val('Error');
				}
			}
		);
	}
	
	function verifyLat(lat) {
		if(isset(lat) && lat >= -85 && lat <= 85) {
			return true;
		}
		else {
			return false;
		}
	}
	
	function verifyLng(lng) {
		if(isset(lng) && lng >= -180 && lng <= 180) {
			return true;
		}
		else {
			return false;
		}
	}
</script>
<script>
	function setModalLineCustomForm(line_id) {
		$('#modal-line-custom-form').trigger("reset");
		$('#modal-line-custom-form input[type=hidden]').val('');
		
		var line = {
			day_id		: $('#plan-line-'+line_id+'-form-hidden input[name=day_id]').val(),
			sort_order	: $('#plan-line-'+line_id+'-form-hidden input[name=sort_order]').val(),
			place_id	: $('#plan-line-'+line_id+'-form-hidden input[name=place_id]').val(),
			title		: $('#plan-line-'+line_id+'-form-hidden input[name=title]').val(),
			description	: $('#plan-line-'+line_id+'-form-hidden textarea[name=description]').val(),
			duration	: $('#plan-line-'+line_id+'-form-hidden input[name=duration]').val(),
			time		: $('#plan-line-'+line_id+'-form-hidden input[name=time]').val(),
			lat			: $('#plan-line-'+line_id+'-form-hidden input[name=lat]').val(),
			lng			: $('#plan-line-'+line_id+'-form-hidden input[name=lng]').val(),
			photo		: $('#plan-line-'+line_id+'-form-hidden input[name=photo]').val(),
			photo_hidden	: $('#plan-line-'+line_id+' .image img').attr('src'),
			image_id	: $('#plan-line-'+line_id+'-form-hidden input[name=image_id]').val(),
			company		: $('#plan-line-'+line_id+'-form-hidden input[name=company]').val(),
			address		: $('#plan-line-'+line_id+'-form-hidden input[name=address]').val(),
			phone		: $('#plan-line-'+line_id+'-form-hidden input[name=phone]').val(),
			fax			: $('#plan-line-'+line_id+'-form-hidden input[name=fax]').val(),
			website		: $('#plan-line-'+line_id+'-form-hidden input[name=website]').val(),
			activity	: $('#plan-line-'+line_id+'-form-hidden input[name=activity]').val(),
		};
		$('#modal-line-custom input[name=line_id]').val(line_id);
		$('#modal-line-custom input[name=day_id]').val(line.day_id);
		$('#modal-line-custom input[name=sort_order]').val(line.sort_order);
		$('#modal-line-custom input[name=place_id]').val(line.place_id);
		$('#modal-line-custom input[name=title]').val(line.title);
		$('#modal-line-custom textarea[name=description]').val(line.description);
		$('#modal-line-custom input[name=duration]').val(line.duration);
		$('#modal-line-custom input[name=time]').val(line.time);
		$('#modal-line-custom input[name=lat]').val(line.lat);
		$('#modal-line-custom input[name=lng]').val(line.lng);
		$('#modal-line-custom input[name=photo]').val(line.photo);
		$('#modal-line-custom input[name=photo_hidden]').val(line.photo_hidden);
		$('#modal-line-custom input[name=image_id]').val(line.image_id);
		$('#modal-line-custom input[name=company]').val(line.company);
		$('#modal-line-custom input[name=address]').val(line.address);
		$('#modal-line-custom input[name=phone]').val(line.phone);
		$('#modal-line-custom input[name=fax]').val(line.fax);
		$('#modal-line-custom input[name=website]').val(line.website);
		$('#modal-line-custom select[name=activity]').val(line.activity);
		
		$('#modal-line-custom input[name=origin_lat]').val(line.lat);
		$('#modal-line-custom input[name=origin_lng]').val(line.lng);
		
		$('#modal-line-custom input[name=duration]').trigger('change');
		$('#modal-line-custom input[name=duration]').trigger('blur');
		$('#modal-line-custom input[name=photo]').trigger('change');
	}
	
	function saveModalLineCustomForm(mode) {
		var line_id = $('#modal-line-custom input[name=line_id]').val();
		var day_id = $('.swiper-slide-active .plan-day-form-hidden input[name=day_id]').val();
		var sort_order = $('.swiper-slide-active .plan-line').length + 1; 
		
		if(mode=='edit') {
			day_id = $('#modal-line-custom input[name=day_id]').val();
			sort_order = $('#modal-line-custom input[name=sort_order]').val();
		}
		
		<!-- START: set line_id for Cookie -->
		if(mode=='add') {
		  <?php if($this->session->data['memory'] == 'cookie') { ?>
			  var line_id = 0;
			  var i = 1;
			  while(line_id < 1) {
				  var check_id = $("#plan-line-" + i + "-form-hidden").length;
				  if (check_id < 1) { line_id = i; }
				  i ++;
				  if(i > 100) { break; }
			  };
		  <?php } ?>
		}
		<!-- END -->
	  
		var line_raw = {
			line_id		: line_id,
			day_id		: day_id,
			sort_order	: sort_order,
			title 		: $('#modal-line-custom input[name=title]').val()||null,
			description	: $('#modal-line-custom textarea[name=description]').val()||null,
			duration	: $('#modal-line-custom input[name=duration]').val()||null,
			time		: $('#modal-line-custom input[name=time]').val()||null,
			lat			: $('#modal-line-custom input[name=lat]').val()||null,
			lng			: $('#modal-line-custom input[name=lng]').val()||null,
			photo		: $('#modal-line-custom input[name=photo]').val()||null,
			image_id	: $('#modal-line-custom input[name=image_id]').val()||null,
			company		: $('#modal-line-custom input[name=company]').val()||null,
			address		: $('#modal-line-custom input[name=address]').val()||null,
			phone		: $('#modal-line-custom input[name=phone]').val()||null,
			fax			: $('#modal-line-custom input[name=fax]').val()||null,
			website		: $('#modal-line-custom input[name=website]').val()||null,
			activity	: $('#modal-line-custom select[name=activity]').val()||null
		};
		
		<!-- START: verify input -->
			if(isset(line_raw.lat) == false && isset(line_raw.lng) == false) {
				line_raw.lat = null;
				line_raw.lng = null;
			}
			else {
				if(verifyLat(line_raw.lat) == false) { 
					var origin_lat = $('#modal-line-custom input[name=origin_lat]').val();
					if(isset(origin_lat)) {
						line_raw.lat = origin_lat;
					}
					else {
						line_raw.lat = null;
						line_raw.lng = null;
					}
				}
				if(verifyLng(line_raw.lng) == false) {
					var origin_lng = $('#modal-line-custom input[name=origin_lng]').val();
					if(isset(origin_lng)) {
						line_raw.lng = origin_lng;
					}
					else {
						line_raw.lat = null;
						line_raw.lng = null;
					}
				}
			}
		<!-- END -->
		
		if(mode=='edit') {
			<!-- START: edit existing line -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					runEditPlanLine(line_raw);
				<?php } else { ?>
					<!-- START: set data -->
						var data = {
							"action":"edit_line",
							"line":line_raw
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showAlert(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								runEditPlanLine(line_raw);
							}
						}, "json");
					<!-- END -->
				<?php } ?>
			<!-- END -->
		}
		else {
			//Google Analytics Event
			ga('send', 'event','line', 'add-line-custom');
			<!-- START: add new line -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					runAddPlanLine(line,line_raw);
				<?php } else { ?>
					<!-- START: set data -->
						var data = {
							"action":"add_line",
							"line":line_raw
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo  $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showAlert(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								line_raw.line_id = json.line_id;
								runAddPlanLine(line_raw);
							}
						}, "json");
					<!-- END -->
				<?php } ?>
			<!-- END -->
		}
	}
	
	function duplicateLine() {
		var line_id;
		var day_id = $('.swiper-slide-active .plan-day-form-hidden input[name=day_id]').val();
		var sort_order = $('.swiper-slide-active .plan-line').length + 1; 
		
		<!-- START: set line_id for Cookie -->
		  <?php if($this->session->data['memory'] == 'cookie') { ?>
			  var line_id = 0;
			  var i = 1;
			  while(line_id < 1) {
				  var check_id = $("#plan-line-" + i + "-form-hidden").length;
				  if (check_id < 1) { line_id = i; }
				  i ++;
				  if(i > 100) { break; }
			  };
		  <?php } ?>
		<!-- END -->
	  
		var line_raw = {
			line_id		: line_id,
			day_id		: day_id,
			sort_order	: sort_order,
			place_id	: $('#modal-line-custom input[name=place_id]').val()||null,
			title 		: $('#modal-line-custom input[name=title]').val()||null,
			description	: $('#modal-line-custom textarea[name=description]').val()||null,
			duration	: $('#modal-line-custom input[name=duration]').val()||null,
			time		: $('#modal-line-custom input[name=time]').val()||null,
			lat			: $('#modal-line-custom input[name=lat]').val()||null,
			lng			: $('#modal-line-custom input[name=lng]').val()||null,
			photo		: $('#modal-line-custom input[name=photo]').val()||null,
			image_id	: $('#modal-line-custom input[name=image_id]').val()||null,
			company		: $('#modal-line-custom input[name=company]').val()||null,
			address		: $('#modal-line-custom input[name=address]').val()||null,
			phone		: $('#modal-line-custom input[name=phone]').val()||null,
			fax			: $('#modal-line-custom input[name=fax]').val()||null,
			website		: $('#modal-line-custom input[name=website]').val()||null
		};
		
		<!-- START: verify input -->
			if(verifyLat(line_raw.lat) == false) { 
				var origin_lat = $('#modal-line-custom input[name=origin_lat]').val();
				if(isset(origin_lat)) {
					line_raw.lat = origin_lat;
				}
				else {
					line_raw.lat = null;
					line_raw.lng = null;
				}
			}
			if(verifyLng(line_raw.lng) == false) {
				var origin_lng = $('#modal-line-custom input[name=origin_lng]').val();
				if(isset(origin_lng)) {
					line_raw.lng = origin_lng;
				}
				else {
					line_raw.lat = null;
					line_raw.lng = null;
				}
			}
		<!-- END -->
		
		var line = {
			line_id		: line_raw.line_id,
			day_id		: line_raw.day_id,
			sort_order	: line_raw.sort_order,
			place_id	: line_raw.place_id,
			title		: line_raw.title,
			description : line_raw.description,
			duration	: convertLineDurationFormat(line_raw.duration),
			time		: convertLineTimeFormat(line_raw.time),
			lat			: line_raw.lat,
			lng			: line_raw.lng,
			photo		: line_raw.photo,
			image_id	: line_raw.image_id,
			company		: line_raw.company,
			address		: line_raw.address,
			phone		: line_raw.phone,
			fax			: line_raw.fax,
			website		: line_raw.website
		}
		
		//Google Analytics Event
		ga('send', 'event','line', 'duplicate-line');
		<!-- START: add new line -->
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				runAddPlanLine(line,line_raw);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"add_line",
						"line":line_raw
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo  $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showAlert(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							line.line_id = json.line_id;
							line_raw.line_id = json.line_id;
							runAddPlanLine(line,line_raw);
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		<!-- END -->
	}
</script>
<script>
	function selectModalLineCustomTab(tab) {
		$('#modal-line-custom .navbar-white .btn').removeClass('active');
		$('#modal-line-custom .tab').hide();
		$('#modal-line-custom .btn-'+tab).addClass('active');
		$('#modal-line-custom .tab-'+tab).show();
		$('#modal-line-custom .modal-body').css('background-color','#EEE');
		if(tab == 'more') { 
			$('#modal-line-custom .modal-body').css('background-color','#FFF');
		}
		if(tab == 'location') {
			initLineMap();
		}
	}
	
	$('#modal-line-custom label').click(function() {
       name = $(this).attr('for');
	   if($('#modal-line-custom input[name='+name+']').length > 0) {
		   $('#modal-line-custom input[name='+name+']').focus();
	   }
	});
	
	function checkPhotoUrl(url) {
		return(url.match(/\.(jpeg|jpg|gif|png)$/) != null);
	}
	
	$('#modal-line-custom input[name=photo]').on('change',function() {
		if(isset($('#modal-line-custom input[name=photo]').val())) {
			var url = $('#modal-line-custom input[name=photo]').val();
		}
		else if(isset($('#modal-line-custom input[name=photo_hidden]').val())) {
			var url = $('#modal-line-custom input[name=photo_hidden]').val();
		}
		else {
			var url = 'resources/image/error/noimage.png';
		}
		$('#modal-line-custom .image img').attr('src',url);
		/*
		if(checkPhotoUrl(url)) {
			$('#modal-line-custom .image img').attr('src',url);
		}
		else {
			$('#modal-line-custom .image img').attr('src','resources/image/error/noimage.png');
		}
		*/
	});
	
	<!-- START: [tab-time] -->
		<!-- START: common function -->
			function convertTimeToMinute(time) {
				var hrs = parseInt(time.substring(0, time.indexOf(':')));
				var mins =  parseInt(time.substring(time.indexOf(':')+1));
				return (hrs * 60 + mins);
			}
			
			function convertMinuteToTime(minute) {
				var hrs = Math.floor(minute / 60);          
				var mins = minute % 60;
				hrs = ("0" + hrs).slice(-2);
				mins = ("0" + mins).slice(-2);
				var string = hrs + ':' + mins;
				return (string);
			}
		<!-- END -->
		<!-- START: [time] -->
			$('#modal-line-custom-form input[name=time]').on('blur',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				if((isset(time_from) && isNaN(time_from) != true) || time_from == 0) {
					if(isset(duration)) {
						time_to = time_from + parseInt(duration);
						if(time_to >= 1440) {
							time_to = time_to - 1440;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						else {
							$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
						}
						value = convertMinuteToTime(time_to);
						$('#modal-line-custom-form input[name=time_to]').val(value);
					}
					else if((isset(time_to) && isNaN(time_to) != true) || time_to == 0) {
						if(time_to >= time_from) {
							value = time_to - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
						}
						else {
							value = time_to + 1440 - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						$('#modal-line-custom-form input[name=duration]').val(value);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
					}
				}
			});
			
			$('#modal-line-custom-form input[name=time_to]').on('blur',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
				
				if((isset(time_to) && isNaN(time_to) != true) || time_to == 0) {
					if((isset(time_from) && isNaN(time_from) != true) || time_from == 0) {
						if(time_to >= time_from) {
							value = time_to - time_from;
						}
						else {
							value = time_to + 1440 - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						$('#modal-line-custom-form input[name=duration]').val(value);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
					}
					else if(isset(duration)) {
						time_from = time_to - parseInt(duration);
						if(time_from < 0) {
							time_from = time_from + 1440;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						else {
							$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
						}
						value = convertMinuteToTime(time_from);
						value = convertMinuteToTime(time_from);
						$('#modal-line-custom-form input[name=time]').val(value);
					}
				}
			});
		<!-- END -->
		<!-- START: [duration] -->
			$('#modal-line-custom-form input[name=duration]').on('blur',function() {
				if(isset($(this).val())) {
					$('#modal-line-custom-form select[name=hrs]').val(Math.floor(parseInt($(this).val())/ 60));
					$('#modal-line-custom-form select[name=mins]').val(parseInt($(this).val())%60);
				}
				else {
					$('#modal-line-custom-form select[name=hrs]').val(0);
					$('#modal-line-custom-form select[name=mins]').val(0);
				}
			});
			
			$('#modal-line-custom-form input[name=duration]').on('change',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				if(isset(time_from) && isNaN(time_from) != true) {
					time_to = time_from + parseInt(duration);
					if(time_to >= 1440) {
						time_to = time_to - 1440;
						$('#modal-line-custom-form .unit-time-to').css('color','#000');
					}
					else {
						$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
					}
					value = convertMinuteToTime(time_to);
					$('#modal-line-custom-form input[name=time_to]').val(value);
					
				}
				else if(isset(time_to) && isNaN(time_to) != true) {
					time_from = time_to - parseInt(duration);
					if(time_from < 0) {
						time_from = time_from + 1440;
						$('#modal-line-custom-form .unit-time-to').css('color','#000');
					}
					else {
						$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
					}
					value = convertMinuteToTime(time_from);
					value = convertMinuteToTime(time_from);
					$('#modal-line-custom-form input[name=time]').val(value);
				}
			});
			
			$('#modal-line-custom-form select[name=hrs]').on('change',function() {
				var hrs = $('#modal-line-custom-form select[name=hrs]').val();
				var mins = $('#modal-line-custom-form select[name=mins]').val();
				var duration;
				if(isset(hrs)) {
					if(isset(mins) == false) { 
						mins = 0;
						$('#modal-line-custom-form select[name=mins]').val(mins); 
					}
					duration = parseInt(hrs) * 60 + parseInt(mins);
					$('#modal-line-custom-form input[name=duration]').val(duration);
					$('#modal-line-custom-form input[name=duration]').trigger('blur');
					$('#modal-line-custom-form input[name=duration]').trigger('change');
				}
				else {
					if(isset(mins)) {
						hrs = 0;
						duration = parseInt(hrs) * 60 + parseInt(mins);
						$('#modal-line-custom-form select[name=hrs]').val(0);
						$('#modal-line-custom-form input[name=duration]').val(duration);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
					else {
						$('#modal-line-custom-form input[name=duration]').val('');
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
				}
			});
			
			$('#modal-line-custom-form select[name=mins]').on('change',function() {
				var hrs = $('#modal-line-custom-form select[name=hrs]').val();
				var mins = $('#modal-line-custom-form select[name=mins]').val();
				var duration;
				if(isset(mins)) {
					if(isset(hrs) == false) { 
						hrs = 0;
						$('#modal-line-custom-form select[name=hrs]').val(hrs); 
					}
					duration = parseInt(hrs) * 60 + parseInt(mins);
					$('#modal-line-custom-form input[name=duration]').val(duration);
					$('#modal-line-custom-form input[name=duration]').trigger('blur');
					$('#modal-line-custom-form input[name=duration]').trigger('change');
				}
				else {
					if(isset(hrs)) {
						mins = 0;
						duration = parseInt(hrs) * 60 + parseInt(mins);
						$('#modal-line-custom-form select[name=mins]').val(0);
						$('#modal-line-custom-form input[name=duration]').val(duration);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
					else {
						$('#modal-line-custom-form input[name=duration]').val('');
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
				}
			});
		<!-- END -->
	<!-- END -->
</script>
<script>
	$("#modal-line-custom").on("show.bs.modal", function () {
		if($('#modal-line-custom-form input[name=line_id]').val() == '') {
			$('#modal-line-map-header-add').show();
			$('#modal-line-map-header-edit').hide();
			$('.button-delete-activity').hide();
		}
		else {
			$('#modal-line-map-header-add').hide();
			$('#modal-line-map-header-edit').show();
			$('.button-delete-activity').show();
		}
		selectModalLineCustomTab('general'); 
		$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
		$('#modal-line-custom-form .unit-duration').css('color','#000');
	});
</script>