
// setup the processing sketch

void setup(){
 
    // create a window with dimensions w & h
    size(800, 400);
    
    // set the frame rate to 30 FPS
    frameRate(30);
    
    // disable stroke around circle
    noStroke();
}

// draw function (called 30x/sec)

void draw(){
  
    if( mousePressed ){
      
      for(int i=0; i<10; i++){
       
          // calculate brush elements randomly
          float w = random(1, 10); // width
          float x = random(-10, 10); // x offset +/-
          float y = random(-10, 10); // y offset +/-
          float a = random(50, 200); // alpha 
          
          // set the draw color
          fill( 255, a);
        
          // draw an ellipse close to the mouse position
          // with the random w 
          ellipse(mouseX+x, mouseY+y, w, w);
      }
    }
}

// called when you press a key on your keyboard

void keyPressed(){
    
    // clear screen when you press 'c'
    if( key == 'c') background(200);
}