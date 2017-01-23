<style>
	.temp-form {
		width:calc(100% - 100px);
		margin:10px 50px 30px 50px;
	}
	.temp-form select {
		width:100%;
		height:40px;
		background-color:transparent;
		border:solid thin #ccc;
		box-shadow:inset 0 1px 1px rgba(0,0,0,.075);
	}
	.temp-result.la .la-row {
		cursor:auto;
	}
</style>

<!-- START: [splash] -->
	<?php echo $modal_home_splash; ?>
<!-- END -->

<div class="row navbar navbar-primary navbar-white">
        <div class="col-xs-3 text-left">
            <a class="btn" data-toggle="modal" data-target="#menu-mobile-main"><i class="fa fa-fw fa-lg fa-bars"></i></a>
        </div>
    </div>
<div class="content-body fixed-width padding">
	
    <div class="text-center" style="color:#e93578;">
        <h1>TREVOL</h1>
    </div>
    <div class="text-center text-sub">
    	Create personal travel itinerary instantly
    </div>
    <form class="temp-form" autocomplete="off">
    	<select name="country_id">
            <option value="0">Select country</option>
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
    </form>
    <hr />
    <div><b>How It Works</b><br /><br /></div>
    <div class="content-body-result temp-result la la-50">
    	<div class="la-row">
        	<div class="col-xs-2">
                <div class="la-icon" style="padding:11px 12px;">
                    <span class="fa-stack">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <strong class="fa-stack-1x fa-inverse">1</strong>
                    </span>
                </div>
            </div>
            <div class="col-xs-10">
                <div class="la-desc la-desc-line-1">
                    <div class="la-text">Select a template itinerary</div>
                </div>
            </div>
        </div>
        <div class="la-row">
        	<div class="col-xs-2">
                <div class="la-icon" style="padding:11px 12px;">
                    <span class="fa-stack">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <strong class="fa-stack-1x fa-inverse">2</strong>
                    </span>
                </div>
            </div>
            <div class="col-xs-10">
                <div class="la-desc la-desc-line-1">
                    <div class="la-text">Customise it</div>
                </div>
            </div>
        </div>
        <div class="la-row">
        	<div class="col-xs-2">
                <div class="la-icon" style="padding:11px 12px;">
                    <span class="fa-stack">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <strong class="fa-stack-1x fa-inverse">3</strong>
                    </span>
                </div>
            </div>
            <div class="col-xs-10">
                <div class="la-desc la-desc-line-1">
                    <div class="la-text">Manage it</div>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div><b>Upcoming Updates</b><br /><br /></div>
    <div class="la la-40">
        <div class="la-row">
            <div class="col-xs-12">
                <div class="la-desc">
                    <div class="la-text la-text-clamp-2">2017-02-28&nbsp;&nbsp;&nbsp;Function to invite and manage members</div>
                </div>
            </div>
        </div>
        <div class="la-row">
            <div class="col-xs-12">
                <div class="la-desc">
                    <div class="la-text la-text-clamp-2">2017-03-31&nbsp;&nbsp;&nbsp;Function to estimate travel budget</div>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="text-sub">
    	<span>If you have any suggestion or discover any bug, feel free to send us an email to <a href="mailto:info@travelrevol.com?Subject=Feedback" target="_top">info@travelrevol.com</a></span>
    </div>
    <!--
    <hr />
    <div><b>Top Destinations</b><br /><br /></div>
    -->
</div>

<!-- START: [modal] -->
	<?php echo $menu_mobile_main; ?>
<!-- END -->

<script>
	<!-- START: [splash] -->
		setTimeout(function() {
			$('#wrapper-splash').fadeOut(500);
		},500);
	<!-- END -->
</script>
<script>
	$('.temp-form').on('change',function() {
		var country_id = $('.temp-form select[name=country_id]').val();
		if(country_id > 0) {
			window.location.href = "<?php echo $link['wizard/new']; ?>" + "&country_id=" + country_id;
		}
	});
</script>