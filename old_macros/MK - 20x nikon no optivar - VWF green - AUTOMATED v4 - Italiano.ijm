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
	run("Enhance Contrast", "saturated=0.35");
	run("Duplicate...", "title=MKs");
	run("Duplicate...", "title=FINAL");
	run("RGB Color");



	//Background Subtraction
	selectWindow("MKs");
	run("Set Scale...", "distance=3.5636 known=1 pixel=1 unit=um");
	run("Subtract Background...", "rolling=90 sliding disable");
	run("Enhance Contrast", "saturated=0.35");

	//Threshold Megakaryocytes
	run("Gaussian Blur...", "sigma=2");

	setAutoThreshold("Yen dark");
	run("Set Measurements...", "area feret's limit redirect=None decimal=1");
	run("Analyze Particles...", "size=3-Infinity circularity=0.1-1.00 show=Masks display clear add");


	//Fill Holes
	selectWindow("Mask of MKs");
	run("Fill Holes");
	run("Watershed");
			
	run("Set Measurements...", "area feret's limit redirect=None decimal=1");
	run("Analyze Particles...", "size=40.00-Infinity circularity=0.2-1.00 show=Masks display clear add exclude");



	run("Create Selection");
	selectWindow("FINAL");
	run("Restore Selection");

	//Color
	run("Colors...", "foreground=yellow background=white selection=yellow");
	run("Draw");

	//Close Windows
	selectWindow("Mask of MKs");
	close();
	selectWindow("MKs");
	close();
	selectWindow("Mask of Mask of MKs");
	close();





	//MKs
	selectWindow("FINAL");

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

