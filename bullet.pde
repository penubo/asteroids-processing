class Bullet {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float size;
  
  Bullet(float x, float y, float _angle) {
    location = new PVector(x, y);
    velocity = new PVector(cos(_angle-PI/2), sin(_angle-PI/2));
    velocity.normalize();
    velocity.mult(4);
    size = 3;
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    fill(0);
    ellipseMode(CENTER);
    ellipse(0, 0, size, size);
    popMatrix();
  }
  
  void update() {
    location.add(velocity);
  }
  
  boolean hitTheWall() {
    if(location.x > width || location.y > height ||
    location.x < 0 || location.y < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean hitTheAsteroid() {
    for(Asteroid asteroid : asteroids) {
      PVector sub = PVector.sub(location, asteroid.location);
      float distance = sub.mag();
      if(distance < (size + asteroid.size) / 2 ) {
        asteroid.attacked();
        return true;
      } 
    }
    return false;
  }
}