class Spaceship {
  // Member Variables
  int x, y, w, health, turretCount, laserCount;
  //PImage ship;

  // Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    health = 100;
    turretCount = 1;
    laserCount = 100;
    //ship = loadImage("filename.png"); 
  }

  // Member Methods
  void display() {
    //imageMode(CENTER);
    //image(ship,x,y);
    stroke(222);
    strokeWeight(3);
    line(x-25, y+30, x-25, y-30);
    rectMode(CENTER);
    rect(x, y, 80, 20);
    ellipse(x, y, 20, 80);
    triangle(x, y-30, x-30, y+20, x+30, y+20);
  }

  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void fire() {
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
