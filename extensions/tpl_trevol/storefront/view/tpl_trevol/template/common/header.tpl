<header>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand" href="<?php echo $homepage; ?>"><?php echo $store; ?></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <?php echo ${$children_blocks[1]}; ?>
      <?php echo ${$children_blocks[2]}; ?>
      <ul class="nav navbar-nav navbar-right">
        <li><?php echo ${$children_blocks[3]}; ?></li>
      </ul>
    </div>
  </div>
</nav>

<div style="margin-top:60px;"></div>

</header>