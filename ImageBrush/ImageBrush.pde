
PImage brushTex;

void setup(){
  
    size(600, 600);
  
    brushTex = loadImage("Brush.png");
  
    imageMode(CENTER);
  
    background(0);
}

void draw(){
  
    // nothing to see here
    // all the action happens in the event handlers
}

void keyPressed(){
 
  // when c pressed, clear the background
  if( key == 'c' ) background(0);
}

void mousePressed(){
 
    // when mouse pressed, draw a mark
    image(brushTex, mouseX, mouseY);
}

void mouseDragged(){
  
  // when mouse dragged, draw a mark
  image(brushTex, mouseX, mouseY);
}