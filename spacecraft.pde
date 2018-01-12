class Spacecraft {
  ArrayList<Bullet> bullets; 
  ArrayList<Bullet> toRemove = new ArrayList<Bullet>();
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float angle;
  
  float triangleScale;
  float triangleX;
  float triangleY;
  float engineX;
  float engineY;
  float engineWidth;
  float engineHeight;
  
  color spacecraftColor = color(255, 255, 255);
  color igniteColor = color(249, 2, 97);
  color engineColor = spacecraftColor;
  int heading = 0;
  
  float maxSpeed;
 
  Spacecraft() {
    bullets = new ArrayList<Bullet>();
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    angle = 0;
    
    triangleScale = 7;
    triangleX = triangleScale;
    triangleY = triangleScale-1;
    engineX = triangleX - 2;
    engineY = triangleY;
    engineWidth = triangleScale - 3.5;
    engineHeight = engineWidth;
    
    maxSpeed = 2;
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    noStroke();
    fill(255);
    triangle(-1*triangleX, triangleY, triangleX, triangleY, 0, -2*triangleY);
    fill(engineColor);
    rect(-1*engineX, engineY, engineWidth, engineHeight);
    rect(engineX-engineWidth, engineY, engineWidth, engineHeight);
    popMatrix();
    for(Bullet bullet : bullets) {
      bullet.update();
      bullet.display();
      if(bullet.hitTheWall()) {
        toRemove.add(bullet);
      }
      if(bullet.hitTheAsteroid()){
        toRemove.add(bullet);
      }
    }
    bullets.removeAll(toRemove);
    toRemove.clear();
  }
  
  void update() {
    angle += heading / 10.0;   
    acceleration = velocity.get();
    acceleration.normalize();
    acceleration.mult(-1);
    acceleration.div(100);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    
    if(location.x > width) {
      location.x -= width;
    } else if (location.x < 0) {
      location.x += width;
    } else if (location.y > height) {
      location.y -= height;
    } else if (location.y < 0) {
      location.y += height;
    }
   
  }
  
  void changeHeading(int val) {
    heading = val;
  }
  
  void accelerate() {
    acceleration = new PVector(cos(angle-PI/2), sin(angle-PI/2));
    acceleration.normalize();
    acceleration.div(30);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
  }
  
  void igniteEngine(boolean _switch) {
    if(_switch) {
      engineColor = igniteColor;
    } else {
      engineColor = spacecraftColor;
    }
  }
  
  void shot() {
    bullets.add(new Bullet(location.x, location.y, angle));
  }
  
  boolean hitTheAsteroid() {
    PVector point1 = new PVector(-1*triangleX, triangleY);
    PVector point2 = new PVector(triangleX, triangleY);
    PVector point3 = new PVector(0, -2*triangleY);
    point1.add(location);
    point2.add(location);
    point3.add(location);
    
    for(Asteroid asteroid : asteroids) {
      PVector sub1 = PVector.sub(point1, asteroid.location);
      PVector sub2 = PVector.sub(point2, asteroid.location);
      PVector sub3 = PVector.sub(point3, asteroid.location);
      float distance1 = sub1.mag();
      float distance2 = sub2.mag();
      float distance3 = sub3.mag();
      if(distance1 < (asteroid.size) / 2 ||
         distance2 < (asteroid.size) / 2 ||
         distance3 < (asteroid.size) / 2) {
        return true;
      } 
    }
    return false;
  }
}