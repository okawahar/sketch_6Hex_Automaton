// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
public abstract class Ocell {
  float x, y;
  float w;
  Ocell (float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
  }
}
//great

class Cell extends Ocell {


  float xoff;
  float yoff;
  int clr;
  color c;
  int xAngle, yAngle, zAngle;
  boolean hex;



  Cell(float x_, float y_, float w_, int clr_, int xAngle_, int yAngle_, int zAngle_, boolean hex_) {
    super(x_, y_, w_);
    clr=clr_;
    xoff = w/2;
    yoff = sin(radians(60))*w;
    xAngle=xAngle_;
    yAngle=yAngle_;
    zAngle=zAngle_;
    hex=hex_;
  }



  void display() {
    if (clr<51) {
      map(clr, 0, 51, 0, 255);
      c=color(0, clr, 255-clr);
    } else if (clr<51&&clr<102) {
      map(clr, 51, 102, 0, 255);
      c=color(0, 255, clr);
    } else if (clr<102&&clr<153) {
      map(clr, 102, 153, 0, 255);
      c=color( 255-clr, 255, clr);
    } else if (clr<153&&clr<204) {
      map(clr, 153, 204, 0, 255);
      c=color(255, 255-clr, 0);
    } else if (clr<204&&clr<255) {
      map(clr, 204, 255, 0, 255);
      c=color(clr, 0, 0);
    } else if (clr==500) {
      c=color(255, 0, 0);
    } else if (clr==1000) {
      c=color(255, 255, 255);
    } 

    fill(c);
    //println(clr+"r:"+red(c)+",g:"+green(c)+",b:"+blue(c));
    stroke(0);
    pushMatrix();

    translate(x, y);
    //rotateX(radians(xAngle));

    //if(yAngle!=0){
    //rotateZ(radians(30));
    //}
    //rotateX(radians(yAngle));

    // if(zAngle!=0){
    //rotateZ(radians(-30));
    //}
    //rotateX(radians(zAngle));



    beginShape();
    vertex(0, yoff);
    vertex(xoff, 0);
    vertex(xoff+w, 0);
    vertex(2*w, yoff);
    vertex(xoff+w, 2*yoff);
    vertex(xoff, 2*yoff);
    vertex(0, yoff);
    endShape();
    popMatrix();
  }

  void scaleA() {

    if (clr==500) {
      c=color(255, 0, 0);
    } else if (clr==1000) {
      c=color(255, 255, 255);
    } 

    fill(c);
    //println(clr+"r:"+red(c)+",g:"+green(c)+",b:"+blue(c));
    stroke(0);
   

    pushMatrix();

    translate(x/4+10, y/4+height/2);

    beginShape();
    vertex(0, yoff/4);
    vertex(xoff/4, 0);
    vertex(xoff/4+w/4, 0);
    vertex(2*w/4, yoff/4);
    vertex(xoff/4+w/4, 2*yoff/4);
    vertex(xoff/4, 2*yoff/4);
    vertex(0, yoff/4);
    endShape();
    popMatrix();
  }
}
