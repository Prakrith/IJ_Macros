Dialog.create("Scratch_Wound_Analysis");
Dialog.addSlider("Timepoints", 0, 72, 0);
Dialog.show();
time = Dialog.getNumber();

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
name = substring(title, 0, dotIndex); 

run("16-bit");
run("Subtract Background...", "rolling=20");
setAutoThreshold("Triangle");
//run("Threshold...");
//setThreshold(0, 0);
run("Convert to Mask");
run("Fill Holes");
run("Analyze Particles...", "size=20000-Infinity show=Outlines display");

//////////////////////////////////////////////////////////////////////
//Need to edit the following code for what results need to be saved.//
//////////////////////////////////////////////////////////////////////

selectWindow("");
newname= substring(list[i],0, indexOf(list[i], ".tif") );
saveAs("Tiff", dir2+newname+"_mask.tif");

setBatchMode(false);