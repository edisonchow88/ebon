<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<?php if ($dt_attention) { ?>
	<div class="info alert alert-warning"><i class="fa fa fa-exclamation-triangle fa-fw"></i> <?php echo $dt_attention; ?></div>
<?php } ?>
<?php echo $dev_tabs ?>
<?php echo $prj_tabs ?>

<div id="content" class="panel panel-default">
	<?php echo $form['form_open']; ?>
	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
			<?php foreach ($form['fields'] as $section => $fields) { ?>
			<label class="h4 heading" id="<?php echo $section;?>"><?php echo ${'developer_tools_tab_' . $section.'_section'}; ?></label>
				<?php foreach ($fields as $name => $field) {

				if(is_array($field)){
					$widthcasses = "col-sm-7 col-xs-12";
				}else{
					//Logic to calculate fields width
					$widthcasses = "col-sm-7";
					if(is_int(stripos($field->style, 'large-field'))){
						$widthcasses = "col-sm-7";
					} else if(is_int(stripos($field->style, 'medium-field')) || is_int(stripos($field->style, 'date'))){
						$widthcasses = "col-sm-5";
					} else if(is_int(stripos($field->style, 'small-field')) || is_int(stripos($field->style, 'btn_switch'))){
						$widthcasses = "col-sm-3";
					} else if(is_int(stripos($field->style, 'tiny-field'))){
						$widthcasses = "col-sm-2";
					}
					$widthcasses .= " col-xs-12";
				} ?>
			<div class="form-group <?php if (!empty($error[$name])) { echo "has-error"; } ?>">
				<label class="control-label col-sm-3 col-xs-12" for="<?php echo $field->element_id; ?>"><?php echo ${'developer_tools_entry_' . $name}; ?></label>
				<div id="<?php echo $name?>" class="input-group afield <?php echo $widthcasses; ?> <?php echo ($name == 'description' ? 'ml_ckeditor' : '')?>">
					<?php
						echo $field;
					?>
				</div>
			    <?php if (!empty($error[$name])) { ?>
			    <span class="help-block field_err"><?php echo $error[$name]; ?></span>
			    <?php } ?>
			</div>
				<?php }  ?><!-- <div class="fieldset"> -->
			<?php }  ?>
	</div>

	<div class="panel-footer col-xs-12">
		<div class="text-center">
			<button class="btn btn-primary lock-on-click">
			<i class="fa fa-save fa-fw"></i> <?php echo $form['submit']->text; ?>
			</button>
			<a class="btn btn-default" href="<?php echo $cancel; ?>">
			<i class="fa fa-arrow-left fa-fw"></i> <?php echo $form['cancel']->text; ?>
			</a>
		</div>
	</div>
	</form>

</div>