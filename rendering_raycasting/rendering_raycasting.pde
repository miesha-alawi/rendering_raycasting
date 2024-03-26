ArrayList<boundary> walls = new ArrayList<boundary>();
int wallsn = 9;
ray r;
particle p;
float yoff = 0;
float xoff = 100;
float sceneW;
float sceneH;


void setup() {
  size(800,400);
  //hard coded scene height and width so that it only takes up
  //half the screen
  sceneW = width/2;
  sceneH = height;
  p = new particle();
  for(int i = 0; i < 5; i++) {
    float x1 = random(sceneW);
    float x2 = random(sceneW);
    float y1 = random(sceneH);
    float y2 = random(sceneH);
    walls.add(new boundary(x1,y1,x2,y2));
  }
  //box boundary walls
  walls.add(new boundary(0,0,sceneW,0));
  walls.add(new boundary(sceneW,0,sceneW,sceneH));
  walls.add(new boundary(sceneW,sceneH,0,sceneH));
  walls.add(new boundary(0,sceneH,0,0));
}

//for user to interact
//to rotate the particle or change field of view
void keyPressed() {
  if(key == 'a') {
    p.rota(0.1);
  } else if (key == 'z') {
    p.rota(-0.1);
  }
  else if(key == 's') {
    p.updateFOV(p.fov+=1);
  }
  else if(key == 'f') {
    p.updateFOV(p.fov-=1);
  }
}

void draw() {
  background(0);
  for(boundary w: walls) {
    w.draw();
  }
  p.draw();
  //using perlin noise to move particle about
  p.update(noise(xoff)*sceneW,noise(yoff)*sceneH);
  xoff += 0.01;
  yoff += 0.01;
  
  ArrayList<Double> scene;
  scene = p.look(walls);
  float w = sceneW / scene.size();
  push();
  translate(sceneW,0);
  for(int i = 0; i < scene.size(); i++) {
    noStroke();
    //map fill colour so that as its further away it is darker
    int b = (int)map(scene.get(i).intValue(),0,sceneW,255,0);
    //map wall height so that as its closer it is taller
    float h = map(scene.get(i).intValue(), 0 , sceneW, sceneH, 0);
    fill(b);
    rectMode(CENTER);
    rect(i*w+w/2,sceneH/2,w+1,h);
  }
  pop();
}
