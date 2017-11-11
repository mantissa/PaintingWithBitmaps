
ArrayList<PVector> texPoints;
ArrayList<PVector> gesturePoints;
boolean bDrawDebug;
PImage imageTex;

void setup(){
 
    size( 1200, 400 , P2D);
  
    texPoints = new ArrayList<PVector>();
    gesturePoints = new ArrayList<PVector>();
    bDrawDebug = false;
    
    imageTex = loadImage("no-21.jpg");
}

void draw(){
  
   background(200);
    
   int nPts = gesturePoints.size();
   
   //noFill();
   noStroke();
   //stroke(1);
   beginShape(TRIANGLE_STRIP);
   
   float time = 0.2 * (float)millis()/1000;
   
   texture(imageTex);
   
   for(int i=0; i<nPts-1; i++){
     
       PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
       PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);
       
       PVector d = p2.sub(p1);
       float a = atan2(d.y, d.x);
       float dist = d.mag();
       
       PVector offset = new PVector();
       offset.x = cos ( a + PI/2 ) * dist;
       offset.y = sin ( a + PI/2 ) * dist;
       
       vertex( gesturePoints.get(i).x - offset.x, gesturePoints.get(i).y - offset.y, 0, cos( time ) * height/2 + height/2);
       vertex( gesturePoints.get(i).x + offset.x, gesturePoints.get(i).y + offset.y, imageTex.width, cos( time ) * height/2 + height/2);
   }

   endShape();
}

void mousePressed(){
 
    gesturePoints.clear();
    gesturePoints.add( new PVector( mouseX, mouseY ));
}

void mouseDragged(){
 
    gesturePoints.add( new PVector( mouseX, mouseY ));
    
    smoothPoints();
}

void smoothPoints(){
 
    for( int i=1; i<gesturePoints.size()-1; i++ ){
      
        PVector pt1 = new PVector(gesturePoints.get(i-1).x, gesturePoints.get(i-1).y);
        PVector pt2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

        gesturePoints.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), 0.1);
    }
}