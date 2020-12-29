PFont font;

ArrayList<Level> levels = new ArrayList<Level>();

int[][] rings_;
int rotation_;
color ringColor_;

int[] col = new int[5];
int[] sum = new int[12];

int totalAttempts = 1;
  
void settings() {
  size(600,600); // Set Main Frame Size
  pixelDensity(displayDensity()); // Set Display Density
}

void setup() {
  noStroke();
  rectMode(CENTER);
  
  font = createFont("IBMPlexMono-Medium.ttf", 15);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  // Level 0 (Bottom)
  rings_ = new int[4][];
  rings_[0] = new int[]{ 11, 11, 14, 11, 14, 11, 14, 14, 11, 14, 11, 14 };
  rings_[1] =  new int[]{ 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
  rings_[2] =  new int[]{ 4, 4, 6, 6, 3, 3, 14, 14, 21, 21, 9, 9 };
  rings_[3] =  new int[]{ 8, 3, 4, 12, 2, 5, 10, 7, 16, 8, 7, 8 };
  rotation_ = 0;
  ringColor_ = color(190, 0, 143);
  levels.add(new Level(rings_, rotation_, ringColor_));
  
  // Level 1
  rings_ = new int[4][];
  rings_[0] = new int[]{ 9, 0, 7, 14, 11, 0, 8, 0, 16, 2, 7, 0 };
  rings_[1] = new int[]{ 12, 3, 6, 0, 14, 12, 3, 8, 9, 0, 9, 20 };
  rings_[2] = new int[]{ 6, 0, 2, 13, 9, 0, 17, 19, 3, 12, 3, 26 };
  rings_[3] = new int[]{ 9, 0, 12, 0, 6, 0, 10, 0, 10, 0, 1, 0 };
  rotation_ = 0;
  ringColor_ = color(49, 129, 0);
  levels.add(new Level(rings_, rotation_, ringColor_));
  
  // Level 2
  rings_ = new int[4][];
  rings_[0] = new int[]{ 7, 8, 9, 13, 9, 7, 13, 21, 17, 4, 5, 0 };
  rings_[1] = new int[]{ 12, 0, 21, 6, 15, 4, 9, 18, 11, 26, 14, 1 };
  rings_[2] = new int[]{ 9, 0, 5, 0, 10, 0, 8, 0, 22, 0, 16, 0 };
  rings_[3] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rotation_ = 0;
  ringColor_ = color(255, 96, 40);
  levels.add(new Level(rings_, rotation_, ringColor_));
  
  // Level 3
  rings_ = new int[4][];
  rings_[0] = new int[]{ 6, 17, 7, 3, 0, 6, 0, 11, 11, 6, 11, 0 };
  rings_[1] = new int[]{ 12, 0, 4, 0, 7, 15, 0, 0, 14, 0, 9, 0 };
  rings_[2] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rings_[3] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rotation_ = 0;
  ringColor_ = color(54, 167, 255);
  levels.add(new Level(rings_, rotation_, ringColor_));
  
  // Level 4 (Top)
  rings_ = new int[4][];
  rings_[0] = new int[]{ 15, 0, 8, 0, 3, 0, 6, 0, 10, 0, 7, 0 };
  rings_[1] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rings_[2] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rings_[3] = new int[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  rotation_ = 0;
  ringColor_ = color(255, 195, 213);
  levels.add(new Level(rings_, rotation_, ringColor_));
}

void draw() {
  clear();
  background(17);
  
  // Calculate Column Sums
  for (int i = 0; i < 12; i++) {
    
    for (int j = 0; j < 5; j++) {
      col[j] = 12 + (i - levels.get(j).rotation);
      if (col[j] > 11) { col[j] -= 12; }
    }
    
    sum[i] = 0;
    
    for (int j = 0; j < 4; j++) {
      if (levels.get(4).rings[j][ col[4] ] != 0) {
        sum[i] += levels.get(4).rings[j][ col[4] ];
      } else if (levels.get(3).rings[j][ col[3] ] != 0) {   
        sum[i] += levels.get(3).rings[j][ col[3] ];
      } else if (levels.get(2).rings[j][ col[2] ] != 0) {
        sum[i] += levels.get(2).rings[j][ col[2] ];
      } else if (levels.get(1).rings[j][ col[1] ] != 0) {
        sum[i] += levels.get(1).rings[j][ col[1] ];
      } else {
        sum[i] += levels.get(0).rings[j][ col[0] ];
      }
    }
 
    // Display Sum
    pushMatrix();
      translate(width/2, height/2);
      rotate(radians((30 * i)));
      if (sum[i] == 42) {
        fill(255, 32, 20);
        ellipse(0, 260, 38, 38);
        fill(17);
      } else {
        fill(255, 50);
      }
      text(sum[i], -1, 260 - 2);
    popMatrix();
  }
  
  // Display
  for (int i = 0; i < levels.size(); i++) {
    levels.get(i).displayLevel();
  }
  
  fill(17);
  ellipse(width/2, height/2, 165, 165);
  
  // Calculate Rotations
  levels.get(0).rotation++;
  if (levels.get(0).rotation > 11) {
    levels.get(0).rotation = 0;
    levels.get(1).rotation++;
    if (levels.get(1).rotation > 11) {
      levels.get(1).rotation = 0;
      levels.get(2).rotation++;
      if (levels.get(2).rotation > 11) {
        levels.get(2).rotation = 0;
        levels.get(3).rotation++;
        if (levels.get(3).rotation > 11) {
          levels.get(3).rotation = 0;
          levels.get(4).rotation++;
          if (levels.get(4).rotation > 11) {
            levels.get(4).rotation = 0;
          }
        }
      }
    }
  }

  // Save Frame Image
  //saveFrame("output/puzzle-######.png");

  // Check if Solved
  if (
    sum[0] == 42 && 
    sum[1] == 42 && 
    sum[2] == 42 && 
    sum[3] == 42 && 
    sum[4] == 42 && 
    sum[5] == 42 && 
    sum[6] == 42 && 
    sum[7] == 42 && 
    sum[8] == 42 && 
    sum[9] == 42 && 
    sum[10] == 42 && 
    sum[11] == 42
  ) {
    println("Solved!");
    noLoop();
  } else {
    // Keep Track of Iterations
    println("Attempt: " + totalAttempts);
    totalAttempts++;
  }
}

void mouseClicked() {
  loop();
}
