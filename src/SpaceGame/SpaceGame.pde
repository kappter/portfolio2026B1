// Mr Kapptie | 18 Sept 2025 | SpaceGame
Spaceship s1;
ArrayList<PowerUp> powups = new ArrayList<PowerUp>();
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Timer rockTimer, puTimer, levelTimer;
int score, rocksPassed, level, rtime;
boolean play;

void setup() {
  size(500, 500);
  rtime = 2000;
  background(22);
  s1 = new Spaceship();
  levelTimer = new Timer(30000);
  levelTimer.start();
  puTimer = new Timer(5000);
  puTimer.start();
  rockTimer = new Timer(rtime);
  rockTimer.start();
  score = 0;
  rocksPassed = 0;
  play = false;
  level = 1;
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    background(22);
    // Check Levels
    if(level == 1){
      // Decrease rockTimer ??
      
    }

    // Distributes a powerup on a timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }

    // Display and moves all powerups
    for (int i = 0; i < powups.size(); i++) {
      PowerUp pu = powups.get(i);
      pu.move();
      pu.display();

      if (pu.intersect(s1)) {
        // Remove Powerup
        powups.remove(pu);
        // Based on type, benefit player
        if (pu.type == 'H') {
          s1.health+=100;
          // Turret Increase
        } else if (pu.type == 'T') {
          s1.turretCount+=1;
          if (s1.turretCount>5) {
            s1.turretCount = 5;
          }
          // Ammo increase
        } else if (pu.type == 'A') {
          s1.laserCount+=100;
        }
      }

      if (pu.reachedBottom()) {
        powups.remove(pu);
        i--;
      }
      println(powups.size());
    }

    // Distributes a rock on a timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }

    // Display and moves all rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.move();
      rock.display();

      if (s1.intersect(rock)) {
        rocks.remove(rock);
        score+=rock.diam;
        s1.health-=10;
      }

      if (rock.reachedBottom()) {
        rocks.remove(rock);
        i--;
      }
      println(rocks.size());
    }

    // Display and move lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {

          //2. eradicate laser
          lasers.remove(laser);
          // 3. rocks should have health based on size
          r.diam -= 50;
          // 4. laser does less hp if rock is bigger
          if (r.diam<5) {
            rocks.remove(r);
          }
          score+=r.diam;
          // 5. laser will do less damage if spammed
          // 6. tapeworm takes over!!!!!!
          // 7. points go towards spaceship DEPENDING on size of rock destroyed w/ laser
        }
      }
      laser.display();
      laser.move();
    }

    s1.display();
    s1.move(mouseX, mouseY);
    infoPanel();


    // Level advance
    if (rocksPassed>10) {
      level++;
      rtime-=10;
    } else if (rocksPassed>20) {
      level++;
    }

    // Game over criteria
    if (s1.health<1) {
      gameOver();
    }
  }
}

void mousePressed() {
  // laser.play();
  if (s1.turretCount == 1) {
    lasers.add(new Laser(s1.x, s1.y));
  } else if (s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  } else if (s1.turretCount == 3) {
    lasers.add(new Laser(s1.x, s1.y));
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  } else {
    lasers.add(new Laser(s1.x, s1.y));
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  }
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, 475, width, 50);
  fill(220);
  textSize(25);
  text("Score: " + score, 20, 475);
  text("Health: " + s1.health, 200, 475);
  text("Passed Rocks: ", width-180, 475);
  text("Turrets: " + s1.turretCount, width-180, 475);
  fill(255);
  text("Level: " + level, width-200, 60);
}

void startScreen() {
  //image(bg1,0,0);
  //background(0);
  fill(255);
  text("Welcome! - press mouse to start!", width/2, height/2);
  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  //image(go1,0,0);
  background(0);
  fill(255);
  text("Game Over!", width/2, height/2);
  noLoop();
}
