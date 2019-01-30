//This macro takes a folder of large images, cuts them, and saves
//them into another folder.

//store dirs & files in vars
dir1 = getDirectory("Select Image Directory ");
list = getFileList(dir1);
dir2 = dir1+"Unstitched"+File.separator;
File.makeDirectory(dir2);
if (!File.exists(dir2))
	exit("Unable to create directory");
	
setBatchMode(true); 

//progress bar
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length); 
	open(dir1+list[i]);	
title = getTitle();	
dotIndex = indexOf(title, ".");
//removes .tif
img_name = substring(title, 0, dotIndex); 

// change images_per_* arguments for different size unstitches.
run("Montage to Stack...", "images_per_row=10 images_per_column=10 border=0");
selectWindow(title);
close();
selectWindow("Stack");
run("Stack to Images");

while(nImages>0){
	save_name = img_name + "_" + nImages;
	saveAs("Png", dir2+save_name);
	close();
}
}
setBatchMode(false); 
