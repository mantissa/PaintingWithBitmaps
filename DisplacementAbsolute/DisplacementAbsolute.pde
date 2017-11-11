
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
          
            float nX = sin( 0.3 * TWO_PI * (float)(x)/ width ) * width * 0.2;
            nX *= sin( time + nX * 0.05 + 0.2 * TWO_PI * (float)(x)/ width ) * 4;
            //nX += sin( nX * 0.125 + time  + (x * 0.0125)  ) * 50;
            //nX += sin( nX * 0.125 + time + (x * 0.0125)  ) * 125;
            nX += noise( x * 0.02 + nX * 0.01, time ) * 50 - 25;
            
            float nY = sin( 0.3 * TWO_PI * (float)(y)/ height ) * height * 0.2;
            nY *= sin( time + nX * 0.05 + 4 * TWO_PI * (float)(y)/height  ) * (1+ (float)y/height);
            //nY += sin( nY * 0.125 + time + (y) * 0.0125 ) * 125;
            nY += noise( y * 0.02 + nX * 0.01, time + float(x)/width * 2.0 ) * 50 - 25;
            
            int rX = constrain(int(nX+width/2), 0, width-1);
            int rY = constrain(int(nY+height/2), 0, height-1);
          
            int readPos = rY * width + rX;
            int writePos = y * width + x;
            
            int pix = myImage.pixels[readPos];
            
            float range = cos( time ) * 125 + 125;
            
            if( brightness(pix) > (range-20) && brightness(pix) < (range+20) ){
              
              float pct = map(brightness(pix), range-20, range+20, 0.0, PI );
              
              float red = (int)lerp(red(pixels[writePos]), red(pix), sin( pct));
              float green = (int)lerp(green(pixels[writePos]), green(pix), sin( pct));
              float blue = (int)lerp(blue(pixels[writePos]), blue(pix), sin( pct));
              
              //pixels[writePos] = color(red, green, blue);
            }
            
            range = noise( x * 0.012 + time, y*0.012 + time ) * 255;
            
            float brightness = brightness(pix);
            
            if( brightness > (range-20) && brightness < (range+20) ){
              
              float pct = map(brightness, range-20, range+20, 0.0, PI );
              
              float red = (int)lerp(red(pixels[writePos]), red(pix), sin( pct));
              float green = (int)lerp(green(pixels[writePos]), green(pix), sin( pct));
              float blue = (int)lerp(blue(pixels[writePos]), blue(pix), sin( pct));
              
              pixels[writePos] = color(red, green, blue);
            }
        }
    }
    
    updatePixels();
}