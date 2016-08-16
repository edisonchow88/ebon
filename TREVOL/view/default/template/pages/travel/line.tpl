<!-- START: Alert -->
	<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END -->

<!-- START: Content -->
	<?php echo $component['table']; ?>
<!-- END -->

<!-- START: Modal -->
	<?php echo $modal_add_line; ?>
    <?php echo $modal_review_line; ?>
    <?php echo $modal_edit_line; ?>
	<?php echo $modal_delete_line; ?>
<!-- END -->