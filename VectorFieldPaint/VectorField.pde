
class VectorField {
 
    void process( PImage source, int spacing ){
     
        int w = source.width;
        int h = source.height;
        int nPixels = w * h;
        imgW = w;
        imgH = h;
        
        gridSpacing = spacing;
        
        gridWidth = w / gridSpacing;
        gridHeight = h / gridSpacing;
        
        println( "source "+imgW + " " + imgH);
        //println( "nPixels "+ nPixels);
        println( "gridSize "+gridWidth + " " + gridHeight);
        
        int gridSize = gridHeight * gridWidth;
        
        // load pixels into memory for access
        source.loadPixels();
        
        // create grid
        // zero out the values
        field = new PVector[gridSize];
        for(int i=0; i<gridSize; i++){
          field[i] = new PVector(0, 0);  
        }
        
        // translate img to grayscale
        brightness = new float[nPixels];
        for(int x=0; x<w; x++){
            for(int y=0; y<h; y++){
              
                int pPos = (y * w) + x;
                
                color c = source.pixels[pPos];
                
                brightness[pPos] = (0.299 * red(c)/255.0) + (0.587 * green(c)/255.0) + (0.114 * blue(c)/255.0);
            }
        }
        
        float [] areaPixels = new float[9];
        
        for(int x=1; x<gridWidth-1; x++){
          for(int y=1; y<gridHeight-1; y++){
        
            int vecPos = y * gridWidth + x;
            
            
            // loop through the area pixels
            for(int i=-1; i<=1; i++){
              for(int j=-1; j<=1; j++){
                
                // determine where to read from in the area (not optimized)
                int readPos = (((y + j) * imgW) + (x + i))*gridSpacing;
                int writePos = (j+1) * 3 + (i + 1);
                
                float BR = brightness[readPos];
                
                 areaPixels[writePos] = BR;
              }
            }
            
            // change over x vs. change over y
            float dX = (areaPixels[0] + areaPixels[3] + areaPixels[6])/3 - (areaPixels[2] + areaPixels[5] + areaPixels[8])/3;
            float dY = (areaPixels[0] + areaPixels[1] + areaPixels[2])/3 - (areaPixels[6] + areaPixels[7] + areaPixels[8])/3;
            
           
            
            field[vecPos].x = dY;
            field[vecPos].y = dX;
            
            //field[vecPos].normalize();
            
             //println( field[vecPos].x + " " + field[vecPos].y);
          }
        }
        

        // fill top row
        
        int y = 0;
        int x;
        for(x=0; x<gridWidth; x++){
         
            int pSrc = (y+1) * gridWidth + x;
            int pDst = y * gridWidth + x;
            
            field[pDst] = field[pSrc];
        }
        
        // fill bottom row
        
        y = gridHeight-1;
        for(x=0; x<gridWidth; x++){
         
            int pSrc = (y-1) * gridWidth + x;
            int pDst = y * gridWidth + x;
            
            field[pDst] = field[pSrc];
        }
        
        // fill left col
        
        x = 0;
        y = gridHeight-1;
        for(y=0; y<gridHeight; y++){
         
            int pSrc = y * gridWidth + x+1;
            int pDst = y * gridWidth + x;
            
            field[pDst] = field[pSrc];
        }
        
        // fill right coloum
        
        x = gridWidth-1;
        y = gridHeight-1;
        for(y=0; y<gridHeight; y++){
         
            int pSrc = y * gridWidth + x-1;
            int pDst = y * gridWidth + x;
            
            field[pDst] = field[pSrc];
        }
    }
    
    void draw(){
      
        noStroke();
     
        for(int x=0; x<gridWidth; x++){
            for(int y=0; y<gridHeight; y++){
              
                int src = (y * imgW+ x )*gridSpacing;
                
                noStroke();
                fill(brightness[src]*255);
                rect( x * gridSpacing, y*gridSpacing, gridSpacing, gridSpacing);
                
                
                stroke(0);
                int p = y * gridWidth + x;
                PVector v = field[p];
                
                line( (x+0.5) *gridSpacing, (y+0.5)*gridSpacing, (x+0.5)*gridSpacing + v.x*gridSpacing*2, (y+0.5)*gridSpacing+v.y*gridSpacing*2);
                
                //noStroke();
                //ellipse((x+0.5) *gridSpacing, (y+0.5)*gridSpacing, 3, 3); 
            }
        }
    }
  
    PVector getVector( PVector pos ){
      
      pos.x = constrain(pos.x, 0, gridWidth-1);
      pos.y = constrain(pos.y, 0, gridHeight-1);
      
      int p = int(pos.y) * gridWidth + int(pos.x);

      return field[p];
    }
    
    PVector getVectorInterpolated( PVector pos ){
      
      float x = pos.x;
      float y = pos.y;
 
      int p1X = int(constrain(x, 0, gridWidth-1));
      int p1Y = int(constrain(y, 0, gridWidth-1));
      
      int p2X = int(x+1);
      int p2Y = int(y+1);
      
      float pctX = x - p1X;
      float pctY = y - p1Y;

      // clockwise
      PVector vecA = field[p1Y*gridWidth+p1X];
      PVector vecB = field[p2Y+gridWidth+p2X];
      
      PVector lerpVec = new PVector();
      lerpVec.x = lerp( vecA.x, vecB.x, pctX);
      lerpVec.y = lerp( vecA.y, vecB.y, pctY);

      return lerpVec;
    }
    
    PVector [] field;
    float [] brightness;
    int gridSpacing;
    int gridWidth;
    int gridHeight;
    int imgW;
    int imgH;
}