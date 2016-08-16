<!-- START: Alert -->
	<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END -->

<!-- START: Content -->
	<?php echo $component['table']; ?>
<!-- END -->

<!-- START: Modal -->
	<?php echo $modal_add_day; ?>
    <?php echo $modal_review_day; ?>
    <?php echo $modal_edit_day; ?>
	<?php echo $modal_delete_day; ?>
<!-- END -->