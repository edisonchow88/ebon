<style>
	#modal-explore-favourite .modal-body {
		padding:0;
	}
	
	#modal-explore-favourite-list-empty {
		padding:15px;
		text-align:center;
	}
	
	.result-favourite-row {
		border-bottom:solid thin #DDD;
		padding:15px 0;
		color:#000;
		cursor:pointer;
	}
	
	.result-favourite-row:hover {
		background-color:#EEE;
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
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-explore-favourite" role="dialog">
    	<div class="modal-header-fixed">
        	<div id="modal-explore-favourite-header-general" class="fixed-bar">
                <div class="col-xs-3 text-left">
                    <a id="modal-explore-favourite-button-edit" class="btn btn-header" onclick="openEditFavourite();">Edit</i></a>
                </div>
                <div class="col-xs-6 text-center">
                    <span class="btn-header modal-title">My Favourites</span>
                </div>
                <div class="col-xs-3 text-right">
                    <a id="modal-explore-favourite-button-close" class="btn btn-header" data-toggle="modal" data-target="#modal-explore-favourite"><i class="fa fa-fw fa-lg fa-times-circle"></i></a>
                    <span class="sr-only">Back</span>
                </div>
            </div>
            <div id="modal-explore-favourite-header-edit" class="fixed-bar">
                <div class="col-xs-3 text-left">
                    <a id="modal-explore-favourite-button-edit" class="btn btn-header" onclick="closeEditFavourite();">Close</i></a>
                </div>
                <div class="col-xs-6 text-center">
                    <span class="btn-header modal-title"></span>
                </div>
                <div class="col-xs-3 text-right">
                	<a id="modal-explore-favourite-button-delete" class="btn btn-header disabled" onclick="deleteFavourite(); closeEditFavourite();">Delete</i></a>
                </div>
            </div>
        </div>
        <div class="modal-header-shadow"></div>
        <div class="modal-dialog fixed-bar">
            <div class="modal-content">
                <div class="modal-body">
                	<div id="modal-explore-favourite-list"></div>
                    <div id="modal-explore-favourite-list-empty">The list is empty.</div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function printFavourite(data) {
		var content = '';
		var address = '';
		var order = '';
		if(data.country != null && data.country != '') {
			address = data.country;
		}
		if(data.region != null && data.region != '') {
			address += ', ' + data.region;
		}
		if(data.city != null && data.city != '') {
			address += ', ' + data.city;
		}
		
		<!-- START: [order] -->
			order = address + ', ' + data.name;
		<!-- END -->
		
		content += ''
			+ '<div class="row result-favourite-row" data-order="'+order+'">'
				+ '<div class="col-xs-2 text-center result-favourite-image">'
					+ '<img src="' + data.photo + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />'
				+ '</div>'
				+ '<div class="col-xs-8 text-left">'
					+ '<div class="result-favourite-blurb line-clamp-1">'
						+ address
					+ '</div>'
					+ '<div class="result-favourite-title line-clamp-1">'
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
		$('#modal-explore-favourite-list').append(content);
	}
	
	function refreshFavouriteList() {
		<?php if($this->user->isLogged() != false) { ?>
			<!-- START: [logged] -->
				<!-- START: set data -->
					var favourite = {
						"action":"get_favourite",
						"user_id":"<?php echo $this->user->getUserId(); ?>"
					};
				<!-- END -->
				<!-- START: send POST -->
					$.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
						runRefreshFavouriteList(favourite);
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
		updateFavouriteButton(favourite.length);
	}
	
	function addFavourite() {
		<!-- START: update button -->
			$('#wrapper-explore-current-favourite .button-add-favourite').hide();
			$('#wrapper-explore-current-favourite .button-show-favourite').show();
		<!-- END -->
		<!-- START: get data -->
			var user_id = "<?php echo $this->user->getUserId(); ?>";
			var place_id = $('#wrapper-explore-current-form input[name=place_id]').val();
			var name = $('#wrapper-explore-current-form input[name=name]').val();
			var photo = $('#wrapper-explore-current-form input[name=photo]').val();
			var city = $('#wrapper-explore-current-form input[name=city]').val();
			var region = $('#wrapper-explore-current-form input[name=region]').val();
			var country = $('#wrapper-explore-current-form input[name=country]').val();
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"	: "add_favourite",
				"user_id"	: user_id,
				"place_id"	: place_id,
				"name"		: name,
				"photo"		: photo,
				"city"		: city,
				"region"	: region,
				"country"	: country
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
				printFavourite(data);
				if(user_id == '') {
					saveFavouriteViaCookie();
				}
			}, "json");
		<!-- END -->
	}
	
	function saveFavouriteViaCookie() {
		<!-- START: declare variable -->
			var favourite = [];
			var i = 0;
		<!-- END -->
		<!-- START: set data -->
			$('.result-favourite-form').each(function() {
				favourite.push($(this).find('input[name=place_id]').val());
				i += 1;
			});
		<!-- END -->
		<!-- START: convert data format -->
			favourite = JSON.stringify(favourite);
		<!-- END -->
		<!-- START: set cookie -->
			setCookie('favourite',favourite,7);
		<!-- END -->
		<!-- START: update button -->
			updateFavouriteButton(i);
		<!-- END -->
	}
	
	function openEditFavourite() {
		$('#modal-explore-favourite-header-general').hide();
		$('#modal-explore-favourite-header-edit').show();
		$('.result-favourite-button').html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$('.result-favourite-button').css('color','#CCC');
		$('.result-favourite-row').off().on('click',function() { 
			var button = $(this).find('.result-favourite-button');
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				deselectFavourite(button);
			}
			else {
				$(this).addClass('selected');
				selectFavourite(button);
			}
		});
	}
	
	function closeEditFavourite() {
		$('#modal-explore-favourite-header-general').show();
		$('#modal-explore-favourite-header-edit').hide();
		$('.result-favourite-button').html('<i class="fa fa-fw fa-lg fa-chevron-right"></i>');
		$('.result-favourite-button').css('color','#000');
		$('.result-favourite-row').off().on('click',function() {
			explorePlace($(this).find('.result-favourite-form input[name=place_id]').val());
			$('#modal-explore-favourite').modal('hide');
		});
	}
	
	function selectFavourite(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('.result-favourite-row.selected').length > 0) {
			$('#modal-explore-favourite-button-delete').removeClass('disabled');
		}
	}
	
	function deselectFavourite(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-favourite-row.selected').length < 1) {
			$('#modal-explore-favourite-button-delete').addClass('disabled');
		}
	}
	
	function deleteFavourite() {
		$('.result-favourite-row.selected').remove();
		saveFavouriteViaCookie();
	}
	
	function inFavourite(place_id) {
		var favourite = getCookie('favourite');
		favourite = JSON.parse(favourite);
		if($.inArray(place_id,favourite) != -1) {
			return true;
		}
		else {
			return false;
		}
	}
	
	function sortFavourite() {
		$('#modal-explore-favourite-list').find('.result-favourite-row').sort(function (a, b) {
			if(a.getAttribute('data-order') < b.getAttribute('data-order')) return -1;
			if(a.getAttribute('data-order') > b.getAttribute('data-order')) return 1;
			return 0;
		})
		.appendTo($('#modal-explore-favourite-list'));
	}
	
	$('.button-add-favourite').on('click',function() { addFavourite(); });
	
	
	function updateFavouriteButton(length) {
		if(length == '') {
			length = $('.result-favourite-form').length;
		}
		if(length > 0) {
			$('#wrapper-explore-favourite-button').html('<span class="badge">'+length+'</span>'+'<i class="fa fa-fw fa-lg fa-heart"></i>');
			$('#modal-explore-favourite-list-empty').hide();
			$('#modal-explore-favourite-button-edit').removeClass('disabled');
		}
		else {
			$('#wrapper-explore-favourite-button').html('<i class="fa fa-fw fa-lg fa-heart-o"></i>');
			$('#modal-explore-favourite-list-empty').show();
			$('#modal-explore-favourite-button-edit').addClass('disabled');
		}
	}
	
	refreshFavouriteList();
</script>
<script>
	$("#modal-explore-favourite").on( "show.bs.modal", function() {
		closeEditFavourite();
		sortFavourite();
	});
</script>