
ArrayList<GestureLoop> loops;

GestureLoop loop;
PImage myImage;
boolean bDrawImg;

void setup() {

  size(457, 650, P2D);

  myImage = loadImage("../Sources/RothkoUntitled1946.jpg");
  myImage.loadPixels();

  loops = new ArrayList<GestureLoop>();

  bDrawImg = false;

  background(200);
}

void draw() {



  if ( bDrawImg) image(myImage, 0, 0);


  for ( GestureLoop l : loops) {

    l.update();
  }

  //stroke(0, 50);
  noStroke();
  fill(255, 0, 0);


  int nLoops = loops.size();
  for (int i=0; i<nLoops; i++) {

    if ( loops.get(i).getIsDrawing()) {

      PVector pt = loops.get(i).getPosition();

      if ( pt.x > 0 && pt.y > 0) {

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
          ellipse(px, py, sz*1.2, sz*1.2);

          fill( color(r, g, b));
          ellipse(px, py, sz, sz);
        }
      }
    }
  }

  if ( loop != null ) loop.draw();
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