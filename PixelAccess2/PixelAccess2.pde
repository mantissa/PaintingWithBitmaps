
PImage myImage;

void setup(){
 
    size(536, 640);
  
    myImage = loadImage("../Sources/RothkoUntitledBasel.jpg");
}

void draw(){
  
    background(0);
 
    int w = myImage.width;
    int h = myImage.height;
    
    noStroke();
    
    // loop thru all the pixels and draw each one (this may be slow AF)
    
    for(int x=0; x<w; x++){
        for(int y=0; y<h; y++){
      
            int pos = y * w + x;
          
            color c = myImage.pixels[pos];
            fill(c);
            
            rect( x, y, 1, 1 );
        }
    }
}