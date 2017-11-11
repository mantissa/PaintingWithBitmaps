
PImage img;
VectorField vectorField;
Gesture [] gestures; 
boolean drawVectorField;

void setup(){
  
    size(780, 800, P2D);
    
    img = loadImage("no-21.jpg");
    
    vectorField = new VectorField();
    vectorField.process( img, 20 );
    
    gestures = new Gesture[20];
    for(int i=0; i<gestures.length; i++){
        PVector p = new PVector( random(width), random(height));
        gestures[i] = new Gesture(p);
    }
    
    drawVectorField = false;
}

void draw(){
 
    background(255);
    
    image(img, 0, 0);
    
    if( drawVectorField ){
     
        vectorField.draw();
    }
    
    for(int i=0; i<gestures.length; i++){
      
       PVector gPos = new PVector(gestures[i].position.x, gestures[i].position.y);
       gPos.div(vectorField.gridSpacing);
      
       PVector vec = vectorField.getVector( gPos );
       PVector move = new PVector(vec.x, vec.y);
       //move.mult(0.2);
       move.normalize();
       move.mult(2);
       
       gestures[i].update(move); 
      
       gestures[i].draw();
       
       if( gestures[i].isOffscreen() ){
         
           gestures[i].position.set(  random(width), random(height) );
       }
    }
}

void keyPressed(){
 
    if( key == 'd'){
     
        drawVectorField = !drawVectorField;
    }
}