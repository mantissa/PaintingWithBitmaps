
import processing.pdf.*;

PImage myImage;

int nFramesToSave = 20;
boolean wasSaved = false;

void setup(){
 
    size(800, 600);
  
    myImage = loadImage("../Sources/RothkoUntitledBasel.jpg");
 
    frameRate(10);
    
    // write to this file
    beginRecord(PDF, "thickLines.pdf"); 
    
    // just call background once
    background(0);
}

void draw(){
  
    // do your thing (with processing shapes)
   
    float time = 0.1 * (float)millis()/1000;
   
    strokeWeight(5);
    noFill();
   
    for(int x=0; x<width+40; x+=50){
      for(int y=0; y<height+40; y+=50){
        
          int px = (int)(noise( 0.001 * x, 0.001 * y +time ) * myImage.width);
          int py = (int)(noise( 0.001 * x, 0.001 * y +time) * myImage.height);
      
          color c = myImage.get( px, py);
            
          stroke(c);    
          
          float sz = random( 10, 100);
          float rx = random( -20, 20);
          float ry = random( -20, 20);
        
          randomCurve(x+rx, y+ry, sz);
      }
    }
    
    if( frameCount >= nFramesToSave && !wasSaved ){
  
        println("Saving PDF");
      
        // finish the file
        endRecord();
        
        wasSaved = true;
    }
}

void randomCurve( float x, float y, float sz){
  
    beginShape();
    
    float startT = random(TWO_PI);
    float maxT = random(PI/2, TWO_PI);
    
    int nPts = (int)random(4, 8);
    
    for(int i=0; i<nPts; i++){

        float rd = random(-sz/2, sz/2);
        
        float cx = x + cos( startT+ (i * maxT/4) ) * (sz + rd);
        float cy = y + sin( startT+ (i * maxT/4) ) * (sz + rd);
        
        curveVertex(cx, cy);
    }
    
    endShape();
}

void keyPressed(){
 
    
}