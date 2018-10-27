
PImage myImage;

void setup(){
 
    size(536, 640);
  
    myImage = loadImage("../Sources/RothkoUntitledBasel.jpg");
    
    image(myImage, 0, 0);
}

void draw(){
 
    // get pixel color at mouse position
    color c = myImage.get( mouseX, mouseY);
    
    // set and fill to color
    stroke(c);
    fill(c);
    
    // stroke size is based on dynamics
    float scale = dist( mouseX, mouseY, pmouseX, pmouseY);
    scale = constrain( scale, 0.0, 100.0);
    scale = map( scale, 0.0, 100.0, 5.0, 150.0);

    ellipse( mouseX, mouseY, scale, scale);
}