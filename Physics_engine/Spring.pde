class Spring {
  Point from;
  Point to;
  float len;
  boolean rigid;
  float k;

  Spring(Point from_, Point to_, float len_) {
    from = from_;
    to = to_;
    len = len_;

    rigid = true;
  }

  Spring(Point from_, Point to_, float len_, float k_) {
    from = from_;
    to = to_;
    len = len_;
    rigid = false;
    k = k_/100;
  }

  void show() {
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
  }

  void applyConstraint() {
    if (!(from.isStatic || to.isStatic)) {
      float distance = dist(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
      float dx = distance - len;
      PVector diff;
      if (!rigid) {
        diff = to.pos.copy().sub(from.pos).setMag(dx).mult(.5 * k);
        from.vel.add(diff);
        to.vel.sub(diff);
      } else {
        diff = to.pos.copy().sub(from.pos).setMag(dx * .5);
        from.pos.add(diff);
        to.pos.sub(diff);
      }
    } else if (from.isStatic && !to.isStatic) {
      float distance = dist(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
      float dx = distance - len;
      PVector diff;
      if (!rigid) {
        diff = to.pos.copy().sub(from.pos).setMag(dx).mult(.5 * k);
        to.vel.sub(diff);
      } else {
        diff = to.pos.copy().sub(from.pos).setMag(dx);
        to.pos.sub(diff);
      }
    } else if (!from.isStatic && to.isStatic) {
      float distance = dist(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
      float dx = distance - len;
      PVector diff;
      if (!rigid) {
        diff = to.pos.copy().sub(from.pos).setMag(dx).mult(.5 * k);
        from.vel.add(diff);
      } else {
        diff = to.pos.copy().sub(from.pos).setMag(dx);
        from.pos.add(diff);
      }
      from.vel.add(diff);
    }
  }
}
