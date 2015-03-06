int CELL_NUM = 100;
int CELL_SIZE = 5;

boolean[][] cells = new boolean[CELL_NUM][CELL_NUM];

int ant_x;
int ant_y;
int ant_direction; // 0=up, 1=right, 2=bottom, 3=left

void setup(){
  size(CELL_NUM * CELL_SIZE, CELL_NUM * CELL_SIZE);
  
  // initialize cells;
  initialize_cells(2);
  
  // initialize ant position
  ant_x = ant_y = int(CELL_NUM / 2);
  ant_direction = 0;
}

void draw(){
  // clear screen
  fill(255);
  rect(0, 0, width, height);
  
   // draw cells
   noStroke();
   fill(30);
   for(int w = 0; w < CELL_NUM; w++){
     for(int h = 0; h < CELL_NUM; h++){
       if(cells[w][h] == true){
         rect(w * CELL_SIZE, h * CELL_SIZE, CELL_SIZE, CELL_SIZE);
       }
     }
   }
  
  // draw lines
  stroke(128);
  strokeWeight(1);
  for(int i = 0; i < CELL_NUM; i++){
    line(i * CELL_SIZE, 0, i * CELL_SIZE, height);
    line(0, i * CELL_SIZE, width, i * CELL_SIZE);
  }
   
   // draw ant
   fill(255, 0, 0);
   rect(ant_x * CELL_SIZE, ant_y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
   
   //act ant
   act_ant();
}

void act_ant(){
  if(cells[ant_x][ant_y] == true){
    turn_left();
  } else {
    turn_right();
  }
  cells[ant_x][ant_y] = !cells[ant_x][ant_y];
  forward_ant();
}

void turn_left(){
  ant_direction -= 1;
  if(ant_direction == -1){
    ant_direction = 3;
  }
}

void turn_right(){
  ant_direction += 1;
  if(ant_direction == 4){
    ant_direction = 0;
  }
}

void forward_ant(){
  switch(ant_direction){
    case 0:
      ant_y = (ant_y != 0 ? ant_y - 1 : CELL_NUM - 1);
      break;
    case 1:
      ant_x = (ant_x != CELL_NUM - 1 ? ant_x + 1 : 0);
      break;
    case 2:
      ant_y = (ant_y != CELL_NUM - 1 ? ant_y + 1 : 0);
      break;
    case 3:
      ant_x = (ant_x != 0 ? ant_x - 1 : CELL_NUM - 1);
      break;
  }
}

void initialize_cells(int method){
  switch(method){
    case 0: // all white
      for(int w = 0; w < CELL_NUM; w++){
        for(int h = 0; h < CELL_NUM; h++){
          cells[w][h] = false;
        }
      }
      break;
      
    case 1: // all black
      for(int w = 0; w < CELL_NUM; w++){
        for(int h = 0; h < CELL_NUM; h++){
          cells[w][h] = true;
        }
      }
      break;
    
    case 2: // put blac rectangle 
      for(int w = 0; w < CELL_NUM; w++){
        for(int h = 0; h < CELL_NUM; h++){
          cells[w][h] = false;
        }
      }
      int rect_x = 40;
      int rect_y = 20;
      for(int w = (CELL_NUM / 2) - int(rect_x / 2); w < (CELL_NUM / 2) + int(rect_x / 2); w++){
        for(int h = (CELL_NUM / 2) - int(rect_y / 2); h < (CELL_NUM / 2) + int(rect_y / 2); h++){
          cells[w][h] = true;
        }        
      }
  }
}
