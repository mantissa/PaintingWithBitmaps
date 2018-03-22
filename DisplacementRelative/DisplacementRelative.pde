
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
          
            float nX = cos( 2 * TWO_PI * (float)(x)/ width ) * 5;
            nX += cos( nX * 0.125 + time  + (x * 0.0125)  ) * 25;
            //nX += sin( nX * 0.125 + time + (x * 0.0125)  ) * 65;
            
            float nY = sin( 2 * TWO_PI * (float)(y)/ height ) * 5;
            nY += sin( nY * 0.125 + time + (y) * 0.0125 ) * 25;
            //nY += sin( nY * 0.125 + time + (y) * 0.0125 ) * 65;
            
            int rX = constrain(int(nX + x), 0, myImage.width-1);
            int rY = constrain(int(nY + y), 0, myImage.height-1);
          
            int readPos = rY * myImage.width + rX;
            int writePos = y * width + x;
            
            int pix = myImage.pixels[readPos];
              
            pixels[writePos] = pix;
        }
    }
    
    updatePixels();
}