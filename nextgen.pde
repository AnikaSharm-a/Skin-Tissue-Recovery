// Function to determine the next generation

void nextgen() {

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
            
      
      // First stage: Bleeding and Clotting
      if (cells[i][j] == 1){
        timepassed[i][j] ++;
        
        if (timepassed[i][j] > 2) nextcells[i][j] = 2;  // Turn into blood clot
        else nextcells[i][j] = 1;
      }


      // Second stage: Inflammation 
      else if (cells[i][j] == 2 && timepassed[i][j] <= 36) { 

        for (int a=-1; a<=1; a++) {
          for (int b=-1; b<=1; b++) {      
            try {if (cells[i+a][j+b] == 0) nextcells[i+a][j+b] = 3;}  // Turn into inflamed tissue
            catch(ArrayIndexOutOfBoundsException e) {}
          }
        }        
      }


      // Third stage: New tissue
      else if (cells[i][j] == 2 && timepassed[i][j] > 36) { 
        nextcells[i][j] = 4;

        for (int a=-1; a<=1; a++) {
          for (int b=-1; b<=1; b++) {      
            try {if (cells[i+a][j+b] == 3) nextcells[i+a][j+b] = 7;}  // Turn into skin that was inflamed
            catch(ArrayIndexOutOfBoundsException e) {}
          }
        }
      }


      // Fourth stage: Scarring
      else if (cells[i][j] == 4 && timepassed[i][j] > 80) nextcells[i][j] = 5; 
    
    
      // Final scar tissue
      else if (cells[i][j] == 5 && timepassed[i][j] > 170) nextcells[i][j] = 6;
    
    
      // Time of each cell
      if (cells[i][j] != 0 && cells[i][j] != 6) timepassed[i][j] ++;   // If cell is not a skin/scar cell
      else timepassed[i][j] = 0;
    }
  }
}
