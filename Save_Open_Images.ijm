macro "OpenSave"{ //run

dir = getDirectory("Choose Results Folder");

while(nImages>0){
	name=getTitle;
	saveAs("Tif",dir+name);
	close();
}
