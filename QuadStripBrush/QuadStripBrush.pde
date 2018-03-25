
ArrayList<PVector> points;
ArrayList<Integer> colors;
boolean isDrawing;

void setup(){
 
    size( 900, 500 );
    
    colorMode( HSB, 255);
    
    points = new ArrayList<PVector>();
    colors = new ArrayList<Integer>();
}

void draw(){
 
    background(227);

    beginShape(QUAD_STRIP);
    
    int nPts = points.size();
  
    for( int i=0; i<nPts-1; i++ ){
      
        PVector pt = new PVector(points.get(i).x, points.get(i).y);
        PVector pt1 = new PVector(points.get(i).x, points.get(i).y);
     
        // calculate the angle of movement
        PVector diff = pt1.sub( points.get(i+1));
        float angle = atan2( diff.x, diff.y );
        
        // fixed width of 10 pix
        float mag = 10; 
        
        // uncomment to make dynamic
        //mag = map( diff.mag(), 0, 10, 3, 15);
        
        // uncomment to taper
        //mag *= sin( PI * float(i)/(nPts-2));
        
        PVector span = new PVector();
        span.x = sin( angle + PI/2 ) * mag;
        span.y = cos( angle + PI/2 ) * mag;
        
        // fill with the saved color
        fill(colors.get(i));

        // add vertices above/below mark
        vertex( pt.x - span.x, pt.y - span.y );
        vertex( pt.x + span.x, pt.y + span.y );
    }
}

void mousePressed(){
  
    isDrawing = true;
 
    // clear the history & add new points/colors
    points.clear();
    points.add( new PVector(mouseX, mouseY ));
    
    colors.clear();
    colors.add( color(random(255), 200, random(127, 255)) );
}

void mouseDragged(){
  
    // add new points/colors
    points.add( new PVector(mouseX, mouseY ));   
    colors.add( color(random(255), 200, random(127, 255)) );
    
    // uncomment to smooth points
    // smoothPoints();
}

void mouseReleased(){
 
    isDrawing = false;
}

void smoothPoints(){
 
    // averaging points based on neighbors
  
    for( int i=1; i<points.size()-1; i++ ){
      
        PVector pt1 = new PVector(points.get(i-1).x, points.get(i-1).y);
        PVector pt2 = new PVector(points.get(i+1).x, points.get(i+1).y);
     
        points.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), 0.075);
    }
}