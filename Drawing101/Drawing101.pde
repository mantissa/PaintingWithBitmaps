
// setup the processing sketch

void setup(){
 
    // create a window with dimensions w & h
    size(800, 600);
    
    // set the frame rate to 30 FPS
    frameRate(30);
}

// draw function (called 30x/sec)

void draw(){
  
    if( mousePressed ){
      
      // get the distance ur mouse moved
      float d = getDistance( mouseX, mouseY, pmouseX, pmouseY );
      
      // change the stroke weight based on distance
      strokeWeight(int(d* 0.5)) ;
      
      // draw a line from the current mouse pos to the previous mouse pos
      line( mouseX, mouseY, pmouseX, pmouseY);
    }
}

void keyPressed(){
  
    println(key);
 
    // clear the screen when you press c
    if( key == 'c') background(200);
}

// custom function 

float getDistance( float x1, float y1, float x2, float y2){
 
    return sqrt( pow(x2 -x1, 2) + pow(y2 -y1, 2));
}