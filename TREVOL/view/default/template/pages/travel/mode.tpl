<!-- START: Alert -->
	<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END -->

<!-- START: Content -->
	<?php echo $component['table']; ?>
<!-- END -->

<!-- START: Modal -->
	<?php echo $modal_add_mode; ?>
    <?php echo $modal_review_mode; ?>
    <?php echo $modal_edit_mode; ?>
	<?php echo $modal_delete_mode; ?>
<!-- END -->