
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
           
           float dist1 = map( red(pixelVal), 0, 255, -100, 100);
           float dist2 = map( green(pixelVal), 0, 255, -100, 100);
           float dist3 = map( blue(pixelVal), 0, 255, -100, 100);
           
           float angle = map( brightness(pixelVal), 0, 255, 0, TWO_PI * 0.2);

           //red
           float nX = cos( angle + time ) * dist1;
           float nY = sin( angle + time ) * dist1; 
           int rX = constrain(int(nX + x), 0, width-1);
           int rY = constrain(int(nY + y), 0, height-1);
           int readPos = rY * width + rX;
           int pix = myImage.pixels[readPos];
           float pR = red( pix );
            
           //green
           nX = cos( angle + TWO_PI/3 + time * 0.33 ) * dist2;
           nY = sin( angle + TWO_PI/3 + time * 0.33 ) * dist2; 
           rX = constrain(int(nX + x), 0, width-1);
           rY = constrain(int(nY + y), 0, height-1);
           readPos = rY * width + rX;
           pix = myImage.pixels[readPos];
           float pG = green( pix );
           
           //blue
           nX = cos( angle + 2*TWO_PI/3 + time * 0.44) * dist3;
           nY = sin( angle + 2*TWO_PI/3 + time * 0.44 ) * dist3; 
           rX = constrain(int(nX + x), 0, width-1);
           rY = constrain(int(nY + y), 0, height-1);
           readPos = rY * width + rX;
           pix = myImage.pixels[readPos];
           float pB = blue( pix );
              
            pixels[writePos] = color(pR, pG, pB);
        }
    }
    
    updatePixels();
}