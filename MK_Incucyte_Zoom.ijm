//set all open images to 10x-incucyte scale, 1392x1040px -> 1700x1270um
run("Set Scale...", "distance=1040 known=1270 pixel=1 unit=um global"); 

//This duplicate is used to outline masked cells
//run("Duplicate...", "title=Duplicate duplicate range=1-24");

//This duplicate is used to analyze the cells
//run("Duplicate...", "title=Duplicate-1 duplicate range=1-24");
run("8-bit");

//Filter,thresh,mask
run("Gaussian Blur...", "sigma=.5 stack");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask", "method=Yen background=Light");

//Mask manipulation
run("Dilate", "stack");
run("Fill Holes", "stack");
run("Erode", "stack"); 

//results
run("Set Measurements...", "area perimeter mean shape stack limit display redirect=None decimal=3");
run("Analyze Particles...", "size=300-Infinity circularity=0.00-1.00 show=Outlines display exclude clear stack");


//Overlays masked outlines on "Duplicate" using the analyzed "Duplicate-1".
//Only does it on the first slice for stacks - best for single images.

//selectWindow("Duplicate-1");
//Change size to 75 for human
//run("Analyze Particles...", "size=300-Infinity circularity=0.00-1.00 show=Masks stack");

//run("Colors...", "foreground=yellow background=white selection=white");
//run("Create Selection");
//selectWindow("Duplicate");
//run("Restore Selection");
//run("Draw", "slice");
//run("Select None");
