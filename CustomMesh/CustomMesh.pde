

PImage myImage;

void setup(){
 
    size( 400, 400 );
}

void draw(){
  
    background( 0, 0, 60);
  
    stroke( 150, 0, 0);
    fill( 220, 200, 50);
    
    strokeWeight(15);
  
    beginShape();
    
    vertex( 50, 50 );
    vertex( width-50, 50 );
    vertex( width-50, height-50);
    vertex( 50, height-50);
    
    endShape(CLOSE);
}