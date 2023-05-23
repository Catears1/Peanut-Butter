/* Game Class Starter File
 * Authors: _____________________
 * Last Edit: 5/23/23
 */

//import processing.sound.*;

//GAME VARIABLES
private int msElapsed = 0;
Grid grid = new Grid(6,8);
//HexGrid hGrid = new HexGrid(3);
PImage bg;
//Player player1;
PImage player1;
PImage player2;
PImage endScreen;
String titleText = "PeanutButter";
String extraText = "Butter Nut Peanut";
AnimatedSprite exampleSprite;
boolean doAnimation;
//SoundFile song;

int player1Row = 3;
int player1Col = 3;



//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(800, 600);

  //Set the title on the title bar
  surface.setTitle(titleText);

  //Load images used
  bg = loadImage("images/chess.jpg");
  //bg = loadImage("images/x_wood.png");
  bg.resize(800,600);
  //player1 = new Player();
  player1 = loadImage("images/chick_image.png");
  player1.resize(grid.getTileWidthPixels(),grid.getTileHeightPixels());
  endScreen = loadImage("images/youwin.png");

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();

  
  //Animation & Sprite setup
  exampleAnimationSetup();

   imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  
  println("Game started...");
  
}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();

  if (msElapsed % 300 == 0) {
    populateSprites();
    moveSprites();
  }

  updateScreen();
  
  if(isGameOver()){
    endGame();
  }

  checkExampleAnimation();
  
  msElapsed +=100;
  grid.pause(100);

}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //set "w" key to move the player1 up
  if(keyCode == 87){
    
    //Store old GridLocation
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    
    //Erase image from previous location
    grid.clearTileImage(oldLoc);

    //change the field for player1Row
    player1Row--;
  }

  if(keyCode == 83){
    //check case where out of bounds
    
    //change the field for player1Row
    player1Row++;

    //shift the player1 picture up in the array
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileImage(loc, player1);

    //eliminate the picture from the old location

  }

  if(keyCode == 68){
    //check case where out of bounds
    
    //change the field for player1Row
    player1Col++;

    //shift the player1 picture up in the array
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileImage(loc, player1);

    //eliminate the picture from the old location

  }

  if(keyCode == 65){
    //check case where out of bounds
    
    //change the field for player1Row
    player1Col--;

    //shift the player1 picture up in the array
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileImage(loc, player1);

    //eliminate the picture from the old location

  }
}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){

  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  System.out.println("Grid location: " + grid.getGridLocation());

  //what to do if clicked? (Make player1 disappear?)


  //Toggle the animation on & off
  doAnimation = !doAnimation;
  System.out.println("doAnimation: " + doAnimation);
  grid.setMark("X",grid.getGridLocation());
  
}



//------------------ CUSTOM  METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText);

    //adjust the extra text as desired
  
  }

}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //update the background
  background(bg);

  //Display the Player1 image
  GridLocation player1Loc = new GridLocation(player1Row, player1Col);
  grid.setTileImage(player1Loc, player1);
  
  //Loop through all the Tiles and display its images/sprites
  

      //Store temporary GridLocation
      
      //Check if the tile has an image/sprite 
      //--> Display the tile's image/sprite



  //Update other screen elements


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){
  
  //What is the index for the last column?
  

  //Loop through all the rows in the last column
  
    //Generate a random number
    

    //10% of the time, decide to add an enemy image to a Tile
    

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

//Loop through all of the rows & cols in the grid
  
      //Store the 2 tile locations to move

      //Check if the current tile has an image that is not player1      


        //Get image/sprite from current location


        //CASE 1: Collision with player1


        //CASE 2: Move enemy over to new location

        
        //Erase image/sprite from old location
        
        //System.out.println(loc + " " + grid.hasTileImage(loc));


      //CASE 3: Enemy leaves screen at first column

}

//Method to handle the collisions between Sprites on the Screen
public void handleCollisions(){


}

//method to indicate when the main game is over
public boolean isGameOver(){
  return false; //by default, the game is never over
}

//method to describe what happens after the game is over
public void endGame(){
    System.out.println("Game Over!");

    //Update the title bar

    //Show any end imagery
    image(endScreen, 100,100);

}

//example method that creates 5 horses along the screen
public void exampleAnimationSetup(){  
  int i = 2;
  exampleSprite = new AnimatedSprite("sprites/chick_walk.png", 50.0, i*75.0, "sprites/chick_walk.json");
}

//example method that animates the horse Sprites
public void checkExampleAnimation(){
  if(doAnimation){
    exampleSprite.animateHorizontal(-0.1,0.07 , true);
  }
}
