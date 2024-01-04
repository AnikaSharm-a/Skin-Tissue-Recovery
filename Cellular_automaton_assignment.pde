// Cellular Automaton Assignment
// Skin Tissue Recovery by Anika Sharma



// Parameters that can be changed
int n = 20;                  // Grid size (20 recommended)
float timerate = 5;          // Number of blinks (hours passed) per second 
boolean gridlines = true;    // Cell lines (true/false)
int colournum = 2;           // User chosen colour number - check below for skin colour options

// Skin colour options for user:
// 0: Vanilla, 1: Beige, 2: Almond, 3: Mocha, 4: Toffee



// Arrays and variables - do not modify
int[][] cells = new int[n][n];       // Possible values: 0,1,2,3,4,5,6,7
int[][] nextcells = new int[n][n];   
float[][] xvals = new float[n][n];   // x positions values of cells
float[][] yvals = new float[n][n];   // y positions of cells
int[][] timepassed = new int[n][n];  // How much time has passed for each cell (hours)
float[][] tvals = new float[n][n];   // For gradients - each cell has it's own looping percentage value
int elapsedtime;                     // Total time passed (hours)      
float cellSize;                      
color skincolours[] = new color[5];  // Skin colours of the user
color userskincol;                   // User chosen skin colour
color inflamcol;                     // Inflamed tissue colour
color newtissuecol;                  // New tissue colour
color scarcol;                       // Scar tissue colour




void setup() {
  size(800, 580);
  cellSize = (width-250)/n; 
  frameRate(timerate);
  if (!gridlines) noStroke();

    
  // User skin colours
  skincolours[0] = color(235, 200, 170); // 0: Vanilla
  skincolours[1] = color(240, 184, 160); // 1: Beige
  skincolours[2] = color(226, 176, 132); // 2: Almond
  skincolours[3] = color(180, 138, 120); // 3: Mocha
  skincolours[4] = color(150, 114, 110); // 4: Toffee
  
  userskincol = skincolours[colournum];
  
  
  // Colour calculations for inflammation
  float ri = red(userskincol)+20;
  float gi = green(userskincol)-20;
  float bi = blue(userskincol)-15;  
  inflamcol = color(ri, gi, bi);  
  
  
  // Colour calculations for new tissue
  float rt = red(userskincol)+20;
  float gt = green(userskincol)-15;
  float bt = blue(userskincol)-5;   
  newtissuecol = color(rt, gt, bt); 
  
  
  // Colour calculations for scarring
  float rs = red(userskincol)+20;
  float gs = green(userskincol)+20;
  float bs = blue(userskincol)+20;  
  scarcol = color(rs, gs, bs);  
}



// Draws all stages of the program
void draw() {  
  background(200);

  // Drawing the grid with the cells
  for (int i=0; i<n; i++) {
    float y = 10 + i*cellSize;

    for (int j=0; j<n; j++) {
      float x = 10 + j*cellSize;

      // Fill x,y position arrays for mouse controls
      xvals[i][j] = x;
      yvals[i][j] = y;


      // Filling the different cell colours based on the type of cell
      
      if (cells[i][j] == 0) fill(userskincol);         // User chosen skin
      else if (cells[i][j] == 1) fill(204, 0, 0);      // Blood               
      else if (cells[i][j] == 2) fill(102, 0, 0);      // Blood clot           
      
      // Skin tissue to inflamed tissue
      else if (cells[i][j] == 3 && timepassed[i][j] <= 36){ 
        fill(lerpColor(userskincol, inflamcol, tvals[i][j]));
        tvals[i][j] += 0.0294;      // determined by 100/34 (# of hrs the cell is in this stage)
        if (tvals[i][j] >= 0.97) tvals[i][j] = 0;
      }         
      
      // Blood clot to new tissue
      else if (cells[i][j] == 4){ 
        fill(lerpColor(color(102, 0, 0), newtissuecol, tvals[i][j]));     
        tvals[i][j] += 0.0227;      // determined by 100/44 (# of hrs the cell is in this stage)
      }
      
      // Inflammed tissue to skin tissue
      else if (cells[i][j] == 7){  
        if (tvals[i][j] >= 0.9) nextcells[i][j] = 0;
        fill(lerpColor(inflamcol, userskincol, tvals[i][j]));
        tvals[i][j] += 0.008;       
      }
           
      // New tissue to scar tissue 
      else if (cells[i][j] == 5){
        if (tvals[i][j] > 0.9) tvals[i][j] = 0; 
        fill(lerpColor(newtissuecol, scarcol, tvals[i][j]));
        tvals[i][j] += 0.01;
      }
      
      // Healed wound scar tissue
      else if (cells[i][j] == 6) fill(scarcol);


      
      // Drawing the cell
      rect(x, y, cellSize, cellSize);
    }
  }


  // Drawing the side info 
  
  // Title
  fill(50);
  textSize(30);
  text("Skin Tissue", 590, 100);
  text("Recovery", 610, 150);
  
  // Elapsed time
  elapsedtime ++;

  textSize(20);
  text("Elapsed Time (hours):", 570, 250);  
  text(elapsedtime, 660, 280); 
  
  
  nextgen();
  updatecells();
}



// Replacing cells with cellsnext
void updatecells() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j] = nextcells[i][j];
    }
  }
}
