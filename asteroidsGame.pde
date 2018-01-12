IntDict keys;
Spacecraft spacecraft;
ArrayList<Asteroid> asteroids;
ArrayList<Asteroid> toRemoveAsteroids;
int shootFrame;
boolean running;

void setup() {
  size(400, 600);
  spacecraft = new Spacecraft();
  asteroids = new ArrayList<Asteroid>();
  toRemoveAsteroids = new ArrayList<Asteroid>();
  keys = new IntDict();
  keys.set("z", 0);
  keys.set("RIGHT", 0);
  keys.set("LEFT", 0);
  keys.set("x", 0);
  running = true;
}

void draw() {
  background(91);
  if(running) {
  if(spacecraft.hitTheAsteroid()) {
    running = false;
  }
  spacecraft.update();
  spacecraft.display();
  
  if(random(1) > 0.99) {
    asteroids.add(new Asteroid(random(width), random(height), random(10, 40)));
  }
  
  if(keys.get("z") == 1) {
    spacecraft.accelerate();
    spacecraft.igniteEngine(true);
  } else {
    spacecraft.igniteEngine(false);
  }
  if(keys.get("x") == 1) {
    if (shootFrame % 10 == 0) {
      spacecraft.shot();
    }
    shootFrame++;
  }
  if(keys.get("RIGHT") == 1) {
    spacecraft.changeHeading(1);
  } else if(keys.get("LEFT") == 1) {
    spacecraft.changeHeading(-1);
  } else {
    spacecraft.changeHeading(0);
  }
   
  for(Asteroid asteroid : asteroids) {
    if(asteroid.hitTheWall()) {
      toRemoveAsteroids.add(asteroid);
    }
    asteroid.update();
    asteroid.display();   
  }
  asteroids.removeAll(toRemoveAsteroids);
  toRemoveAsteroids.clear();
  } else {
    background(255);
    fill(0);
    textAlign(CENTER);
    text("Game Over", width/2, height/2);
    text("press any key to retry", width/2, height/2 + 20);
    if(keyPressed) {
      setup();
    }
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      keys.set("RIGHT", 1);
      keys.set("LEFT", 0);
    } else if (keyCode == LEFT) {
      keys.set("LEFT", 1);
      keys.set("RIGHT", 0);
    }
  } else if(key == 'z' && keys.get("z") != 1) {
    keys.set(Character.toString(key), 1);
  } else if(key == 'x' && keys.get("x") != 1) {
    keys.set(Character.toString(key), 1);
    shootFrame = 0;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      keys.set("RIGHT", 0);
    } else if (keyCode == LEFT) {
      keys.set("LEFT", 0);
    }
  } else if(key == 'z' || key == 'x') {
    keys.set(Character.toString(key), 0);
  }
}