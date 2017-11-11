
PImage myImage;

void setup(){
  
    size(425, 400);
    //size(780, 800);
  
    myImage = loadImage("welovecutepets.jpg");
    //myImage = loadImage("no-21.jpg");
    myImage.loadPixels();
    
    loadPixels();
}

void draw(){
  
    float time =  (float)  millis()/1000;
  
    for(int x=0; x<width; x++){
        for(int y=0; y<height; y++){
          
           int writePos = y * width + x;
           int pixelVal = myImage.pixels[writePos];
           
           float dist = map( blue(pixelVal), 0, 255, -20, 20);
           dist += noise( 0.02 * x + 5.0+time, 0.02 * y + 5.0+time) * 20-10;
           float angle = map( brightness(pixelVal), 0, 255, 0, TWO_PI * 2);

           // dist = cos( dist + time + (float)x/width ) * 250;
            float o = (float)x/width * TWO_PI * 4 + noise( 0.02 * x, 0.02 * y, time) * TWO_PI;
            float nX = cos( angle + time + o ) * dist;
            float nY = sin( angle + time + o ) * dist;
            
            int rX = constrain(int(nX + x), 0, width-1);
            int rY = constrain(int(nY + y), 0, height-1);
            int readPos = rY * width + rX;
            
            int pix = myImage.pixels[readPos];
              
            pixels[writePos] = pix;
        }
    }
    
    updatePixels();
}