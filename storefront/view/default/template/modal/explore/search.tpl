<style>
	#modal-explore-search-input-keyword-wrapper {
		height:40px;
		padding:3px;
	}
	
	#modal-explore-search-input-keyword {
		text-align:left;
		font-size:12px;
		border-radius:5px;
	}
	
	#modal-explore-search-input-keyword-wrapper .btn-header {
		margin-top:-3px;
		color:#e93578;
	}
	
	#modal-explore-search-button-clear {
		position:absolute;
		top:0;
		right:0;
		padding:0;
	}
	
	#modal-explore-search-button-clear div {
		border-radius:5px;
		background-color:#FFF;
		margin:5px 0;
		padding:0 15px;
		line-height:30px;
		text-align:center;
	}
	
	#modal-explore-search-no-result {
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
    <div class="modal" id="modal-explore-search" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar">
            <div class="modal-content">
                <div class="modal-header">
                	<div id="modal-explore-search-input-keyword-wrapper" class="row">
                    	<div class="col-xs-10" style="max-width:calc(100% - 80px);">
                        	<form id="modal-explore-search-keyword-form">
                                <input id="modal-explore-search-input-keyword" class="form-control" placeholder="Search"/>
                                <a id="modal-explore-search-button-clear" class="btn btn-header"><div><i class="fa fa-fw fa-times-circle"></i><span class="sr-only">x</span></div></a>
                            </form>
                        </div>
                        <div class="col-xs-2 text-right">
                        	<a class="btn btn-header" data-toggle="modal" data-target="#modal-explore-search">Cancel</a>
                        </div>
                    </div>
                    <div id="modal-explore-search-no-result">
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
	$('#modal-explore-search-button-clear').on('click', function() {
		$('#modal-explore-search-input-keyword').val('');
		$('#modal-explore-search-input-keyword').trigger('change');
		setTimeout(function() { $('#modal-explore-search-input-keyword').focus(); }, 1);
	});
	
	$('#modal-explore-search-input-keyword').on('keyup change', function() {
		if($('#modal-explore-search-input-keyword').val() != '') {
			$('.pac-container').removeClass('hidden');
			$('#modal-explore-search-button-clear').show();
		}
		else {
			$('.pac-container').addClass('hidden');
			$('#modal-explore-search-button-clear').hide();
		}
	});
	
	$("#modal-explore-search").on( "show.bs.modal", function() {
		setTimeout(function() { $('#modal-explore-search-input-keyword').focus(); }, 1);
		$('#wrapper-explore-search').hide();
		$('#wrapper-explore-search-shadow').hide();
		$('#modal-explore-search .modal-body').hide();
		$('#modal-explore-search-button-clear').hide();
		$('#modal-explore-search-no-result').hide();
	});
	
	$("#modal-explore-search").on( "hidden.bs.modal", function() { 
		$('#modal-explore-search-form-alert').html('');
		$('#modal-explore-search-input-keyword').val('');
		$('#modal-explore-search-input-keyword').trigger('change');
		setTimeout(function() { $('#wrapper-explore-search input').blur(); }, 1);
		$('#wrapper-explore-search').show();
		$('#wrapper-explore-search-shadow').show();
	});
	
	//IMPORATNT: Disable form submit by enter key 
	$('#modal-explore-search-keyword-form').on('keyup keypress', function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 13) { 
			e.preventDefault();
			return false;
		}
	});
</script>

