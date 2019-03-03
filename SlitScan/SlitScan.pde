
// @note: install "video" library Sketch=>ImportLibrary=>AddLibrary 
import processing.video.*;

Capture cam;

int scanX;

void setup() {
  
  size(640, 480, P3D);

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
  
  //background(0);
  
  if (cam.available() == true) {
    
    cam.read();
  
    beginShape(QUAD);
    texture(cam);
    vertex( scanX, 0, width/2, 0 );
    vertex( scanX+1, 0, width/2+1, 0);
    vertex( scanX+1, height, width/2+1, height);
    vertex( scanX, height, width/2, height);
    endShape(CLOSE);
    
    if( ++scanX == width ){
     
        scanX = 0;
    }
  }
}