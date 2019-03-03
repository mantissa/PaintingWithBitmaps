
// @note: install "video" library Sketch=>ImportLibrary=>AddLibrary 
import processing.video.*;

Capture cam;

Brush brushes[];

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
  
  brushes = new Brush[50];
  for(int i=0; i<brushes.length; i++){
    
    float x = random( width);
    float h = random( 30, 150);
    float y = random( 0, height-h);
    float speed = ceil(random( 1.0, 3.0));
    
    brushes[i] = new Brush(x, y, h, speed);
  }
  
  noStroke();
  background(0);
}

void draw() {
  
  //background(0);
  
  if (cam.available() == true) {
    
    cam.read();
  
    for(int i=0; i<brushes.length; i++){
     
        brushes[i].move();
        brushes[i].draw();
    }
  }
}