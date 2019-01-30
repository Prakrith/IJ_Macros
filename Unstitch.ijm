//This macro cuts a large image and save it to a folder.
macro "run"{

dir = getDirectory("Choose Results Folder");

run("Montage to Stack...", "images_per_row=10 images_per_column=10 border=0");
run("Stack to Images");

while(nImages>0){
	name=getTitle;
	saveAs("Tif",dir+name);
	close();
}
