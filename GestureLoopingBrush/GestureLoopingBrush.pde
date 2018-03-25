
ArrayList<GestureLoop> loops;

GestureLoop loop;
PImage myImage;
boolean bDrawImg;
boolean isRecording;
PGraphics buffer;

void setup() {

  size(457, 650, P2D);
  frameRate(60);

  myImage = loadImage("../Sources/RothkoUntitled1946.jpg");
  myImage.loadPixels();

  loops = new ArrayList<GestureLoop>();

  bDrawImg = false;
  isRecording = false;

  buffer = createGraphics(width, height);
  buffer.beginDraw();
  background(200);
  buffer.endDraw();
}

void draw() {
  
  background(0);
  
  // draw the source image as the background
  // @note: press 'd' to toggle
  if ( bDrawImg) image(myImage, 0, 0);
  
  buffer.beginDraw();

  //stroke(0, 50);
  buffer.noStroke();
  buffer.fill(255, 0, 0);
  
  int nLoops = loops.size();
  for (int i=0; i<nLoops; i++) {

    //loops.get(i).draw();
    
    if ( loops.get(i).getIsDrawing() || true) {

      // get the position of the gesture loop
      PVector pt = loops.get(i).getPosition();

      if ( pt.x > 0 && pt.y > 0 ) {
        
        // create 5 marks simultanousely
        // marks are made randomly around the cursor
        int nMarks = 5;

        for (int j=0; j<nMarks; j++) {

          // create a random angle
          float a = random(TWO_PI);
         
          // and a random offset
          float d = random(0, 8);
          float rx = cos( a ) * d;
          float ry = sin( a ) * d;

          // contstrain the pts to the image size
          int px = (int)constrain( pt.x+rx, 0, width-1);
          int py = (int)constrain( pt.y+ry, 0, height-1);

          // get the pixel color
          int pix = myImage.pixels[ py * width + px];
          float sz = map( brightness(pix), 0, 255, 4, 20);
          
          // randomly adjust the brightness of the mark
          float br = random(0.8, 1.0);
          float r = red(pix)*br;
          float g = green(pix)*br;
          float b = blue(pix)*br;

          // draw a mark
          buffer.fill( color(r, g, b));
          buffer.ellipse(pt.x+rx, pt.y+ry, sz, sz);
        }
      }
    }
  }
  
  buffer.endDraw();
  
  image(buffer, 0, 0);
  
  // draw the current mark
  if ( isRecording ) loop.draw();
  
  // update all the recorded loops
  for ( GestureLoop l : loops) {
     l.update();
  }
}

void keyPressed() {

  if ( key == 'd') bDrawImg = !bDrawImg;
}

void mousePressed() {

  // create a new loop
  loop = new GestureLoop();
  loop.start(mouseX, mouseY);
  isRecording = true;
}

void mouseDragged() {

  // add a new point
  loop.addPoint(mouseX, mouseY);
}

void mouseReleased() {

  // stop recording & loop playback
  loop.stop();
  loop.loop();
  isRecording = false;

  // add to the array
  loops.add(loop);
  loop = null;
}