// This macro takes an input folder of tiff stacks and generates an output folder of the reshaped stacks
// ie: original_folder_stack_size = 1-48, new_folder_stack_1 = 1-24, new_folder_stack_2 = 12-24 etc...
Dialog.create("Format Stack");
Dialog.addSlider("First Slice:", 1, 200, 0); 
Dialog.addSlider("Last Slice:", 1, 200, 0);
Dialog.addSlider("Increment:", 1, 10, 0);
Dialog.show();
slice1 = Dialog.getNumber();
slice2 = Dialog.getNumber();
increment = Dialog.getNumber();

dir1 = getDirectory("1. Select Image Directory ");
list = getFileList(dir1);
dir2 = dir1+"Substacks"+File.separator;
File.makeDirectory(dir2);
if (!File.exists(dir2))
	exit("Unable to create directory");

setBatchMode(true); 
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length); //progress bar
	open(dir1+list[i]);	
title = getTitle();	
dotIndex = indexOf(title, ".");
name = substring(title, 0, dotIndex); //removes .tif

run("Make Substack...", "  slices=" + slice1 + "-" + slice2 + "-" + increment);
saveAs("tiff", dir2 + name);
}
setBatchMode(false); 