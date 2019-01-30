run("Subtract Background...", "rolling=50 light");
run("Enhance Contrast...", "saturated=0.4");
run("8-bit");
run("Invert");
//run("Threshold...");
//setThreshold(163, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Fill Holes");
run("Open");
run("Set Measurements...", "feret's redirect=None decimal=1");
run("Analyze Particles...", "size=700-Infinity display exclude clear add");

