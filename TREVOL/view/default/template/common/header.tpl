<?php if ($logged) { ?>
	<div>

	<div class="navbar navbar-fixed-top headerbar">
    
    	<div class="header-left">
			<ul class="headermenu">
                <li class="hidden-xs">
					<div class="btn-group">
						<a href="<?php echo $home; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Home">TREVOL
						</a>
					</div>
				</li>
                <li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['destination']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Destination">
							<i class="fa fa-map-marker fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['interest']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Interest">
							<i class="fa fa-gratipay fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['poi']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Poi">
							<i class="fa fa-camera-retro fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['tag']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Tag">
							<i class="fa fa-tag fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                 <li>
					<div class="btn-group">
						<a href="<?php echo $link['image']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Image">
							<i class="fa fa-picture-o fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['user']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="User">
							<i class="fa fa-user fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['dataset']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Dataset">
							<i class="fa fa-book fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['database']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Database">
							<i class="fa fa-database fa-lg"></i><span class="hidden-sm hidden-xs"></span>
						</a>
					</div>
				</li>
				<li>
					<div class="btn-group">
						<a href="<?php echo $link['store']; ?>" target="_blank" class="btn btn-default tp-icon"  data-toggle="tooltip" data-placement="bottom" title="store">
							<span>Store</span>
						</a>
					</div>
				</li>
			</ul>
		</div>

		<div class="header-right">
			<ul class="headermenu">
                <li>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							<i class="fa fa-user fa-lg"></i>
							<span class="hidden-sm hidden-xs"><?php echo $username; ?></span>
							<span class="caret"></span>
						</button>

						<div class="dropdown-menu dropdown-menu-head pull-right">
							<ul class="dropdown-list gen-list">
								<li><a href="<?php echo $link['logout']; ?>"><i
												class="fa fa-unlock"></i><?php echo $text_logout; ?></a></li>
							</ul>
						</div>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['language']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Language">
							<i class="fa fa-language fa-lg"></i>
						</a>
					</div>
				</li>
                <li>
					<div class="btn-group">
						<a href="<?php echo $link['log']; ?>" class="btn btn-default tp-icon" data-toggle="tooltip" data-placement="bottom" title="Log">
							<i class="fa fa-exclamation-triangle fa-lg"></i>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<!-- header-right -->

	</div><!-- headerbar -->

	<!-- modals location outside of headerbar -->
	<?php if ($config_voicecontrol) { ?>
		<?php include($template_dir . '/template/common/voice_controls.tpl'); ?>
	<?php } ?>
	<?php
		echo $this->html->buildElement(
			array(	'type' => 'modal',
					'id' => 'message_modal',
					'modal_type' => 'lg',
					'data_source' => 'ajax'));
	?>
	
    <div style="margin-top:50px;"></div>
    
    <!-- DISABLED by TREVOL, 2016/01/24
	<div class="pageheader">
		<?php
		$current = '';
		$breadcrumbs_html = '';
		foreach ($breadcrumbs as $breadcrumb) {
			$breadcrumbs_html .= '<li>';
			if ($breadcrumb['current']) {
				$current = $breadcrumb;
				$breadcrumbs_html .= $breadcrumb['icon'] . $breadcrumb['text'];
			} else {
				$breadcrumbs_html .= '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['icon'] . $breadcrumb['text'] . '</a>';
			}
			$breadcrumbs_html .= '</li>';
		}
		?>
		<h2>
			<?php if ($current_menu['icon']) { ?>
				<?php echo $current_menu['icon']; ?>
			<?php } else { ?>
			<i class="fa fa-th-list"></i>
				<?php } ?>
			<?php if ($current && $current['text']) {
				echo $current['text'];
			} else {
				echo $heading_title;
			} ?>
			<?php if ($current && $current['sub_text']) { ?>
				<span><?php echo $current['sub_text']; ?></span>
			<?php } ?>
		</h2>

		<?php if ($breadcrumbs && count($breadcrumbs) > 1) { ?>
			<div class="breadcrumb-wrapper">
				<ol class="breadcrumb">
					<?php echo $breadcrumbs_html; ?>
				</ol>
			</div>
		<?php } ?>
	</div>
    -->
</div>
<script type="text/javascript">
$(document).ready(function () {
		
	<?php if (count($breadcrumbs) <= 1 && $ant) { ?>
	//register ant shown in dashboard 
	updateANT('<?php echo $mark_read_url; ?>');
	<?php } ?>
	
	//global seach section 
	$("#global_search").chosen({'width':'260px','white-space':'nowrap'});

	$("#global_search").ajaxChosen({
	    type: 'GET',
	    url: '<?php echo $search_suggest_url; ?>',
	    dataType: 'json',
		jsonTermKey: "term",
		keepTypingMsg: "<?php echo $text_continue_typing; ?>",
		lookingForMsg: "<?php echo $text_looking_for; ?>"   
	}, function (data) {
		if(data.response.length < 1) {
			$("#searchform").chosen({no_results_text: "<?php echo $text_no_results; ?>"});
			return '';
		}
		//build result array 
		var dataobj = new Object;
	    $.each(data.response, function (i, row) {
	    	if(!dataobj[row.category]){
	    		dataobj[row.category] = new Object;
	    		dataobj[row.category].name = row.category_name;
	    		dataobj[row.category].icon = row.category_icon;
	    		dataobj[row.category].items = [];
	    	}
	    	//if controller present need to open modal 
	    	var onclick = 'onClick="window.open(\''+row.page+'\');"';
	    	if (row.controller) {
	    		onclick = ' data-toggle="modal" data-target="#message_modal"' + 'href="'+row.controller+'" ';
	    	}
	    	var html = '<a '+onclick+' "class=search_result" title="'+row.text+'">'+ row.title + '</a>';
			dataobj[row.category].items.push({ value: row.order_id, text: html });
	    });
	    var results = [];
	    var serch_action = '<?php echo $search_action ?>&search=' + $('#global_search_chosen input').val();
	    var onclick = 'onClick="window.open(\''+serch_action+'\');"';
	    results.push({ 
	    	value: 0,
	    	text: '<div class="text-center"><a '+onclick+' class="btn btn-deafult"><?php echo $search_everywhere; ?></a></div>'
	    });
	    $.each(dataobj, function (category, datacat) {
	    	var url = serch_action + '#' + category;
	    	var onclick = 'onClick="window.open(\''+url+'\');"';
	    	var header = '<span class="h5">'+searchSectionIcon(category)+datacat.name+'</span>';
	    	//show more result only if there are more records
	    	if(datacat.items.length == 3) {
	    		header += '<span class="pull-right"><a class="more-in-category" '+onclick+'><?php echo $text_all_matches;?></a></span>';
	    	}
	    	results.push({ 
				group: true,
				text: header, 
				items: datacat.items
			});    	
		});
		//inbind chosen click events 
		$('#global_search_chosen .chosen-results').unbind();
		
		return results;
	});
		
	<?php if(!$home_page) { ?>
	$(window).on('load',function(){
		setTimeout(
			function() {
				$('.ant_window').addClass('open'); //show with delay
				setTimeout(	function() {$('.ant_window').removeClass('open')}, 6000); //hide
			}, 1500
		);
	});

	<?php } ?>
	//update ANT Viewed message only on click
	$('.ant_window button').click(function (event) {
		updateANT('<?php echo $mark_read_url; ?>');
	});
	
	//process side tabs ajax
	$('#right_side_view').click(function (event) {
		//right side not opened yet? load data for first tab
		if(!$('body').hasClass('stats-view')) {
			loadAndShowData('<?php echo $latest_customers_url; ?>', $('#rp-alluser'));
		}
	});

	$('.rightpanel').on('shown.bs.tab', function (e) {
	  var target = $(e.target).attr("href");
	  if(target == '#rp-alluser') {
		loadAndShowData('<?php echo $latest_customers_url; ?>', $('#rp-alluser'));  	
	  } else if(target == '#rp-orders') {
		loadAndShowData('<?php echo $latest_orders_url; ?>', $('#rp-orders'));  		  
	  }
	});
			
});
</script>

<?php } else { ?><!-- not logged in -->

	<div class="mainpanel no-columns">

	<div class="pageheader">
		<div class="logopanel">
			<a href="<?php echo $home; ?>">
				TREVOL
			</a>
		</div>
		<!-- logopanel -->
	</div>

	<script type="text/javascript">
		//remove cokies if loged out
		$(document).ready(function () {
			$.removeCookie("sticky-header");
			$.removeCookie("sticky-leftpanel");
			$.removeCookie("leftpanel-collapsed");
		});
	</script>

<?php } ?>