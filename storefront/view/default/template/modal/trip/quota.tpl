<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-quota" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Exceeded Quota</h4>
                </div>
            <div class="modal-body">
            	<div class='alert alert-danger'>
                    <b>WARNING: <span id="modal-trip-quota-alert-text">New trip cannot be created.</span></b>
                </div>
                <div style="padding:10px 15px;">
                    <span>You have reached the maximum number of trips for the current account. Please consider to upgrade your account or <a data-dismiss="modal" data-toggle="modal" data-target="#modal-trip-load">remove some of the trips</a>.</span>
                </div>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3 pull-right">
                            <button type="button" class="btn btn-block btn-primary" data-dismiss="modal" data-toggle="modal" data-target="#modal-account-upgrade">Upgrade Account</button>
                        </div>
                        <div class="pull-right line-spacer">
                        	<i class="fa fa-fw"></i>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-3 pull-right">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->