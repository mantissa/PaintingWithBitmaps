import processing.video.*;

Capture cam;

// @note: install "video" library Sketch=>ImportLibrary=>AddLibrary 

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[3]);
    cam.start();     
  }      
  
  noStroke();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  /*
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  */
  
  cam.loadPixels();
  
  // draw yourself pixelated
  int pixelSize = 20;
  
  
  
  for(int x=0; x<cam.width; x+=pixelSize){
      for(int y=0; y<cam.height; y+=pixelSize){
   
           int pos = y * cam.width + x;
           color c = cam.pixels[pos];
           
           fill(c);
           rect( x, y, pixelSize, pixelSize);
      }
  }
}