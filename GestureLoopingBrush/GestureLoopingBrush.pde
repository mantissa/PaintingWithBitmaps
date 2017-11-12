
ArrayList<GestureLoop> loops;

GestureLoop loop;
PImage myImage;
boolean bDrawImg;
PGraphics buffer;

void setup() {

  size(457, 650, P2D);
  frameRate(60);

  myImage = loadImage("../Sources/RothkoUntitled1946.jpg");
  myImage.loadPixels();

  loops = new ArrayList<GestureLoop>();

  bDrawImg = false;

  buffer = createGraphics(width, height);
  buffer.beginDraw();
  background(200);
  buffer.endDraw();
}

void draw() {
  
  background(200);
  
  if ( bDrawImg) image(myImage, 0, 0);
  
  buffer.beginDraw();
  
  

  //stroke(0, 50);
  noStroke();
  fill(255, 0, 0);
  
  int nLoops = loops.size();
  for (int i=0; i<nLoops; i++) {

    //loops.get(i).draw();
    
    if ( loops.get(i).getIsDrawing() || true) {

      PVector pt = loops.get(i).getPosition();

      fill(#ff0000);
      //ellipse(pt.x, pt.y, 5, 5);

      if ( pt.x > 0 && pt.y > 0 ) {

        for (int j=0; j<5; j++) {

          float a = random(TWO_PI);
          float d = random(0, 8);

          float rx = cos( a ) * d;
          float ry = sin( a ) * d;

          int px = (int)constrain( pt.x+rx, 0, width-1);
          int py = (int)constrain( pt.y+ry, 0, height-1);

          int pix = myImage.pixels[ py * width + px];
          float sz = map( brightness(pix), 0, 255, 4, 20);
          float br = random(0.8, 1.0);

          float r = red(pix)*br;
          float g = green(pix)*br;
          float b = blue(pix)*br;

          fill( 0, 50);
          ellipse(pt.x+rx, pt.y+ry, sz*1.2, sz*1.2);

          fill( color(r, g, b));
          ellipse(pt.x+rx, pt.y+ry, sz, sz);
        }
      }
    }
  }
  
  buffer.endDraw();
  
  image(buffer, 0, 0);
  
  //if ( loop != null ) loop.draw();
  
  for ( GestureLoop l : loops) {

    l.update();
  }

  
}

void keyPressed() {

  if ( key == 'd') bDrawImg = !bDrawImg;
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