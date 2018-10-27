
int noiseIndex = 0;
PImage colors;
int [] indices;

void setup(){
 
    size(600, 600);
    
    colors = loadImage("colors.png");
    
    indices = new int[16];
    for(int i=0; i<16; i++){ 
      indices[i] = (int)random(1000);
    }
}

void draw(){
 
    //background(0);
    
    
    
    strokeWeight(0.5);
    
    int spacing = width/4;
    
    int ct = 0;
    
    randomSeed(noiseIndex);
    
    noStroke();
    
    for(int i=0; i<4; i++){
      for(int j=0; j<4; j++){
        
        
        
        int rx = (int)random(colors.width-1);
        int ry = (int)random(colors.height-1);
        
        int ox = (int)random(-spacing/4, spacing/4);
        int oy = (int)random(-spacing/4, spacing/4);
        
        color c = colors.get( rx, ry);
        
        fill(c);
        
        rx = (int)random(colors.width-1);
        ry = (int)random(colors.height-1);
        
        c = colors.get( rx, ry);
        
        stroke(0);
        
        noiseShape( spacing*(i+0.5)+ox, spacing*(j+0.5)+oy, 50, 50, noiseIndex+ct);

        ct++;
      }
    }
  
    if( frameCount % 6 == 0 )noiseIndex++;
}

void noiseShape(float x, float y, float w, float h, float index){
  
    float noiseScale = 0.05;
    float noiseDisplace = 150.0;
    int nPts = 80;
  
    beginShape();
    
    float r = random(TWO_PI);
    
    for(int i=0; i<nPts; i++){
     
        float a = r + TWO_PI * float(i)/(nPts-1);
        
        float px = x + cos( a ) * w;
        float py = y + sin( a ) * h;
        
        float ox = (noise( px*noiseScale, py*noiseScale +index) - 0.5) * noiseDisplace;
        float oy = (noise( px*noiseScale, py*noiseScale+index+100.0 )-0.5) * noiseDisplace;
        
        vertex(px + ox, py + oy);
    }
    
    endShape();
}

void keyPressed(){
 
    noiseIndex++;
}