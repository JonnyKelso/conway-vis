int rows = 500;
int cols = 500;
int edge_size = 10;
boolean[][] state;
boolean[][] new_state;
boolean paused = false;

void setup()
{
  size(1000, 1000); // window size
  frameRate(60);
  stroke(255, 255, 255);  // colour of grid
  state = new boolean[cols][rows];  // array of current grid
  new_state = new boolean[cols][rows];  // array for next generation computed from rules in computeState()

  // set some initial state,
  // usually some predefined state that produces some interesting evolution
  setInitialState();
}

void draw()
{
  // allow pausing by clicking on screen
  if (!paused)
  {
    // clear next gen grid
    new_state = new boolean[cols][rows];

    // clear screen
    background(0);
    
    

    // draw screen for current grid
    for (int x = 0; x < cols; x++)
    {
      for (int y = 0; y < rows; y++)
      {
        if (state[x][y] == true)
        {
          fill(0, 255, 0);
        } else
        {
          fill(0, 0, 0);
        }
        rect(x * edge_size, y * edge_size, edge_size, edge_size);

        // compute next generation state
        if (computeState(x, y))
        {
          new_state[x][y] = true;
        } else
        {
          new_state[x][y] = false;
        }
      }
    }

    state = new_state;
    // copy next gen state to current state
    /*for (int x = 0; x < cols; x++)
    {
      for (int y = 0; y < rows; y++)
      {
        state[x][y] = new_state[x][y];
      }
    }*/
  }
  // draw elements that make up the user interface
  // (text on screen, boxes etc)
  drawUI();
}

// set some initial state,
// usually some predefined state that produces some interesting evolution
void setInitialState()
{
  // A range of classic GOL machines, taken from https://en.wikipedia.org/wiki/Conway's_Game_of_Life

  // this is an initial state that shows a simple 'blinker'  //<>//
  // (just a 1x3 horizontal line that changes into a 1x3 vertical line)
  //blinker();

  // this is an initial state that exhibits infinite growth
  //infinite_growth();

  // this is an initial state that creates a "Gospers Glider Gun"
  GosperGliderGun();
}

// determine if the cell in x,y will live on in the next generation, 
// by following the Game  of Life rules
boolean computeState(int x, int y)
{
  // if this is the first frame, just show the current state
  if (frameCount == 1)
  {
    return state[x][y];
  } else
  {
    // compute number of alive neighbours
    int alive_neighbours = 0;
    if ((x > 0 && x < cols - 1) && 
      (y > 0 && y < rows - 1))
    {
      for (int i = -1; i <= 1; i++)
      {
        for (int j = -1; j <= 1; j++)
        {
          if (i == 0 && j == 0)
          {
            //do nothing
          } else
          {
            if (state[x + i][y + j] ==  true)
            {
              alive_neighbours++;
            }
          }
        }
      }

      // RULES:
      //Any live cell with two or three live neighbours lives, unchanged, to the next generation.
      if (state[x][y] == true && 
        (alive_neighbours == 2 || alive_neighbours == 3)) { 
        return true;
      }
      //Any dead cell with exactly three live neighbours will come to life.
      if (state[x][y] == false && alive_neighbours == 3) { 
        return true;
      }
    }
  }
  return false;
}

// predefined grid state to produce a known conways GOL pattern
// this is an initial state that creates a "blinker"
void blinker()
{

  state[5][5]= true;
  state[5][6]= true;
  state[5][7]= true;
}

// predefined grid state to produce a known conways GOL pattern
// this is an initial state that exhibits infinite growth
void infinite_growth()
{
  int xoff = 10;
  int yoff = 50;
  for (int x = 0; x < cols; x++)
  {
    if (x >= 5 && x <= 12)
    {
      state[x + xoff][yoff] = true;
    } else if (x >= 14 && x <= 18)
    {
      state[x + xoff][yoff] = true;
    } else if (x >= 22 && x <= 24)
    {
      state[x + xoff][yoff] = true;
    } else if (x >= 31 && x <= 37)
    {
      state[x + xoff][yoff] = true;
    } else if (x >= 39 && x <= 43)
    {
      state[x + xoff][yoff] = true;
    }
  }
}

// predefined grid state to produce a known conways GOL pattern
// this is an initial state that creates a "Gospers Glider Gun"
void GosperGliderGun()
{

  state[1][5]= true;
  state[1][6]= true;
  state[2][5]= true;
  state[2][6]= true;
  state[11][5]= true;
  state[11][6]= true;
  state[11][7]= true;
  state[12][4]= true;
  state[12][8]= true;
  state[13][3]= true;
  state[13][9]= true;
  state[14][3]= true;
  state[14][9]= true;
  state[15][6]= true;
  state[16][4]= true;
  state[16][8]= true;
  state[17][5]= true;
  state[17][6]= true;
  state[17][7]= true;
  state[18][6]= true;
  state[21][3]= true;
  state[21][4]= true;
  state[21][5]= true;
  state[22][3]= true;
  state[22][4]= true;
  state[22][5]= true;
  state[23][2]= true;
  state[23][6]= true;
  state[25][1]= true;
  state[25][2]= true;
  state[25][6]= true;
  state[25][7]= true;
  state[35][3]= true;
  state[35][4]= true;
  state[36][3]= true;
  state[36][4]= true;
  state[35][22]= true;
  state[35][23]= true;
  state[35][25]= true;
  state[36][22]= true;
  state[36][23]= true;
  state[36][25]= true;
  state[36][26]= true;
  state[36][27]= true;
  state[37][28]= true;
  state[38][22]= true;
  state[38][23]= true;
  state[38][25]= true;
  state[38][26]= true;
  state[38][27]= true;
  state[39][23]= true;
  state[39][25]= true;
  state[40][23]= true;
  state[40][25]= true;
  state[41][24]= true;
}

// draw elements that make up the user interface
// (text on screen, boxes etc)
void drawUI()
{
  fill(255,255,255);
  textSize(22);
  text("click to pause", 10, height-10);
}
// was used in debugging producing random booleans for populating initial state
boolean randomBoolean()
{
  return (random(0, 10) > 5.0);
}

// pause drawing if mouse button is clicked
void mousePressed()
{
  paused = !paused;
}