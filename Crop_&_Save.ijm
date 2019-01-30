// This macro allows you to click selections from your open (either flat-single,
//  or multi-channel) image, and saves them into a folder of your choice.

function cropROI();


macro "run" {

if(nImages>1) exit ("Close all but one image before proceeding.");
getDimensions(imageWidth, imageHeight, channels, slices, frames);  
if(slices>1) exit ("This image has "+slices+" slices. "+"A single image is required.");

//where to save cropped images
 dir = getDirectory("Choose folder to save cropped images:");
 if (dir=="") exit("No directory available.");

name=getTitle();
basename = substring(name,0,lengthOf(name)-4);

//Change this value to change size of cropped image
ROIsize=250;
//image numbering starts at
i=1;

leftButton=16; rightButton=4; shift=1; ctrl=2; alt=8;
x2=-1; y2=-1; z2=-1; flags2=-1;

	logOpened = false;
	print("Use the +/- keys on your keyboard to zoom in & out");
	print("End the macro by closing this window.");
	print("\n Saving crops to "+dir);
	//continue until log is closed	  
      while (!logOpened || isOpen("Log")) {
          getCursorLoc(x, y, z, flags);
		
		//only recalculate if the cursor or button is pressed has changed position
		if (x!=x2 || y!=y2 || z!=z2 || flags!=flags2) {

			//crop an ROI when a click is detected
			if(flags==16||flags==2){
				cropROI(x,y,ROIsize,basename,i);
				i++;

			}
            
              logOpened = true;
              startTime = getTime();
          }
          x2=x; y2=y; z2=z; flags2=flags;
          wait(100);
	}

  

}


function cropROI(x,y,size,basename,i){	

	roiWidth=size;
	roiHeight=size;
	getDimensions(imageWidth, imageHeight, channels, slices, frames);  
	
	
	if(x-roiWidth/2<0){left=0;}
	else if(x+roiWidth/2>imageWidth){left=imageWidth-roiWidth;}
	else{left=x-roiWidth/2;}
	
	if(y-roiHeight/2<0){top=0;}
	else if(y+roiHeight/2>imageHeight){top=imageHeight-roiHeight;}
	else{top=y-roiHeight/2;}				
	
	run("Specify...", "width="+roiWidth+" height="+roiHeight+" x="+left+" y="+top+" slice=5");
	run("Duplicate...", "title=crop duplicate channels=1-"+channels);
	selectWindow("crop");
	
	saveAs("Tiff", dir+basename+"-"+i+".tif");
	selectWindow(basename+"-"+i+".tif");
	close();
}
