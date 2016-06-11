<?php


if (! defined ( 'DIR_CORE' )) {
header ( 'Location: static_pages/' );
}




$file = DIR_EXT . '/tpl_trevol/layout.xml';
$layout = new ALayoutManager('default');
$layout->loadXml(array('file' => $file));
