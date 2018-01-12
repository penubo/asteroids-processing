class Asteroid {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float size;
  
  Asteroid(float x, float y, float _size) {
    location = new PVector(x, y);
    velocity = PVector.sub(spacecraft.location, location);
    velocity.normalize();
    size = _size;
  }
  
  void display() {
    pushMatrix();
    fill(255, 100);
    ellipseMode(CENTER);
    ellipse(location.x, location.y, size, size);
    popMatrix();
  } 
  
  void update() {
    location.add(velocity);
  }
  
  void attacked() {
    ArrayList<Asteroid> toRemoveAsteroid = new ArrayList<Asteroid>();
    toRemoveAsteroid.add(this);
    float newSize;
    if(size > 30) {
      newSize = size / 2;
      Asteroid asteroidA = new Asteroid(location.x + 1, location.y, newSize);
      Asteroid asteroidB = new Asteroid(location.x - 1, location.y, newSize);
      asteroidA.changeDirection(1);
      asteroidB.changeDirection(-1);
      asteroids.add(asteroidA);
      asteroids.add(asteroidB);
    }
    asteroids.removeAll(toRemoveAsteroid);
  }
  
  boolean hitTheWall() {
    if(location.x > width || location.y > height ||
    location.x < 0 || location.y < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  
  
  void changeDirection(int offset) {
    if(offset > 0) {
      velocity.x *= -1;
    } else {
      velocity.y *= -1;
    }
  }
}