
PImage myImage;

Gesture [] gestures;

void setup() {

  size(1200, 600, P3D);
  //hint(DISABLE_DEPTH_TEST);

  myImage = loadImage( "no-21.jpg" );
  myImage.loadPixels();

  /*
    Float aa = new Float(1.0);
   PVector tt = new PVector(1, 0, 0);
   test(aa, tt);
   println( aa + " " + tt);
   
   test2(aa);
   println( aa)
   */

  gestures = new Gesture[600];
  
  for(int i=0; i<gestures.length; i++){
    
    gestures[i] = new Gesture();
    gestures[i].index = (int)random(40);
    
    int rX = (int)random(width-1);
    int rY = (int)random(height-1);
    
    gestures[i].c = myImage.pixels[ rY * myImage.width + rX];
    //gestures[i].thickness = map(brightness(gestures[i].c), 0, 255, 1, 30);
  }
  
}

void draw() {
  
  

  float t = 0.1 * float(millis())/1000;
  
  for(Gesture g : gestures ){
    g.create(t);
  }
  
  /*
  float angle = map(mouseX, 0, width, 0, 360);
  //println( "angle "+angle );

  Quaternion q = new Quaternion();
  q.makeRotate( angle, 0, 0, 1);

  PVector pt = new PVector(100, 0, 0);
  pt = q.rotate( pt );
  
  println(pt);
  */
  
 
  
  background(127);
  
  for(Gesture g : gestures){
    g.draw(t);
  }
  
  /*
  
  pushMatrix();
  
  translate(width/2, height/2);
  
  stroke(0);
  
  line( 0, 0, pt.x, pt.y);
  
  popMatrix();
  
  */
  
  //println(pt);
}

void test( Float a, PVector pv ) {

  a = 100.0;
  pv.x = -1;
  pv.y = 0;
  pv.z = 0;
}

void test2( float a ) {

  a = a * 2;
}