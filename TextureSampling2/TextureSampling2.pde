
ArrayList<PVector> texPoints;
ArrayList<PVector> gesturePoints;
boolean bDrawDebug;
PImage imageTex;

void setup() {
  
  bDrawDebug = false;
  
  size( 800, 800, P2D); 
 
  texPoints = new ArrayList<PVector>();
  gesturePoints = new ArrayList<PVector>();
  
  imageTex = loadImage("UntitledColumbus.jpg");
}

void draw() {

  background(200);

  int nPts = gesturePoints.size();
  float time = 0.2 * (float)millis()/1000;

  //noFill();
  noStroke();
  //stroke(1);
  fill(255);

  if (!bDrawDebug) {

    beginShape(TRIANGLE_STRIP);
    
    texture(imageTex);

    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * 2 * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;

      float sampleAngle = 0.2 * i + time;

      PVector samplePos = new PVector();
      samplePos.x = cos( sampleAngle ) * imageTex.width/4 + imageTex.width/2;
      samplePos.y = sin( sampleAngle ) * imageTex.width/4 + imageTex.width/2;

      PVector samplePos2 = new PVector();
      samplePos2.x = cos( sampleAngle + 0.2) * imageTex.width/4 + imageTex.width/2;
      samplePos2.y = sin( sampleAngle + 0.2 ) * imageTex.width/4 + imageTex.width/2;

      PVector p3 = new PVector(samplePos.x, samplePos.y);
      PVector p4 = new PVector(samplePos2.x, samplePos2.y);

      d = p4.sub(p3);
      a = atan2(d.y, d.x);

      PVector sampleOffset = new PVector();
      sampleOffset.x = cos ( a + PI/2 ) * dist;
      sampleOffset.y = sin ( a + PI/2 ) * dist;

      vertex( gesturePoints.get(i).x - offset.x, gesturePoints.get(i).y - offset.y, samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y);
      vertex( gesturePoints.get(i).x + offset.x, gesturePoints.get(i).y + offset.y, samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y);
    }

    endShape();
    
  } else {

    beginShape(TRIANGLE_STRIP);
    
    texture(imageTex);

    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * 2 * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;

      float sampleAngle = 0.2 * i + time;

      PVector samplePos = new PVector();
      samplePos.x = cos( sampleAngle ) * imageTex.width/4 + imageTex.width/2;
      samplePos.y = sin( sampleAngle ) * imageTex.width/4 + imageTex.width/2;

      PVector samplePos2 = new PVector();
      samplePos2.x = cos( sampleAngle + 0.2) * imageTex.width/4 + imageTex.width/2;
      samplePos2.y = sin( sampleAngle + 0.2 ) * imageTex.width/4 + imageTex.width/2;

      PVector p3 = new PVector(samplePos.x, samplePos.y);
      PVector p4 = new PVector(samplePos2.x, samplePos2.y);

      d = p4.sub(p3);
      a = atan2(d.y, d.x);

      PVector sampleOffset = new PVector();
      sampleOffset.x = cos ( a + PI/2 ) * dist;
      sampleOffset.y = sin ( a + PI/2 ) * dist;

      vertex( samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y, samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y);
      vertex( samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y, samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y);
    }

    endShape();
    
    drawOutline();
  }
}

void keyPressed(){
 
    bDrawDebug = !bDrawDebug;
}

void mousePressed() {

  gesturePoints.clear();
  gesturePoints.add( new PVector( mouseX, mouseY ));
}

void mouseDragged() {

  gesturePoints.add( new PVector( mouseX, mouseY ));

  smoothPoints();
}

void drawOutline(){
 
    int nPts = gesturePoints.size();
    float time = 0.2 * (float)millis()/1000;
  
    stroke(0);
  
    beginShape(LINE_STRIP);

    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * 2 * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;

      float sampleAngle = 0.2 * i + time;

      PVector samplePos = new PVector();
      samplePos.x = cos( sampleAngle ) * imageTex.width/4 + imageTex.width/2;
      samplePos.y = sin( sampleAngle ) * imageTex.width/4 + imageTex.width/2;

      PVector samplePos2 = new PVector();
      samplePos2.x = cos( sampleAngle + 0.2) * imageTex.width/4 + imageTex.width/2;
      samplePos2.y = sin( sampleAngle + 0.2 ) * imageTex.width/4 + imageTex.width/2;

      PVector p3 = new PVector(samplePos.x, samplePos.y);
      PVector p4 = new PVector(samplePos2.x, samplePos2.y);

      d = p4.sub(p3);
      a = atan2(d.y, d.x);

      PVector sampleOffset = new PVector();
      sampleOffset.x = cos ( a + PI/2 ) * dist;
      sampleOffset.y = sin ( a + PI/2 ) * dist;

      vertex( samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y, samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y);
      //vertex( samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y, samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y);
    }

    endShape();
    
    beginShape(LINE_STRIP);

    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * 2 * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;

      float sampleAngle = 0.2 * i + time;

      PVector samplePos = new PVector();
      samplePos.x = cos( sampleAngle ) * imageTex.width/4 + imageTex.width/2;
      samplePos.y = sin( sampleAngle ) * imageTex.width/4 + imageTex.width/2;

      PVector samplePos2 = new PVector();
      samplePos2.x = cos( sampleAngle + 0.2) * imageTex.width/4 + imageTex.width/2;
      samplePos2.y = sin( sampleAngle + 0.2 ) * imageTex.width/4 + imageTex.width/2;

      PVector p3 = new PVector(samplePos.x, samplePos.y);
      PVector p4 = new PVector(samplePos2.x, samplePos2.y);

      d = p4.sub(p3);
      a = atan2(d.y, d.x);

      PVector sampleOffset = new PVector();
      sampleOffset.x = cos ( a + PI/2 ) * dist;
      sampleOffset.y = sin ( a + PI/2 ) * dist;

      //vertex( samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y, samplePos.x - sampleOffset.x, samplePos.y -sampleOffset.y);
      vertex( samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y, samplePos.x + sampleOffset.x, samplePos.y + sampleOffset.y);
    }

    endShape();
}


void smoothPoints() {

  for ( int i=1; i<gesturePoints.size()-1; i++ ) {

    PVector pt1 = new PVector(gesturePoints.get(i-1).x, gesturePoints.get(i-1).y);
    PVector pt2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

    gesturePoints.get(i).lerp( new PVector((pt1.x + pt2.x)/2, (pt1.y + pt2.y)/2), 0.5);
  }
}