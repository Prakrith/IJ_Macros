run("Duplicate...", "title=threshold");
run("Variance...", "radius=2");
run("Mean...", "radius=2");
run("Enhance Contrast...", "saturated=0.4");
selectWindow("threshold");
//run("Threshold...");
setAutoThreshold("Triangle dark");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Open");
run("Fill Holes");
run("Watershed");
//analyze
run("Set Measurements...", "area feret's limit redirect=None decimal=1");
run("Set Scale...", "distance=22.64 known=15.2 unit=uM");
run("Analyze Particles...", "size=176-1900 circularity=.5-1.00 display exclude clear add");