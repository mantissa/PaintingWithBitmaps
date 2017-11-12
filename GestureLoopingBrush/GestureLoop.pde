
class GesturePoint {

  GesturePoint( float x, float y, long time ) {

    this.point = new PVector(x, y);
    this.time = time;
  }

  PVector point;
  long time;
}

class GestureLoop {

  GestureLoop() {

    points = new ArrayList<GesturePoint>();
    isDrawing = false;
    loopLengthMs = 2000;
  }

  void update() {

    if ( isLooping ) {

      long elapsed = (millis() - loopStartMs);

      if ( elapsed >= 1.1 * gestureDurMs ) {

        loop();
        
      } else {

        int nPts = points.size();

        if ( points.size() > 0 ) {

          if ( currentPos < nPts -1 && elapsed >= points.get(currentPos+1).time ) {

            currentPos++;
          }
        }
      }
    }
  }

  void draw() {

    drawDebug();
  }

  void drawDebug() {

    noFill();
    stroke(0);

    beginShape();

    for ( GesturePoint p : points ) {
      vertex( p.point.x, p.point.y );
    }

    endShape();
  }

  void start(float x, float y) {

    points.clear();

    points.add( new GesturePoint(x, y, 0) );

    gestureStartMs = millis();
    isDrawing = true;
  }

  void addPoint( float x, float y) {

    long elapsed = millis() - gestureStartMs;

    points.add( new GesturePoint(x, y, elapsed) );
  }

  void stop() {

    gestureDurMs = millis() - gestureStartMs;
    isDrawing = false;
  }

  void loop() {

    isLooping = true;
    loopStartMs = millis();
    currentPos = 0;
  }

  boolean getIsDrawing() {

    long elapsed = millis() - loopStartMs;
    return elapsed < gestureDurMs;
  }

  PVector getPosition() {

    if ( points.size() == 0) {

      return new PVector();
    }

    return points.get(currentPos).point;
  }

  ArrayList<GesturePoint> points;

  long gestureDurMs;
  long gestureStartMs;
  int currentPos;

  long loopStartMs;
  long loopLengthMs;

  boolean isDrawing;
  boolean isLooping;
}