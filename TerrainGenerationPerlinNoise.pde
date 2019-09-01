int scale = 15;
int col, row;

int windowW = 1200;
int windowH = 600;

float flying = 0;

float[][] terrain;

void setup() {
  size(500, 500, P3D);
  col = windowW / scale;
  row = windowH / scale;
  terrain = new float[col][row];
  float yoff = flying;
  for (int y = 0; y < row; y++) {
    float xoff = 0;
    for (int x = 0; x < col; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 0);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
}

void draw() {
  flying -= 0.04;
  background(0); 
  stroke(255);
  noFill();
  translate(500/2, 500/2);
  rotateX(PI/3);
  translate(-windowW/2, -windowH/2);
  float yoff = flying;
  for (int y = 0; y < row; y++) {
    float xoff = 0;
    for (int x = 0; x < col; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.1;
    }
    yoff += 0.1;
  }

  for (int y = 0; y < row-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < col; x++) {
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (1+y)*scale, terrain[x][y+1]);
    }
    stroke(map(y, 0, row, 0, 255), map(y, 0, row, 0, 255), map(y, 0, row, 0, 255));
    endShape();
  }
}
