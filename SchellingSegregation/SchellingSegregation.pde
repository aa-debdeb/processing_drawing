int CELL_NUM = 100;
int CELL_SIZE = 5;
 
//float[] pop_rate = {0.2, 0.2, 0.2, 0.2, 0.1}; // blank_rate = 1.0 - sum(pop_rate)
float[] pop_rate = {0.4, 0.4};
float resettle_rate = 0.6;

int[][] cells;

void setup(){
  
  // initialize cells
  cells = new int[CELL_NUM][CELL_NUM];
  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      cells[w][h] = 0;
      float rand = random(1);
      float sum_rate = 0.0;
      for(int i = 0; i < pop_rate.length; i++){
        sum_rate += pop_rate[i];
        if(rand <= sum_rate){
          cells[w][h] = i + 1;
          break;
        }
      }
    }
  }
  
  // setup screen
  size(CELL_NUM * CELL_SIZE, CELL_NUM * CELL_SIZE);
  noStroke();
  smooth();
  frameRate(10);

}

void draw(){

    // clear screen
    background(255);
    
    // draw cells
    for(int w = 0; w < CELL_NUM; w++){
      for(int h = 0; h < CELL_NUM; h++){
        switch(cells[w][h]){
          case 0:
            fill(255);
            break;
          case 1:
            fill(255, 0, 0);
            break;
          case 2:
            fill(0, 0, 255);
            break;
          case 3:
            fill(0, 255, 0);
            break;
          case 4:
            fill(255, 255, 0);
            break;
          case 5:
            fill(0, 255, 255);
            break;
        }
        rect(w * CELL_SIZE, h * CELL_SIZE, CELL_SIZE, CELL_SIZE);
      }
    }
    
    // draw grid
    strokeWeight(1);
    stroke(0);
    for(int i = 0; i < CELL_NUM + 1; i++){
      line(i * CELL_SIZE, 0, i * CELL_SIZE, height);
      line(0, i * CELL_SIZE, width, i * CELL_SIZE);
    }
    
    // calculate next cells
    ArrayList<int[]> blank_list = new ArrayList<int[]>();
    ArrayList<int[]> resettle_list = new ArrayList<int[]>();
    for(int w = 0; w < CELL_NUM; w++){
      for(int h = 0; h < CELL_NUM; h++){
        if(cells[w][h] != 0){
          int up = (h != 0 ? h - 1 : CELL_NUM - 1);
          int bottom = (h != CELL_NUM - 1 ? h + 1 : 0);
          int left = (w != 0 ? w - 1 : CELL_NUM - 1);
          int right = (w != CELL_NUM - 1 ? w + 1 : 0);
          
          int num_neighbor = 0;
          if(cells[w][h] == cells[left][up]) num_neighbor++;
          if(cells[w][h] == cells[w][up]) num_neighbor++;
          if(cells[w][h] == cells[right][up]) num_neighbor++;
          if(cells[w][h] == cells[left][h]) num_neighbor++;
          if(cells[w][h] == cells[right][h]) num_neighbor++;
          if(cells[w][h] == cells[left][bottom]) num_neighbor++;
          if(cells[w][h] == cells[w][bottom]) num_neighbor++;
          if(cells[w][h] == cells[right][bottom]) num_neighbor++;
          float neighbor_rate = num_neighbor / 8.0;
          
          if(neighbor_rate < resettle_rate){
            int[] resettle_cell = {w, h};
            resettle_list.add(resettle_cell);
          }
        } else {
          int[] blank_cell = {w, h};
          blank_list.add(blank_cell);
        }
      }
    }
    while(!resettle_list.isEmpty()){
      int[] resettle_cell = resettle_list.remove(floor(random(resettle_list.size())));
      int[] blank_cell = blank_list.remove(floor(random(blank_list.size())));
      cells[blank_cell[0]][blank_cell[1]] = cells[resettle_cell[0]][resettle_cell[1]];
      cells[resettle_cell[0]][resettle_cell[1]] = 0;
      blank_list.add(resettle_cell);
    }
}
