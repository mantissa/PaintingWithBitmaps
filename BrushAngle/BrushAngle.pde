
float heading;

void setup(){
 
    size(800, 400);
    
     ellipseMode(CENTER);
}

void draw(){
 
    background(0);
    
    //float heading = atan2( mouseY-pmouseY, mouseX-pmouseX);
    
    PVector vec = new PVector(mouseX-pmouseX, mouseY-pmouseY);
    float heading = vec.heading();
    
    pushMatrix();
    
    translate(mouseX, mouseY);
    
    rotate( heading );
    
    ellipse( 0, 0, 40, 10);
    
    popMatrix();
}