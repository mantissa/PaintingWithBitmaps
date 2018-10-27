
void setup(){
 
    size( 800, 300 );
}

void draw(){
 
    // use random seeds to 'seed' random numbers 
    // so that they're the same every frame
    randomSeed(0);
  
    // begin our custom shape (with type quad strip)
    beginShape(QUAD_STRIP);
  
    // step across the screen, 50 pixels at a time
    for( int i=50; i<=width-50; i+=50){
  
        // set the fill color (randomly)
        color c = color( random(255), random(255), random(255)); 
        fill(c);

        // add vertices in pairs: one below, one above
        vertex( i, height/2 - 80);
        vertex( i, height/2 + 80);
    }
    
    // end our custom shape
    endShape();
}