<style>
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-archive" role="dialog">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-archive-header-general" class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a id="modal-trip-archive-button-edit" class="btn btn-header" onclick="openEditFavourite();">Edit</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">Archived Trips</span>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a id="modal-trip-archive-button-close" class="btn btn-header" data-toggle="modal" data-target="#modal-trip-archive"><i class="fa fa-fw fa-lg fa-times-circle"></i></a>
                        <span class="sr-only">Back</span>
                    </div>
                </div>
                <div id="modal-trip-archive-header-edit" class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a id="modal-trip-archive-button-edit" class="btn btn-header" onclick="closeEditFavourite();">Cancel</i></a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title"></span>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a id="modal-trip-archive-button-delete" class="btn btn-header disabled" onclick="deleteFavourite(); closeEditFavourite();">Delete</i></a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-bar">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                        <div id="modal-trip-archive-list"></div>
                        <div id="modal-trip-archive-list-empty">The list is empty.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
</script>