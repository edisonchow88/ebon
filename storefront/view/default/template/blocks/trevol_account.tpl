<?php if (!$login) { ?>
  <li class="dropdown"><a href="<?php echo $account; ?>" class="top menu_account"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Hi, <?php echo $name; ?></a>
    <ul class=" dropdown-menu dropdown-menu-right pull-left">
        <li class="dropdown <?php if ( $password == $current) echo 'current'; ?>">
          <a href="<?php echo $password; ?>"><i class="fa fa-key fa-fw"></i>&nbsp; <?php echo $text_password; ?></a>
        </li>	
        
        <li class="dropdown <?php if ( $logout == $current) echo 'current'; ?>">
          <a href="<?php echo $logout; ?>"><i class="fa fa-lock fa-fw"></i>&nbsp;
            <?php echo $text_not.' '.$name.'? '.$text_logout; ?></a>
        </li>	  		
        
        <?php echo $this->getHookVar('customer_account_links'); ?>
    </ul>
  </li>
<?php } else { ?>
  <li class="dropdown"><a href="<?php echo $login; ?>"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Sign in</a>
    <ul class="dropdown-menu pull-left">
        <li class="dropdown">
          <a href="<?php echo $login; ?>">Sign Up</a>
        </li>
    </ul>
  </li>
<?php } ?>