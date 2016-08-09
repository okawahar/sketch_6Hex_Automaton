//Nature of Code
//tudelft

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;
import processing.opengl.*;
import controlP5.*;


ControlP5 slider;
ControlP5 XA;
ControlP5 YA;
ControlP5 ZA;
ControlP5 init;
ControlP5 restart;
int size=40;
int X=0;
int Y=0;
int Z=0;
boolean SET=false;
boolean RESET=false;
boolean preRESET;

GOL tempgol;
GOL gol;
int preSize;
PeasyCam cam;
PMatrix3D currCameraMatrix;
PGraphics3D g3;
int rightbar=320;

void setup() {
  size(1220, 1000, OPENGL);
  cam = new PeasyCam(this, width/2-120, height/2, 0, 1000);  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  g3 = (PGraphics3D)g;
  gol = new GOL();
  gol.init();

  init = new ControlP5(this);
  init.addToggle("SET")
    .setPosition(20, 300)
    .setSize(50, 20)
    ;

  restart = new ControlP5(this);
  restart.addToggle("RESET")
    .setPosition(20, 350)
    .setSize(50, 20)
    ;


  slider = new ControlP5(this);
  slider.addSlider("size")
    .setPosition(20, 50)
    .setRange(0, 255)
    ; 

  XA = new ControlP5(this);
  XA.addSlider("X")
    .setPosition(20, 100)
    .setRange(0, 360)
    ; 

  YA = new ControlP5(this);
  YA.addSlider("Y")
    .setPosition(20, 150)
    .setRange(0, 360)
    ; 

  ZA = new ControlP5(this);
  ZA.addSlider("Z")
    .setPosition(20, 200)
    .setRange(0, 360)
    ; 
  slider.setAutoDraw(false);
  XA.setAutoDraw(false);
  YA.setAutoDraw(false);
  ZA.setAutoDraw(false);
  init.setAutoDraw(false);
  restart.setAutoDraw(false);
  
  
}

void draw() {
  background(0);


    RESET=false;
    gol.generate();
    pushMatrix();
    gol.display();
    popMatrix();
    
  
  
  
  gui();

  if (preSize!=size) {
    gol.init();
  }
  if (preRESET!=RESET) {
    gol.init();
  }
  preSize=size;
  preRESET=RESET;
}

void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  fill(20);
  rect(0, 0, rightbar, height);

    pushMatrix();
    gol.show();
    popMatrix();
  
  slider.draw();
  XA.draw();
  YA.draw();
  ZA.draw();
  init.draw();
  restart.draw();
  g3.camera = currCameraMatrix;
}

// reset board when mouse is pressed
void mouseDragged() {
  gol.colorChange();
}

void mousePressed() {
  if (SET==false) {
    gol.choose();
  } else if (SET==true) {
    gol.select();
  }
  if (RESET==true)gol.init();
}

void keyReleased() {
}