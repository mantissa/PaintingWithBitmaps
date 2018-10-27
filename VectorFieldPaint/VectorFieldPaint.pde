
PImage img;
PImage imgBlur;
VectorField vectorField;
Gesture [] gestures; 
boolean drawVectorField;
boolean drawImage;
boolean drawBlur;
boolean drawShapes;

void setup(){
  
    size(780, 800, P2D);
    
    img = loadImage("no-21.jpg");
    imgBlur = loadImage("no-21gray.jpg");
    
    vectorField = new VectorField();
    vectorField.process( imgBlur, 20 );
    
    gestures = new Gesture[80];
    for(int i=0; i<gestures.length; i++){
        PVector p = new PVector( random(width), random(height));
        gestures[i] = new Gesture(p);
    }
    
    drawVectorField = false;
    drawImage = false;
    drawBlur = false;
    drawShapes = true;
}

void draw(){
 
    //background(171,  0,  9);;
    background(227, 97,11);
    
    if( drawImage ) image(img, 0, 0);
    if( drawBlur ) image(imgBlur, 0, 0);
    if( drawVectorField ) vectorField.draw();
    
    for(int i=0; i<gestures.length; i++){
      
       PVector gPos = new PVector(gestures[i].position.x, gestures[i].position.y);
       gPos.div(vectorField.gridSpacing);
      
       //PVector vec = vectorField.getVectorInterpolated( gPos );
       PVector vec = vectorField.getVector( gPos );
       PVector move = new PVector(vec.x, vec.y);

        // normalize
       //move.normalize();
       
       // minimum speed (x or y)
       
       float min = 2;
       boolean useMinX = false;
       boolean useMinY = false;
       
       if( useMinX ){
         
         boolean dirX = move.x < 0.0;
       
         if( dirX){
             
           move.x = max( abs(move.x), min ) * -1;
           
         } else {
           
           move.x = max( move.x, min );
         }
       }
       
       if( useMinY){
         
         boolean dirY = move.y < 0.0;
       
         if( dirY){
             
           move.y = max( abs(move.y), min ) * -1;
           
         } else {
           
           move.y = max( move.y, min );
         }
       }
       
       // how fast?
       move.mult(100);
       
       // direction smoothing (lower looks better)
       gestures[i].direction.lerp( move, 0.1);
      
       gestures[i].update(gestures[i].direction); 
      
       if( drawShapes ) gestures[i].draw();
       
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
    if( key == 's') drawShapes = !drawShapes;
}