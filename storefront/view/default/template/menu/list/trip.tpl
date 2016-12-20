<div class="page-menu">
    <div class="menu-shadow" style="display:none;" onclick="togglePageMenu();"></div>
    <ul class="menu menu-primary" style="display:none;">
        <li>
            <a href="<?php echo $link['list/trip/upcoming']; ?>">
                <i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#3C0;"></i>Upcoming
            </a>
        </li>
        <li>
            <a href="<?php echo $link['list/trip/past']; ?>">
                <i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#FA0"></i>Past
            </a>
        </li>
        <li>
            <a href="<?php echo $link['list/trip/invited']; ?>">
                <i class="fa fa-fw fa-lg fa-envelope"></i>Invited
            </a>
        </li>
        <li>
            <a href="<?php echo $link['list/trip/removed']; ?>">
                <i class="fa fa-fw fa-lg fa-trash"></i>Removed
            </a>
        </li>
    </ul>
</div>

<script>
	function togglePageMenu() {
		$('.page-menu .menu-shadow').fadeToggle();
		$('.page-menu .menu').slideToggle();
		$('.navbar-primary .fa-caret-down').toggleClass('fa-flip-vertical');
		$('body').toggleClass('modal-open');
	}
	
	function closePageMenu() {
		$('.page-menu .menu-shadow').fadeOut('slow');
		$('.page-menu .menu').slideUp();
		$('.navbar-primary .fa-caret-down').removeClass('fa-flip-vertical');
		$('body').removeClass('modal-open');
	}
	
	function closePageMenuInstant() {
		$('.page-menu .menu-shadow').hide();
		$('.page-menu .menu').hide();
		$('.navbar-primary .fa-caret-down').removeClass('fa-flip-vertical');
		$('body').removeClass('modal-open');
	}
</script>