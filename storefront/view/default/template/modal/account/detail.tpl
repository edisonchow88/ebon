<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-account-detail" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
            	<div class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-account-detail"><i class="fa fa-fw fa-lg fa-times-circle"></i><span class="sr-only">Cancel</span></a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">My Account</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-dialog fixed-bar">
            <div class="modal-header-shadow"></div>
            <div class="modal-content">
                <div class="modal-body">
                    <div id="modal-account-detail-form-alert"></div>
                    <?php echo $modal_component['form']; ?>
                </div>
            </div>
        </div>
    </div>
<!-- END -->