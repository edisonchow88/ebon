<!-- START: [button] -->
    <?php if($role_id == 1) { ?>
        <div id="wrapper-debug-button" class="btn btn-default" onclick="toggle_wrapper_debug();">
            Debug
        </div>
    <?php } ?>
<!-- END -->

<!-- START: [modal] -->
    <div id="wrapper-debug">
        <div id="wrapper-debug-modal-background" onclick="hide_wrapper_debug();">
        </div>
        <div id="wrapper-debug-modal-body" class="col-xs-12 col-sm-6 col-md-3">
            <div id="wrapper-debug-modal-shadow" class="box-shadow">
            </div>
            <div id="wrapper-debug-modal-content">
                <?php echo $modal_component['form']; ?>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: [script] -->
	<script>
        function toggle_wrapper_debug() {
            if(document.getElementById('wrapper-debug-modal-background').style.display == 'block') {
                hide_wrapper_debug();
            }
            else {
                show_wrapper_debug();
            }
        }
        
        function show_wrapper_debug() {
            $('#wrapper-debug').show();
            $('#wrapper-debug-modal-background').fadeIn();
            $('#wrapper-debug-modal-shadow').slideDown('fast');
            $('#wrapper-debug-modal-content').slideDown('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-debug-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-debug-icon').attr('data-original-title', 'Close Debug Menu');
            <!-- END -->
        }
        
        function hide_wrapper_debug() {
            $('#wrapper-debug-modal-background').fadeOut();
            $('#wrapper-debug-modal-shadow').slideUp('fast');
            $('#wrapper-debug-modal-content').slideUp('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-debug-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-debug-icon').attr('data-original-title', 'Open Debug Menu');
            <!-- END -->
        }
    </script>
<!-- END -->