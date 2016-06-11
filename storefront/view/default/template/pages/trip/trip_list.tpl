<h1 class="heading1">
	<span class="maintext"><i class="fa fa-suitcase"></i><?php echo $heading_title; ?></span>
</h1>

<?php if ($success) { ?>
	<div class="alert alert-success">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<?php echo $success; ?>
	</div>
<?php } ?>

<?php if ($error) { ?>
<div class="alert alert-error alert-danger">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<?php echo $error; ?>
</div>
<?php } ?>

<div class="panel panel-default">
    
	<div class="panel-heading col-xs-12">
		<div class="primary_content_actions pull-right">
			<div class="btn-group mr10 toolbar">
				<a class="actionitem btn btn-primary lock-on-click tooltips" href="<?php echo $add; ?>" title="<?php echo $button_add; ?>">
				<i class="fa fa-plus fa-fw"></i>
				</a>
			</div>
		</div>

	</div>

	<div class="contentpanel">
    	<div>Total Trips: <?php echo $this->data['total_trips'];?></div>
        
		<table class="table table-striped table-bordered">
            <tr>
            	<th>Trip ID</th>
                <th>Date</th>
                <th>Trip Name</th>
                <th>Action</th>
            </tr>
            <?php foreach($trips as $trip) { ?>
                <tr>
                    <td><?php echo $trip['trip_id']?></td>
                    <td><?php echo $trip['date_start']?></td>
                    <td><?php echo $trip['trip_name']?></td>
                    <td>
                    	<a href="<?php echo $delete.$trip['trip_id']; ?>" class="btn btn-sm btn-default" title="Delete trip"><i class="fa fa-trash fa-fw"></i></a>
                        <a href="" class="btn btn-sm btn-default" title="Print itinerary"><i class="fa fa-print fa-fw"></i></a>
                        <a href="<?php echo $edit.$trip['trip_id']; ?>" class="btn btn-sm btn-default" title="Edit trip"><i class="fa fa-edit fa-fw"></i></a>
                        <a href="<?php echo $view.$trip['trip_id']; ?>" class="btn btn-sm btn-default" title="View itinerary"><i class="fa fa-list fa-fw"></i></a>
                    </td>
                </tr>
            <?php } ?>
		</table>
	</div>

</div>