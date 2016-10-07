<style>
	.result-row {
		width:100%;
		background-color:#FFF;
		color:#000;
		border-bottom:solid thin #DDD;
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
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-day" role="dialog">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-day-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-day">Done</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">All Days</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
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
		$('#modal-trip-day .modal-body').html('');
		printDayList();
	});
</script>
<script>
	function initSortableDay() {
		$('#modal-trip-day .modal-body').sortable({	
			delay: 100,
			axis: "y",
			items: ">.result-row", 
			handle: ".fa-arrows",
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
		$('.modal-trip-day-result-row').on('click',function() {
			var sort_order = $(this).find('input[name="sort_order"]').val();
			var index = parseInt(sort_order) - 1;
			mySwiper.slideTo(index,0);
			$('#modal-trip-day').modal('hide');
		});
	}
	
	function updateDayList() {
		var speed = 300;
		$.each($('.modal-trip-day-result-row'),function(index) {
			var sort_order = parseInt(index) + 1;
			var day_id = $(this).find('input[name="day_id"]').val();
			$(this).find('input[name="sort_order"]').val(sort_order);
			$(this).find('.text-day').fadeOut(speed).html('Day ' + sort_order).fadeIn(speed);
			$('#plan-day-'+day_id+'-form-hidden').find('input[name="sort_order"]').val(sort_order);
		});
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
	
	function printDayList() {
		var content = '';
		var sort_order;
		var icon;
		
		$('.plan-day-form-hidden').each(function() {
			icon = '';
			$(this).parent('.plan-day').find('.plan-line-form-hidden').each(function() {
				icon += ''
					+ '<span class="fa-stack fa-fw fa-1x">'
						+ '<i class="fa fa-circle fa-stack-2x text-success"></i>'
						+ '<i class="fa fa-camera fa-stack-1x fa-inverse"></i>'
					+ '</span>'
				;
			});
			day_id = $(this).find('input[name="day_id"]').val();
			sort_order = $(this).find('input[name="sort_order"]').val();
			content = ''
				+ '<div class="modal-trip-day-result-row result-row row">'
					+ '<div class="result-cell col-xs-4">'
						+ '<i class="fa fa-fw fa-arrows grabbable"></i>'
						+ '<i class="fa fa-fw"></i>'
						+ '<span class="text-day">'
						+ 'Day '
						+ sort_order
						+ '</span>'
					+ '</div>'
					+ '<div class="result-cell col-xs-8">'
						+ icon
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
	}
</script>