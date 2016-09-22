<style>
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
		height:100vh;
		padding-top:20vh;
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
	
	.tag {
		margin-right:5px;
	}
</style>

<!-- START: [header] -->
    <div class="fixed-bar wrapper-header-main row">
        <div class="col-xs-3 text-left">
        </div>
        <div class="col-xs-6">
            <h1>Explore</h1>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn btn-header"><i class="fa fa-fw fa-lg fa-heart-o"></i></a>
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
        </div>
        <div id="wrapper-explore-current-action">
        	<div id="wrapper-explore-current-favourite" class="row wrapper-explore-current-row">
            	<a>
                    <span class="fa-stack fa-lg">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-heart fa-stack-1x fa-inverse"></i>
                    </span>
                 	<span>Add to My Favourite</span>
                 </a>
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
<!-- END -->

<!-- START: [modal] -->
	<?php echo $modal_explore_search; ?>
    <?php echo $modal_explore_map; ?>
    <?php echo $modal_explore_review; ?>
<!-- END -->

<script>
	function getHash() {
		var hash = location.hash;
		if(hash.indexOf('gid') > 0) {
			hash = hash.replace('#gid=','');
		}
		return hash;
	}
	
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

	function updateWrapperExploreResult(place) {
		var current = {
			place_id					: null,
			name						: null,
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
			international_phone_number	: null
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
		
		<!-- START: clear ex-data -->
			<!-- START: reset value -->
				$('#wrapper-explore-current-image').html('');
				$('#wrapper-explore-current-parent').html('');
				$('#wrapper-explore-current-title').html('');
				$('#wrapper-explore-current-rating').html('');
				$('#wrapper-explore-current-tag').html('');
				$('#wrapper-explore-current-hour .detail').html('');
				$('#wrapper-explore-current-address .detail').html('');
				$('#wrapper-explore-current-phone .detail').html('');
				$('#wrapper-explore-current-website .detail').html('');
				$('#wrapper-explore-current-review').html('');
			<!-- END -->
			<!-- START: reset visibility -->
				$('#wrapper-explore-current-misc').show();
				$('#wrapper-explore-current-parent').hide();
				$('#wrapper-explore-current-rating').hide();
				$('#wrapper-explore-current-tag').hide();
				$('#wrapper-explore-current-hour').hide();
				$('#wrapper-explore-current-address').hide();
				$('#wrapper-explore-current-phone').hide();
				$('#wrapper-explore-current-website').hide();
			<!-- END -->
		<!-- END -->
		
		<!-- START: set hash -->
			window.location.hash = '#gid='+current.place_id;
		<!-- END -->
		
		//image
		if(current.photos.length > 0) {
			$('#wrapper-explore-current-image').html("<img src='"+current.photos[0].url+"' onerror='$(this).hide();'>");
		}
		
		//parent
		if(current.types.length > 0) {
			if($.inArray('country',current.types) != -1) {
				//set world as parent
				$('#wrapper-explore-current-parent').html('<a>World /</a>');
				$('#wrapper-explore-current-parent').show();
			}
			else if($.inArray('administrative_area_level_1',current.types) != -1) {
				//set country as parent
				if(current.address_components.length > 0) {
					$.each(current.address_components, function(index,value) {
						if($.inArray('country',value.types) != -1) {
							$('#wrapper-explore-current-parent').html(value.long_name+' /');
							$('#wrapper-explore-current-parent').show();
						}
					});
				}
			}
			else if($.inArray('locality',current.types) != -1) {
				//set administrative as parent
				if(current.address_components.length > 0) {
					$.each(current.address_components, function(index,value) {
						if($.inArray('administrative_area_level_1',value.types) != -1) {
							$('#wrapper-explore-current-parent').html(value.long_name+' /');
							$('#wrapper-explore-current-parent').show();
						}
					});
				}
			}
			else {
				//set city as parent
				if(current.address_components.length > 0) {
					$.each(current.address_components, function(index,value) {
						if($.inArray('locality',value.types) != -1) {
							$('#wrapper-explore-current-parent').html(value.long_name+' /');
							$('#wrapper-explore-current-parent').show();
						}
					});
				}
			}
			
		}
		
		//title
		$('#wrapper-explore-current-title').html(current.name);
		
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
				else if(value == 'political') {}
				else if(value == 'establishment') {}
				else if(value == 'premise') {}
				else {
					value = convertTitleCase(value.replace(/_/g, ' '));
					tag.push(value);
				}
			});
			
			if(tag.length > 0) {
				$.each(tag, function(index,value) {
					$('#wrapper-explore-current-tag').append('<div class="label label-pill label-warning tag">'+value+'</div>');
				});
				$('#wrapper-explore-current-tag').show();
			}
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
		
		setTimeout(function() {
			$(window).scrollTop(0);
			$('#wrapper-explore-current').show();
			$('#wrapper-explore-loading').hide();
		}, 500);
	}
	
	window.onhashchange = function() {
		initMap();
	}
</script>