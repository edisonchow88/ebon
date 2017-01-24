<style>
	#modal-trip-share .modal-body textarea {
		width:100%;
		color:#999;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-trip-share" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
            <div class="modal-header fixed-width">
                <div class="navbar navbar-primary navbar-modal fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn" data-toggle="modal" data-target="#modal-trip-share">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Share Trip</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-body fixed-width padding">
            	<div class="navbar navbar-shadow"></div>
                <div class="modal-member-join-alert">
                </div>
                <div>Anyone with the link can view</div>
                    	<textarea rows="4" readonly="readonly" onclick="selectShareTripLink();"></textarea>
                        <a type="button" class="btn btn-block btn-primary modal-button" onclick="copyShareTripLink();">Copy Link</a>
                        <a id="modal-trip-share-button-whatsapp" type="button" class="btn btn-block btn-default modal-button" onclick="shareViaWhatsapp();" data-action="share/whatsapp/share" href="">WhatsApp</a>
            </div>
  
            </div>
        </div>
    </div>
<!-- END -->

<script>
	//$('#modal-trip-share .modal-body textarea').val("<?php echo $link['preview']; ?>");
	
	function ifMobileAndTablet() {
		var check = false;
		(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
		return check;
	}
	
	function selectShareTripLink() {
		$('#modal-trip-share .modal-body textarea').focus();
		document.execCommand('SelectAll');
	}
	
	function copyShareTripLink() {
		$('#modal-trip-share .modal-body textarea').focus();
		document.execCommand('SelectAll');
		document.execCommand("Copy", false, null);
		
		//iOS did not allow programatically copy text hence need to exclude it
		var iOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
		if(iOS == false) {
			showHint('Link Copied');
		}
		//Google Analytics Event
		ga('send', 'event','trip', 'share-trip-via-link');
	}
	
	function shareViaWhatsapp() {
		if(ifMobileAndTablet() == true) {
		}
		else {
			showAlert('Limited to Mobile');
		}
		//Google Analytics Event
		ga('send', 'event','trip', 'share-trip-via-whatsapp');
	}
	
	function getShareLink() {
		
		
		
	}
	
	$("#modal-trip-share").on("show.bs.modal", function () {
		trip_id = $('#modal-trip-action-form input[name=trip_id]').val();
		
		<!-- START: set data -->
				var data = {
					"action":"get_share_link",
					"trip_id":trip_id
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					$('#modal-trip-share .modal-body textarea').val(json);
					
					var title = $('#wrapper-title-input').val();
					//var url = "<?php echo $link['preview']; ?>";
					var url = json;
					var text = encodeURIComponent('*' + title + '*') + '%0A' + encodeURIComponent(url);
					$('#modal-trip-share-button-whatsapp').attr('href','whatsapp://send?text='+text);
				}, "json");
			<!-- END -->		
			
		
		//Google Analytics Event
		ga('send', 'event','trip', 'open-modal-trip-share');
	});
</script>