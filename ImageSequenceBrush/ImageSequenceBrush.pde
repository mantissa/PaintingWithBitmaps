
PImage brushTex;

void setup(){
  
    size(600, 600);
  
    brushTex = loadImage("Brush.png");
  
    imageMode(CENTER);
  
    background(0);
}

void draw(){
  
    
}

void keyPressed(){
 
  if( key == 'c' ) background(0);
}

void mousePressed(){
 
    image(brushTex, mouseX, mouseY);
}

void mouseDragged(){
  
  image(brushTex, mouseX, mouseY);
}