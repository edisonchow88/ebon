<style>
	#modal-line-delete .modal-modal {
		top:0;
		height:100vh;
	}
	
	.modal-modal-button {
		position:absolute;
		width:100%;
		padding:15px;
		top:calc(50vh);
		z-index:30;
	}
	
	.modal-modal-button .btn {
		background-color:#FFF;
		height:50px;
		padding:15px;
		border-bottom:solid thin #DDD;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-line-delete" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar fixed-width">
            <div class="modal-content" style="position:relative;">
                <div class="modal-modal fixed-width" data-toggle="modal" data-target="#modal-line-delete"></div>
                <div class="modal-modal-button">
                	<div><a class="btn btn-block" style="color:#F00;" onclick="deletePlanLine();">Delete Activity</a></div>
                    <div><a class="btn btn-block" style="color:#000;" data-toggle="modal" data-target="#modal-line-delete"><b>Cancel</b></a></div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function deletePlanLine() {
		line_id = $('#modal-line-custom input[name=line_id]').val();
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>					
			$("#plan-line-" + line_id).remove();
			$('#modal-line-delete').modal('hide');
			$('#modal-line-custom').modal('hide');
			runDeletePlanLine();
		<?php } else { ?>
			<!-- START: set data -->
				var data = {
					"action":"delete_line",
					"line_id":line_id
				};
			<!-- END -->
		
			<!-- START: send POST -->
				$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
					if(typeof json.warning != 'undefined') {
						showHint(json.warning);
					}
					else if(typeof json.success != 'undefined') {
						$("#plan-line-"+ line_id).remove();
						$('#modal-line-delete').modal('hide');
						$('#modal-line-custom').modal('hide');
						runDeletePlanLine();
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function runDeletePlanLine() {
		<!-- START: init function -->
			//updatePlanTableDayDuration();
			updatePlanTableLineDayIdAndSortOrder();
			//updatePlanTableButtonEvent();
		<!-- END -->
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: hint -->
			showHint('Activity Deleted');
		<!-- END -->
	}
</script>

