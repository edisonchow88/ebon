<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
$keyword = $_REQUEST['keyword'];

$this->load->model('catalog/category','storefront');
$this->load->model('catalog/product', 'storefront');

$result = '';
$result .= '{';
$categories = $this->model_catalog_category->getCategoriesByKeyword($keyword);
$result .= '"category":';
	$result .= '[';
	$i = 0;
	$n = count($categories);
	foreach($categories as $category) {
		$i += 1;
		$path = $this->model_catalog_category->buildPath($category["category_id"]);
		$parent = $this->model_catalog_category->buildPathName($category["category_id"]);
		$result .= '{';
		$result .= '"category_id":"'.$category["category_id"].'"';
		$result .= ',';
		$result .= '"name":"'.$category["name"].'"';
		$result .= ',';
		$result .= '"link":"'.$this->html->getSEOURL('product/category','&path='.$path).'"';
		$result .= ',';
		$result .= '"parent":"'.$parent.'"';
		$result .= '}';
		if($i != $n) { $result .= ','; }
	}
	$result .= ']';
$result .= ',';

$products = $this->model_catalog_product->searchProductsByKeyword($keyword);
//$products = array(array("product_id"=>1,"name"=>"kiyo"));
$result .= '"product":';
	$result .= '[';
	$i = 0;
	$n = count($products);
	foreach($products as $product) {
		$i += 1;
		$path = $this->model_catalog_category->buildPath($product["category_id"]);
		$parent = $this->model_catalog_category->buildPathName($product["category_id"]);
		$result .= '{';
		$result .= '"product_id":"'.$product["product_id"].'"';
		$result .= ',';
		$result .= '"name":"'.$product["name"].'"';
		$result .= ',';
		$result .= '"link":"'.$this->html->getSEOURL('product/product','&path='.$path.'&product_id='.$product["product_id"]).'"';
		$result .= ',';
		$result .= '"parent":"'.$parent.'"';
		$result .= '}';
		if($i != $n) { $result .= ','; }
	}
	$result .= ']';
$result .= '}';
echo $result;
?>
