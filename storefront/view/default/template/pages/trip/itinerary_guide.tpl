<style>
	.spacer-bar {
		min-height:20px;
	}
	
	#section-itinerary-guide {
		text-align:left;
	}
	
	#section-itinerary-guide-header {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-itinerary-guide-header .input-group {
		border-radius:10px;
	}
	
	#section-itinerary-guide-header .form-control {
		border-radius:10px;
	}
	
	#section-itinerary-guide-header .btn-simple {
		padding-right:0;
		padding-left:0;
	}
	
	#section-itinerary-guide-header-close {
		font-size:24px;
		line-height:14px;
	}
	
	#section-itinerary-guide-content {
		position:relative;
		overflow-y:auto;
		overflow-x:hidden;
		height:calc(100vh - 48px - 2px - 30px - 70px - 40px);
	}
	
	#section-itinerary-guide-button-add {
		position:absolute;
		top:118px;
		right:0;
		padding:15px;
		z-index:10;
		text-align:center;
		font-size:36px;
	}
	
	#section-itinerary-guide-button-add a {
		display:block;
		width:52px;
		height:52px;
		border:solid thin #CCC;
		border-radius:26px;
		background-color:#FFF;
		color:#e93578;
		box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2), 0 2px 4px 0 rgba(0, 0, 0, 0.19);
	}
	
	#section-itinerary-guide-button-add a:hover {
		box-shadow: 0 6px 10px 0 rgba(0, 0, 0, 0.2), 0 10px 26px 0 rgba(0, 0, 0, 0.19);
	}
	
	#section-itinerary-guide-button-add-text {
		position:absolute;
		top:193px;
		right:7px;
		width:68px;
		color:#fff;
		text-align:center;
	}
	
	#section-itinerary-guide-button-add-text a {
		color:#fff;
		text-decoration:none;
	}
	
	#section-itinerary-guide-parent {
		padding:7px 7px 0 7px;
		background-color:#e93578;
		color:#FFF;
	}
	
	#section-itinerary-guide-parent a {
		color:#FFF;
	}
	
	#section-itinerary-guide-image {
		overflow:hidden;
		max-height:160px;
	}
	
	#section-itinerary-guide-name {
		padding:7px;
		font-size:18px;
		background-color:#e93578;
		color:#FFF;
	}
	
	#section-itinerary-guide-tag {
		padding:7px 7px 0 7px;
	}
	
	#section-itinerary-guide-blurb {
		padding:7px 7px 0 7px;
	}
	
	#section-itinerary-guide-description {
		padding:7px 7px 0 7px;
		display:none;
	}
	
	#section-itinerary-guide-button-read {
		padding:7px 7px 0 7px;
		text-align:center;
	}
	
	#section-itinerary-guide-result-summary {
		padding:7px;
	}
	
	.result {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	.result-image {
		display:block;
		float:left;
		width:80px;
	}
	
	.result-image img {
		border-radius:40px;
	}
	
	.result-description {
		display:block;
		float:left;
		padding-left:7px;
	}
	
	.result-name {
		color:#333;
	}
	
	.result-blurb {
		padding: 3px 0;
	}
	
	.result-tag {
		padding: 3px 0;
	}
	
	.result-button {
		padding:0 7px;
	}
</style>

<div id="section-itinerary-guide">
    <div id="section-itinerary-guide-header">
        <div class="row">
            <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
        </div>
        <div class="row">
            <div class="input-group pull-left inline col-xs-12 col-sm-12 col-md-12 col-lg-9">
                <input class="form-control" type="text" placeholder='Search ...'  />
            </div>
            <div class="inline pull-right col-md-12 col-lg-3">
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="close_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Guide' 
                >
                	<i class="fa fa-fw" id="section-itinerary-guide-header-close">&times;</i>
                </a>
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="open_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Expand Guide' 
                >
                	<i class="fa fa-fw fa-arrows-alt"></i>
                </a>
            </div>
        </div>
    </div>
    <div id="section-itinerary-guide-content">
    	<div id="section-itinerary-guide-button-add"><a>&#43;</a></div>
        <div id="section-itinerary-guide-button-add-text"><small><a>Add to Trip</a></small></div>
        <div id="section-itinerary-guide-image"><?php echo $result['current']['image']; ?></div>
        <div id="section-itinerary-guide-parent"><a><small><span>Malaysia</span> ></small></a></div>
        <div id="section-itinerary-guide-name"><?php echo $result['current']['name']; ?></div>
        <div id="section-itinerary-guide-tag">
        	<a class="label label-pill" data-row-name="<?php echo $result['current']['tag']['name']; ?>" style="background-color:<?php echo $result['current']['tag']['type_color']; ?>;"><?php echo $result['current']['tag']['name']; ?></a>
        </div>
        <div id="section-itinerary-guide-blurb"><?php echo $result['current']['blurb']; ?></div>
        <div id="section-itinerary-guide-description"><?php echo $result['current']['description']; ?></div>
        <div id="section-itinerary-guide-button-read"><a class="btn btn-default btn-block" onclick="toggle_guide_description();"><span id="section-itinerary-guide-button-read-text">Read More</span></a></div>
        <hr />
        <div id="section-itinerary-guide-result-summary">Total <?php echo $result['count']; ?> results</div>
        <?php foreach($result['child'] as $i) { ?>
        <div class="result row">
            <div class="result-image"><?php echo $i['image']; ?></div>
            <div class="result-description">
            	<div class="result-name"><?php echo $i['name']; ?></div>
                <div class="result-blurb"><small><?php echo $i['blurb']; ?></small></div>
                <div class="result-tag"><a class="label label-pill" data-row-name="<?php echo $i['tag']['name']; ?>" style="background-color:<?php echo $i['tag']['type_color']; ?>;"><?php echo $i['tag']['name']; ?></a></div>
            </div>
            <div class="result-button"><a>&#43;</a></div>
        </div>
        <?php } ?>
        <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
    </div>
</div>

<script>
	function toggle_guide_description() {
		if(document.getElementById('section-itinerary-guide-description').style.display == 'block') {
			document.getElementById('section-itinerary-guide-description').style.display = 'none';
			document.getElementById('section-itinerary-guide-button-read-text').innerHTML = 'Read More';
		}
		else {
			document.getElementById('section-itinerary-guide-description').style.display = 'block';
			document.getElementById('section-itinerary-guide-button-read-text').innerHTML = 'Hide Description';
		}
	}
</script>