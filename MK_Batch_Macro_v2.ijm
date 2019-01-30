//This macro analyzes proplatelet producing MKs from
//tiff stacks taken from the Incucyte Zoom.

Dialog.create("MK_Analysis");
Dialog.addSlider("Timepoints", 0, 72, 0);
Dialog.addCheckbox("Human MKs? -- [Default: Mouse]", false);
//Dialog.addCheckbox("20X? -- [Default: 10X]", false);
Dialog.show();
time = Dialog.getNumber();
human = Dialog.getCheckbox();
if (human==true) size = 5;
else size = 200;


//store dirs & files in vars
dir1 = getDirectory("Select Image Directory ");
//if (dir1=="") exit("No directory available.");
list = getFileList(dir1);
dir2 = dir1+"Results"+File.separator;
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

//set all open images to 10x-incucyte ZOOM scale, 1392x1040px [FLR: 1280x1024px], 1700x1270um [FLR: 1900x1520um]
// known = 387 & pixel = 0.61 for 20x; k = 1548, p = 1.22 for 10x.
run("Set Scale...", "distance=1040 known=387 pixel=0.61 unit=um global"); 

//filter,thresh,mask
run("8-bit");
run("Gaussian Blur...", "sigma=0.5 stack");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask", "method=Yen background=Light");

//mask manipulation
run("Dilate", "stack");
run("Fill Holes", "stack");
run("Erode", "stack");

//results
run("Set Measurements...", "area perimeter center shape stack limit display redirect=None decimal=3");
run("Analyze Particles...", "size=" + size + "-Infinity circularity=0.00-1.00 show=Outlines display exclude clear stack");


//save as csv, extension can be modified
saveAs("results",  dir2 + name + ".csv"); 
}
setBatchMode(false); 
