/* Game Class Starter File
 * Authors: Aiden Sing, Tahlei Richardson
 * Last Edit: 5/17/23
 */

//import processing.sound.*;

//GAME VARIABLES
Grid grid = new Grid(100,100);
//HexGrid hGrid = new HexGrid(3);
PImage bg;
PImage player1;
Player p;
Player p1;
Player p2;
PImage endScreen;
String titleText = "PeanutButter";
String extraText = "Butter Nut Peanut";
// AnimatedSprite exampleSprite;
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
  bg = loadImage("images/grass.png");
  //bg = loadImage("images/x_wood.png");
  bg.resize(800,600);
  player1 = loadImage("images/x_wood.png");
  p1 = new Player("sprites/chick_walk.png", "sprites/chick_walk.json");
  p2 = new Player("sprites/chick_walk_inverted.png", "sprites/chick_walk_inverted.json");
  p = new Player("sprites/chick_walk.png", "sprites/chick_walk.json");
  player1.resize(grid.getTileWidthPixels(),grid.getTileHeightPixels());
  endScreen = loadImage("images/youwin.png");

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();

  
  //Animation & Sprite setup
  //exampleAnimationSetup();

  println("Game started...");

  //fullScreen();   //only use if not using a specfic bg image
}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  
  updateTitleBar();
  updateScreen();
  populateSprites();
  moveSprites();
  p.update();
  if(isGameOver()){
    endGame();
  }

  //checkExampleAnimation();

}


//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
  
  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  System.out.println("Grid location: " + grid.getGridLocation());

  //what to do if clicked?
  doAnimation = !doAnimation;
  System.out.println("doAnimation: " + doAnimation);
  grid.setMark("X",grid.getGridLocation());
  
}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key


  //What to do when a key is pressed?
  
  //set "w" key to move the player1 up



  if(keyCode == 87){

    if(player1Row - 2 <= 2){
      player1Row +=0;
    }

    else{   
    player1Row-=2;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);
    }
  }

  //set "q" key to move the player1 l left/up diagnol
  if(keyCode == 81) {

    if(player1Col - 2 <= 2 && (player1Row - 2 <= 2) == false){
      player1Row -=2;
      player1Col +=0;
    }

    else if(player1Row - 2 <= 2 && (player1Col - 2 <= 2) == false){
      player1Row +=0;
      player1Col -=2;
    }
    else if(player1Row - 2 <= 2 && player1Col - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    }

    else{
    player1Row-=2;
    player1Col-=2;
    p = p1;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);
  }
  }

  //set "e" key to move the player1 up/right diagnol
  if(keyCode == 69) {
    if(player1Row - 2 <= 2 && (player1Col + 2 >= 92) == false){
      player1Row +=0;
      player1Col +=2;
    }
    else if(player1Col + 2 >= 92 && (player1Row - 2 <= 2) == false){
      player1Row -=2;
      player1Col +=0;
    }
    else if(player1Col + 2 >= 92 && player1Row - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    }
    else{
      player1Row-=2;
      player1Col+=2;
      p = p2;
      p.setAnimationSpeed(0.1);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      grid.setTileSprite(loc, p);
    }
    
  }

  //set "z" key to move the player1 down/left diagnol
  if(keyCode == 90) {
    if(player1Col - 2 <= 2 && (player1Row + 2 >= 86) == false){
      player1Row +=2;
      player1Col +=0;
    }

    else if(player1Row + 2 >= 86 && (player1Col - 2 <= 2) == false){
      player1Row +=0;
      player1Col -=2;
    }
    else if(player1Row + 2 >= 86 && player1Col - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    } 
    else {
    player1Row+=2;
    player1Col-=2;
    p = p1;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);
    }
  }

  //set "c" key to move the player1 dow/right diagnol
  if(keyCode == 67) {
    if(player1Row + 2 >= 86 && (player1Col + 2 >= 92) == false){
      player1Row +=0;
      player1Col +=2;
    }
    else if(player1Col + 2 >= 92 && (player1Row + 2 >= 86) == false){
      player1Row +=2;
      player1Col +=0;
    }
    else if(player1Col + 2 >= 92 && player1Row + 2 >= 86){
      player1Row +=0;
      player1Col +=0;
    }
    else{
      player1Row+=2;
      player1Col+=2;
      p = p2;
      p.setAnimationSpeed(0.1);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      grid.setTileSprite(loc, p);
    }
    
  }
  
  //set "s" key to move the player1 down
  if(keyCode == 83){
    if(player1Row + 2 >= 86){
      player1Row +=0;
    }

    else{
    player1Row+=2;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);
  }
  }
  //set "d" key to move the player1 right 
  if(keyCode == 68){
    if(player1Col + 2 >= 92){
      player1Col +=0;
    }

    else{
    player1Col+=2;
    p = p2;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);

  }
  }


  //set "a" key to move the player1 left
  if(keyCode == 65){

    if(player1Col - 2 <= 2){
      player1Col +=0;
    }

    else{
    player1Col-=2;
    p = p1;
    p.setAnimationSpeed(0.1);
    GridLocation loc = new GridLocation(player1Row, player1Col);
    grid.setTileSprite(loc, p);

  }


}
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
  grid.setTileSprite(player1Loc, p);
  
  //update other screen elements


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){


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
// public void exampleAnimationSetup(){  
//   int i = 2;
//   exampleSprite = new AnimatedSprite("sprites/horse_run.png", 50.0, i*75.0, "sprites/horse_run.json");
// }

//example method that animates the horse Sprites
// public void checkExampleAnimation(){
//   if(doAnimation){
//     exampleSprite.setAnimationSpeed(1.0);
//     exampleSprite.animateVertical(1.0, 0.1, true);
//   }
// }