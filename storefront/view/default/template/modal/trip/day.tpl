<style>
	#modal-trip-day .header.header-white {
		background-color:#FFF;
		color:#000;
		border-bottom:solid thin #DDD;
	}
	
	.result-row {
		width:100%;
		background-color:#FFF;
		color:#000;
		border-bottom:solid thin #DDD;
		cursor:pointer;
	}
	
	.result-row.active {
		background-color:#FFC;
	}
	
	.result-row:hover {
		background-color:#EEE;
	}
	
	.result-cell {
		padding:10px 15px;
		line-height:28px;
		overflow:hidden;
	}
	
	.ui-placeholder-day {
		height:50px;
		background-color:#EEE;
		border-bottom:solid thin #DDD;
	}
	.ui-placeholder-day > div {
		opacity:.5;
	}
	
	.button-sort-day {
		overflow:hidden;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top noselect" id="modal-trip-day" role="dialog">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">All Days</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
                <div id="modal-trip-day-header-general" class="header header-secondary header-white fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" onclick="openEditDay();">Edit</a>
                    </div>
                    <div class="col-xs-6 text-center">
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header" onclick="addPlanDay();">New Day</a>
                    </div>
                </div>
                <div id="modal-trip-day-header-edit" class="header header-secondary header-white fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" onclick="closeEditDay();">Done</a>
                    </div>
                    <div class="col-xs-6 text-center">
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header button-delete" onclick="deleteSelectedDay();">Delete</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-trip-day").on("show.bs.modal", function () {
		refreshDayList();
	});
