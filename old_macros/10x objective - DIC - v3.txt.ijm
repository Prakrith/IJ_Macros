//original 10X Macro to analyze flMK
run("Duplicate...", "title=Duplicate duplicate range=1-26");

run("Duplicate...", "title=Duplicate-1 duplicate range=1-26");
run("8-bit");

run("Gaussian Blur...", "sigma=0.50 stack");

setThreshold(0, 105);
setOption( "BlackBackground", false);
run("Convert to Mask", "method=Yen background=Light");

run("Dilate", "stack");
run("Fill Holes", "stack");
run("Erode", "stack");

run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
run("Set Measurements...", "area feret's limit display redirect=None decimal=3");

setAutoThreshold("Default");
run("Analyze Particles...", "size=100-Infinity circularity=0.80-1.00 show=Outlines display exclude clear stack");

selectWindow("Duplicate-1");
run("Analyze Particles...", "size=100-Infinity circularity=0.8-1.00 show=Masks stack");


run("Colors...", "foreground=yellow background=white selection=white");
run("Create Selection");
selectWindow("Duplicate");
run("Restore Selection");
run("Draw", "slice");
run("Select None");
