// For the user to initiate the program by making a cut

void mouseDragged(){
  for (int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      if (mouseX>xvals[i][j] && mouseX<xvals[i][j]+cellSize && mouseY>yvals[i][j] && mouseY<yvals[i][j]+cellSize && cells[i][j] == 0){
        cells[i][j] = 1;
      }  
    }
  }
}
