<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>

<?php echo $product_tabs ?>

<div id="content" class="panel panel-default">
    
    <div class="panel-heading col-xs-12">
    	<h2>Operating Hours</h2>
		<div class="primary_content_actions pull-right">
			<div class="btn-group mr10 toolbar">
				<a class="actionitem btn btn-primary lock-on-click tooltips" href="<?php echo $add_hour; ?>" title="<?php echo $button_add; ?>">
				<i class="fa fa-plus fa-fw"></i> Add New Operating Hour
				</a>
                
<!-- Disabled by TREVOL, 2016/02/04
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus fa-fw"></i> Add New Hour</button>
-->
                
			</div>
		</div>

	</div>

	<div class="panel-heading col-xs-12">
		<table class="table table-striped table-bordered">
            <tr>
            	<th>Status</th>
                <th>Date</th>
                <th>Day</th>
                <th>Time</th>
                <th>Description</th>
                <th style="width:100px;">Action</th>
            </tr>
            <?php foreach($hours as $hour) { ?>
                <tr>
                	<td><?php echo $hour['status']?></td>
                    <td><?php echo $hour['date']?></td>
                    <td><?php echo $hour['day']?></td>
                    <td><?php echo $hour['time']?></td>
                    <td><?php echo $hour['description']?></td>
                    <td>
                    	<a href="<?php echo $delete_hour[$hour['product_hour_id']]; ?>" class="btn btn-sm btn-default" title="Delete Hour"><i class="fa fa-trash fa-fw"></i></a>
                        <a href="<?php echo $edit_hour[$hour['product_hour_id']]; ?>" class="btn btn-sm btn-default" title="Edit Hour"><i class="fa fa-edit fa-fw"></i></a>
                    </td>
                </tr>
            <?php } ?>
		</table>
	</div>
    
    <div class="panel-heading col-xs-12">
    	<h2>Ticket</h2>
		<div class="primary_content_actions pull-right">
			<div class="btn-group mr10 toolbar">
				<a class="actionitem btn btn-primary lock-on-click tooltips" href="<?php echo $add_price; ?>" title="<?php echo $button_add; ?>">
					<i class="fa fa-plus fa-fw"></i> Add New Ticket
				</a>
			</div>
		</div>

	</div>
    
    <div class="panel-heading col-xs-12">
		<table class="table table-striped table-bordered">
            <tr>
                <th>Name</th>
            	<th>Condition</th>
                <th>Amount</th>
                <th style="width:100px;">Action</th>
            </tr>
            <?php foreach($prices as $price) { ?>
                <tr>
                	<td><?php echo $price['name']?></td>
                    <td><?php echo $price['condition']?></td>
                    <td><?php echo $price['amount']?></td>
                    <td>
                    	<a href="<?php echo $delete_price[$price['product_price_id']]; ?>" class="btn btn-sm btn-default" title="Delete Ticket"><i class="fa fa-trash fa-fw"></i></a>
                        <a href="<?php echo $edit_price[$price['product_price_id']]; ?>" class="btn btn-sm btn-default" title="Edit Ticket"><i class="fa fa-edit fa-fw"></i></a>
                    </td>
                </tr>
            <?php } ?>
		</table>
	</div>
    
<!-- Modal, Disabled by TREVOL, 2016/02/04
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Edit Operating Hours</h4>
          </div>
          <div class="modal-body">
            <form>
                <div class="panel-body panel-body-nopadding tab-content col-xs-12">
                    <div class="form-group">
                        <label class="col-sm-2 col-xs-11">Status <span class="required">*</span></label>
                        <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                        <div class="input-group afield col-sm-7 col-xs-12">
                            <select class="form-control col-sm-7 col-xs-12">
                                <option>Open</option>
                                <option>Closed</option>
                                <option>Temporarily Closed</option>
                            </select>                    
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-xs-11">Date <span class="required">*</span></label>
                        <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                        <div class="input-group afield col-sm-7 col-xs-12">
                            <select class="form-control col-sm-7 col-xs-12">
                                <option>Normal days</option>
                                <option>Specific dates</option>
                                <option>Specific months</option>
                            </select>
                            <div class="container-fluid">
                                <label class="col-sm-2 col-xs-11">Month <span class="required">*</span></label>
                                <select class="form-control col-sm-2 col-xs-6">
                                    <option>First day</option>
                                    <option>Early (between 1-10)</option>
                                    <option>Mid (between 11-20)</option>
                                    <option>Late (between 21-30)</option>
                                    <option>Last day</option>
                                </select>
                                <select class="form-control col-sm-2 col-xs-6">
                                    <option>January</option>
                                    <option>February</option>
                                    <option>March</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-xs-11">Day <span class="required">*</span></label>
                        <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                        <div class="col-sm-7 col-xs-12">
                            <div>Select All | Un-select All</div>
                            <div style="height:32px;"><input type="checkbox" checked/><span>&nbsp;Monday</span></div>
                            <div style="height:32px;"><input type="checkbox" checked/><span>&nbsp;Tuesday</span></div>
                            <div style="height:32px;"><input type="checkbox" checked/><span>&nbsp;Wednesday</span></div>
                            <div style="height:32px;"><input type="checkbox"/><span>&nbsp;Holidays</span><span>&nbsp;(Customise the list of holidays)</span></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-xs-11">Time <span class="required">*</span></label>
                        <span class="col-sm-1 col-xs-1" style="text-align:right; color:green;"><i class="fa fa-question" title="status"></i></span>
                        <div class="col-sm-7 col-xs-12">
                        	<div class="input-group afield">
                                <input class="form-control atext" type="time" value="00:00:00" />
                                <span style="display:table-cell; text-align:center; vertical-align:middle;">&nbsp;~&nbsp;</span>
                                <input class="form-control atext" type="time" value="23:59:00"  />
                            </div>
                        	<input type="checkbox" /><span> Whole day</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 col-xs-12">Description</label>
                        <div class="input-group afield col-sm-7 col-xs-12">
                            <input class="form-control atext" type="text" />
                        </div>
                        <span class="help-block field_err">Help</span>
                    </div>
                </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>
    </div>
</div>
-->