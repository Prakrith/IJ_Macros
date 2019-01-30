//This macro converts bit depths of all images in a folder.
  
//store img dir & imgs
dir1 = getDirectory("Select Image Directory ");
list = getFileList(dir1);
//create output dir in img dir
dir2 = dir1+"RGB"+File.separator;
File.makeDirectory(dir2);
if (!File.exists(dir2))
	exit("Unable to create directory");

setBatchMode(true);

//progress bar
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length); 
	open(dir1+list[i]);	

//remove .tif from image name	
title = getTitle();	
dotIndex = indexOf(title, ".");
name = substring(title, 0, dotIndex); 

run("RGB Color");
saveAs("Tif",dir2+name);
close();

}

setBatchMode(false);