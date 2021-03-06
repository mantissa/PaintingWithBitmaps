
PImage myImage;
PImage brushImage;

void setup(){
  
    size( 780, 800 );
    
    background(0);
  
    // load an image, assign it to myImage
    myImage = loadImage("no-21.jpg");
    
    // load a brush image
    brushImage = loadImage("../Sources/Brush.png");
    
    // make the pixels available for sampling
    myImage.loadPixels();
    
    // draw all the images centered
    imageMode(CENTER);
}

void draw(){
 

}

void mouseDragged(){
  
   drawBrush();
}

void mousePressed(){
 
    drawBrush();
}

void drawBrush(){
 
    for(int i=0; i<30; i++){
       
          // calculate brush elements randomly
          float w = random(1, 15); // width
          float x = mouseX + random(-25, 25); // x offset +/-
          float y = mouseY + random(-25, 25); // y offset +/-
          
          // keeps a (float) value within a specified range
          x = constrain(x, 0, width-1);
          y = constrain(y, 0, height-1);
          
          int c = myImage.pixels[ int(y) * width + int(x) ];
          float r = red(c);
          float g = green(c);
          float b = blue(c);
          float a = random(127); // alpha 
          
          // set the draw color
          tint( r, g, b, a);
        
          // draw an ellipse close to the mouse position
          // with the random w 
          image(brushImage, x, y, 20, 20);
      }
}

void keyPressed(){
 
    if( key == 'c') background(0);
}