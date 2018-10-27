
PImage myImage;

void setup(){
  
    // make sure this is the same size as the image
    size(425, 400);
  
    // load ur image & the pixels
    myImage = loadImage("welovecutepets.jpg");
    myImage.loadPixels();
    
    // make the screen pixels available
    loadPixels();
}

void draw(){
  
    // the speed of time-based modulations
    float time = 0.2 * (float)  millis()/1000;
  
    for(int x=0; x<width; x++){
        for(int y=0; y<height; y++){
          
            float nX = noise( 0.002 * (float)x)* width * 1.5;
            float nY = noise( 0.002 * (float)y)* height * 1.5;
          
            // 'alternative tuning'
            //float nX = noise( 0.002 * (float)(x), time )* width * 1.5;
            //float nY = noise( 0.002 * (float)(y), time )* height * 1.5;
            
            // make sure that those values stay within the image dimensions
            int rX = constrain(int(nX), 0, width-1);
            int rY = constrain(int(nY), 0, height-1);
          
            // instead of reading and writing to the same position
            // we read from a slightly offset position that can be
            // modulated by noise, sin wave, etc.
            int readPos = rY * width + rX;
            int writePos = y * width + x;
            
            // read the pixel
            int pix = myImage.pixels[readPos];
         
            // write directly to the screen's pixel
            pixels[writePos] = pix;
        }
    }
    
    updatePixels();
}