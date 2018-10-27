

PImage imageTex;

void setup(){
 
    size( 400, 400 , P2D);
    imageTex = loadImage("no-21.jpg");
}

void draw(){
  
   background(200);
   
   noStroke();
   
   beginShape(TRIANGLE_STRIP);
   
   texture(imageTex);
   
   vertex( 0, 0, 0+mouseX, 0);
   vertex( 0, 200, 0+mouseX, 200);
   
   vertex( 200, 0, 200+mouseX, 0);
   vertex( 200, 200, 200+mouseX, 200);
   
   endShape();
}