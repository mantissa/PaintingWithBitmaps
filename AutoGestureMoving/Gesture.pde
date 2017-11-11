
class Gesture {

  float curveRate = 0.03;
  boolean isEnding = false;
  boolean isEnded = false;
  float maxRotate = 55;
  int pointCount = 0;
  float startf;
  int markRate;
  boolean noFill;
  int moveRate;
  color outline;
  
  Gesture() {
    
    direction = new Quaternion();
    direction.makeRotate(random(4)*90, 0, 0, 1);

    angles = new ArrayList<Quaternion>();
    points = new ArrayList<PVector>();
    crossing = new ArrayList<Integer>();
    colors = new ArrayList<Integer>();
    aaPairs = new ArrayList<AngleAxisPair>();
    marks = new ArrayList<Boolean>();

    gPts = 100; //(int)random(40, 100);
    index = (int)random(5);
    stepSize = 4; //(int)random(3, 7);
    c = color(random(255), random(255), random(255));
    thickness = random(8, 30);
    pointCount = 0;
    
    markRate = (int)random(1, 12);
    
    position = new PVector();
    position.x = random(width);
    position.y = random(height);
    
    startf = millis()/1000;
    
    noFill = random(1.0) > 0.5;
    
    if(noFill) outline = (int)random(10, 60);
    
    moveRate = (int) random(1, 5);
  }
  
  void move( float t ){
    
      if( frameCount % moveRate  > 0) return ;
    
      int tw = width;
      int th = height;
      
      
    
    /*
      if( isEnding ){
          
          int ptIndex = 0;
          int nPts = points.size();
          boolean onScreen = false;
          
          while( ptIndex < nPts && !onScreen ){
            
            PVector pt = points.get(ptIndex);
            
            //println("testing "+index);
       
            if( pt.x > 0 && pt.y > 0 && pt.x < tw && pt.y < th ){
               onScreen = true;
            }
            
            ptIndex++;
          }
          
          if( !onScreen ) {
            println("ended");
            isEnded = true;
            return;
          }
      }
     */
      
      float angle = noise( 12 * (t-startf), index) * maxRotate - maxRotate/2;

      Quaternion q = new Quaternion();
      q.makeRotate( angle, 0, 0, 1);
      
      direction.multiply(q);
      
      AngleAxisPair pair = new AngleAxisPair();
      pair.angle = direction.getRotate( pair.axis );
      
      PVector pt = new PVector(stepSize, 0);
      rotatePoint( pt, pair.angle, pair.axis);
      pt.add( position );
      
      position = pt;
      
      if(pointCount % markRate == 0){
       
          int pixPos = clamp((int)pt.y, 0, th-1) * tw + clamp((int)pt.x, 0, tw-1);
          
          c = img.pixels[pixPos];
          
          marks.add(true);
      
      } else {
          marks.add(false);
      }
      
      colors.add(c);
      
      pointCount++;

      points.add( pt );
      angles.add( new Quaternion(direction) );
      crossing.add( 0 );
      aaPairs.add( pair );
      
      if( points.size() > gPts ){
       
          // start removing @ end
          angles.remove( 0 );
          points.remove( 0 );
          crossing.remove( 0 );
          aaPairs.remove(0);
          colors.remove(0);
          marks.remove(0);
      }
      
      if( pt.x < 0 || pt.x > width || pt.y < 0 || pt.y > height ){
         isEnding = true;
      }
  }

