
class VectorField {
 
    void process( PImage img, int spacing ){
     
        int w = img.width;
        int h = img.height;
        
        gridSpacing = spacing;
        
        gridWidth = w / gridSpacing;
        gridHeight = h / gridSpacing;
        
        println( "gridSize "+gridWidth + " " + gridHeight);
        
        int gridSize = gridHeight * gridWidth;
        
        // load pixels into memory for access
        img.loadPixels();
        
        field = new PVector[gridSize];
        for(int i=0; i<gridSize; i++){
           
          field[i] = new PVector(0, 0);  
           
        }
        
        // get the pixels 
        brightness = new float[gridSize];
        for(int x=0; x<gridWidth; x++){
            for(int y=0; y<gridHeight; y++){
              
                int gPos = y * gridWidth + x;
                int iPos = (y * spacing * w ) + x * spacing;
                color c = img.pixels[iPos];
                brightness[gPos] = 0.33 * (float)red(c)/255.0 + 0.59 * (float)green(c)/255.0 + 0.11* (float)blue(c)/255.0;
            }
        }
        
        for(int x=1; x<gridWidth-1; x++){
            for(int y=1; y<gridHeight-1; y++){
              
                int p = y * gridWidth + x;
                
                float dX = brightness[y * gridWidth + x+1] - brightness[y * gridWidth + x-1];
                float dY = brightness[(y+1) * gridWidth + x] - brightness[(y-1) * gridWidth + x];
                float br = brightness[p];
                
                float a = atan2(dY, dX);
                
                field[p].x = sin( a ) * gridSpacing * br;
                field[p].y = cos( a ) * gridSpacing * br;
                
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
        
        x = gridWidth-1;
        y = gridHeight-1;
        for(y=0; y<gridHeight; y++){
         
            int pSrc = y * gridWidth + x-1;
            int pDst = y * gridWidth + x;
            
            field[pDst] = field[pSrc];
        }
    }
    
    void draw(){
     
        for(int x=0; x<gridWidth; x++){
            for(int y=0; y<gridHeight; y++){
              
                int p = y * gridWidth + x;
                
                fill(brightness[p]*255);
                //rect( x * gridSpacing, y*gridSpacing, gridSpacing, gridSpacing);
                
                PVector v = field[p];
                line( (x+0.5) *gridSpacing, (y+0.5)*gridSpacing, (x+0.5)*gridSpacing + v.x, (y+0.5)*gridSpacing+v.y);
            }
        }
    }
  
    PVector getVector( PVector pos ){
      
      int p = int(pos.y) * gridWidth + int(pos.x);

      return field[p];
    }
    
    PVector getVectorInterpolated( PVector pos ){
      
      float x = pos.x / gridSpacing;
      float y = pos.y / gridSpacing;
      
      int p1X = int(x);
      int p1Y = int(y);
      
      int p2X = int(x+1);
      int p2Y = int(y+1);
      
      float pctX = x - p1X;
      float pctY = y - p1X;
      
      PVector interpolated = new PVector();
      

      return field[p];
    }
    
    PVector [] field;
    float [] brightness;
    int gridSpacing;
    int gridWidth;
    int gridHeight;
}