<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesResourceImageUpload extends AController {

	public function main() {
		$request = $this->request->files;
		foreach($request as $e) {
			foreach($e as $key => $value) {
				$file[$key] = $value;
			}
		}
		
		$ds = DIRECTORY_SEPARATOR; 
		$file['tmp_name'] = str_replace('\/',$ds,$file['tmp_name']);
		
		$upload_directory = DIR_RESOURCE . $ds . "image" . $ds . "cropped" . $ds;
		$upload_file = $upload_directory . $file['name'];
		
		if (move_uploaded_file($file['tmp_name'], $upload_file)) {
			$result['alert'] = "Success: Image has been uploaded";
		} else {
			$result['alert'] = "Error: Please check the folder permission";
		}
		
		$response = json_encode($result);
		echo $response;		
	}
}