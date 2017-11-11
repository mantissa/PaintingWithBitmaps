
ArrayList<PVector> points;
ArrayList<Integer> colors;
boolean isDrawing;
int repeats = 2;

class QuadStripBrush {

  QuadStripBrush() {

    points = new ArrayList<PVector>();
    colors = new ArrayList<Integer>();
  }
  
  void addVertices( ArrayList<PVector> vertices){
   
      points.clear();
      points.addAll( vertices );
      
      smoothPoints();
      smoothPoints();
  }

  void draw() {

    beginShape(QUADS);

    int nPts = points.size();

    for ( int i=0; i<nPts-2; i++ ) {

      PVector pt = new PVector(points.get(i).x, points.get(i).y);
      PVector pt1 = new PVector(points.get(i).x, points.get(i).y);

      PVector diff = pt1.sub( points.get(i+1));

      float angle = atan2( diff.x, diff.y );

      float mag = map( diff.mag(), 0, 10, 2, 10);

      //mag *= sin( repeats * PI * float(i)/(nPts-2));

      PVector span = new PVector();
      span.x = sin( angle + PI/2 ) * mag;
      span.y = cos( angle + PI/2 ) * mag;
      
      int px = constrain( (int)pt.x, 0, width-1);
      int py = constrain( (int)pt.y, 0, height-1);
      
      int pColor = myImage.pixels[ py * width + px ];
      fill( pColor);
      stroke( red(pColor)*0.95, green(pColor)*0.95, blue(pColor)*0.95);
      //color c = color( random(255), 200, random(127, 255)); 

      vertex( pt.x - span.x, pt.y - span.y );
      vertex( pt.x + span.x, pt.y + span.y );
      
      pt = new PVector(points.get(i+1).x, points.get(i+1).y);
      pt1 = new PVector(points.get(i+1).x, points.get(i+1).y);

      diff = pt1.sub( points.get(i+2));

      angle = atan2( diff.x, diff.y );

      mag = map( diff.mag(), 0, 10, 2, 10);

      //mag *= sin( repeats*PI * float(i+1)/(nPts-2));

      //PVector span = new PVector();
      span.x = sin( angle + PI/2 ) * mag;
      span.y = cos( angle + PI/2 ) * mag;
      
      vertex( pt.x + span.x, pt.y + span.y );
      vertex( pt.x - span.x, pt.y - span.y );
    }
    
    endShape();
    
    drawFront();
  }
  
  void drawFront(){
    
     if( points.size() < 2 ) return;
    
     PVector front = new PVector();
     front.x = points.get(1).x - points.get(0).x;
     front.y = points.get(1).y - points.get(0).y;
     
     int pX = constrain( (int)points.get(0).x, 0, width-1);
     int pY = constrain( (int)points.get(0).y, 0, height-1);
    
     float heading = front.heading(); 
     
     
     int pColor = myImage.pixels[pY * width + pX];
     
     fill( pColor);
     stroke( red(pColor)*0.95, green(pColor)*0.95, blue(pColor)*0.95);
    
     
    
     pushMatrix();
    
     translate( points.get(0 ).x, points.get(0 ).y );
    
     rotate( heading );
     
     
     
     ellipse( 0, 0, front.mag()*2, front.mag()*2);
    
     popMatrix();
  }

  void smoothPoints() {

    for ( int i=1; i<points.size()-1; i++ ) {

      PVector pt1 = new PVector(points.get(i-1).x, points.get(i-1).y);
      PVector pt2 = new PVector(points.get(i+1).x, points.get(i+1).y);

      points.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), 1.0);
    }
  }
}