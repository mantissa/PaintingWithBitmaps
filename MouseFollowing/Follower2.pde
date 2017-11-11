
class Follower2 extends Follower {

  float spread;
  float heading;

  Follower2() {

    println("follower2");

    spread = random(-10, 10);
    ;
  }

  void follow( PVector p ) {

    heading = atan2(mouseY-pmouseY, mouseX-pmouseX);
    float d = getDistance(mouseX, mouseY, pmouseX, pmouseY);

    d = map(d, 0, 10, 0.0, 2.0);
    //d = constrain( d, 0.0, 2.0);

    dist = spread * constrain(d, 0.2, 10.0) ; //random(-10, 10);
    sz = (pow(d, 1.5)+1) * abs(sin(angle)) * 5;
    sz = constrain( sz, 1.0, 120);
    //dist = noise( angle * 0.05, index ) * 35; //5 * d  + 5; 
    alpha = noise( angle * 0.1, index ) * 20;
    mult = noise( angle * 0.1, index ) * 2.0; 
    
    PVector offset = new PVector(random(-20, 20), 0);
    offset.rotate( (heading));
    

    pos.x = p.x + cos( heading + PI/2 ) * (dist ) + offset.x; //+ random(-100, 100));
    pos.y = p.y + sin( heading + PI/2) * (dist ) + offset.y; // + random(-10, 3));

    angle += speed * d;
  }

  void draw() {

    float d = getDistance(mouseX, mouseY, pmouseX, pmouseY);

    if ( d == 0 ) return;

    float x = pos.x;
    float y = pos.y;

    x = clamp(x, 0, width);
    y = clamp(y, 0, height);

    int c = myImage.pixels[ int(mouseY) * width + int(mouseX) ];
    float r = red(c)  * mult;
    float g = green(c)  * mult;
    float b = blue(c)  * mult;

    // set the draw color
    //stroke(r, g, b, 10);
    fill( r, g, b);
    //stroke(r, g, b, 20);

    strokeWeight((20)); //*constrain(d, 0.0, 1.0));

    pushMatrix();

    translate( x, y );

    rotate( heading  + random(-PI/8, PI/8)  );

    ellipseMode(CENTER);

    ellipse( 0, 0, sz, sz*0.5 );

    popMatrix();

    //ellipse( x, y, 20 * sin( heading ), 10 * cos(heading));
  }
}