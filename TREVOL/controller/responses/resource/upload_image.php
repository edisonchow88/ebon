<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesResourceUploadImage extends AController {

	public function main() {
		$request = $this->request->files;
		foreach($request as $e) {
			foreach($e as $key => $value) {
				$file[$key] = $value;
			}
		}
		
		$ds = DIRECTORY_SEPARATOR; 
		$file['tmp_name'] = str_replace('\/',$ds,$file['tmp_name']);
		
		$result = $file;
		
		$result['warning'] = '';
		if($file['type'] != "image/jpeg" && $file['type'] != "image/png" && $file['type'] != "image/gif") {
			$result['warning'][] = "The file is not JPG or PNG or GIF.";
		}
		if($file['size'] > 2000000) {
			$result['warning'][] = "Size of the image exceeded 2 Mb.";
		}
		
		$response = json_encode($result);
		echo $response;		
	}
}