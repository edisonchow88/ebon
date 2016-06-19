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
		
		$response = json_encode($result);
		echo $response;		
	}
}