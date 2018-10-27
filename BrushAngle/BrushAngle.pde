
float heading;

void setup(){
 
    size(800, 600);
    
    // set ellipse to draw in the center
    ellipseMode(CENTER);
}

void draw(){
 
    background(0);
    
    // calculate the distance between mouse now and previoud mouuse
    float heading = atan2( mouseY-pmouseY, mouseX-pmouseX);
    
    // another method using PVector
    //PVector vec = new PVector(mouseX-pmouseX, mouseY-pmouseY);
    //float heading = vec.heading();
    
    // store transform matrix
    pushMatrix();
    
    // move to mouse position
    translate(mouseX, mouseY);
    
    // rotate 
    rotate( heading );
    
    // draw shape
    ellipse( 0, 0, 40, 10);
    
    // return to previous transform
    popMatrix();
}