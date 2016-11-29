<style>
	#wrapper-explore-favourite-button .badge{
		font-size:11px;
		margin-right:5px;
		border-radius:10px;
		background-color:#900;
	}
	
	#wrapper-explore-search {
		position:fixed;
		top:40px;
		height:40px;
		padding:3px;
		background-color:#DDD;
		border-bottom:solid thin #CCC;
	}
	
	#wrapper-explore-search input {
		text-align:center;
		font-size:12px;
		border-radius:5px;
	}
	
	#wrapper-explore-search-shadow {
		height:40px;
	}
	
	#wrapper-explore-loading {
		text-align:center;
		height:calc(100vh - 120px);
		padding-top:30vh;
	}
	
	#wrapper-explore-current {
		background-color:#FFF;
		color:#000;
	}
	
	#wrapper-explore-current a:hover {
		color:#000;
		text-decoration:underline;
	}
	
	.wrapper-explore-current-row {
		padding:10px 0;
		min-height:40px;
	}
	
	.wrapper-explore-current-row-half {
		padding:0;
		line-height:20px;
		min-height:20px;
	}
	
	#wrapper-explore-current-image {
		background-color:#666;
		max-height:225px;
		overflow:hidden;
	}
	
	#wrapper-explore-current-image img {
		width:100%;
	}
	
	#wrapper-explore-current-main {
		border-top:solid thin #EEE;
		padding:7px 15px;
	}
	
	#wrapper-explore-current-action {
		border-top:solid thin #EEE;
		padding:7px 15px;
	}
	
	#wrapper-explore-current-parent {
		font-size:12px;
		color:#999;
	}
	
	#wrapper-explore-current-title {
		font-weight:bold;
		font-size:18px;
	}
	
	#wrapper-explore-current-misc {
		border-top:solid thin #EEE;
		padding:7px 15px;
	}
	
	#wrapper-explore-current-website .detail {
		overflow:hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	
	#wrapper-explore-current-website .detail a {
		color:#000;
	}
	
	#wrapper-explore-current-website .detail a:hover {
		text-decoration:underline;
	}
	
	#wrapper-explore-child {
		margin-top:15px;
		margin-bottom:30px;
	}
	
	.tag {
		margin-right:5px;
	}
	
	/* START: [child] */
		.result {
			width:100%;
			padding:5px 15px;
		}
		
		.result-wrapper {
			width:100%;
			background-color:#FFF;
			border-radius:5px;
			cursor:pointer;
		}
		
		/* START: [country] */
			.result-country {
				width:100%;
				padding:5px 15px;
			}
		
			.result-country-wrapper {
				position:relative;
				border-radius:5px;
				cursor:pointer;
			}
			
			.result-country-image {
				height:150px;
				overflow:hidden;
				border-radius:5px;
			}
			
			.result-country-image img {
				width:100%;
				margin-top:-50px;
			}
			
			.result-country-name {
				position:absolute;
				bottom:0;
				width:100%;
				padding:7px 15px;
				border-radius:0 0 5px 5px;
				background:linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.8));
				color: white;
				text-shadow:
				-1px -1px 0 #000,
				1px -1px 0 #000,
				-1px 1px 0 #000,
				1px 1px 0 #000;
				font-size:18px;
			}
		/* END */
		
		.result-image-wrapper {
			position:relative;
		}
		
		.result-image {
			display:block;
			float:left;
			width:120px;
			height:120px;
			border-radius:5px 0px 0px 5px;
		}
		
		.result-image img {
			border-radius:5px 0px 0px 5px;
		}
		
		.result-ranking {
			position:absolute;
			top:5px;
			left:5px;
			width:20px;
			height:20px;
			border-radius:3px;
			background-color:#000;
			color:#FFF;
			text-align:center;
			padding:0;
			opacity:.7;
		}
		
		.result-description {
			position:relative;
			height:120px;
			display:block;
			float:left;
			padding-top:7px;
			padding-left:7px;
			width:calc(100% - 120px - 15px);
			color:#333;
		}
		
		.result-name {
			color:#e93578;
			font-weight:bold;
			height:20px;
			overflow:hidden;
			margin-bottom:7px;
		}
		
		.result-rating {
			color:#000;
			margin-bottom:7px;
		}
		
		
		.result-blurb {
			width:100%;
			height:34px;
			overflow:hidden;
			margin-bottom:7px;
		}
		
		.line-clamp-1 {
			display: -webkit-box;
			-webkit-line-clamp: 1;
			-webkit-box-orient: vertical;  
		}
		
		.line-clamp-2 {
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;  
		}
		
		.result-tag {
			position:absolute;
			bottom: 15px;
		}
		
		.result-button {
			display:block;
			float:right;
			padding:30px 7px;
			text-align:center;
			font-weight:bold;
		}
		
		
		.result-child-button-add {
			position:absolute;
			bottom:15px;
			right:0;
		}
		
		.result-child-button-add a {
			margin-left:15px;
			color:#999;
		}
		
		.result-child-button-add a:hover {
			margin-left:15px;
			color:#333;
		}
		
		.result-subtitle {
			font-weight:bold;
			color:#333;
			padding:10px 15px 0px 15px;
		}
	/* END */
