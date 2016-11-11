<style>
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-country-add" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-country-add-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-country-add">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Add Country</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header button-add-country" data-toggle="modal" data-target="#modal-country-add">Save</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<form class="mobile-form" id="modal-country-add-form">
                    		<div class="row">
                                <div class="col-xs-4"><label for="country_id" selected>Country</label></div>
                                <div class="col-xs-8">
                                    <select name="country_id">
                                        <?php
                                        	foreach($country as $key => $value) {
                                            	echo '<option value="'.$value['country_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                                
                                            }
                                        ?>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-country-add").on("show.bs.modal", function () {
		$('#modal-country-add-form select[name=country_id] option').show();
		$('.result-country-form').each(function() {
			var country_id = $(this).find('input[name=country_id]').val();
			$('#modal-country-add-form select[name=country_id] option[value='+country_id+']').hide();
		});
		$('#modal-country-add-form select[name=country_id] option').each(function () {
			if ($(this).css('display') != 'none') {
				$(this).prop("selected", true);
				return false;
			}
		});
	});
</script>