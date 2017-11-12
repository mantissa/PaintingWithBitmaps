
class Gesture {

  PVector position;
  PVector direction;
  PVector lastPosition;
  Integer newColor; 
  boolean bEndShape;
  int nFrames;

  ArrayList<PVector> points;
  ArrayList<Integer> colors;
  
  float minWidth;  // *
  float maxWidth; // *
  int gestureLength; // * 
  int colorInterval; // *
  int loopDuration; // *

  Gesture(PVector pos) {

    points = new ArrayList<PVector>();
    colors = new ArrayList<Integer>();
    newColor = new Integer(0);

    position = new PVector(pos.x, pos.y); 
    direction = new PVector(0., 0.0);

    minWidth = 5;
    maxWidth = 5 + random(0, 20);
    gestureLength = (int)random(50, 200);
    colorInterval = (int)random(2, 10);
    loopDuration = (int)random(100, 200);

    reset();
  }

  void update(PVector vel) {
    
    if( bEndShape ){
     
        points.remove(0);//points.size()-1);
        colors.remove(0); //colors.size()-1);
      
        return;
    }
    
    position.add(vel);
    
    if ( colors.size() % colorInterval == 0 ) {

      int px = constrain( (int)position.x, 0, img.width-1);
      int py = constrain( (int)position.y, 0, img.height-1);

      newColor = img.pixels[ py * img.width + px ];  
    } 

    colors.add( newColor);
    points.add( new PVector(position.x, position.y) );

    if ( points.size() >= gestureLength ) {

      points.remove(0);//points.size()-1);
      colors.remove(0); //colors.size()-1);
    }
    
    smoothPoints( points, 0.1);
    
    nFrames++;
  }

  boolean isOffscreen() {

    return position.x < 0 || position.x > width || position.y < 0 || position.y > height;
  }

  void draw() {

    fill(0);
    //ellipse( position.x, position.y, 5, 5);
    //noStroke();
    stroke(0, 15);
   // println(points.size());


    if( points.size() < 2 ) return;

    beginShape(QUADS);

    int nPts = points.size();

    int lastColor = 0;

    for ( int i=0; i<nPts-2; i++ ) {

      PVector pt = new PVector(points.get(i).x, points.get(i).y);
      PVector pt1 = new PVector(points.get(i).x, points.get(i).y);

      lastColor = colors.get(i);

      PVector diff = pt1.sub( points.get(i+1));

      float angle = atan2( diff.y, diff.x );

      float mag = 0; //map( diff.mag(), 0, 1, minWidth, maxWidth);

      if ( true ) {

        mag = map( brightness(lastColor), 0, 255, minWidth, maxWidth);
        //mag *= sin( PI * float(i)/(nPts-2));
        mag = constrain(mag, minWidth, maxWidth);
        
      } else {

        mag = map( diff.mag(), 0, 1, minWidth, maxWidth);
        mag = constrain(mag, minWidth, maxWidth);
        //mag *= sin( PI * float(i)/(nPts-2));
      }

      mag *= sin( PI * float(i)/(nPts-2));

      PVector span = new PVector();
      span.x = cos( angle + PI/2 ) * mag;
      span.y = sin( angle + PI/2 ) * mag;

      fill( lastColor);
      //stroke( red(lastColor)*0.95, green(lastColor)*0.95, blue(lastColor)*0.95);
      //color c = color( random(255), 200, random(127, 255)); 

      vertex( pt.x - span.x, pt.y - span.y );
      vertex( pt.x + span.x, pt.y + span.y );

      pt = new PVector(points.get(i+1).x, points.get(i+1).y);
      pt1 = new PVector(points.get(i+1).x, points.get(i+1).y);

      diff = pt1.sub( points.get(i+2));
      
      lastColor = colors.get(i+1);

      angle = atan2( diff.y, diff.x );

      if ( true ) {

        mag = map( brightness(lastColor), 0, 255, minWidth, maxWidth);
        mag = constrain(mag, minWidth, maxWidth);
        
      } else {

        mag = map( diff.mag(), 0, 1, minWidth, maxWidth);
        
        mag = constrain(mag, minWidth, maxWidth);
        
      }
      
      mag *= sin( PI * float(i+1)/(nPts-2));

      span.x = cos( angle + PI/2 ) * mag;
      span.y = sin( angle + PI/2 ) * mag;

      vertex( pt.x + span.x, pt.y + span.y );
      vertex( pt.x - span.x, pt.y - span.y );
    }

    endShape();
  }
  
  void smoothPoints(ArrayList<PVector> pts, float amt){
 
    for( int i=1; i<pts.size()-1; i++ ){
      
        PVector pt1 = new PVector(pts.get(i-1).x, pts.get(i-1).y);
        PVector pt2 = new PVector(pts.get(i+1).x, pts.get(i+1).y);

        pts.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), amt);
    }
}

  void reset() {

    points.clear();
    colors.clear();
    nFrames = 0;
    bEndShape = false;
  }
}