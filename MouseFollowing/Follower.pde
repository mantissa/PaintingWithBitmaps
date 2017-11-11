
class Follower {

  PVector pos;
  float angle;
  float dist;
  float sz;
  float index;
  float speed;
  float alpha;
  float mult;

  Follower() {
    
    println("hi");

    pos = new PVector();
    angle = random(TWO_PI);
    dist = random(12, 30);
    index = random(1000);
    speed = random(0.035*0.25, 0.035);
  }

  void follow( PVector p ) {
    
    float d = getDistance(mouseX, mouseY, pmouseX, pmouseY);

    sz = abs( cos( angle * 0.1) )* 12;
    dist = noise( angle * 0.05, index ) * 35; //5 * d  + 5; 
    alpha = noise( angle * 0.1, index ) * 127;
    mult = noise( angle * 0.1, index ) * 2.0; 

    pos.x = p.x + cos( angle ) * dist;
    pos.y = p.y + sin( angle ) * dist;

    angle += speed * d;
  }

  void draw() {

    float d = getDistance(mouseX, mouseY, pmouseX, pmouseY);
    
    if( d == 0 ) return;
    
    float x = pos.x;
    float y = pos.y;

    x = clamp(x, 0, width);
    y = clamp(y, 0, height);

    int c = myImage.pixels[ int(mouseY) * width + int(mouseX) ];
    float r = red(c)  * mult;
    float g = green(c)  * mult;
    float b = blue(c)  * mult;

    // set the draw color
    fill( r, g, b);
    //stroke(r, g, b, 20);

    strokeWeight(sz+10);

    ellipse( x, y, sz, sz);
  }

  // keeps a (float) value within a specified range

  float clamp( float value, float min, float max ) {

    value = max( value, min );
    value = min( value, max );

    return value;
  }

  float getDistance( float x1, float y1, float x2, float y2) {

    return sqrt( pow(x2 -x1, 2) + pow(y2 -y1, 2));
  }
}