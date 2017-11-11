
ArrayList<GestureLoop> loops;
GestureLoop loop;

void setup(){
  
  size(1200, 400);
 
  loops = new ArrayList<GestureLoop>();
}

void draw(){
  
    background(127);
 
    if( loop != null ) loop.draw();
    
    for( GestureLoop l : loops){
     
        l.draw();
    }
}

void mousePressed(){
 
   loop = new GestureLoop();
  
   loop.start(mouseX, mouseY);
}

void mouseDragged(){
 
  loop.addPoint(mouseX, mouseY);
}

void mouseReleased(){
 
   loop.stop();
   loop.loop();
   
   loops.add(loop);
   
   loop = null;
}