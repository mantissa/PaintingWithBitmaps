
size(600, 600);

background(0);

colorMode(HSB, 360, 255, 255, 255);

for(int i=0; i<10; i++){
    for(int j=0; j<10; j++){
  
        float h = map(i, 0, 9, 0, 200);
        float br = map(j, 0, 9, 50, 255);
        color c = color( h, 255, br);
        fill(c);
        stroke(c);
        
        rect(i*60, j*60, 60, 60);
    }
}

save( "pix.png");