  void draw(float t) {
    
    noStroke();
    fill(c);
    
    int tw = width;
    int th = height;

    boolean isOnScreen = false;
    int nPts = points.size();
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    for(int i=0; i<nPts; i++){
     
        PVector pt = points.get(i);
        
        AngleAxisPair aaPair = aaPairs.get(i);

        if( !isOnScreen && pt.x > 0 && pt.y > 0 && pt.x < tw && pt.y < th ){
             isOnScreen = true;
         }
      
        // calculate the span
        float pct = float(i)/(nPts-1);
        float w = sin(PI*pct) * thickness; //(noise((t*30)+(0.2*i), index)*15+5);
        PVector span = new PVector(0, w, 0);
        rotatePoint( span, aaPair.angle, aaPair.axis);
        
        // add span to pts (to L and R)
        PVector p1 = new PVector(pt.x, pt.y); 
        PVector p2 = new PVector(pt.x, pt.y); 
        p1.sub(span);
        p2.add(span);
        vertices.add(p1);
        vertices.add(p2);
    }
    
    if( !isOnScreen ){
      
      isEnded = true;
    }
    
    noStroke();
    
    if( !noFill){
    
    //stroke(0, 40);
    //beginShape(TRIANGLE_STRIP);
    beginShape(QUADS);
   
    for(int i=0; i<vertices.size()-4; i+=2){
     
       PVector pt1 = vertices.get(i);
       PVector pt2 = vertices.get(i+1);
       PVector pt3 = vertices.get(i+3);
       PVector pt4 = vertices.get(i+2);
       
       color col = colors.get(i/2);
       
       fill(col, 220);
       
       vertex(pt1.x, pt1.y); //, pt.z);
       vertex(pt2.x, pt2.y); //, pt.z);
       vertex(pt3.x, pt3.y); //, pt.z);
       vertex(pt4.x, pt4.y); //, pt.z);
       
       //vertex(pt1.x, pt1.y); //, pt.z);
       //vertex(pt2.x, pt2.y); //, pt.z);
    }
    
    endShape();
    }
     
    stroke(0, noFill ? outline : 50);
    
    noFill();
    
    beginShape(LINES);
    
    for(int i=0; i<vertices.size()-4; i+=2){
     
          PVector pt1 = vertices.get(i);
          PVector pt2 = vertices.get(i+1);
          PVector pt3 = vertices.get(i+2);
          PVector pt4 = vertices.get(i+3);
          
          vertex(pt1.x, pt1.y); 
          vertex(pt3.x, pt3.y); 
          
          vertex(pt2.x, pt2.y); 
          vertex(pt4.x, pt4.y); 
      
       if( marks.get(i/2)){
      
          
         
          vertex(pt1.x, pt1.y); 
          vertex(pt2.x, pt2.y); 
          
          
       } 
         
         
    }
    
    endShape();
    
    // draw the heading ...
    
    noFill();

    if( mousePressed ){
      stroke(255, 0, 0);
      
      PVector pt = new PVector(20, 0);
      pt = direction.rotate( pt );
      pt.add( position );
      
      line(pt.x, pt.y, position.x, position.y);
    }
  }
  
  void rotatePoint( PVector pt, float angle, PVector axis){

    PVector ax = axis.normalize();
    float a = radians(angle);
    float sina = sin( a );
    float cosa = cos( a );
    float cosb = 1.0f - cosa;
    
    float nx = pt.x*(ax.x*ax.x*cosb + cosa) + pt.y*(ax.x*ax.y*cosb - ax.z*sina) + pt.z*(ax.x*ax.z*cosb + ax.y*sina);
    float ny = pt.x*(ax.y*ax.x*cosb + ax.z*sina) + pt.y*(ax.y*ax.y*cosb + cosa) + pt.z*(ax.y*ax.z*cosb - ax.x*sina);
    float nz = pt.x*(ax.z*ax.x*cosb - ax.y*sina) + pt.y*(ax.z*ax.y*cosb + ax.x*sina) + pt.z*(ax.z*ax.z*cosb + cosa);
    
    pt.set( nx, ny, nz);
  }
  
  void reset(){
   
    //println("reset");
    
    pointCount = 0;
    
    angles.clear();
    points.clear();
    crossing.clear();
    colors.clear();
    aaPairs.clear();
    marks.clear();
    
    position.x = random(width);
    position.y = random(height);
    position.z = 0;
    
    //direction.reset();
    direction.makeRotate(random(4)*90, 0, 0, 1);
    
    isEnding = false;
    isEnded = false;
    
    startf = millis()/1000;
  }

  int clamp( int val, int min, int max){
     
        if( val > max ) return max;
        if( val < min ) return min;
        return val;
    }

  Quaternion direction;

  ArrayList<Quaternion> angles;
  ArrayList<PVector> points;
  ArrayList<Integer> crossing;
  ArrayList<Integer> colors;
  ArrayList<AngleAxisPair> aaPairs;
  ArrayList<Boolean> marks;
  
  int gPts;
  int index;
  float thickness;
  float stepSize;
  color c;
  PVector position;
  float rotation;
};