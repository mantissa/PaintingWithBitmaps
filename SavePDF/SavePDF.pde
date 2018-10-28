
import processing.pdf.*;

PImage myImage;

void setup(){
 
    size(1200, 600);
  
    myImage = loadImage("../Sources/RothkoUntitledBasel.jpg");
    
    // disable animations
    noLoop();
    
    // write to this file
    beginRecord(PDF, "thickLines.pdf"); 
}

void draw(){
  
    // do your thing (with processing shapes)
  
    background(0);
 
    int strokeW = 80;
    
    randomSeed(0);
   
    strokeWeight(strokeW);
   
    for(int x=0; x<width+strokeW; x+= (strokeW+5)){
      
        int divisions = (int) random(1, 8);
        
        float [] sizes = new float[divisions];
        float total = 0.0;
        for(int d=0; d<divisions;d++){
            sizes[d] = random(0.15, 1.0);
            total += sizes[d];
        }
        
        float totalH = height - divisions*strokeW;
        
        for(int d=0; d<divisions;d++){
            sizes[d] /= total;
            sizes[d] *= totalH;
        }
        
        float start = strokeW/2;
        
        for(int d=0; d<divisions; d++){
          
            int rx = (int)random( myImage.width-1);
            int ry = (int)random( myImage.height-1);
            
            color c = myImage.get( rx, ry);
            
            stroke(c);
         
            line( x, start, x, start+sizes[d]);
            
            start += sizes[d] + strokeW;
        }
    }
  
    // finish the file
    endRecord();
}