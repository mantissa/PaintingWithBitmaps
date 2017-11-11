
PImage myImage;

Follower [] followers;

void setup(){
 
    size( 780, 800 );
    frameRate(60);
    
    // load an image, assign it to myImage
    myImage = loadImage("no-21.jpg");
    
    // make the pixels available for sampling
    myImage.loadPixels();
    
    followers = new Follower[20];
    
    for(int i=0; i<followers.length; i++){
     
        followers[i] = new Follower();
    }
    
    stroke(0, 10);
    strokeWeight(2);
}

void draw(){
  
    //background(200);
 
    for(int i=0; i<followers.length; i++){
     
        followers[i].follow( new PVector(mouseX, mouseY));
        followers[i].draw();
    }
}

void keyPressed(){
 
    if( key == 'c') background(200);
}