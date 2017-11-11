
class Gesture {

  Gesture() {

    angles = new ArrayList<Quaternion>();
    points = new ArrayList<PVector>();

    gPts = (int)random(15, 40);
    index = (int)random(1000);
    stepSize = 6;
    c = color(random(255), random(255), random(255));
    thickness = random(5, 30);
    
    position = new PVector();
    position.x = random(width);
    position.y = random(height);
    
    rotation = random(360);
  }

  void create( float t ) {

    angles.clear();
    points.clear();
    
    float curveRate = 0.03;

    PVector lastPt = new PVector(0, 0); //width/2, height/2);

    for (int i=0; i<gPts; i++) {

      float angle = noise( curveRate * (- i) + t, index + t) * 360 ;

      Quaternion q = new Quaternion();
      q.makeRotate( angle, 0, 0, 1);
      
      angles.add(0, q);

      PVector pt = new PVector(-stepSize, 0, 0);
      pt = q.rotate( pt );
      pt.add(lastPt);

      points.add(0, pt );

      lastPt.set(pt);
    }
    
    lastPt.set(0, 0);
    
    

    for (int i=0; i<gPts; i++) {

      float angle = noise( curveRate * i +  t, index +t) * 360;
      
      //angle = cos( radians( angle )) * 180;

      //println( i + " angle "+angle );

      Quaternion q = new Quaternion();
      q.makeRotate( angle, 0, 0, 1);
      
      points.add( lastPt );

      PVector pt = new PVector(stepSize, 0, 0);
      pt = q.rotate( pt );
      pt.add(lastPt);
      
      angles.add(q);

      

      lastPt = pt;
    }
  }

  void update() {
  }

  void draw(float t) {

    noFill();

    pushMatrix();

    translate(position.x, position.y);
    rotate( rotation );
    
    noStroke();
    fill(c);
    //stroke(c);

    int nPts = points.size();
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    for(int i=0; i<nPts; i++){
     
        PVector pt = points.get(i);
        Quaternion q = angles.get(i);
        
        float angle = 0;
        PVector axis = new PVector();
        angle = q.getRotate(axis);
      
        Quaternion q2 = new Quaternion();
        q2.makeRotate(angle + 90, axis.x, axis.y, axis.z);
      
        float pct = float(i)/(nPts-1);
        /*
        if( i < 15 ){
            pct = float(i)/30;
        } else if( i > nPts-15){
           pct = float(nPts-1-i)/30; 
        }
        */
      
        float w = sin(PI*pct) * thickness; //(noise((t*30)+(0.2*i), index)*15+5);
        PVector span = new PVector(w, 0);
        span = q2.rotate(span);
        
        PVector p1 = new PVector(pt.x, pt.y, pt.z);
        PVector p2 = new PVector(pt.x, pt.y, pt.z);
        p1.sub(span);
        p2.add(span);
        
        vertices.add(p1);
        vertices.add(p2);
    }
    
    beginShape(TRIANGLE_STRIP);
    
    

    for ( PVector pt : vertices ) {
      
      vertex(pt.x, pt.y);
    }

    endShape();
    
    // draw center line (debug)
    
    noFill();
    
    /*
    
    beginShape();

    stroke(0);

    for ( PVector pt : points ) {
      vertex(pt.x, pt.y);
    }


    endShape();
   */

    popMatrix();
  }

  ArrayList<Quaternion> angles;
  ArrayList<PVector> points;
  int gPts;
  int index;
  float thickness;
  float stepSize;
  color c;
  PVector position;
  float rotation;
};