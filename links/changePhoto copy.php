<html>
<head>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-style: italic;
}
.style2 {font-size: 12px}
-->
</style>
<?php
function getFileExtension($str) {

        $i = strrpos($str,".");
        if (!$i) { return ""; }

        $l = strlen($str) - $i;
        $ext = substr($str,$i+1,$l);

        return $ext;

    } ?>
</head>
<body>
<?php
/*
 *v page allows users to request a photo change
 */
if(strpos($_SERVER["HTTP_REFERER"], "http;//oberlintest.blackboard.com") == 0){
	if($_FILES['file']['tmp_name']!="")
	{
		//Get destination folder
		$folder = '../Photos/requests/';
		$pext = getFileExtension($_FILES['file']['name']);
    	$pext = strtolower($pext);
    	if (($pext != "jpg")  && ($pext != "jpeg"))
    	{
			print "<h1>ERROR</h1>Image Extension Unknown.<br>";
			print "<p>Please upload only a JPEG image with the extension .jpg or .jpeg ONLY<br><br>";
			print "The file you uploaded had the following extension: $pext</p>\n";
	
			/*== delete uploaded file ==*/
			unlink($_FILES['file']['tmp_name']);
			exit();
    	}
		//-- RE-SIZING UPLOADED IMAGE
		$src = imagecreatefromjpeg($_FILES['file']['tmp_name']);
		list($width,$height)=getimagesize($_FILES['file']['tmp_name']);
		$newheight;
		$newwidth;
		if($height > $width){
			$newheight=150;
			$newwidth=($width/$height)*150;
		}
		else{
		 	$newwidth=150;
			$newheight=($height/$width)*150;
		}
		$tmp=imagecreatetruecolor($newwidth,$newheight);
		
		// this line actually does the image resizing, copying from the original
		// image into the $tmp image
		imagecopyresampled($tmp,$src,0,0,0,0,$newwidth,$newheight,$width,$height);
		
		// now write the resized image to disk.
		$filename = $folder. $_POST['uid']."__".$_POST['uemail'];
		if(imagejpeg($tmp,$filename,100)){
			echo "Your photo was successfully uploaded and is awaiting approval.";
		}
		else{
			echo "Could not upload photo. Please try again or email OCTET at octet@oberlin.edu.";
		}
		
		imagedestroy($src);
		imagedestroy($tmp); // NOTE: PHP will clean up the temp file it created when the request has completed.
		
	}
}
else
{
 echo "You appear to have navigated to this page in error.";
}
?>
</body>
</html>