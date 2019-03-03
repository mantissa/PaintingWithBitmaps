

PImage imageTex;

void setup(){

    size( 400, 400 , P2D);
    
    // load our texture
    imageTex = loadImage("no-21.jpg");
    
    // white outline
    stroke(255);
}

void draw(){
  
   background(0);
   
   // create a custom shape
   beginShape(QUAD);
   
   // bind the texture
   texture(imageTex);
   
   // add vertices (arg1, arg2) and include texture coordinates (arg3, arg4)
   // coordinates are listed clockwise (TL, TR, BR, BL)
   
   vertex( 100, 100, 0+mouseX, mouseY);
   vertex( 300, 100, 200+mouseX, mouseY);
   
   vertex( 300, 300, 200+mouseX, mouseY+200);
   vertex( 100, 300, 0+mouseX, mouseY+200);

   endShape();
}