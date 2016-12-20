<style>
	#modal-member-view input:disabled {
		color:#000;
	}
	
	.modal-transport-custom-info{
		font-size:1.2em;
		height: 30px;
		text-align:center;
	}

</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal_transport_custom" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-account-login-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal_transport_custom">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Custom Transport</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    	 <a class="btn btn-header" data-dismiss="modal">Add</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                	<div id="modal-account-login-form-alert"></div>
                    <div class="modal-body">
                       	<!-- modal info here -->
                       	<div class="modal-transport-custom-info">
                           		<span class="origin"></span>
                   				<span class="custom-arrow">&#8594;</span>
                      		 	<span class="destination"></span>
                        </div>
                        <div class="modal-transport-custom-list">
                        </div>                       
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function setOriginDestination(origin, destination) {
		var origin_title = $("#plan-line-"+origin).find('.plan-line-form-hidden input[name=title]').val();
		var destination_title = $("#plan-line-"+destination).find('.plan-line-form-hidden input[name=title]').val();
		$(".modal-transport-custom-info .origin").html(origin_title);
		$(".modal-transport-custom-info .destination").html(destination_title);
		
	}
</script>
<script>
	$("#modal_transport_custom").on( "show.bs.modal", function() {
		/*$('#modal-member-edit-form').hide();
		$('#modal-member-view-header-edit').hide();
		$('#modal-member-view .modal-member-view-alert').html('');
		<?php if($this->session->data['mode'] != 'edit') { ?>
			$('#modal-member-view .button-edit-member').hide();
		<?php } ?>*/
	});
</script>