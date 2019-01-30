// This macro semi-automates the analysis of stained histology slides using the IHC Toolbox (https://imagej.nih.gov/ij/plugins/ihc-toolbox/index.html) plugin.
// 1) Before running this macro, the user needs to train a model in the Toolbox using some images of your stained slides. Refer to the link for instructions.
// 2) When executing the macro, read through the comments to correctly run this analysis.
// ***Unfortunately the bulk of this is not automated, so users will have to monitor the macro to analyze each image.
// window_size: 25 seed_size: 220 final_size: 280 (liver MK)

setBatchMode(true);

// load array of all files inside input directory
dir = getDirectory("Choose Tiff Folder"); 
list = getFileList(dir);

//Set measurements
run("Set Measurements...", "area mean min median area_fraction display redirect=None decimal=0");
run("Bio-Formats Importer", "open=[" + dir + list[0] + "] color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");         

// Select"Read User Model", and be sure to click ok on the initial popup dialog. **Not automated at the moment.
run("IHC Toolbox", "");
waitForUser("User selects custom color detection model", "Select \"Read User Model\", open your text file, then click OK on this dialog.")
close()

for (i=0; i< list.length; i++) {

	print("Analyzing: "+ list[i]);
	
	// process tiff files only
	if (endsWith(list[i], ".tif") || endsWith(list[i], ".tiff"))  {
		 
		 // open each file with Bio-Formats and convert to RGB
         run("Bio-Formats Importer", "open=[" + dir + list[i] + "] color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");         
         run("RGB Color");

setBatchMode(false);

		// User clicks "Training" on IHC Toolbox. **Not automated at the moment.
		waitForUser("FOR NOW, user input is needed...", "Press \"Color\", then click OK when \"Stain Color Detection\" window appears.");

setBatchMode(true);
		
		selectWindow("Stain Color Detection");
		analyzedName = replace(replace(list[i],".tiff","_IHC-Analyzed.tiff"),".tif","_IHC-Analyzed.tif");
		print("Saving:  " + analyzedName);
		save(dir + analyzedName); // Save image to check the Color Detection result
		
		// Find % of interested color over entire sample
		run("Make Binary");
		run("Measure");
		setResult("Label", i*2, analyzedName);
        selectWindow(list[i] + " (RGB)");
        run("Make Binary");
		run("Measure");
		setResult("Label", (i*2)+1, list[i]);

		run("Close All");
	}
}

resultName = "IHC_Results.xls";
print("Saving:  " + resultName);
saveAs("Results", dir + resultName);

setBatchMode(false);
