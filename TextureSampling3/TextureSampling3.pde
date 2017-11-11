
ArrayList<TextureGesture> gestures;
TextureGesture newGesture;
boolean bDrawDebug;
PImage imageTex;

void setup(){
 
    size( 800, 800 , P2D);
  
    bDrawDebug = false;
    
    gestures = new ArrayList<TextureGesture>();
    newGesture = null;
    imageTex = loadImage("../Sources/RothkoUntitled1946.jpg");
}

void draw(){
  
   background(0);
   
   for( TextureGesture tg : gestures ){
    
       tg.draw();
       tg.drawOutline();
   }
   
   if( newGesture != null ){
       newGesture.draw();
       newGesture.drawOutline();
   }
}

void mousePressed(){
 
    newGesture = new TextureGesture();
    newGesture.gesturePoints.add( new PVector( mouseX, mouseY ));
   

    
}

void mouseDragged(){
 
    if( newGesture != null ){
       newGesture.gesturePoints.add( new PVector( mouseX, mouseY ));
        smoothPoints(newGesture.gesturePoints, 0.05);
    }
    
   
}

void mouseReleased(){
  
    gestures.add( newGesture );
    newGesture = null;
}

void keyPressed(){
 
    if( key == 'c' ){
     
        gestures.clear();
        newGesture = null;
    }
}

void smoothPoints(ArrayList<PVector> pts, float amt){
 
    for( int i=1; i<pts.size()-1; i++ ){
      
        PVector pt1 = new PVector(pts.get(i-1).x, pts.get(i-1).y);
        PVector pt2 = new PVector(pts.get(i+1).x, pts.get(i+1).y);

        pts.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), amt);
    }
}