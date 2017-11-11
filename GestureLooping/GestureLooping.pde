
GestureLoop loop;

void setup(){
  
  size(1200, 400);
 
  loop = new GestureLoop();
}

void draw(){
  
    background(127);
 
    loop.draw();
}

void mousePressed(){
 
   loop.start(mouseX, mouseY);
}

void mouseDragged(){
 
  loop.addPoint(mouseX, mouseY);
}

void mouseReleased(){
 
   loop.stop();
   loop.loop();
}