
run("16-bit");
run("Subtract Background...", "rolling=20");
setAutoThreshold("Triangle");
//run("Threshold...");
//setThreshold(0, 0);
run("Convert to Mask");
run("Fill Holes");
run("Analyze Particles...", "size=20000-Infinity show=Outlines display");
