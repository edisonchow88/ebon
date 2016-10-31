<style>
	#modal-line-favourite .modal-body {
		padding:0;
		padding-bottom:70px;
	}
	
	.result-favourite-row {
		border-bottom:solid thin #DDD;
		padding:15px 0;
		color:#000;
		cursor:pointer;
	}
	
	.result-favourite-image img {
		width:40px;
		height:40px;
		border-radius:20px;
		border:solid thin #DDD;
	}
	
	.result-favourite-title {
		font-weight:bold;
		overflow:hidden;
	}
	
	.result-favourite-blurb {
		color:#777;
		overflow:hidden;
		font-size:12px;
	}
	
	.result-favourite-button {
		text-align:right;
		line-height:40px;
		padding-right:16px;
	}
	
	.result-favourite-row.selected > .result-favourite-button {
		color:#e93578;
	}
	
	/* START: empty-list */
		.empty-list {
			color:#777;
			margin-top:20vh;
			padding:15px;
			text-align:center;
		}
		
		.empty-list .title {
			background-color:transparent;
			color:#777;
			font-weight:bold;
		}
	/* END */
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-favourite" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-favourite-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-favourite">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">My Favourites</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                    	<div id="modal-line-favourite-list"></div>
                        <div id="modal-line-favourite-list-empty" class="empty-list">
                        	<div class="title">Your List is Empty</div>
                            <div class="cta">Click to <a data-toggle="modal" data-target="#modal-line-explore" data-dismiss="modal">explore new places</a>.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function printFavourite(data) {
		var content = '';
		var address = '';
		var last_address_component = '';
		var order = '';
		if(data.country != null && data.country != '') {
			if(data.country.toLowerCase() != data.name.toLowerCase()) {
				address = data.country;
			}
			last_address_component = data.country;
		}
		if(data.region != null && data.region != '') {
			if(data.region.toLowerCase() != data.name.toLowerCase()) {
				address += ', ' + data.region;
			}
			last_address_component = data.region;
		}
		if(data.city != null && data.city != '') {
			if(data.city.toLowerCase() != data.name.toLowerCase()) {
				address += ', ' + data.city;
			}
			last_address_component = data.city;
		}
		
		<!-- START: [order] -->
			if(last_address_component.toLowerCase() == data.country.toLowerCase()) {
				order = data.name;
			}
			else {
				order = address + ', ' + data.name;
			}
		<!-- END -->
		
		<!-- START: [title only] -->
			var line_height = '';
			if(address == '') {
				line_height = 'style="line-height:40px;"';
			}
		<!-- END -->
		
		content += ''
			+ '<div class="row result-favourite-row" data-order="'+order+'" data-toggle="modal" data-target="#modal-line-favourite" onclick="explorePlace(\'' + data.place_id + '\');">'
				+ '<div class="col-xs-2 text-center result-favourite-image">'
					+ '<img src="' + data.photo + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />'
				+ '</div>'
				+ '<div class="col-xs-8 text-left">'
					+ '<div class="result-favourite-blurb line-clamp-1">'
						+ address
					+ '</div>'
					+ '<div class="result-favourite-title line-clamp-1" ' + line_height + '>'
						+ data.name
					+ '</div>'
				+ '</div>'
				+ '<div class="col-xs-2 text-right result-favourite-button">'
					+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
				+ '</div>'
				+ '<form class="result-favourite-form hidden">'
					+ '<input type="hidden" name="place_id" value="' + data.place_id + '"/>'
				+ '</form>'
			+ '</div>'
		;
		$('#modal-line-favourite-list').append(content);
	
		$(".result-favourite-row").on("click",function(){
			//Google Analytics Event
			ga('send', 'event','line', 'add-line-favourite');
		});
	}
	
	function refreshFavouriteList() {
		<!-- START: reset list -->
			$('#modal-line-favourite-list').html('');
		<!-- END -->
		<?php if($this->user->isLogged() != false) { ?>
			<!-- START: [logged] -->
				<!-- START: set data -->
					var data = {
						"action":"get_favourite",
						"user_id":"<?php echo $this->user->getUserId(); ?>"
					};
				<!-- END -->
				<!-- START: send POST -->
					$.post("<?php echo $ajax['main/ajax_favourite']; ?>", data, function(json) {
						runRefreshFavouriteList(json);
					}, "json");
				<!-- END -->
			<!-- END -->
		<?php } else { ?>
			<!-- START: [not logged] -->
				var favourite = getCookie('favourite');
				if(favourite == '') {
					<!-- START: [first time] -->
						var favourite = [];
						favourite = JSON.stringify(favourite);
						setCookie('favourite',favourite,7);
						favourite = JSON.parse(favourite);
						runRefreshFavouriteList(favourite);
					<!-- END -->
				}
				else {
					<!-- START: [revisit] -->
						favourite = JSON.parse(favourite);
						runRefreshFavouriteList(favourite);
					<!-- END -->
				}
			<!-- END -->
		<?php } ?>
	}
	
	function runRefreshFavouriteList(favourite) {
		updateFavouriteButton(favourite.length);
		for(i=0;i<favourite.length;i++) {
			<!-- START: set data -->
				var data = {
					"action":"get_place",
					"place_id":favourite[i]
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
					printFavourite(json);
				}, "json");
			<!-- END -->
		}
	}
	
	function sortFavourite() {
		$('#modal-line-favourite-list').find('.result-favourite-row').sort(function (a, b) {
			if(a.getAttribute('data-order') < b.getAttribute('data-order')) return -1;
			if(a.getAttribute('data-order') > b.getAttribute('data-order')) return 1;
			return 0;
		})
		.appendTo($('#modal-line-favourite-list'));
	}
	
	$('.button-add-favourite').on('click',function() { addFavourite(); });
	
	function updateFavouriteButton(length) {
		if(length == '') {
			length = $('.result-favourite-form').length;
		}
		if(length > 0) {
			$('#modal-line-favourite-list-empty').hide();
			$('#modal-line-favourite .modal-content').css('background-color','#FFF');
		}
		else {
			$('#modal-line-favourite-list-empty').show();
			$('#modal-line-favourite .modal-content').css('background-color','#EEE');
		}
	}
</script>
<script>
	$("#modal-line-favourite").on( "show.bs.modal", function() {
		refreshFavouriteList();
		sortFavourite();
	});
	$("#modal-line-favourite").on( "shown.bs.modal", function() {
		$('#modal-line-favourite .modal-content').scrollTop(0);
	});
	
	
</script>