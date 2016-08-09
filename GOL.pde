// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class GOL {


  float h = sin(radians(60))*size;
  int columns, rows;

  // Game of life nextA
  Cell[][] boardA;
  Cell[][] nextA;
 


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = width/int(size*3);
    rows = height/int(h);
    boardA = new Cell[columns][rows];
    nextA = new Cell[columns][rows];
    
    init();
  }

  void init() {

    float h = sin(radians(60))*size;
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {

        if (j % 2 == 0) {
          boardA[i][j] = new Cell(i*size*3, j*h, size, int(random(200, 255)), 0, 0, 0, false);
          nextA[i][j] = new Cell(i*size*3, j*h, size, 0, 0, 0, 0, false);
        } else { 
          boardA[i][j] = new Cell(i*size*3+size+size/2, j*h, size, int(random(200, 255)), 0, 0, 0, false);
          nextA[i][j] = new Cell(i*size*3+size+size/2, j*h, size, 0, 0, 0, 0, false);
        }
      }
    }
  }



  // The process of creating the new generation
  void generate() {
    columns = width/int(size*3);
    rows = height/int(h);
    delay(10);


    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 2; x < columns-2; x++) {
      for (int y = 2; y < rows-2; y++) {
        // Add up all the states in a 3x3 surrounding grid
        int neighbors=0;
        int denominator=0;
        if (boardA[x][y].hex==true) {
          if (boardA[x-1][y-1].hex==true) {
            neighbors+=boardA[x-1][y-1].clr;
            denominator++;
          } 
          if (boardA[x-1][y+1].hex==true) {
            neighbors+=boardA[x-1][y+1].clr;
            denominator++;
          }  
          if (boardA[x][y-1].hex==true) {
            neighbors+=boardA[x][y-1].clr;
            denominator++;
          } 
          if (boardA[x][y+1].hex==true) {
            neighbors+=boardA[x][y+1].clr;
            denominator++;
          }  
          if (boardA[x][y-2].hex==true) {
            neighbors+=boardA[x][y-2].clr;
            denominator++;
          } 
          if (boardA[x][y+2].hex==true) {
            neighbors+=boardA[x][y+2].clr;
            denominator++;
          }
          //neighbors = 
          //  boardA[x-1][y-1].clr+
          //  boardA[x-1][y+1].clr+
          //  boardA[x][y-1].clr+
          //  boardA[x][y+1].clr+
          //  boardA[x][y-2].clr+
          //  boardA[x][y+2].clr;

          int xAdjacent=0;
          xAdjacent=(boardA[x][y-2].xAngle+boardA[x][y+2].xAngle)/2;

          int yAdjacent=0;
          if (y%2==0) {
            yAdjacent=(boardA[x-1][y-1].yAngle+boardA[x][y+1].yAngle)/2;
          } else {
            yAdjacent=(boardA[x][y-1].yAngle+boardA[x+1][y+1].yAngle)/2;
          }

          int zAdjacent=0;
          if (y%2==0) {
            zAdjacent=(boardA[x][y-1].zAngle+boardA[x-1][y+1].zAngle)/2;
          } else {
            zAdjacent=(boardA[x+1][y-1].zAngle+boardA[x][y+1].zAngle)/2;
          }



          //nextA[x][y].clr = round(neighbors/6);
          //nextA[x][y].clr = round(neighbors/denominator);
          //println(x+":"+y+":"+denominator);
          nextA[x][y].xAngle=xAdjacent;
          nextA[x][y].yAngle=yAdjacent;
          nextA[x][y].zAngle=zAdjacent;
        } else if (boardA[x][y].hex==false) {
          boardA[x][y].clr=1000;
        }
      }
    }

    //for (int x=0; x<2; x++) {
    //  for (int y=0; y<2; y++) {
    //    nextA[x][y].clr=boardA[x][y].clr;
    //  }
    //  for (int y=rows-2; y<rows; y++) {
    //    nextA[x][y].clr=boardA[x][y].clr;
    //  }
    //}
    //for (int x=columns-2; x<columns; x++) {
    //  for (int y=0; y<2; y++) {
    //    nextA[x][y].clr=boardA[x][y].clr;
    //  }
    //  for (int y=rows-2; y<rows; y++) {
    //    nextA[x][y].clr=boardA[x][y].clr;
    //  }
    //}

    //nextA is now our boardA
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        boardA[i][j].clr= nextA[i][j].clr;
      }
    }
  }


  void colorChange() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if (j % 2 == 0) {
          if (mouseX<(i*size*3-size/2)+size&&mouseX>(i*size*3-size/2)-size) {
            if (mouseY<j*h+size*2&&mouseY>j*h-size*2) {
              boardA[i][j].clr=255;
            }
          }
        } else {
          if (mouseX<(i*size*3+size)+size&&mouseX>(i*size*3+size)-size) {
            if (mouseY<j*h+size*2&&mouseY>j*h-size*2) {
              boardA[i][j].clr=255;
            }
          }
        }
      }
    }
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if (boardA[i][j].hex==true) {
          boardA[i][j].display();
        }
        //textSize(22);
        //fill(0);
        //if (j % 2 == 0) {
        ////  text("x:"+i+"y:"+j, i*size*3, j*h);
        //  ellipse(i*size*3-size/2, j*h, size*2, size*2);
        //} else {
        ////  text("x:"+i+"y:"+j, i*size*3+size+size/2, j*h);
        //  ellipse(i*size*3+size, j*h, size*2, size*2);
        //}
      }
    }
  }
  void show() {

    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {

        if (boardA[i][j].hex==true) {

          boardA[i][j].clr=500;
         

          boardA[i][j].scaleA();

        } else if (boardA[i][j].hex==false) {

          boardA[i][j].clr=1000;
          

          boardA[i][j].scaleA();
        }
      }
    }
  }

  void choose() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if (j % 2 == 0) {
          if (mouseX*4<round((i*size*3-size/2)+size/4)&&mouseX*4>round((i*size*3-size/2)-size/4)){
            if (mouseY<round(height/2+(j*h/4+size/4))&&mouseY>round(height/2+(j*h/4-size/4))) {
              boardA[i][j].hex=true;
                println((i*size*3-size/2)-size/4+":"+mouseX*4+":"+((i*size*3-size/2)+size/4));
            }
          }
        } else {
          if (mouseX*4<round((i*size*3+size)+size/4)&&mouseX*4>round((i*size*3+size)-size/4)) {
            if (mouseY<round(height/2+(j*h/4+size/4))&&mouseY>round(height/2+(j*h/4-size/4))) {
              boardA[i][j].hex=true;
            }
          }
        }
      }
    }
  }

  void select() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if (j % 2 == 0) {
          if (mouseX<i*size*3+size*2&&mouseX>i*size*3-size*2) {
            if (mouseY<j*h+size*2&&mouseY>j*h-size*2) {
              boardA[i][j].xAngle=X;
              boardA[i][j].yAngle=Y;
              boardA[i][j].zAngle=Z;
            }
          }
        } else {
          if (mouseX<i*size*3+size+size/2+size*2&&mouseX>i*size*3+size+size/2-size*2) {
            if (mouseY<j*h+size*2&&mouseY>j*h-size*2) {
              boardA[i][j].xAngle=X;
              boardA[i][j].yAngle=Y;
              boardA[i][j].zAngle=Z;
            }
          }
        }
      }
    }
  }
}