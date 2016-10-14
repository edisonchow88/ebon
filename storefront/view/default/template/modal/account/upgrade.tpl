<style>
	#modal-account-upgrade table {
		margin-bottom:20px;
		width:100%;
		font-size:12px;
	}
	
	#modal-account-upgrade table thead {
	}
	
	#modal-account-upgrade table th, #modal-account-upgrade table td {
		padding:15px;
		text-align:center;
	}
	
	#modal-account-upgrade table thead th:first-child {
		text-align:left;
	}
	
	#modal-account-upgrade table tr td:first-child {
		text-align:left;
	}
	
	#modal-account-upgrade table tr td:last-child {
		text-align:right;
	}
	
	#modal-account-upgrade table tr {
		border-bottom:solid thin #999;
	}
	
	#modal-account-upgrade table tr.selected {
		background-color:#FFC;
	}
	
	#modal-account-upgrade table .btn-default.disabled {
		opacity:1;
	}
</style>

<!-- START: Modal -->
    <div class="modal fade" id="modal-account-upgrade" role="dialog" data-backdrop="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Plans &#38; Pricing</h4>
                </div>
            <div class="modal-body">
                <table>
                	<thead>
                        <th>Plan</th>
                        <th>Trips</th>
                        <th>Archive</th>
                        <th>Privacy</th>
                        <th>Price</th>
                        <th></th>
                    </thead>
                    <tbody>
                    	<?php if($role_id == 2) { echo '<tr class="selected">'; } else { echo '<tr>'; } ?>
                        	<td>Free</td>
                            <td>3</td>
                            <td>10</td>
                            <td><i class="fa fa-fw fa-unlock-alt text-danger" data-toggle="tooltip" data-placement="top" title="No private setting"></i></td>
                            <td>$0 / mo</td>
                            <td>
                            	<?php 
                                	if($role_id == 2) { 
                                    	echo '<a class="btn btn-block btn-default btn-sm disabled">Current Plan</a>'; 
                                    } else { 
                                    	echo '<a class="btn btn-block btn-primary btn-sm">Select Plan</a>'; 
                                    } 
                                ?>
                            </td>
                        </tr>
                        <?php if($role_id == 3) { echo '<tr class="selected">'; } else { echo '<tr>'; } ?>
                        	<td>Standard</td>
                            <td>10</td>
                            <td>50</td>
                            <td><i class="fa fa-fw fa-lock text-success" data-toggle="tooltip" data-placement="top" title="Enable private setting"></i></td>
                            <td>$19 / mo</td>
                            <td>
                            	<?php 
                                	if($role_id == 3) { 
                                    	echo '<a class="btn btn-block btn-default btn-sm disabled">Current Plan</a>'; 
                                    } else { 
                                    	echo '<a class="btn btn-block btn-primary btn-sm">Select Plan</a>'; 
                                    } 
                                ?>
                            </td>
                        </tr>
                        <?php if($role_id == 4) { echo '<tr class="selected">'; } else { echo '<tr>'; } ?>
                        	<td>Premium</td>
                            <td>50</td>
                            <td>200</td>
                            <td><i class="fa fa-fw fa-lock text-success" data-toggle="tooltip" data-placement="top" title="Enable private setting"></i></td>
                            <td>$29 / mo</td>
                            <td>
                            	<?php 
                                	if($role_id == 4) { 
                                    	echo '<a class="btn btn-block btn-default btn-sm disabled">Current Plan</a>'; 
                                    } else { 
                                    	echo '<a class="btn btn-block btn-primary btn-sm">Select Plan</a>'; 
                                    } 
                                ?>
                            </td>
                        </tr>
                        <?php if($role_id == 5) { echo '<tr class="selected">'; } else { echo '<tr>'; } ?>
                        	<td>Business</td>
                            <td>200</td>
                            <td>Unlimited</td>
                            <td><i class="fa fa-fw fa-lock text-success" data-toggle="tooltip" data-placement="top" title="Enable private setting"></i></td>
                            <td>$49 / mo</td>
                            <td>
                            	<?php 
                                	if($role_id == 5) { 
                                    	echo '<a class="btn btn-block btn-default btn-sm disabled">Current Plan</a>'; 
                                    } else { 
                                    	echo '<a class="btn btn-block btn-primary btn-sm">Select Plan</a>'; 
                                    } 
                                ?>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->