</style>

<!-- START: [header] -->
    <div class="fixed-bar wrapper-header-main row">
        <div class="col-xs-3 text-left">
        </div>
        <div class="col-xs-6">
            <h1>Explore</h1>
        </div>
        <div class="col-xs-3 text-right">
            <a id="wrapper-explore-favourite-button" class="btn btn-header" data-toggle="modal" data-target="#modal-explore-favourite"><i class="fa fa-fw fa-lg fa-heart-o"></i></a>
        </div>
    </div>


    <div class="fixed-bar" id="wrapper-explore-search">
        <input class="form-control" placeholder="Search" data-toggle="modal" data-target="#modal-explore-search"/>
    </div>
    
    <div id="wrapper-explore-search-shadow"></div>
<!-- END -->

<!-- START: [body] -->
    <div class="row" id="wrapper-explore-loading">
        <i class="fa fa-circle-o-notch fa-spin fa-4x fa-fw"></i> <span class="sr-only">Loading...</span>
    </div>
    <div id="wrapper-explore-current" class="box-shadow">
        <div id="wrapper-explore-current-image"></div>
        <div id="wrapper-explore-current-main">
            <div id="wrapper-explore-current-parent" class="row wrapper-explore-current-row-half"></div>
            <div id="wrapper-explore-current-title" class="row wrapper-explore-current-row"></div>
            <div id="wrapper-explore-current-rating" class="row wrapper-explore-current-row-half"></div>
        	<div id="wrapper-explore-current-tag" class="row wrapper-explore-current-row"></div>
            <div id="wrapper-explore-current-description" class="row wrapper-explore-current-row"></div>
        </div>
        <div id="wrapper-explore-current-action">
        	<div id="wrapper-explore-current-favourite" class="row wrapper-explore-current-row">
            	<a class="button-add-favourite">
                	<span class="fa-stack fa-lg">
                        <i class="fa fa-heart fa-stack-1x"></i>
                    </span>
                 	<span>Add to My Favourite</span>
                 </a>
                 <div class="button-show-favourite">
                    <span class="fa-stack fa-lg" style="color:#e93578;">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-heart fa-stack-1x fa-inverse"></i>
                    </span>
                 	<span>Added. </span>
                    <span><a data-toggle="modal" data-target="#modal-explore-favourite">(view my favourite)</a></span>
                 </div>
            </div>
        </div>
        <div id="wrapper-explore-current-misc">
            <div id="wrapper-explore-current-hour" class="row wrapper-explore-current-row">
                <div class="col-xs-2"><i class="fa fa-fw fa-clock-o"></i></div>
                <div class="col-xs-10 detail"></div>
            </div>
            <div id="wrapper-explore-current-address" class="row wrapper-explore-current-row">
                <div class="col-xs-2"><i class="fa fa-fw fa-map-marker"></i></div>
                <div class="col-xs-10 detail"></div>
            </div>
            <div id="wrapper-explore-current-phone" class="row wrapper-explore-current-row">
                <div class="col-xs-2"><i class="fa fa-fw fa-phone"></i></div>
                <div class="col-xs-10 detail"></div>
            </div>
            <div id="wrapper-explore-current-website" class="row wrapper-explore-current-row">
                <div class="col-xs-2"><i class="fa fa-fw fa-globe"></i></div>
                <div class="col-xs-10 detail"></div>
            </div>
        </div>
    </div>
    <div id="wrapper-explore-child">
    	<div class="result-list-wrapper" id="wrapper-explore-child-destination-country">
        	<div class="result-list"></div>
        </div>
    	<div class="result-list-wrapper" id="wrapper-explore-child-destination">
        	<div class="result-subtitle">Top Destinations</div>
        	<div class="result-list"></div>
        </div>
        <div class="result-list-wrapper" id="wrapper-explore-child-destination-national-park">
        	<div class="result-subtitle">National Parks</div>
        	<div class="result-list"></div>
        </div>
        <div class="result-list-wrapper" id="wrapper-explore-child-destination-airport">
        	<div class="result-subtitle">International Airports</div>
        	<div class="result-list"></div>
        </div>
        <div class="result-list-wrapper" id="wrapper-explore-child-destination-island">
        	<div class="result-subtitle">Islands</div>
        	<div class="result-list"></div>
        </div>
        <div class="result-list-wrapper" id="wrapper-explore-child-poi">
        	<div class="result-subtitle">Point of Interests</div>
        	<div class="result-list"></div>
        </div>
    </div>
