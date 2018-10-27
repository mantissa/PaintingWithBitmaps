
void setup(){
  
    size(400, 400);
    frameRate(30);
}

void draw(){
  
    background(0);
 
    // rotate first then draw shape at 100,100
    //rotateAroundOrigin(true);
    
    // translate first, then rotate, draw shape at 100,100
    //translateThenRotate(true);
    
    // same as above but draw rectangle around center
    //translateThenRotateAroundCenter();
    
    // draw both transformations, what do you see?
    rotateAroundOrigin(false);
    translateThenRotate(false);
    
    // draw both transformations with push/pop
    //usingPushPop();
}

void rotateAroundOrigin( boolean grid ){

    rotate( radians(frameCount) );
    rect(100, 100, 50, 50);
    
    if( grid ) drawGrid();
}

void translateThenRotate(boolean grid){
  
    translate(100, 100);
    rotate( radians(frameCount) );
    rect(0, 0, 50, 50);
    
    if( grid )  drawGrid();
}

void translateThenRotateAroundCenter(){
 
    rectMode(CENTER);
  
    translate(100, 100);
    rotate( radians(frameCount) );
    rect(0, 0, 50, 50);
    
    drawGrid();
}

void usingPushPop(){
 
    pushMatrix();
    rotateAroundOrigin(false);
    popMatrix();
    
    pushMatrix();
    translateThenRotateAroundCenter();
    popMatrix();
}

void drawGrid(){
  
    stroke(127);
 
    for(int x=0; x<width; x+= 20)
    {  
        line(x, 0, x, height);
    }
    
    for(int y=0; y<height; y+= 20)
    {  
      line(0, y, width, y);        
    }
}