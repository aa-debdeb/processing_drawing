int CELL_NUM = 100;
int CELL_SIZE = 5;

int[][] cells;

// 0: defects, 1: cooperates
float[][] pd_matrix = {{1.0, 5.0}, 
                        {0.0, 4.0}};

float mutation_rate = 0.001;

void setup(){

  cells = new int[CELL_NUM][CELL_NUM];
  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      cells[w][h] = 0;
      if(random(1) < 0.01){
        cells[w][h] = 0;
      } else {
        cells[w][h] = 1;
      }
    }
  }
  
  size(CELL_NUM * CELL_SIZE, CELL_NUM * CELL_SIZE);
  noStroke();
  smooth();
}

void draw(){

  // clear screen
  fill(255);
  rect(0, 0, width + 1, height + 1);  

  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      if(cells[w][h] == 0){ // defects
        fill(255, 0, 0);
      } else{ // cooperates
        fill(0, 255, 0);
      }
      rect(w * CELL_SIZE, h * CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
  }  

  // draw line
  strokeWeight(1);
  stroke(0);
  for(int i = 0; i < CELL_NUM + 1; i++){
    line(i * CELL_SIZE, 0, i * CELL_SIZE, height);
    line(0, i * CELL_SIZE, width, i * CELL_SIZE);
  }
  
  // calculate score
  float[][] scores = new float[CELL_NUM][CELL_NUM];
  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      int up = (h != 0 ? h - 1 : CELL_NUM - 1);
      int bottom = (h != CELL_NUM - 1 ? h + 1 : 0);
      int left = (w != 0 ? w - 1 : CELL_NUM - 1);
      int right = (w != CELL_NUM - 1 ? w + 1 : 0); 
 
      int my_state = cells[w][h];
      scores[w][h] = pd_matrix[my_state][cells[left][up]] + pd_matrix[my_state][cells[w][up]] + pd_matrix[my_state][cells[right][up]]
                      + pd_matrix[my_state][cells[left][h]] + pd_matrix[my_state][cells[right][h]]
                      + pd_matrix[my_state][cells[left][bottom]] + pd_matrix[my_state][cells[w][bottom]] + pd_matrix[my_state][cells[right][bottom]];
                   
    }
  }
  
  // change state
  int[][] next_cells = new int[CELL_NUM][CELL_NUM];
  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      int up = (h != 0 ? h - 1 : CELL_NUM - 1);
      int bottom = (h != CELL_NUM - 1 ? h + 1 : 0);
      int left = (w != 0 ? w - 1 : CELL_NUM - 1);
      int right = (w != CELL_NUM - 1 ? w + 1 : 0);
      
      float max_score = scores[w][h];
      ArrayList<Integer> max_state = new ArrayList<Integer>();
      max_state.add(cells[w][h]);
      if(max_score < scores[left][up]) {max_state.clear(); max_state.add(cells[left][up]); max_score = scores[left][up];}
        else if(max_score == scores[left][up]) {max_state.add(cells[left][up]);}
      if(max_score < scores[w][up]) {max_state.clear(); max_state.add(cells[w][up]); max_score = scores[w][up];}
        else if(max_score == scores[w][up]) {max_state.add(cells[w][up]);}
      if(max_score < scores[right][up]) {max_state.clear(); max_state.add(cells[right][up]); max_score = scores[right][up];}
        else if(max_score == scores[right][up]) {max_state.add(cells[right][up]);}
      if(max_score < scores[left][h]) {max_state.clear(); max_state.add(cells[left][h]); max_score = scores[left][h];}
        else if(max_score == scores[left][h]) {max_state.add(cells[left][h]);}  
      if(max_score < scores[right][h]) {max_state.clear(); max_state.add(cells[right][h]); max_score = scores[right][h];}
        else if(max_score == scores[right][h]) {max_state.add(cells[right][h]);} 
      if(max_score < scores[left][bottom]) {max_state.clear(); max_state.add(cells[left][bottom]); max_score = scores[left][bottom];}
        else if(max_score == scores[left][bottom]) {max_state.add(cells[left][bottom]);}
      if(max_score < scores[w][bottom]) {max_state.clear(); max_state.add(cells[w][bottom]); max_score = scores[w][bottom];}
        else if(max_score == scores[w][bottom]) {max_state.add(cells[w][bottom]);}
      if(max_score < scores[right][bottom]){max_state.clear(); max_state.add(cells[right][bottom]); max_score = scores[right][bottom];}
        else if(max_score == scores[right][bottom]) {max_state.add(cells[right][bottom]);}; 
     
      if(max_score == scores[w][h]){
         next_cells[w][h] = cells[w][h];
      } else {
        int next_state = floor(random(max_state.size())); 
        next_cells[w][h] = max_state.get(next_state);
      }
    }
  }
  cells = next_cells;
  
  // mutate
  for(int w = 0; w < CELL_NUM; w++){
    for(int h = 0; h < CELL_NUM; h++){
      if(random(1) < mutation_rate){
        cells[w][h] = (cells[w][h] == 1) ? 0 : 1;
      }
    }
  }
 
}