</script>
<script>
	function initSortableDay() {
		$('#modal-trip-day .modal-body').sortable({	
			delay: 100,
			axis: "y",
			items: ">.result-row", 
			handle: ".sort-handle",
			appendTo: "parent",	
			containment: ".modal-content",
			scrollSpeed: 10,
			cursorAt: {
				top: 15
			},
			placeholder: "ui-placeholder-day",
			helper:function(event,ul) {
				return $('<div class="ui-helper-day"></div>');
			},
			start: function(e, ui) {
				$(this).sortable("refreshPositions");
				ui.placeholder.html(ui.item.html());
			},
			sort: function(event, ui) {				
			},
			stop: function(event, ui) {
			},
			update: function(event,ui) {
				updateDayList();
			}
		});
	}
	
	function initDayListButton() {
		$('#modal-trip-day .result-row').off().on('click',function() {
			var day_id = $(this).find('input[name="day_id"]').val();
			viewDay(day_id);
			$('#modal-trip-day').modal('hide');
		});
	}
	
	function viewDay(day_id) {
		var sort_order = $('#plan-day-'+day_id+'-form-hidden').find('input[name="sort_order"]').val();
		var index = parseInt(sort_order) - 1;
		mySwiper.slideTo(index,0);
		$('.modal-trip-day-result-row').removeClass('active');
		$('#modal-trip-day-result-row-'+day_id).addClass('active');
	}
	
	function updateDaySortOrder() {
		var speed = 300;
		$.each($('.modal-trip-day-result-row'),function(index) {
			var sort_order = parseInt(index) + 1;
			var day_id = $(this).find('input[name="day_id"]').val();
			$(this).find('input[name="sort_order"]').val(sort_order);
			$(this).find('.text-day').fadeOut(speed).html('Day ' + sort_order).fadeIn(speed);
			$('#plan-day-'+day_id+'-form-hidden').find('input[name="sort_order"]').val(sort_order);
		});
	}
	
	function updateDayList() {
		updateDaySortOrder();
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
			showHint('Day Sorted');
			refreshPlanTable();
		<?php } else { ?>
			var day = new Array();
			var day_id;
			var sort_order;
			var order;
			
			$('.plan-day-form-hidden').each(function() {
				day_id = $(this).find('input[name=day_id]').val();
				sort_order = $(this).find('input[name=sort_order]').val();
				day.push({"day_id":day_id,"sort_order":sort_order});
			});
			order = JSON.stringify(day);
			<!-- START: set data -->
				var data = {
					"action":"sort_day",
					"order":order
				};
			<!-- END -->
		
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					if(typeof json.warning != 'undefined') {
						showHint(json.warning);
					}
					else if(typeof json.success != 'undefined') {
						showHint('Day Sorted');
						refreshPlanTable();
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function refreshDayList() {
		var content = '';
		var sort_order;
		var icon;
		var selected;
		
		$('#modal-trip-day .modal-body').html('');
		
		$('.plan-day-form-hidden').each(function() {
			icon = '';
			var num_of_line = $(this).parent('.plan-day').find('.plan-line-form-hidden').length;
			if(num_of_line <= 4) {
				$(this).parent('.plan-day').find('.plan-line-form-hidden').each(function() {
					icon += ''
						+ '<span class="fa-stack fa-fw fa-1x">'
							+ '<i class="fa fa-circle fa-stack-2x text-success"></i>'
							+ '<i class="fa fa-camera fa-stack-1x fa-inverse"></i>'
						+ '</span>'
					;
				});
			}
			else {
				icon += ''
					+ '<span class="fa-stack fa-fw fa-1x">'
						+ '<i class="fa fa-circle fa-stack-2x text-success"></i>'
						+ '<i class="fa fa-camera fa-stack-1x fa-inverse"></i>'
					+ '</span>'
					+ ' x ' + num_of_line
				;
			}
			day_id = $(this).find('input[name="day_id"]').val();
			sort_order = $(this).find('input[name="sort_order"]').val();
			if($('#plan-day-'+day_id).hasClass('swiper-slide-active')) { active = 'active'; } else { active = ''; }
			content = ''
				+ '<div id="modal-trip-day-result-row-' + day_id + '" class="modal-trip-day-result-row result-row row ' + active + '">'
					+ '<div class="result-cell col-xs-10 sort-handle">'
						+ '<span class="button-sort-day hidden">'
							+ '<i class="fa fa-fw fa-arrows grabbable"></i>'
							+ '<i class="fa fa-fw"></i>'
						+ '</span>'
						+ '<span class="text-day">'
							+ 'Day '
							+ sort_order
						+ '</span>'
						+ '<span>'
							+ '<i class="fa fa-fw"></i>'
							+ '<i class="fa fa-fw"></i>'
							+ icon
						+ '</span>'
					+ '</div>'
					+ '<div class="result-cell col-xs-2 text-right result-select-button">'
						+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
					+ '</div>'
					+ '<form class="modal-trip-day-result-form-hidden ">'
						+ '<input type="hidden" name="day_id" value="'+day_id+'"/>'
						+ '<input type="hidden" name="sort_order" value="'+sort_order+'"/>'
					+ '</form>'
				+ '</div>'
			;
			$('#modal-trip-day .modal-body').append(content);
		});
		
		initSortableDay();
		initDayListButton();
		closeEditDay();
	}
	
	function openEditDay() {
		$('#modal-trip-day-header-general').hide();
		$('#modal-trip-day-header-edit').show();
		$('#modal-trip-day .result-select-button').html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$('#modal-trip-day .result-select-button').css('color','#CCC');
		$('#modal-trip-day .button-sort-day').removeClass('hidden');
		$('#modal-trip-day .result-row').removeClass('selected');
		$('#modal-trip-day .button-delete').addClass('disabled');
		$('#modal-trip-day .result-row').off().on('click',function() { 
			var button = $(this).find('.result-select-button');
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				deselectDay(button);
			}
			else {
				$(this).addClass('selected');
				selectDay(button);
			}
		});
	}
	
	function closeEditDay() {
		$('#modal-trip-day-header-general').show();
		$('#modal-trip-day-header-edit').hide();
		$('#modal-trip-day-button-delete').addClass('disabled');
		$('#modal-trip-day .result-select-button').html('<i class="fa fa-fw fa-lg fa-chevron-right"></i>');
		$('#modal-trip-day .result-select-button').css('color','#000');
		$('#modal-trip-day .button-sort-day').addClass('hidden');
		initDayListButton();
	}
	
	function selectDay(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('#modal-trip-day .result-row.selected').length > 0) {
			$('#modal-trip-day .button-delete').removeClass('disabled');
		}
	}
	
	function deselectDay(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('#modal-trip-day .result-row.selected').length < 1) {
			$('#modal-trip-day .button-delete').addClass('disabled');
		}
	}
	
	function deleteSelectedDay() {
		var day = Array();
		var day_id = '';
		$('#modal-trip-day .result-row.selected').each(function() {
			day_id = $(this).find('input[name=day_id]').val();
			sort_order = $(this).find('input[name=sort_order]').val();
			day.push({day_id:day_id,sort_order:sort_order});
		});
		deleteDay(day);
	}
	
	function deleteDay(day) {
		var slide_index;
		var day_id;
		var existed = {};
		var deleted = {};
		existed.day_id = Array();
		deleted.day_id = Array();
		deleted.slide = Array();
		<!-- START: generate array -->
			<!-- START: [existed day] -->
				$('.plan-day-form-hidden').each(function() {
					day_id = $(this).find('input[name=day_id]').val();
					existed.day_id.push(day_id);
				});
			<!-- END -->
			<!-- START: [deleted day] -->
				$.each(day, function(index,value) {
					slide_index = parseInt(value.sort_order) - 1;
					deleted.slide.push(slide_index);
					deleted.day_id.push(value.day_id);
				});
			<!-- END -->
		<!-- END -->
		<!-- START: verify if remain at least one day -->
			var num_of_day = $('.plan-day-form-hidden').length;
			if(deleted.day_id.length >= existed.day_id.length) {
				showHint('Cannot be deleted. There must be at least one day.');
				return false;
			}
		<!-- END -->
		<!-- START: select new day -->
			var selected_day_id = $('.swiper-slide-active .plan-day-form-hidden').find('input[name=day_id]').val();
			var target_day_id = selected_day_id;
			var index = $.inArray(selected_day_id,deleted.day_id);
			var prev = 0;
			var next = 0;
			
			if(index != -1) {
				<!-- START: select one existing prev day as new day -->
					for(i=(num_of_day-1);i>=0;i--) {
						if(prev == 1 && $.inArray(existed.day_id[i],deleted.day_id) == -1) {
							target_day_id = existed.day_id[i];
							prev = 2;
						}
						if(existed.day_id[i] == selected_day_id) {
							prev = 1;
						}
					}
				<!-- END -->
				<!-- START: select one existing next day as new day if do not have candidate in prev day -->
					if(prev != 2) {
						for(i=0;i<num_of_day;i++) {
							if(next == 1 && $.inArray(existed.day_id[i],deleted.day_id) == -1) {
								target_day_id = existed.day_id[i];
								next = 2;
							}
							if(existed.day_id[i] == selected_day_id) {
								next = 1;
							}
						}
					}
				<!-- END -->
			}
		<!-- END -->
		<!-- START: [data] -->
			mySwiper.removeSlide(deleted.slide);
			refreshDayList();
			updateDaySortOrder();
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
				runDeleteDay(day);
				viewDay(target_day_id);
			<?php } else { ?>
				$.each(day, function(index, value) {
					<!-- START: set data -->
						var data = {
							"action":"delete_day",
							"day_id":value.day_id,
							"sort_order":value.sort_order
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							if(index == (day.length - 1)) {
								if(typeof json.warning != 'undefined') {
									showHint(json.warning);
								}
								else if(typeof json.success != 'undefined') {
									runDeleteDay(day);
									viewDay(target_day_id);
								}
							}
						}, "json");
					<!-- END -->
				});
			<?php } ?>
	}
	
	function runDeleteDay(day) {
		<!-- START: chain reaction -->
			refreshPlanTable();
		<!-- END -->
		<!-- START: hint -->
			if(day.length == 1) {
				showHint('Day '+day[0].sort_order+' Deleted');
			}
			else {
				showHint('Days Deleted');
			}
		<!-- END -->
	}
</script>
<script>
	$("#modal-trip-day").on( "show.bs.modal", function() {
		closeEditDay();
	});
</script>