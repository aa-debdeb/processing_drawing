int CELL_NUM = 100;
int CELL_SIZE = 5;

int[][] cells;

void setup(){
  size(CELL_NUM * CELL_SIZE + 1, CELL_NUM * CELL_SIZE + 1);
  frameRate(40);
  
  // initialize cells
  cells = new int[CELL_NUM][CELL_NUM];
  for(int x = 0; x < CELL_NUM; x++){
    for(int y = 0; y < CELL_NUM; y++){
      if(random(1) < 0.5){
        cells[x][y] = 1;
      } else {
        cells[x][y] = 0;
      }
    }
  }
}

void draw(){
  // clear
  background(255);
  
  //draw grid
  stroke(220);
  strokeWeight(1);
  for(int x = 0; x < CELL_NUM + 1; x++){
    line(x * CELL_SIZE, 0, x * CELL_SIZE, height);
  }
  for(int y = 0; y < CELL_NUM + 1; y++){
    line(0, y * CELL_SIZE, width, y * CELL_SIZE);
  }
    
  // draw cells
  noStroke();
  fill(50);
  for(int x = 0; x < CELL_NUM; x++){
    for(int y = 0; y < CELL_NUM; y++){
      if(cells[x][y] == 1){
        rect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
      }
    }
  }

  saveFrame("frames2/####.png");

  // calculate next cells
  int[][] next_cells = new int[CELL_NUM][CELL_NUM];
  for(int x = 0; x < CELL_NUM; x++){
    for(int y = 0; y < CELL_NUM; y++){
      int top = (y != 0 ? y - 1 : CELL_NUM - 1); 
      int bottom = (y != CELL_NUM - 1 ? y + 1 : 0);
      int left = (x != 0 ? x - 1 : CELL_NUM - 1); 
      int right = (x != CELL_NUM - 1 ? x + 1 : 0);
      
      int sum = cells[left][top] + cells[x][top] + cells[right][top]
                  + cells[left][y] + cells[right][y]
                  + cells[left][bottom] + cells[x][bottom] + cells[right][bottom];
      
      if((cells[x][y] == 1 && (sum == 2 || sum == 3)) || (cells[x][y] == 0) && (sum == 3)){
        next_cells[x][y] = 1;
      } else {
        next_cells[x][y] = 0;
      }
      
    }
  }
  cells = next_cells;
   
}

// function for initializaiton
// 0: random
// 1: Glider
void initialize(int method){
  switch(method){
    case 0:
      for(int i = 0; i < CELL_NUM; i++){
        for(int j = 0; j < CELL_NUM; j++){
          if(random(1) < 0.5){
            cells[i][j] = 1;
          } else {
            cells[i][j] = 0;
          }
        }
      }
      break;
    case 1:
      break;
  }
}
