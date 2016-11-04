<!-- START: Alert -->
	<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END -->

<!-- START: Content -->
	<?php echo $component['table']; ?>
<!-- END -->

<!-- START: Modal -->
	<?php echo $modal_add_photo; ?>
    <?php echo $modal_review_photo; ?>
    <?php echo $modal_edit_photo; ?>
	<?php echo $modal_delete_photo; ?>
<!-- END -->