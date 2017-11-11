
PImage myImage;

void setup(){
  
    size( 780, 800 );
  
    // load an image, assign it to myImage
    myImage = loadImage("no-21.jpg");
}

void draw(){
 
    // draw the image at 0, 0
    image( myImage, 0, 0);
}