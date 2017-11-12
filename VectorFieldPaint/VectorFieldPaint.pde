
PImage img;
PImage imgBlur;
VectorField vectorField;
Gesture [] gestures; 
boolean drawVectorField;
boolean drawImage;
boolean drawBlur;

void setup(){
  
    size(780, 800, P2D);
    
    img = loadImage("no-21.jpg");
    imgBlur = loadImage("no-21gray.jpg");
    
    vectorField = new VectorField();
    vectorField.process( imgBlur, 20 );
    
    gestures = new Gesture[600];
    for(int i=0; i<gestures.length; i++){
        PVector p = new PVector( random(width), random(height));
        gestures[i] = new Gesture(p);
    }
    
    drawVectorField = false;
    drawImage = false;
    drawBlur = false;
}

void draw(){
 
    background(200);
    
    if( drawImage ) image(img, 0, 0);
    if( drawBlur ) image(imgBlur, 0, 0);
    
    if( drawVectorField ){
     
        vectorField.draw();
    }
    
    for(int i=0; i<gestures.length; i++){
      
       PVector gPos = new PVector(gestures[i].position.x, gestures[i].position.y);
       gPos.div(vectorField.gridSpacing);
      
       PVector vec = vectorField.getVectorInterpolated( gPos );
       //PVector vec = vectorField.getVector( gPos );
       PVector move = new PVector(vec.x, vec.y);
       
       boolean dirX = move.x < 0.0;
       boolean dirY = move.y < 0.0;
       

       //move.normalize();
       //move.mult(2);
       
       float min = 0.25;
       
       if( dirX){
           
         move.x = max( abs(move.x), min ) * -1;
         
       } else {
         
         move.x = max( move.x, min );
       }
       
       if( dirY){
           
         move.y = max( abs(move.y), min ) * -1;
         
       } else {
         
         move.y = max( move.y, min );
       }
       
       
       //move.y = max( move.y, 0.1 );
       //move.mult(0.2);
       
       //move.mult(2);
       
       gestures[i].direction.lerp( move, 0.5);
      
       gestures[i].update(gestures[i].direction); 
      
       gestures[i].draw();
       
       if( gestures[i].isOffscreen() || gestures[i].nFrames > gestures[i].loopDuration){
         
           gestures[i].bEndShape = true;
           
           if( gestures[i].points.size() == 0){
            
               gestures[i].reset();
               gestures[i].position.set(  random(width), random(height) );
           }
  
       }
    }
}

void keyPressed(){
 
    if( key == 'd') drawVectorField = !drawVectorField;
    if( key == 'i') drawImage = !drawImage;
    if( key == 'b') drawBlur = !drawBlur;
}