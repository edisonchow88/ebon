<style>
	#modal-itinerary-menu .modal-modal {
		height:100vh;
		top:0;
	}
	
	#modal-itinerary-menu .modal-footer {
		position:fixed;
		bottom:0;
		left:0;
		right:0;
		margin:auto;
		padding:0;
		background-color:#FFF;
		color:#000;
		z-index:30;
		text-align:left;
	}
</style>

<!-- START: Modal -->
    <div class="modal fade" id="modal-itinerary-menu" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-modal fixed-width" data-dismiss="modal"></div>
            <div class="modal-dialog fixed-width">
            </div>
            <div class="modal-footer fixed-width">
            	<ul class="menu menu-white">
                	<li data-dismiss="modal" class="button-edit-trip-info" data-toggle="modal" data-target="#modal-trip-info"><i class="fa fa-fw fa-lg fa-edit"></i><i class="fa fa-fw"></i>Edit Trip Info</li>
                    <li class="button-preview-trip"><i class="fa fa-fw fa-lg fa-eye"></i><i class="fa fa-fw"></i>Preview Trip</li>
                    <li data-dismiss="modal" data-toggle="modal" data-target="#modal-trip-share"><i class="fa fa-fw fa-lg fa-share"></i><i class="fa fa-fw"></i>Share Trip</li>
                    <li data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times"></i><i class="fa fa-fw"></i>Cancel</li>
                </ul>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-itinerary-menu").on("show.bs.modal", function () {
		$('#modal-itinerary-menu .modal-footer').hide();
	});
	$("#modal-itinerary-menu").on("shown.bs.modal", function () {
		$('#modal-itinerary-menu .modal-footer').slideDown('fast');
	});
	$("#modal-itinerary-menu").on("hide.bs.modal", function () {
		$('#modal-itinerary-menu .modal-footer').slideUp();
	});
</script>
<script>
	$('.button-preview-trip').click(function(e){
		var win = window.open("<?php echo $link['preview']; ?>", '_blank');
		if (win) {
			//Browser has allowed it to be opened
			win.focus();
		} else {
			//Browser has blocked it
			alert('Please allow popups for this website');
		}
	});
</script>