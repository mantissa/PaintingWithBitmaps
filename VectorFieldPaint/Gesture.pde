
class Gesture {
 
    PVector position;
    PVector lastPosition;
    int numFrames;
    
    Gesture(PVector pos) {
     
        position = new PVector(pos.x, pos.y); 
        
        reset();
    }
    
    void update(PVector dir){
      
        position.add(dir);
    }
    
    boolean isOffscreen(){
     
        return position.x < 0 || position.x > width || position.y < 0 || position.y > height;
    }
    
    void draw(){
     
        fill(0);
        ellipse( position.x, position.y, 5, 5);
    }
    
    void reset(){
     
        numFrames = 0;
    }
}