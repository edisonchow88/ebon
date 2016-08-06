<!-- START: Modal -->
    <div class="modal fade" id="modal-account-login" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Log In</h4>
                </div>
            <div class="modal-body">
                <form id="modal-account-login-form">
                    <div id="modal-account-login-form-alert"></div>
                    <?php echo $modal_component['modal-login-form']; ?>
                </form>
            </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="login();">Log In</button>
                </div>
            </div>
        </div>
    </div>
<!-- END: Modal -->

<!--
<div class="col-sm-6 newcustomer">
	<h2 class="heading2"><?php echo $text_i_am_new_customer; ?></h2>
	<div class="loginbox">
		<h4 class="heading4"><?php echo $text_checkout; ?></h4>
		<?php echo $form1[ 'form_open' ]; ?>
		<fieldset>
			<div class="form-group mt20">
		      <?php echo $form1[ 'register' ];?>
			</div>
		<?php if ($guest_checkout) { ?>
			<div class="form-group mt20">
		      <?php echo $form1[ 'guest' ];?>
			</div>
		<?php } ?>
			<div class="form-group mt20 mb40">
		      <?php echo $text_create_account; ?>
			</div>
			<button type="submit" class="btn btn-orange pull-right"  title="<?php echo $form1['continue']->name ?>">
				<i class="<?php echo $form1['continue']->icon; ?> fa"></i>
				<?php echo $form1['continue']->name ?>
			</button>
		</fieldset>
		</form>
	</div>
</div> 

<div class="col-sm-6 returncustomer">
	<h2 class="heading2"><?php echo $text_returning_customer; ?></h2>
	<div class="loginbox form-horizontal">
		<h4 class="heading4"><?php echo $text_i_am_returning_customer; ?></h4>
		<?php echo $form2['form_open']; ?>
			<fieldset>
				<div class="form-group">
				  <label class="control-label col-sm-4">
				  <?php 
				  	if ($noemaillogin) {
				  		echo $entry_loginname; 
				  	} else {
				  		echo $entry_email_address;
				  	}
				  ?>
				  </label>
				  <div class="input-group col-sm-5">
					<?php echo $form2['loginname']?>
				  </div>
				</div>
				<div class="form-group">
				  <label class="control-label col-sm-4"><?php echo $entry_password; ?></label>
				  <div class="input-group col-sm-5">
					<?php echo $form2['password']?>
				  </div>
				</div>
				<a href="<?php echo $forgotten_pass; ?>"><?php echo $text_forgotten_password; ?></a>
				<?php if($noemaillogin) { ?>
				&nbsp;&nbsp;<a href="<?php echo $forgotten_login; ?>"><?php echo $text_forgotten_login; ?></a>
				<?php } ?>
				<br>
				<br>
				<button type="submit" class="btn btn-orange pull-right"  title="<?php echo $form2['login_submit']->name ?>">
					<i class="<?php echo $form2['login_submit']->{'icon'}; ?>"></i>
					<?php echo $form2['login_submit']->name ?>
				</button>
			</fieldset>
		</form>
	</div>
	<?php echo $this->getHookVar('login_extension'); ?>
</div>
-->