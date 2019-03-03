
class Brush {
 
    float x;
    float y;
    float h;
    float speed;
    float index;
    
    float px;
    float py;
    float pxspeed;
    
    Brush( float x_, float y_, float h_, float speed_ ){
     
        x = x_;
        y = y_;
        h = h_;
        speed = speed_;
        
        px = random( width );
        py = random( height-h);
        
        index = random(1000);
        
        pxspeed = random( 0.25, 0.5);
    }
    
    void move(){
     
        x += speed;
        
        if( x > width ){
         
            x = 0;
            
            y = random( 0, height-h);
        }
        
        
        px += pxspeed;
        
        if( px > width ){
         
            px = 0;
            
            //y = random( 0, height-h);
        }
        
    }
    
    void draw(){
      
        //float px2 = px + noise( 5.0 * float(millis())/1000, index ) * 100. - 50.;
      
        //tint(255, 127);
      
        beginShape(QUAD);
        texture(cam);
        vertex( x, y, px, py );
        vertex( x+speed, y, px, py);
        vertex( x+speed, y+h, px, py+h*2);
        vertex( x, y+h, px, py+h*2);
        endShape(CLOSE);
    }
}