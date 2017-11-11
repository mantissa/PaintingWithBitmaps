
Gesture [] gestures;
PImage img;


void setup() {

  size(790, 800, P2D); // for no-21
  //size(1067, 800, P2D); // for maxresdefault
  hint(DISABLE_DEPTH_TEST);
  
  //strokeWeight(1);
  
  // load the image
  img = loadImage("no-21.jpg");
  //img = loadImage("maxresdefault.jpg");
  
  // load pixels into memory for access
  img.loadPixels();

  // create 'gestures'
  gestures = new Gesture[180];
  for(int i=0; i<gestures.length; i++){
    gestures[i] = new Gesture();
  }
}

void draw() {
  
  background(127);
  
  // draw background (optional);
  image(img, 0, 0);
  
  float t = float(millis())/1000;
  
  for(Gesture g : gestures ){
    
    // update
    g.move(t);
    
    // draw
    g.draw(t);
    
    // check if 'dead'
    if(g.isEnded){
        g.reset();
    }
  }
}