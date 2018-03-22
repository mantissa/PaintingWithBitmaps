
ArrayList<GestureLoop> loops;
GestureLoop loop;

void setup(){
  
  size(1200, 400);
 
  loops = new ArrayList<GestureLoop>();
}

void draw(){
  
    background(127);
 
    if( loop != null ) loop.draw();
    
    stroke(0);
    
    for( GestureLoop l : loops){
     
        l.draw();
    }
    
   for( GestureLoop l : loops){
    
       if( !l.getIsShrinking()){
         
           PVector pt = l.getPosition();
       
   
         fill(255, 0, 0);
         stroke(255, 0, 0);
         ellipse( pt.x, pt.y, 3, 3);
       }
     
       
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