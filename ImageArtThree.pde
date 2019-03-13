//Click to start

PImage galaxy;
PImage foreground;
popper[] p;
int count = 0;


void setup(){
  size(960, 540);
  galaxy = loadImage("galaxy.jpg");
  galaxy.resize(width, height);
  foreground = new PImage(width, height);
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      foreground.set(i, j, 0); 
    }
  }
  background(0);
}

void draw(){
  image(galaxy, 0, 0);
  image(foreground, 0, 0);
  try{
    if(frameCount - count == 120){
      p = new popper[60];
      for(int i = 0; i < p.length; i++){
      p[i] = new popper(); 
      count = frameCount;
  }
    }
    for(popper x : p){
      x.update();
      x.display();
    }
  } catch(NullPointerException e) {
    
  }
}

void mousePressed(){
  p = new popper[60];
  for(int i = 0; i < p.length; i++){
    p[i] = new popper(); 
  }
}

class popper{
  int x;
  int y;
  float[] particleAccelerations;
  PVector[] particles;
  float acceleration;
  
  popper(){
    x = int(random(50, width - 50));
    y = int(random(20, height - 50));
    particleAccelerations = new float[5];
    particles = new PVector[5];
    for(int i = 0; i < particles.length; i++){
      particles[i] = new PVector(0, 0);
    }
    float angleAccel = -1;
    for(int i = 0; i < particleAccelerations.length; i++){
       particleAccelerations[i] = angleAccel;
       angleAccel += 0.5;
    }
    acceleration = 0;
  }
  
  void update(){
     acceleration += 0.2;
     for(int i = 0; i < particles.length; i++){
       particles[i].y += acceleration;
       particles[i].x += particleAccelerations[i];
       particleAccelerations[i] *= 0.99;
     }
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    fill(255);
    for(int i = 0; i < particles.length; i++){
      ellipse(particles[i].x, particles[i].y, 2, 2); 
      for(int k = 0; k < 3; k++){
        for(int j = 0; j < 3; j++){
          foreground.set(int(x + k + particles[i].x), int(y + j + particles[i].y), color(0,0,0,0)); 
        }
      }
    }
    popMatrix();
  }
}