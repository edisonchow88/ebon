<style>
	#modal-line-filter {
		z-index:15000;
	}
	
	#modal-line-filter label {
		background-color:#FFF;
		color:#999;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		font-weight:normal;
	}
	#modal-line-filter input, #modal-line-filter select {
		background-color:#FFF;
		color:#000;
		height:50px;
		width:100%;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		-webkit-appearance: none;
	}
	#modal-line-filter input:disabled {
		color:#999;
	}
	#modal-line-filter select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-filter" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-filter-header-add" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Set Filter</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-filter">Done</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<form id="modal-line-filter-form">
                        	<div class="row">
                                <div class="col-xs-4"><label for="country" selected>Country</label></div>
                                <div class="col-xs-8">
                                    <select name="country">
                                        <option value="all">All Countries</option>
                                        <?php
                                        	foreach($country as $key => $value) {
                                            	echo '<option value="'.$value['iso_code_2'].'">'.$value['name'].'</option>';
                                                
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