

PImage imageTex;

void setup(){

    size( 780, 400 , P2D);
    
    // load our texture
    imageTex = loadImage("no-21.jpg");
    
    // white outline
    noStroke();
}

void draw(){
  
   // disable the background
   //background(0);
   
   for(int i=0; i<5; i++){
   
       // create a custom shape
       beginShape(QUAD);
       
       // bind the texture
       texture(imageTex);
       
       // add vertices (arg1, arg2) and include texture coordinates (arg3, arg4)
       // coordinates are listed clockwise (TL, TR, BR, BL)
       
       float w = 50;
       w = random( 2, 100);
       float x = random(0, width-w);
       float y = random(0, width-w);
       
       float tx = random(0, width-w);
       float ty = random(0, width-w);
       
       // try offsetting each vertex coordinate
       // so that the composition isn't so rectilinear
       
       vertex( x, y, tx, ty);
       vertex( x+w, y, tx+w, ty);
       
       vertex( x+w, y+w, tx+w, ty+w);
       vertex( x, y+w, tx, ty+w);
      
       endShape();
   }
}