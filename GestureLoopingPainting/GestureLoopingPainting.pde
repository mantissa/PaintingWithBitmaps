
ArrayList<GestureLoop> loops;
ArrayList<QuadStripBrush> brushes;
GestureLoop loop;
PImage myImage;
boolean bDrawImg;

void setup() {

  size(780, 800, P2D);

  myImage = loadImage("no-21.jpg");
  myImage.loadPixels();

  loops = new ArrayList<GestureLoop>();
  brushes = new ArrayList<QuadStripBrush>();
  
  bDrawImg = true;
}

void draw() {

    background(127);
  
    
    if( bDrawImg) image(myImage, 0, 0);
  
    
    for ( GestureLoop l : loops) {

      l.draw();
    }
    
    //stroke(0, 50);
    noStroke();
    fill(255, 0, 0);

    int nLoops = loops.size();
    for (int i=0; i<nLoops; i++) {

      QuadStripBrush b = new QuadStripBrush();
      b.addVertices( loops.get(i).getPoints() );   
      b.draw();
    }
  
  
  if ( loop != null ) loop.draw();
}

void keyPressed(){
 
    if( key == 'd') bDrawImg = !bDrawImg;
}

void mousePressed() {

  loop = new GestureLoop();

  loop.start(mouseX, mouseY);
}

void mouseDragged() {

  loop.addPoint(mouseX, mouseY);
}

void mouseReleased() {

  loop.stop();
  loop.loop();

  loops.add(loop);

  loop = null;
}