<!-- END -->
<!-- START: [form] -->
	<div class="hidden">
    	<form id="wrapper-explore-current-form">
        	<input type="hidden" name="place_id"/>
            <input type="hidden" name="name"/>
            <input type="hidden" name="photo"/>
            <input type="hidden" name="city"/>
            <input type="hidden" name="region"/>
            <input type="hidden" name="country"/>
        </form>
    </div>
<!-- END -->

<script>
	function startLoadExplore() {
		$(window).scrollTop(0);
		$('#wrapper-explore-loading').show();
		$('#wrapper-explore-current').hide();
		$('#wrapper-explore-child').hide();
	}
	
	startLoadExplore();
	
	function explorePlace(place_id) {
		if(place_id != '') {
			window.location.hash = '#tab=explore&gid='+place_id;
		}
		else {
			window.location.hash = '';
		}
	}
	
	function searchPlace(keyword) {
		startLoadExplore();
		$('#modal-explore-search-input-keyword').val(keyword);
		var input = document.getElementById('modal-explore-search-input-keyword');
		google.maps.event.trigger(input, 'focus')
		google.maps.event.trigger(input, 'keydown', {
			keyCode: 13
		});
		$('#modal-explore-search-input-keyword').val('');
	}

	function updateWrapperExploreResult(place) {
		var current = {
			place_id					: null,
			name						: null,
			description					: null,
			lat							: null,
			lng							: null,
			url							: null,
			photos						: new Array(),
			icon						: null,
			types						: new Array(),
			rating						: null,
			reviews						: new Array(),
			permenantly_closed			: null,
			address_components			: new Array(),
			formatted_address			: null,
			vicinity					: null,
			opening_hours				: {},
			utc_offset					: null,
			website						: null,
			international_phone_number	: null,
			destination					: new Array(),
			poi							: new Array()
		};
		
		<!-- START: set variable from Google -->
			Object.keys(place).forEach(function(key,index) {
				if(key == 'photos') {
					for(i=0;i<place.photos.length;i++) {
						current.photos[i] = place.photos[i];
						current.photos[i].url = place.photos[i].getUrl({'maxWidth': 400, 'maxHeight': 400});
					}
				}
				else {
					current[key] = place[key];
				}
			});
		<!-- END -->
		
		<!-- START: replace variable from server -->
			<!-- START: set data -->
                var data = { action:'search',place_id:current.place_id }
            <!-- END -->
            <!-- START: send POST -->
                $.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
					if(json != false) {
						<!-- START: replace google variable via server data -->
							if(isset(json.current.name)) {
								current.name = json.current.name;
							}
							if(isset(json.current.tag)) {
								current.tag = json.current.tag;
							}
							if(typeof json.current.parent != 'undefined' && json.current.parent != null && json.current.parent != '') {
								current.parent = json.current.parent;
							}
							if(typeof json.current.image != 'undefined' && json.current.image != null && json.current.image != '') {
								current.image = json.current.image;
							}
							if(typeof json.current.description != 'undefined' && json.current.description != null && json.current.description != '') {
								current.description = json.current.description;
							}
							if(isset(json.current.type)) {
								current.type = json.current.type;
							}
							if(isset(json.destination)) {
								current.destination = json.destination;
							}
							if(typeof json.poi != 'undefined' && json.poi != null && json.poi != '') {
								current.poi = json.poi;
							}
						<!-- END -->
					}
					runUpdateWrapperExploreResult(current, json);
                }, "json");
            <!-- END -->
		<!-- END -->
	}
	
	function runUpdateWrapperExploreResult(current, json) {
		<!-- START: clear ex-data -->
			<!-- START: reset value -->
				$('#wrapper-explore-current-image').html('');
				$('#wrapper-explore-current-parent').html('');
				$('#wrapper-explore-current-title').html('');
				$('#wrapper-explore-current-rating').html('');
				$('#wrapper-explore-current-tag').html('');
				$('#wrapper-explore-current-description').html('');
				$('#wrapper-explore-current-hour .detail').html('');
				$('#wrapper-explore-current-address .detail').html('');
				$('#wrapper-explore-current-phone .detail').html('');
				$('#wrapper-explore-current-website .detail').html('');
				$('#wrapper-explore-current-review').html('');
				$('.result-list').html('');
			<!-- END -->
			<!-- START: reset visibility -->
				$('#wrapper-explore-current-misc').show();
				$('#wrapper-explore-current-parent').hide();
				$('#wrapper-explore-current-rating').hide();
				$('#wrapper-explore-current-tag').hide();
				$('#wrapper-explore-current-description').hide();
				$('#wrapper-explore-current-hour').hide();
				$('#wrapper-explore-current-address').hide();
				$('#wrapper-explore-current-phone').hide();
				$('#wrapper-explore-current-website').hide();
				$('.result-list-wrapper').hide();
			<!-- END -->
			<!-- START: reset form -->
				$('#wrapper-explore-current-form input').val('');
			<!-- END -->
		<!-- END -->
		
		<!-- START: set hash -->
			if(getHashTab() != '') {
				window.location.hash = '#tab=' + getHashTab() + '&gid=' + current.place_id;
			}
			else {
				window.location.hash = '#tab=explore&gid=' + current.place_id;
			}
		<!-- END -->
		
		<!-- START: [favourite] -->
			updateWrapperExploreButtonAddFavourite(current.place_id);
		<!-- END -->
		
		<!-- START: [place_id] -->
			$('#wrapper-explore-current-form input[name=place_id]').val(current.place_id);
		<!-- END -->
		
		//image
		<!-- START: [image] -->
			<!-- START: using own server -->
				if(typeof current.image != 'undefined' && current.image != null && current.image != '') {
					$('#wrapper-explore-current-image').html("<img src='"+current.image[0].path+"' onerror='$(this).hide();'>");
					$('#wrapper-explore-current-form input[name=photo]').val(current.image[0].path);
				}
				
			<!-- END -->
			<!-- START: using Google -->
				else {
					if(current.photos.length > 0) {
						$('#wrapper-explore-current-image').html("<img src='"+current.photos[0].url+"' onerror='$(this).hide();'>");
						$('#wrapper-explore-current-form input[name=photo]').val(current.photos[0].url);
					}
				}
			<!-- END -->
		<!-- END -->
		
		//parent
		<!-- START: [parent] -->
			<!-- START: set city, region, country -->
			if(current.address_components.length > 0) {
				var city = 0;
				var region = 0;
				var country = 0;
				
				<!-- START: assign address component -->
					$.each(current.address_components, function(index,value) {
						if($.inArray('locality',value.types) != -1) {
							city = value.long_name;
							$('#wrapper-explore-current-form input[name=city]').val(city);
						}
						else if($.inArray('administrative_area_level_1',value.types) != -1) {
							region = value.long_name;
							$('#wrapper-explore-current-form input[name=region]').val(region);
						}
						else if($.inArray('country',value.types) != -1) {
							country = value.long_name;
							$('#wrapper-explore-current-form input[name=country]').val(country);
						}
					});
				<!-- END -->
			}
			<!-- END -->
			<!-- START: using own server -->
				if(isset(current.type)) {
						if(typeof current.parent != 'undefined' && current.parent != null && current.parent != '') {
							if(typeof current.parent.g_place_id != 'undefined' && current.parent.g_place_id != null && current.parent.g_place_id != '') {
								$('#wrapper-explore-current-parent').html('<a onclick="explorePlace(\''+current.parent.g_place_id+'\');">'+current.parent.name+' /</a>');
							}
							else {
								$('#wrapper-explore-current-parent').html('<a onclick="explorePlace(\'\');">'+current.parent.name+' /</a>');
							}
						}
					$('#wrapper-explore-current-parent').show();
				}
			<!-- END -->
			<!-- START: using Google -->
				else {
					if(current.address_components.length > 0) {
						<!-- START: set parent based on type -->
							if(current.types.length > 0) {
								if($.inArray('country',current.types) != -1) {
									//set world as parent
									$('#wrapper-explore-current-parent').html('<a onclick="explorePlace(\'\');">Earth /</a>');
									$('#wrapper-explore-current-parent').show();
								}
								else if($.inArray('administrative_area_level_1',current.types) != -1) {
									//set country as parent
									$('#wrapper-explore-current-parent').html('<a onclick="searchPlace(\''+country+'\');">'+country+' /</a>');
									$('#wrapper-explore-current-parent').show();
								}
								else if($.inArray('locality',current.types) != -1) {
									//set administrative as parent
									if(region != 0 && city != region) { //avoid city and region with same name
										$('#wrapper-explore-current-parent').html('<a onclick="searchPlace(\''+region+'\');">'+region+' /</a>');
										$('#wrapper-explore-current-parent').show();
									}
									else if(country != 0) {
										//$('#wrapper-explore-current-parent').html(country+' /');
										$('#wrapper-explore-current-parent').append('<a onclick="searchPlace(\''+country+'\');">'+country+' /</a>');
										$('#wrapper-explore-current-parent').show();
									}
								}
								else {
									//set lowest political as parent
									if(city != 0) {
										$('#wrapper-explore-current-parent').html('<a onclick="searchPlace(\''+city+'\');">'+city+' /</a>');
										$('#wrapper-explore-current-parent').show();
									}
									else if(region != 0) {
										$('#wrapper-explore-current-parent').html('<a onclick="searchPlace(\''+region+'\');">'+region+' /</a>');
										$('#wrapper-explore-current-parent').show();
									}
									else if(country != 0) {
										$('#wrapper-explore-current-parent').html('<a onclick="searchPlace(\''+country+'\');">'+country+' /</a>');
										$('#wrapper-explore-current-parent').show();
									}
								}
							}
						<!-- END -->
					}
				}
			<!-- END -->
		<!-- END -->
		
		//title
		$('#wrapper-explore-current-title').html(current.name);
		$('#wrapper-explore-current-form input[name=name]').val(current.name);
		
		//rating
		if(current.rating != null) {
			$('#wrapper-explore-current-rating').html(current.rating);
			$('#wrapper-explore-current-rating').append('<i class="fa fa-fw"></i>');
			for(i=1;i<=5;i++) {
				if(current.rating >= i) {
					$('#wrapper-explore-current-rating').append('<i class="fa fa-fw fa-star"></i>');
				}
				else if(current.rating >= (i - 0.5)) {
					$('#wrapper-explore-current-rating').append('<i class="fa fa-fw fa-star-half-o"></i>');
				}
				else {
					$('#wrapper-explore-current-rating').append('<i class="fa fa-fw fa-star-o"></i>');
				}
			}
			$('#wrapper-explore-current-rating').append('<i class="fa fa-fw"></i>');
			if(current.reviews != null) {
				$('#wrapper-explore-current-rating').append('<a data-toggle="modal" data-target="#modal-explore-review">Read Reviews</a>');
			}
			$('#wrapper-explore-current-rating').show();
		}
		
		//tag
		if(current.types.length > 0) {
			var tag = new Array();
			
			$.each(current.types, function(index,value) {
				if(value == 'country') {
					tag.push('Country');
				}
				else if (value.toLowerCase().indexOf("administrative") >= 0) {
					tag.push('Region');
				}
				else if(value == 'locality') {
					tag.push('City');
				}
				else if (value.toLowerCase().indexOf("level") >= 0) {
				}
				else if(value == 'sublocality') {
					tag.push('Area');
				}
				else if(value == 'natural_feature') {
					tag.push('Nature');
				}
				else if(value == 'political') {}
				else if(value == 'establishment') {}
				else if(value == 'premise') {}
				else {
					value = convertTitleCase(value.replace(/_/g, ' '));
					tag.push(value);
				}
			});
			if(isset(current.tag)) {
				$.each(current.tag, function(index,value) {
					$('#wrapper-explore-current-tag').append('<div class="label label-pill label-warning tag">'+value.name+'</div>');
				});
				$('#wrapper-explore-current-tag').show();
			}
			else {
				if(tag.length > 0) {
					$.each(tag, function(index,value) {
						$('#wrapper-explore-current-tag').append('<div class="label label-pill label-warning tag">'+value+'</div>');
					});
					$('#wrapper-explore-current-tag').show();
				}
			}
		}
		
		//description
		if(current.description != null) {
			$('#wrapper-explore-current-description').html(current.description);
			$('#wrapper-explore-current-description').show();
		}
		
		//hour
		<!-- START: define weekday -->
			var weekday = new Array(7);
			weekday[0]=  "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";
		<!-- END -->
		
		if(typeof current.opening_hours.periods != 'undefined' && current.opening_hours.periods != null) {
			$('#wrapper-explore-current-hour').show();
			$.each(current.opening_hours.periods, function(index,value) {
				if(typeof value.open != 'undefined' && value.open != null && typeof value.close != 'undefined' && value.close != null) {
					$('#wrapper-explore-current-hour .detail').append(''
						+ '<div class="row">'
							+ '<div class="col-xs-5">'
								+ weekday[value.open.day]
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ convertTime([value.open.time.slice(0, 2), ':', value.open.time.slice(2)].join(''))
							+ '</div>'
							+ '<div class="col-xs-1 text-center">'
								+ '-'
							+ '</div>'
							+ '<div class="col-xs-3 text-left">'
								+ convertTime([value.close.time.slice(0, 2), ':', value.open.time.slice(2)].join(''))
							+ '</div>'
						+ '</div>'
					);
				}
			});
		}
		
		//address
		if(typeof current.formatted_address != 'undefined' && current.formatted_address != null) {
			$('#wrapper-explore-current-address').show();
			$('#wrapper-explore-current-address .detail').html(current.formatted_address);
			$('#wrapper-explore-current-address .detail').append(' <a data-toggle="modal" data-target="#modal-explore-map">(see map)</a>');
		}
		
		//phone
		if(typeof current.international_phone_number != 'undefined' && current.international_phone_number != null) {
			$('#wrapper-explore-current-phone').show();
			$('#wrapper-explore-current-phone .detail').html(current.international_phone_number);
		}
		
		//website
		if(typeof current.website != 'undefined' && current.website != null) {
			$('#wrapper-explore-current-website').show();
			$('#wrapper-explore-current-website .detail').html('<a href="'+current.website+'" target="_blank">'+current.website+'</a>');
		}
		
		//review
		if(current.reviews.length > 0) {
			var content;
			$.each(current.reviews, function(index, value) {
				//photo
				var photo = '';
				if(typeof value.profile_photo_url != 'undefined' && value.profile_photo_url != null && value.profile_photo_url != '') {
					photo = '<img class="review-profile-photo" src="'+value.profile_photo_url+'" onerror="this.onerror = \"\";this.src = \"resources/image/error/noprofilephoto.png\";">';
				}
				else {
					photo = '<img class="review-profile-photo" src="resources/image/error/noprofilephoto.png">';
				}
				
				//time
				var a = new Date(value.time*1000);
				var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
				var year = a.getFullYear();
				var month = months[a.getMonth()];
				var date = a.getDate();
				var hour = a.getHours();
				var min = a.getMinutes();
				var sec = a.getSeconds();
				var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
				
				//rating
				var star = '';
				var rating = value.aspects[0].rating;
				for(i=1;i<=5;i++) {
					if(rating >= i) {
						star += '<i class="fa fa-fw fa-star"></i>';
					}
					else if(rating >= (i - 0.5)) {
						star += '<i class="fa fa-fw fa-star-half-o"></i>';
					}
					else {
						star += '<i class="fa fa-fw fa-star-o"></i>';
					}
				}
				star += ' ';
				
				content = ''
					+ '<div class="review row">'
						+ '<div class="col-xs-3 text-center review-profile">'
							+ '<div class="noimage hidden"></div>'
							+ photo
						+ '</div>'
						+ '<div class="col-xs-9">'
							+ '<div class="review-author-name">'
								+ value.author_name
							+ '</div>'
							+ '<div class="review-time">'
								+ time
							+ '</div>'
							+ '<div class="review-text">'
								+ star
								+ value.text
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
				$('#wrapper-explore-current-review').append(content);
			});
		}
		
		<!-- START: reset child -->
			var count = 0;
		<!-- END -->
		
		<!-- START: hide child wrapper -->
			$('#wrapper-explore-child-destination').hide();
			$('#wrapper-explore-child-destination-airport').hide();
			$('#wrapper-explore-child-destination-national-park').hide();
			$('#wrapper-explore-child-destination-island').hide();
			$('#wrapper-explore-child-poi').hide();
		<!-- END -->
		
		<!-- START: [child destination] -->
			if(current.destination.length > 0) {
				count = parseFloat(count) + parseFloat(json.count.destination);
				//document.getElementById('section-content-guide-result-count').innerHTML = count;
				var ranking = { text:'' };
				for(i=0;i<json.count.destination;i++) {
					var tag_name = json.destination[i].tag[0].name.replace(/\s+/g, '-').toLowerCase();
					<!-- START: assign ranking -->
						if(typeof ranking[tag_name] == 'undefined') { 
							ranking[tag_name] = 1;
							$('.result-subtitle.destination-'+tag_name).show();
						}
						else {
							ranking[tag_name] = parseInt(ranking[tag_name]) + 1;
						}
						ranking.text = ranking[tag_name];
					<!-- END -->
					<!-- START: write content -->
						content = '';
						content += '<div class="result row">';
							content += '<div class="result-wrapper col-xs-12 box-shadow" ';
							content += 'onclick="explorePlace(\''+json.destination[i].g_place_id+'\')";';
							content += '>';
								content += '<div class="result-image-wrapper">';
									content += '<div class="result-image">';
										content += json.destination[i].image;
									content += '</div>';
									content += '<div class="result-ranking">';
										content += ranking.text;
									content += '</div>';
								content += '</div>';
								content += '<div class="result-description">';
									content += '<div class="result-name line-clamp-1">';
										content += json.destination[i].name;
									content += '</div>';
									content += '<small><div class="result-blurb line-clamp-2">';
										content += json.destination[i].blurb;
									content += '</div></small>';
									content += '<div class="result-tag">';
										if(typeof json.destination[i].tag != 'undefined') {
											for(t=0;t<Math.min(json.destination[i].tag.length,3);t++) {
												var name = json.destination[i].tag[t].name;
												var color = json.destination[i].tag[t].type_color;
												content += '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
											}
										}
									content += '</div>';
								content += '</div>';
							content += '</div>';
						content += '</div>';
					<!-- END -->
					<!-- START: assign wrapper -->
						if(name == 'Airport') {
							$('#wrapper-explore-child-destination-airport .result-list').append(content);
							$('#wrapper-explore-child-destination-airport').show();
						}
						else if(name == 'National Park') {
							$('#wrapper-explore-child-destination-national-park .result-list').append(content);
							$('#wrapper-explore-child-destination-national-park').show();
						}
						else if(name == 'Island') {
							$('#wrapper-explore-child-destination-island .result-list').append(content);
							$('#wrapper-explore-child-destination-island').show();
						}
						else {
							$('#wrapper-explore-child-destination .result-list').append(content);
							$('#wrapper-explore-child-destination').show();
						}
					<!-- END -->
				}
			}
		<!-- END -->
		
		<!-- START: [child poi] -->
			if(current.poi.length > 0) {
				count = parseFloat(count) + parseFloat(json.count.poi);
				var ranking = { text:'' };
				for(i=0;i<json.count.poi;i++) {
					var tag_name = json.poi[i].tag[0].name.replace(/\s+/g, '-').toLowerCase();
					<!-- START: assign ranking -->
						if(typeof ranking['poi'] == 'undefined') { 
							ranking['poi'] = 1;
							$('.result-subtitle.poi-'+tag_name).show();
						}
						else {
							ranking['poi'] = parseInt(ranking['poi']) + 1;
						}
						ranking.text = ranking['poi'];
					<!-- END -->
					<!-- START: write content -->
						content = '';
						content += '<div class="result row">';
							content += '<div class="result-wrapper col-xs-12 box-shadow" ';
							content += 'onclick="explorePlace(\''+json.poi[i].g_place_id+'\')";';
							content += '>';
								content += '<div class="result-image-wrapper">';
									content += '<div class="result-image">';
										content += json.poi[i].image;
									content += '</div>';
									content += '<div class="result-ranking">';
										content += ranking.text;
									content += '</div>';
								content += '</div>';
								content += '<div class="result-description">';
									content += '<div class="result-name line-clamp-1">';
										content += json.poi[i].name;
									content += '</div>';
									content += '<small><div class="result-blurb line-clamp-2">';
										content += json.poi[i].blurb;
									content += '</div></small>';
									content += '<div class="result-tag">';
										if(typeof json.poi[i].tag != 'undefined') {
											for(t=0;t<Math.min(json.poi[i].tag.length,3);t++) {
												var name = json.poi[i].tag[t].name;
												var color = json.poi[i].tag[t].type_color;
												content += '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
											}
										}
									content += '</div>';
								content += '</div>';
							content += '</div>';
						content += '</div>';
					<!-- END -->
					<!-- START: assign wrapper -->
						$('#wrapper-explore-child-poi .result-list').append(content);
						$('#wrapper-explore-child-poi').show();
					<!-- END -->
				}
			}
		<!-- END -->
		
		setTimeout(function() {
			$(window).scrollTop(0);
			$('#wrapper-explore-current').show();
			$('#wrapper-explore-child').show();
			$('#wrapper-explore-loading').hide();
		}, 500);
	}
	
	function updateWrapperExploreButtonAddFavourite(place_id) {
		<?php if($this->user->isLogged() == false) { ?>
			if(inFavourite(place_id) == true) {
				$('#wrapper-explore-current-favourite .button-add-favourite').hide();
				$('#wrapper-explore-current-favourite .button-show-favourite').show();
			}
			else {
				$('#wrapper-explore-current-favourite .button-add-favourite').show();
				$('#wrapper-explore-current-favourite .button-show-favourite').hide();
			}
		<?php } else { ?>
			<!-- START: set data -->
				var data = {
					"action"	: "get_favourite",
					"user_id"	: "<?php echo $this->user->getUserId(); ?>"
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['main/ajax_favourite']; ?>", data, function(json) {
					var favourite = json;
					if($.inArray(place_id,favourite) != -1) {
						$('#wrapper-explore-current-favourite .button-add-favourite').hide();
						$('#wrapper-explore-current-favourite .button-show-favourite').show();
					}
					else {
						$('#wrapper-explore-current-favourite .button-add-favourite').show();
						$('#wrapper-explore-current-favourite .button-show-favourite').hide();
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function initExplore() {
		<!-- START: replace variable from server -->
			<!-- START: set data -->
                var data = { action:'init' }
            <!-- END -->
            <!-- START: send POST -->
                $.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
					<!-- START: reset value -->
						$('.result-list').html('');
					<!-- END -->
					<!-- START: reset visibility -->
						$('.result-list-wrapper').hide();
					<!-- END -->
					<!-- START: [child destination] -->
						var count = 0;
						count = parseFloat(count) + parseFloat(json.count.destination);
						var ranking = { text:'' };
						for(i=0;i<json.count.destination;i++) {
							var tag_name = json.destination[i].tag[0].name.replace(/\s+/g, '-').toLowerCase();
							<!-- START: assign ranking -->
							/*
								if(typeof ranking[tag_name] == 'undefined') { 
									ranking[tag_name] = 1;
									$('.result-subtitle.destination-'+tag_name).show();
								}
								else {
									ranking[tag_name] = parseInt(ranking[tag_name]) + 1;
								}
								ranking.text = ranking[tag_name];
							*/
							<!-- END -->
							<!-- START: write content -->
								content = '';
								content += '<div class="result-country row">';
									content += '<div class="result-country-wrapper col-xs-12 box-shadow" ';
									content += 'onclick="explorePlace(\''+json.destination[i].g_place_id+'\')";';
									content += '>';
										content += '<div class="result-country-image">';
											content += json.destination[i].image;
										content += '</div>';
										content += '<div class="result-country-name">';
											content += json.destination[i].name;
										content += '</div>';
									content += '</div>';
								content += '</div>';
								/*
								content += '<div class="result row">';
									content += '<div class="result-wrapper col-xs-12 box-shadow" ';
									content += 'onclick="explorePlace(\''+json.destination[i].g_place_id+'\')";';
									content += '>';
										content += '<div class="result-image-wrapper">';
											content += '<div class="result-image">';
												content += json.destination[i].image;
											content += '</div>';
											content += '<div class="result-ranking">';
												content += ranking.text;
											content += '</div>';
										content += '</div>';
										content += '<div class="result-description">';
											content += '<div class="result-name line-clamp-1">';
												content += json.destination[i].name;
											content += '</div>';
											content += '<small><div class="result-blurb line-clamp-2">';
												content += json.destination[i].blurb;
											content += '</div></small>';
											content += '<div class="result-tag">';
												if(typeof json.destination[i].tag != 'undefined') {
													for(t=0;t<Math.min(json.destination[i].tag.length,3);t++) {
														var name = json.destination[i].tag[t].name;
														var color = json.destination[i].tag[t].type_color;
														content += '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
													}
												}
											content += '</div>';
										content += '</div>';
									content += '</div>';
								content += '</div>';
								*/
							<!-- END -->
							<!-- START: assign wrapper -->
								$('#wrapper-explore-child-destination-country .result-list').append(content);
								$('#wrapper-explore-child-destination-country').show();
							<!-- END -->
							$('#wrapper-explore-child').show();
						}
					<!-- END -->
					
					setTimeout(function() {
						$(window).scrollTop(0);
						$('#wrapper-explore-loading').hide();
					}, 300);
                }, "json");
            <!-- END -->
		<!-- END -->
	}
	
	window.onhashchange = function() {
		var hashTab = getHashTab();
		if(hashTab != '') {
			showTab(hashTab);
		}
		initMap();
	}
</script>
<script>
	function convertTime(time) {
	  // Check correct time format and split into components
	  time = time.toString ().match (/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];
	
	  if (time.length > 1) { // If time format correct
		time = time.slice (1);  // Remove full string match value
		time[5] = +time[0] < 12 ? ' am' : ' pm'; // Set AM/PM
		time[0] = +time[0] % 12 || 12; // Adjust hours
	  }
	  return time.join (''); // return adjusted time or original string
	}
	
	function convertTitleCase(str) {
		return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
	}
</script>

<!-- START: [modal] -->
	<?php echo $modal_explore_search; ?>
    <?php echo $modal_explore_map; ?>
    <?php echo $modal_explore_review; ?>
    <?php echo $modal_explore_favourite; ?>
<!-- END -->