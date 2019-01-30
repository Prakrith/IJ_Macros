//Get image directories
rawDir=getDirectory("Choose Raw Data Folder")
resultDir=getDirectory("Choose Result Data Folder")

//Direct image analysis
list=getFileList(rawDir);
for(i=0; i<list.length; i++)
{
	run("Bio-Formats Importer", "open=["+rawDir+list[i]+"]");




	setBatchMode(true);
	//Raw image
	//name=getInfo("image.filename");



	
//Duplicate
	run("Remove Outliers...", "radius=20 threshold=50 which=Dark");
	run("Enhance Contrast", "saturated=0.4");
	run("Duplicate...", "title=ENDOs");
	run("Duplicate...", "title=FINAL");
	run("RGB Color");



	//ENDOs
	//Threshold
	selectWindow("ENDOs");
	run("Subtract Background...", "rolling=90 sliding disable");
	run("Maximum...", "radius=2");
	setAutoThreshold("Moments dark");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");	
	run("Dilate");		
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");
	run("Dilate");	
	run("Dilate");		
	run("Fill Holes");
	run("Erode");
	run("Erode");
	run("Erode");
	run("Erode");	
	run("Erode");
	run("Erode");	
	run("Erode");	
	run("Erode");	
	run("Erode");	
	run("Erode");		
	run("Erode");
	run("Erode");
	run("Erode");
	run("Erode");	
	run("Erode");
	run("Erode");	
	run("Erode");	
	run("Erode");	
	run("Erode");	
	run("Erode");		


	//Set Scale
	run("Set Scale...", "distance=3.5636 known=1 pixel=1 unit=um");

	//Threshold
	//run("Threshold...");
	run("Set Measurements...", "area feret's perimeter limit redirect=None decimal=1");
	run("Analyze Particles...", "size=50.00-Infinity circularity=0-1.00 show=Masks display exclude clear add");
	run("Create Selection");
	selectWindow("FINAL");
	run("Restore Selection");

	//Color
	run("Colors...", "foreground=red background=white selection=yellow");
	run("Draw");

	//Close Windows
	selectWindow("ENDOs");
	close();
	selectWindow("Mask of ENDOs");
	close();


	//MKs
	selectWindow("FINAL");



	//Background Subtraction
	//run("Subtract Background...", "rolling=90 sliding disable");
	//run("Enhance Contrast", "saturated=0.35");

	//Threshold Megakaryocytes
	//run("Median...", "radius=2");


	//Set Scale
	run("Set Scale...", "distance=3.5636 known=1 pixel=1 unit=um");

	//Scale Bar
	run("Scale Bar...", "width=25 height=4 font=0 color=White background=None location=[Lower Right] bold");





	//Save Data
	roiManager("Save", resultDir+list[i]+"_ROI.zip");
	
	selectWindow("Results");
	saveAs("Results", resultDir+list[i]+"_result.xls");

	selectWindow("FINAL");
	newname= substring(list[i],0, indexOf(list[i], ".tif") );
	saveAs("Tiff", resultDir+newname+"_mask.tif");

  run("Close All");
  roiManager("reset");
  run("Clear Results");
}

