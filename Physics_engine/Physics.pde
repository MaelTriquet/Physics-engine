class Physics {
  ArrayList<Point> points = new ArrayList<Point>();
  ArrayList<Spring> springs = new ArrayList<Spring>();
  PVector gravity = new PVector();
  PVector heightBoundaries = new PVector(0, height);
  PVector widthBoundaries = new PVector(0, width);
  float collisionFriction = .9;
  float friction = .006;

  Physics() {
  }

  void setGravity(PVector gravity_) {
    gravity = gravity_.copy();
  }
  
  void show() {
    for (Spring s : springs) {
      s.show();
    }
    for (Point p : points) {
      p.show();
    }
  }
  
  void update() {
    for (Point p : points) {
      applyGravity(p);
      checkBoundaries(p);
      p.update(friction);
    }
    
    for (Spring s : springs) {
      s.applyConstraint();
    }
  }
  
  void checkBoundaries(Point p) {
    if (p.pos.x - p.radius/2 < widthBoundaries.x) {
      p.pos.x = p.radius/2 + widthBoundaries.x;
      p.vel.mult(collisionFriction);
    }
    if (p.pos.x + p.radius/2 > widthBoundaries.y) {
      p.pos.x = -p.radius/2 + widthBoundaries.y;
      p.vel.mult(collisionFriction);
    }
    if (p.pos.y - p.radius/2 < heightBoundaries.x) {
      p.pos.y = p.radius/2 + heightBoundaries.x;
      p.vel.mult(collisionFriction);
    }
    if (p.pos.y + p.radius/2 > heightBoundaries.y) {
      p.pos.y = -p.radius/2 + heightBoundaries.y;
      p.vel.mult(collisionFriction);
    }
  }
  
  void applyGravity(Point p) {
    p.vel.add(gravity);
  }
}
