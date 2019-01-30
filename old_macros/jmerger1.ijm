//////////////////////////////////////////////////////////////////////////////////////////
// README
//////////////////////////////////////////////////////////////////////////////////////////
// Name: jmerger1.txt
// Purpose: ImageJ macro for merging IF Microscopy data
// Date: 01/06/2016
// Author: Isaac Han
//////////////////////////////////////////////////////////////////////////////////////////
// This script was written to merge three microscopy images at a time where the three 
// files are black/white, red, and blue, captured in that order. For other colors/formats, 
// additional modifications to the script will need to be made.
//////////////////////////////////////////////////////////////////////////////////////////
// DIRECTIONS
//////////////////////////////////////////////////////////////////////////////////////////
// A few changes are necessary before running the macro.
// Data from the microscope is usually saved in a "[path/directory]/Acquired" format and 
// the subsequent images are saved with a number following the "Acquired" such as 
// "Acquired-2", "Acquired-3" etc. In order for the script to recognize the first file, 
// you must change the filename of the first file from "Acquired" to "Acquired-1".

// The file path of the directory(folder) the images you want merged must be input into 
// this script. The output composite images will also be saved into the same directory, 
// so it's important to have separate directories for each experiment or else this macro 
// will overwrite the previous experiment.

// In Windows, the file directory can be obtained by holding down the shift key, right 
// clicking on the  file (the first "Acquired-1" file) > "find" > "copy as path"

// In Mac OSX, select the image file, press "command-i" and copy the address following
// the "Where:". All the arrows will turn into backslashes when you paste it.

// Now paste the path between the two quotation marks after the "PATH = " below, 
// and add a "\" to the end for Windows, and "/" to the end for OSX.
//////////////////////////////////////////////////////////////////////////////////////////
PATH = "/Volumes/ITALIANO/ECM project/2016-2-15/3D/+ stauro/D3/"
//////////////////////////////////////////////////////////////////////////////////////////
// OSX Example: "/Users/isaac/Desktop/Work/Working Directory/011916/"
// PATH = "/Users/isaac/Desktop/Work/Imaging/1:6:2016/"
//////////////////////////////////////////////////////////////////////////////////////////
// The next step is to enter the number of files you have (the last Acquired-#). 
// Enter that below.
//////////////////////////////////////////////////////////////////////////////////////////
FILECOUNT = 20
//////////////////////////////////////////////////////////////////////////////////////////
// Example:
// FILECOUNT = 183

// Lastly, save this file (save as a different name if you want to keep track of changes),
// and go to ImageJ. 
// In the top menu go to Plugins > Macros > Run... and find this newly saved .txt
// The macro should now compile all your images in a "Composite-#.tif" format!
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

i = 0
x = 1
while (i < FILECOUNT/2) {
	open(PATH + "10x_NO_caspase_2000ms_" + x + ".tif");
	open(PATH + "10x_NO_DIC_100ms_" + x + ".tif");
	run("Merge Channels...", "c2=10x_NO_caspase_2000ms_" + x + ".tif c4=10x_NO_DIC_100ms_" + x + ".tif create");
//	run("Flatten");
	saveAs("Tiff", PATH + "Composite-" + 1 + i + ".tif");
	close();
	i = i + 1;
	x = x + 1;
   }