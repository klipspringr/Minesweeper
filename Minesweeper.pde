

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 40;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public boolean isFinished;

void setup ()
{
    size(400, 400);
    isFinished = false;
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int j = 0; j < NUM_COLS; j++)
    {
        for(int i = 0; i < NUM_ROWS; i ++)
        {
            buttons[i][j] = new MSButton(i, j);
        }
    }
    bombs = new ArrayList <MSButton>();
    //declare and initialize buttons
    setBombs();
}
public void setBombs()
{
    //your code
    for (int i = 0; i < NUM_BOMBS; i++)
    {
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        //System.out.println("row: "+row);
        //System.out.println("col: "+col);
        if(bombs.contains(buttons[row][col]) == false)
        {

            bombs.add(buttons[row][col]);
            // System.out.println("Bombs deployed!" + row + ", " + col);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    isFinished = true;
}
public boolean isWon()
{
    int bombCount = 0;
    //your code here
    for (int i = 0; i < NUM_BOMBS - 5; i++)
    {
        if (bombs.get(i).isMarked() == true){
            bombCount ++;
            if(bombCount == NUM_BOMBS)
            {
                return true;
            }
        }

    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
     for (int j = 0; j < NUM_COLS; j++)
    {
        for(int i = 0; i < NUM_ROWS; i ++)
        {
            buttons[i][j].clicked = true;
            if(buttons[i][j].marked == true)
            {
                buttons[i][j].marked = false;
            }
        }
    }

    // System.out.println("Something happened!");

    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");

}
public void displayWinningMessage()
{
    //your code here
     for (int j = 0; j < NUM_COLS; j++)
    {
        for(int i = 0; i < NUM_ROWS; i ++)
        {
            buttons[i][j].clicked = true;
            if(buttons[i][j].marked == true)
            {
                buttons[i][j].marked = false;
            }
        }
    }
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
    buttons[9][13].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
            if(marked == true)
            {
                marked = false;
            }else if(marked == false)
            {
                marked = true;
            }
        }
        else if(bombs.contains(buttons[r][c]) && marked == false)
        {
               
            displayLosingMessage();
            isFinished = true;
        }
        else if (countBombs(this.r, this.c) != 0) {
            this.setLabel("" + (countBombs(this.r, this.c)));
        //your code here
        }
        else
        {
            if(isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false)
            {
                buttons[r+1][c].mousePressed();
            } //1
            
        
             if(isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false)
            {
                buttons[r+1][c+1].mousePressed();
            }//2

            if(isValid(r, c+1) == true && buttons[r][c+1].isClicked() == false)
            {
                buttons[r][c+1].mousePressed();
            }//3
            
             if(isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false)
            {
                buttons[r-1][c+1].mousePressed();
            }//4

            if(isValid(r-1, c) == true && buttons[r-1][c].isClicked() == false)
            {
                buttons[r-1][c].mousePressed();
            }//5
            if(isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            //6
            if(isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false)
            {
                buttons[r][c-1].mousePressed();
            }//7
            if(isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false)
            {
                buttons[r+1][c-1].mousePressed();
            }//8

        }
    }

    public void draw () 
    {    
        if (marked)
            fill(250, 161, 255);
        else if( clicked && bombs.contains(this) ) 
            fill(245,76,76);
        else if(clicked)
            fill(227, 255, 254);
        else 
            fill(255, 227, 228);
        stroke(140);
        rect(x, y, width, height);
        fill(15);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r < 20 && r >= 0 && c >= 0 && c < 20)
        {
            return true;
        }else
        {
        return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1, col)== true)
        {
            if(bombs.contains(buttons[row-1][col]) == true)
            numBombs++;
        }
        if(isValid(row-1, col+1)== true)
        {
            if(bombs.contains(buttons[row-1][col+1]) == true)
            numBombs++;
        }
        if(isValid(row, col+1)== true)
        {
            if(bombs.contains(buttons[row][col+1]) == true)
            numBombs++;
        }
        if(isValid(row+1, col+1)== true)
        {
            if(bombs.contains(buttons[row+1][col+1]) == true)
            numBombs++;
        }
        if(isValid(row +1, col)== true)
        {
            if(bombs.contains(buttons[row+1][col]) == true)
            numBombs++;
        }
        if(isValid(row+1, col-1)== true)
        {
            if(bombs.contains(buttons[row+1][col-1]) == true)
            numBombs++;
        }
        if(isValid(row, col-1)== true)
        {
            if(bombs.contains(buttons[row][col-1]) == true)
            numBombs++;
        }
        if(isValid(row-1, col-1)== true)
        {
            if(bombs.contains(buttons[row-1][col-1]) == true)
            numBombs++;
        }
        return numBombs;
    }
}



