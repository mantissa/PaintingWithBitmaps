

class TextureGesture {

  ArrayList<PVector> texPoints;
  ArrayList<PVector> gesturePoints;
  float index; 
  float speed; 

  TextureGesture() {

    texPoints = new ArrayList<PVector>();
    gesturePoints = new ArrayList<PVector>();
    index = random(1000);
    speed = random(0.1, 1.2);
  }

  void draw() {



    int nPts = gesturePoints.size();

    noStroke();
    //stroke(1, 50);
    beginShape(TRIANGLE_STRIP);

    float time = speed * (float)millis()/1000;

    texture(imageTex);

    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;

      float sampleAngle = 0.2 * i + time;

      PVector samplePos = new PVector();
      samplePos.x = cos( sampleAngle ) * (noise( index+time*0.15 )*0.8 + 0.2) * imageTex.width/4 + imageTex.width/2;
      samplePos.y = sin( sampleAngle ) * (noise( index+time*0.15 )*0.8 + 0.2) * imageTex.width/4 + imageTex.width/2;

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
  }
  
  void drawOutline() {

    noTexture();

    int nPts = gesturePoints.size();

    noFill();
    strokeWeight(0.5);
    stroke(1, 150);
    beginShape(LINE_STRIP);

    float time = speed * (float)millis()/1000;
    
    for (int i=0; i<nPts-1; i++) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;


      vertex( gesturePoints.get(i).x - offset.x, gesturePoints.get(i).y - offset.y);
      //vertex( gesturePoints.get(i).x + offset.x, gesturePoints.get(i).y + offset.y);
    }
    
    for (int i=nPts-2; i>=0; i--) {

      PVector p1 = new PVector(gesturePoints.get(i).x, gesturePoints.get(i).y);
      PVector p2 = new PVector(gesturePoints.get(i+1).x, gesturePoints.get(i+1).y);

      PVector d = p2.sub(p1);
      float a = atan2(d.y, d.x);
      float dist = d.mag() * sin( PI * float(i)/(nPts-1));

      PVector offset = new PVector();
      offset.x = cos ( a + PI/2 ) * dist;
      offset.y = sin ( a + PI/2 ) * dist;


      //vertex( gesturePoints.get(i).x - offset.x, gesturePoints.get(i).y - offset.y);
      vertex( gesturePoints.get(i).x + offset.x, gesturePoints.get(i).y + offset.y);
    }

    endShape();
  }
}