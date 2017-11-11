
void setup(){
 
    size( 800, 300 );
}

void draw(){
 
    randomSeed(0);
  
    beginShape(QUAD_STRIP);
  
    for( int i=50; i<=width-50; i+=50){
  
        color c = color( random(255), random(255), random(255)); 
        fill(c);
      
        vertex( i, height/2 - 80);
        vertex( i, height/2 + 80);
    }
    
    endShape();
}