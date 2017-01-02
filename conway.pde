int rows = 100;
int cols = 100;
int edge_size = 10;
boolean[][] state;
boolean[][] new_state;

void setup()
{
  size(1000, 1000);
  frameRate(10);
  stroke(255, 255, 255);
  state = new boolean[cols][rows];

  setInitialState();
}

void draw()
{
  new_state = new boolean[cols][rows];
  background(0);

  for (int y = 0; y < rows; y++)
  {
    for (int x = 0; x < cols; x++)
    {
      if (computeState(x, y))
      {
        fill(0, 255, 0); 
        new_state[y][x] = true;
      } else
      {
        noFill();
        new_state[y][x] = false;
      }
      rect(x * edge_size, y * edge_size, edge_size, edge_size);
    }
  }
  state = new_state;
}
void setInitialState()
{
  // from https://en.wikipedia.org/wiki/Conway's_Game_of_Life
  // this is an initial state that exhibits infinite growth
  for (int x = 0; x < cols; x++)
  {
    if (x >= 40 && x <= 47)
    {
      state[40][x] = true;
    } else if (x >= 49 && x <= 53)
    {
      state[40][x] = true;
    } else if (x >= 57 && x <= 59)
    {
      state[40][x] = true;
    } else if (x >= 66 && x <= 72)
    {
      state[40][x] = true;
    } else if (x >= 74 && x <= 78)
    {
      state[40][x] = true;
    } else
    {
      state[40][x] = false;
    }
  }
}
boolean computeState(int x, int y)
{
  boolean isAlive = false;
  if (frameCount == 1)
  {
    isAlive = state[y][x];
  } else
  {
    int alive_neighbours = 0;
    if ((x > 0 && x < cols - 1) && (y > 0 && y < rows - 1))
    {
      for (int i = (x - 1); i <= (x + 1); i++)
      {
        for (int j = (y - 1); j <= (y + 1); j++)
        {
          if (state[j][i] ==  true)
          {
            alive_neighbours++;
          }
        }
      }

      // RULES:
      //Any live cell with fewer than two live neighbours dies (referred to as underpopulation or exposure[1]).
      if (alive_neighbours < 2) { 
        isAlive = false;
      }
      //Any live cell with more than three live neighbours dies (referred to as overpopulation or overcrowding).
      if (alive_neighbours > 3) { 
        isAlive = false;
      }
      //Any live cell with two or three live neighbours lives, unchanged, to the next generation.
      if ((alive_neighbours == 2) || (alive_neighbours == 3)) { 
        isAlive = true;
      }
      //Any dead cell with exactly three live neighbours will come to life.
      if (alive_neighbours == 3) { 
        isAlive = true;
      }
    }
  }



  return isAlive;
}
boolean randomBoolean()
{
  return (random(0, 10) > 5.0);
}