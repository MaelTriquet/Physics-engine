class Point {
  PVector pos;
  PVector vel;
  PVector prev_pos;
  int radius = 20;
  boolean isStatic;

  Point(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    prev_pos = pos.copy();
  }

  Point(float x, float y, boolean isStatic_) {
    pos = new PVector(x, y);
    vel = new PVector();
    prev_pos = pos.copy();
    isStatic = isStatic_;
  }

  void show() {
    if (selected == this && pause) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    circle(pos.x, pos.y, radius);
  }

  void update(float friction) {
    if (!isStatic) {
      pos.add(vel);
      vel = pos.copy().sub(prev_pos);
      if (vel.mag() > 1) {
        vel.mult(1 - friction);
      } else if (vel.mag() > .3) {
        vel.mult(1 - 3*friction);
      } else if (vel.mag() > .05) {
        vel.mult(1 - 5 * friction);
      } else {
        vel.mult(1 - 7 * friction);
      }
      prev_pos = pos.copy();
    }
  }
}
