
PImage myImage;

void setup(){
  
    size(425, 400);
  
    myImage = loadImage("welovecutepets.jpg");
    myImage.loadPixels();
    
    loadPixels();
}

void draw(){
  
    float time = 0.2 * (float)  millis()/1000;
  
    for(int x=0; x<width; x++){
        for(int y=0; y<height; y++){
          
            float nX = noise( 0.002 * (float)x)* width * 1.5;
            float nY = noise( 0.002 * (float)y)* height * 1.5;
          
            //float nX = noise( 0.002 * (float)(x), time )* width * 1.5;
            //float nY = noise( 0.002 * (float)(y), time )* height * 1.5;
            
            int rX = constrain(int(nX), 0, width-1);
            int rY = constrain(int(nY), 0, height-1);
          
            int readPos = rY * width + rX;
            int writePos = y * width + x;
            
            int pix = myImage.pixels[readPos];
         
            pixels[writePos] = pix;
            
        }
    }
    
    updatePixels();
}