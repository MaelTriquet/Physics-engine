Physics world;
Point selected;
boolean pause = true;

void setup() {
  size(800, 800);
  fill(0);
  stroke(0);
  world = new Physics();
  world.setGravity(new PVector(0, .1));
}

void draw() {
  background(255);
  println(frameRate);
  world.show();
  if (!pause) {
    world.update();
  }
}

void mousePressed() {
  if (pause) {
    boolean done = false;
    for (Point p : world.points) {
      if (dist(p.pos.x, p.pos.y, mouseX, mouseY) < p.radius / 2) {
        done = true;
        if (selected == null) {
          selected = p;
        } else {
          world.springs.add(new Spring(selected, p, dist(selected.pos.x, selected.pos.y, p.pos.x, p.pos.y), 3));
          selected = null;
        }
      }
    }
    if (!done) {
      world.points.add(new Point(mouseX, mouseY));
    }
  }
}


void mouseDragged() {
  if (!pause) {
    for (Point p : world.points) {
      if (dist(p.pos.x, p.pos.y, mouseX, mouseY) < p.radius / 2) {
        p.pos = new PVector(mouseX, mouseY);
      }
    }
  }
}

void keyPressed() {
  pause = !pause;
}
