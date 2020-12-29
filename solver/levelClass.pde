class Level {
  int[][] rings;
  int rotation;
  color ringColor;
  
  Level(int[][] _rings, int _rotation, color _ringColor) {
    rings = _rings;
    rotation = _rotation;
    ringColor = _ringColor;
  }
  
  void displayRing(int ring, int i, color ringColor, int yPos) {
    if (ring != 0) {
        pushMatrix();
          translate(width/2, height/2);
          rotate(radians((30 * i) + (30 * rotation)));
          fill(ringColor);
          stroke(17,150);
          rect(0, yPos, 40, 40);
          noStroke();
          fill(17);
          text(ring, -1, yPos - 2);
        popMatrix();
      }
  }
  
  void displayLevel() {
    for (int i = 0; i < 12; i++) {
      displayRing(rings[0][i], i, ringColor, 100);
      displayRing(rings[1][i], i, ringColor, 140);
      displayRing(rings[2][i], i, ringColor, 180);
      displayRing(rings[3][i], i, ringColor, 220);
    }
  }
}
