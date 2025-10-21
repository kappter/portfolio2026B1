class Laser {
  // Member Variables
  int x, y, w, h, speed;
  //PImage 11;

  // Constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    w = 4;
    h = 10;
    speed = 10;
    // load PImage here
  }

  // Member Methods
  void display() {
    rectMode(CENTER);
    fill(255,0,0);
    rect(x,y,w,h);
  }

  void move() {
    y = y - speed;
  }

  boolean reachedTop() {
    if (y<0-10) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Rock r) {
    float d = dist(x,y,r.x,r.y);
    if(d<50) {
      return true;
    } else {
      return false;
    }
  }
}
