

PFont font;

float[] dashes = { 16.0f, 8.0f, 4.0f, 8.0f };


void setup(){
  
    font = loadFont("Serif-48.vlw");
    textFont(font);

    size( 600, 600 );
}

void draw(){
  
   background(200);
  
   drawAngle();
   //drawCircle(); 
}

void drawAngle(){
  
   // draw a line from the center to the mouse
   int p1x = width/2;
   int p1y = height/2;
   
   int p2x = mouseX;
   int p2y = mouseY;
   
   stroke(0);
   fill(0);
   line( p1x, p1y, p2x, p2y);
   ellipse( p1x, p1y, 5, 5);
   
   float a = getAngle(p1x, p1y, p2x, p2y);
   float d = getDistance(p1x, p1y, p2x, p2y);
   
   text( "angle: " + a, 10, 50);
   text( "distance: " + d, 10, 100);
   
   // draw the angle/vector
   pushMatrix();
   translate( p2x, p2y);
   rotate( a );
   triangle( 0, -5, 10, 0, 0, 5);
   popMatrix();
   
   // draw dx and dy
   stroke( 0, 150);
   dashLine( p1x, p1y, p2x, p1y, 5);
   dashLine( p2x, p1y, p2x, p2y, 5);
   
   // draw the perpendicular too
   stroke(100, 0, 0);
   pushMatrix();
   translate( p1x, p1y);
   rotate( a + PI/2);
   line(0, 0, 50, 0);
   popMatrix();
}

void drawCircle(){
 
    fill(0);
  
    float p1x = width/2;    
    float p1y = height/2;
  
    for(float a=0; a<TWO_PI; a+= PI/20){
     
        float c1x = cos( a ) * 200;
        float c1y = sin( a ) * 200;
        
        //line(p1x, p1y, p1x+c1x, p1y+c1y);
        ellipse( p1x+c1x, p1y+c1y, 5, 5 );
    }
    
    
    float a = map( mouseX, 0, width, 0, TWO_PI);
    
    float c1x = cos( a ) * 200;
    float c1y = sin( a ) * 200;
    
    strokeWeight(2);
    line(p1x, p1y, p1x+c1x, p1y+c1y);
}

void dashLine(float x1, float y1, float x2, float y2, int spacing){
 
    float dx = x2 - x1;
    float dy = y2 - y1;
  
    PVector dist = new PVector(dx, dy);
    
    float mag = dist.mag();
    
    PVector stepSize = dist.div( mag );
  
    beginShape(LINES);
    
    for(float i=0; i<mag; i+=spacing){
     
        vertex( x1+i * stepSize.x, y1+i * stepSize.y);
        vertex( x1+(i+1) * stepSize.x, y1+(i+1) * stepSize.y);
    }
    
    endShape();
}

float getAngle( float p1x, float p1y, float p2x, float p2y ){
 
    float dx = p2x-p1x;
    float dy = p2y-p1y;
    
    return atan2( dy, dx);
}

float getDistance( float x1, float y1, float x2, float y2) {

    return sqrt( pow(x2 -x1, 2) + pow(y2 -y1, 2));
  }