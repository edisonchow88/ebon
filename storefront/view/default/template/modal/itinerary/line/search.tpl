<style>
	#modal-line-search-input-keyword-wrapper {
		height:40px;
		padding:3px;
	}
	
	#modal-line-search-input-keyword {
		text-align:left;
		font-size:12px;
		border-radius:5px;
	}
	
	#modal-line-search-input-keyword-wrapper .btn-header {
		margin-top:-3px;
		color:#e93578;
	}
	
	#modal-line-search-button-clear {
		position:absolute;
		top:0;
		right:0;
		padding:0;
	}
	
	#modal-line-search-button-clear div {
		border-radius:5px;
		background-color:#FFF;
		margin:5px 0;
		padding:0 15px;
		line-height:30px;
		text-align:center;
	}
	
	#modal-line-search-no-result {
		background-color:#FFF;
		color:#777;
		padding:15px;
		font-size:12px;
	}
	
    .pac-container { 
		position:fixed !important;
		top:40px !important;
		margin-left:-3px !important;
		padding:0 1px 15px 1px !important;
		width:100% !important;
		max-width:400px !important;
        z-index: 10000 !important;
		border:none !important;
		border-radius:0 !important;
		box-shadow:none !important;
    }
	
	.pac-container.pac-logo.hdpi:after {
		margin-right:15px;
	}
	
	.pac-item {
		height:60px;
		border:none;
		border-bottom:solid thin #EEE;
		clear:both;
	}
	
	
	.pac-item:last-child {
		margin-bottom:15px;
	}
	
	.pac-item > span:first-child {
		float:left;
		width:15px;
		margin:20px 5px;
	}
	
	.pac-item > span {
		float:right;
		width:calc(100% - 40px);
		margin-top:5px;
	}
	.pac-item > span:last-child {
		margin-top:-10px;
	}
	
	.pac-icon {
	}
	
	.pac-item-query {
	}
</style>
<!-- START: Modal -->
    <div class="modal" id="modal-line-search" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar fixed-width">
            <div class="modal-content">
                <div class="modal-header">
                	<div class="modal-modal fixed-width" data-toggle="modal" data-target="#modal-line-search"></div>
                	<div id="modal-line-search-input-keyword-wrapper" class="row">
                    	<div class="col-xs-10" style="max-width:calc(100% - 80px);">
                        	<form id="modal-line-search-keyword-form">
                                <input id="modal-line-search-input-keyword" class="form-control" placeholder="Search"/>
                                <a id="modal-line-search-button-clear" class="btn btn-header"><div><i class="fa fa-fw fa-times-circle"></i><span class="sr-only">x</span></div></a>
                            </form>
                        </div>
                        <div class="col-xs-2 text-right">
                        	<a class="btn btn-header" data-toggle="modal" data-target="#modal-line-search">Cancel</a>
                        </div>
                    </div>
                    <div id="modal-line-search-no-result">
                    	Your search did not match any places.
                    </div>
                </div>
                <div class="modal-body">
                    <?php echo $modal_component['form']; ?>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$('#modal-line-search-button-clear').on('click', function() {
		$('#modal-line-search-input-keyword').val('');
		$('#modal-line-search-input-keyword').trigger('change');
		setTimeout(function() { $('#modal-line-search-input-keyword').focus(); }, 1);
	});
	
	$('#modal-line-search-input-keyword').on('keyup change', function() {
		if($('#modal-line-search-input-keyword').val() != '') {
			$('.pac-container').removeClass('hidden');
			$('#modal-line-search-button-clear').show();
		}
		else {
			$('.pac-container').addClass('hidden');
			$('#modal-line-search-button-clear').hide();
		}
	});
	
	$("#modal-line-search").on( "show.bs.modal", function() {
		setTimeout(function() { $('#modal-line-search-input-keyword').focus(); }, 1);
		$('.search-bar').hide();
		$('.search-bar-shadow').hide();
		$('#modal-line-search .modal-body').hide();
		$('#modal-line-search-button-clear').hide();
		$('#modal-line-search-no-result').hide();
		
	});
	
	$("#modal-line-search").on( "hidden.bs.modal", function() { 
		$('#modal-line-search-form-alert').html('');
		$('#modal-line-search-input-keyword').val('');
		$('#modal-line-search-input-keyword').trigger('change');
		setTimeout(function() { $('.search-bar input').blur(); }, 1);
		$('.search-bar').show();
		$('.search-bar-shadow').show();
	});
	
	//IMPORATNT: Disable form submit by enter key 
	$('#modal-line-search-keyword-form').on('keyup keypress', function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 13) { 
			e.preventDefault();
			return false;
		}
	});
</script>

