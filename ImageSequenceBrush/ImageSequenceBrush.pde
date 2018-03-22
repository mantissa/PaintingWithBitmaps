
PImage frames[];

void setup(){
  
   size(750, 500, P3D);
   frameRate(30);
  
   frames = new PImage[600];
   for(int i=0; i<600; i++){
    
       String fr = "frames/img_"+nf(i, 4)+".png"; 
       frames[i] = loadImage(fr);
   }
   
   colorMode(HSB, 360, 100, 100);
   background(0);
}

void draw(){
 
    
}

void mouseMoved(){
  
    int frameNo = frameCount % 600;
    
    imageMode(CENTER);
    
    pushMatrix();
    
    translate(mouseX, mouseY);
    
    PVector dist = new PVector(mouseX-pmouseX, mouseY-pmouseY);
    float angle = dist.heading();
    
    rotate(angle);
    
    float h = noise( 0.1*frameCount, 0 ) * 360;
    float s = 70+noise( 0.1*frameCount, 1 ) * 30;
    float b = 70+noise( 0.1*frameCount, 2 ) * 30;
    
    color c = color(h, s, b);
    
    //tint(c);
    image( frames[frameNo], 0, 0);
    
    popMatrix();
}