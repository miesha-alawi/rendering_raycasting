class particle {
  int fov;
  PVector pos;
  ArrayList<ray> rays;
  int rayn;
  float heading;
  particle() {
    pos = new PVector(width/2,height/2);
    rays = new ArrayList<ray>();
    heading = 0;
    fov = 45;
    for(int i = -fov/2; i < fov/2; i+= 1) {
     rays.add(new ray(pos , radians(i) + heading));
    }
  }
  
  //to rotate the particle on an angle
  void rota(float angle) {
    heading += angle;
    int index = 0;
    for(int i = -fov/2; i < fov/2; i+= 1) {
     rays.get(index).setAngle(radians(i)+heading);
     index++;
    }
  }
  
  void updateFOV(int amount) {
    fov = amount;
    rays.clear();
    for(int i = -fov/2; i < fov/2; i+= 1) {
     rays.add(new ray(pos , radians(i)));
    }
    
  }
  
  //to look for boundaries and see how close or far they are
  ArrayList<Double> look(ArrayList<boundary> wa) {
    ArrayList<Double> sc = new ArrayList<Double>();
    for(ray r : rays) {
      PVector closest = null;
      double record = Double.POSITIVE_INFINITY;
      for(boundary w: wa) {
        PVector pt = r.cast(w);
        if(pt != null) {
          float d = PVector.dist(pos,pt);
          float a = r.dir.heading() - heading;
          d *= cos(a);
          if(d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if(closest != null) {
        stroke(255,100);
        line(pos.x,pos.y, closest.x,closest.y);
      } 
      sc.add(record);
    }
    
    return sc;
  }
  
  void update(float x, float y) {
    pos.set(x,y);
  }
  
   void draw() {
     fill(255);
     ellipse(pos.x,pos.y,4,4);
     for(ray r : rays) {
       r.draw();
     }
   }

}
