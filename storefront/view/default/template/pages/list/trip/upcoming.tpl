<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-main">
        <div class="col-xs-3 text-left">
            <a class="btn" data-toggle="modal" data-target="#modal-home-menu" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-bars"></i></a>
        </div>
        <div class="col-xs-6 text-center">
            <a onclick="togglePageMenu();"><h1>Upcoming</h1><i class="fa fa-fw fa-caret-down"></i></a>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn" data-toggle="modal" data-target="#modal-trip-search" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-search"></i></a>
        </div>
    </div>
    <?php echo $menu_list_trip; ?>
    <div class="row navbar navbar-secondary navbar-general">
        <div class="col-xs-6 text-left">
            <a class="btn btn-edit-trip" onclick="openEditTrip();">Edit</a>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn" href="<?php echo $link['trip/new']; ?>">Add Trip</a>
        </div>
    </div>
    <div class="row navbar navbar-secondary navbar-edit hidden">
        <div class="col-xs-6 text-left">
            <a class="btn" onclick="closeEditTrip();">Done</a>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-remove-trip disabled" onclick="removeTripMulti();">
            	<?php 
                	if($this->user->isLogged() == false) { 
                    	echo 'Delete';
                    }
                    else {
                    	echo 'Remove';
                    }
                ?>
            </a>
        </div>
    </div>
</div>
<div class="content-body-loading fixed-width">
    <div class="col-xs-12">
        <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
    </div>
</div>
<div class="content-body-empty fixed-width">
    <div class="col-xs-12">
    	<div><b>No Upcoming Trip</b></div>
        <div>Click to create a <a href="<?php echo $link['trip/new']; ?>">new trip</a></div>
    </div>
</div>
<div class="content-body fixed-width">
	<div class="navbar navbar-shadow"></div>
    <div class="navbar navbar-shadow"></div>
    <div class="row navbar navbar-quaternary">
        <div class="col-xs-6 text-left">
            <span class="text-sub">Sort by</span>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-sort-trip" data-toggle="modal" data-target="#modal-trip-sort">&darr;; DATE</a>
        </div>
    </div>
    <div class="content-body-alert"></div>
    <div class="content-body-result la la-70 la-border noselect">
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_home_menu; ?>
    <?php echo $modal_trip_search; ?>
    <?php echo $modal_trip_sort; ?>
    <?php echo $modal_trip_action; ?>
<!-- END -->

<!-- START: [script] -->
	<?php echo $script_list_trip; ?>
<!-- END -->

<script>
	refreshTrip();
</script>