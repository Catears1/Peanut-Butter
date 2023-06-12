/* Game Class Starter File
 * Authors: Aiden Sing, Tahlei Richardson
 * Last Edit: 5/17/23
 */

//import processing.sound.*;

//import processing.sound.*;

//GAME VARIABLES
private int msElapsed = 0;
String titleText = "PeanutButter";
String extraText = "Butter Nut Peanut";

//Screens
Screen currentScreen;
World currentWorld;
Grid currentGrid;

//Splash Screen Variables
Screen splashScreen;
String splashBgFile = "images/chess.jpg";
PImage splashBg;

//Main Screen Variables
Grid mainGrid;
Screen mainScreen;
String mainBgFile = "images/grass.png";
PImage mainBg;

PImage player1;
String player1File = "images/x_wood.png";
int player1Row = 30;
int player1Col = 3;
float walkSpeed = 0.2;
int health = 3;
Player p;
Player p1;
Player p2;

PImage hs;
String hsFile = "images/outhouseremovedbg.png";

//House Screen Variables
Grid houseGrid;
PImage houseBg;
String houseBgFile = "images/inhouse.png";

String bgs[] = {"inhouse.png", "outhouseremovedbg.png", "grass.png"};
// boolean itemCollision = false;

// AnimatedSprite exampleSprite;
boolean doAnimation;
//SoundFile song;

//EndScreen variables
World endScreen;
PImage endBg;
String endBgFile = "images/youwin.png";

//Example Variables
//HexGrid hGrid = new HexGrid(3);
//SoundFile song;


//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(1920, 1080);

  //Set the title on the title bar
  surface.setTitle(titleText);


  //Load BG images used
  splashBg = loadImage(splashBgFile);
  splashBg.resize(1920,1080);
  mainBg = loadImage(mainBgFile);
  mainBg.resize(1920,1080);
  houseBg = loadImage(houseBgFile);
  houseBg.resize(1920,1080);
  endBg = loadImage(endBgFile);
  endBg.resize(1920,1080);

  //setup the screens/worlds/grids in the Game
  splashScreen = new Screen("splash", splashBg);
  mainGrid = new Grid("grass", mainBg, 100,100);
  houseGrid = new Grid("house", houseBg, 100,100);
  endScreen = new World("end", endBg);
  currentScreen = splashScreen;
  currentGrid = mainGrid;

  //Load other images

  //setup the sprites  
  player1 = loadImage(player1File);
  player1.resize(mainGrid.getTileWidthPixels(),mainGrid.getTileHeightPixels());
  p1 = new Player("sprites/chick_walk.png", "sprites/chick_walk.json");
  p2 = new Player("sprites/chick_walk_inverted.png", "sprites/chick_walk_inverted.json");
  p = new Player("sprites/chick_walk.png", "sprites/chick_walk.json");
  p.setAnimationSpeed(walkSpeed);

  //add sprites to the Screens
  System.out.println("Adding sprites to main world...");
  // mainGrid.addSpriteCopyTo(item1, 1000,100);
  // mainGrid.addSpriteCopyTo(item2, 900, 400);
  mainGrid.printSprites();
  hs = loadImage(hsFile);
  System.out.println("Done adding sprites to sky world..");

  //Other Setup
  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();
  
  imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  println("Game started...");

}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {
  // image(hs, 0, 0);
  // image(hs, 0, 0, width/2, height/2);

  updateTitleBar();
  p.update();
  updateScreen(); //<--where logic is to switch screens
  populateSprites();
  moveSprites();
  
  if(isGameOver()){
    endGame();
  }
  //checkExampleAnimation();

}


//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
    
  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  //Toggle the animation on & off
  doAnimation = !doAnimation;
  System.out.println("doAnimation: " + doAnimation);
  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
  }

  
}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key


  //What to do when a key is pressed?
  System.out.println("Player1 is at (" + player1Row + "," + player1Col + ")");
  //set "w" key to move the player1 up
  if(keyCode == 87){
    if(player1Row - 2 <= 2){
      player1Row +=0;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else if(hsItemCollisions() == true && currentScreen == houseGrid) {
      player1Row+=0;
    }
    else{   
      player1Row-=1;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
  }

  //set "q" key to move the player1 l left/up diagnol
  if(keyCode == 81) {
    if(player1Col - 2 <= 2 && (player1Row - 2 <= 2) == false){
      player1Row -=1;
      player1Col +=0;
    }
    else if(player1Row - 2 <= 2 && (player1Col - 2 <= 2) == false){
      player1Row +=0;
      player1Col -=1;
    }
    else if(player1Row - 2 <= 2 && player1Col - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else{
      player1Row-=1;
      player1Col-=1;
      p = p1;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }


  }

  //set "e" key to move the player1 up/right diagnol
  if(keyCode == 69) {
    if(player1Row - 2 <= 2 && (player1Col + 2 >= 92) == false){
      player1Row +=0;
      player1Col +=1;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else if(player1Col + 2 >= 92 && (player1Row - 2 <= 2) == false){
      player1Row -=1;
      player1Col +=0;
    }
    else if(player1Col + 2 >= 92 && player1Row - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    }
    
    else{
      player1Row-=1;
      player1Col+=1;
      p = p2;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
    
  }

  //set "z" key to move the player1 down/left diagnol
  if(keyCode == 90) {
    if(player1Col - 2 <= 2 && (player1Row + 2 >= 86) == false){
      player1Row +=1;
      player1Col +=0;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else if(player1Row + 2 >= 86 && (player1Col - 2 <= 2) == false){
      player1Row +=0;
      player1Col -=1;
    }
    else if(player1Row + 2 >= 86 && player1Col - 2 <= 2){
      player1Row +=0;
      player1Col +=0;
    } 
    else {
      player1Row+=1;
      player1Col-=1;
      p = p1;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
  }

  //set "c" key to move the player1 dow/right diagnol
  if(keyCode == 67) {
    if(player1Row + 2 >= 86 && (player1Col + 2 >= 92) == false){
      player1Row +=0;
      player1Col +=1;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else if(player1Col + 2 >= 92 && (player1Row + 2 >= 86) == false){
      player1Row +=1;
      player1Col +=0;
    }
    else if(player1Col + 2 >= 92 && player1Row + 2 >= 86){
      player1Row +=0;
      player1Col +=0;
    }
    else{
      player1Row+=1;
      player1Col+=1;
      p = p2;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
  }
  
  //set "s" key to move the player1 down
  if(keyCode == 83){
    if(player1Row + 2 >= 86){
      player1Row +=0;
    }else if(hsItemCollisions() == true && currentScreen == houseGrid) {
      player1Row+=0;
    }
    else{
      player1Row+=1;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
  }

  //set "d" key to move the player1 right 
  if(keyCode == 68){
    if(player1Col + 2 >= 92){
      player1Col +=0;
    }
    
    else{
      player1Col+=1;
      p = p2;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
    }
  }


  //set "a" key to move the player1 left
  if(keyCode == 65){

    if(player1Col - 2 <= 2){
      player1Col +=0;
    }
    else if(mainItemCollisions() == true && currentScreen == mainGrid) {
      player1Row+=0;
    }
    else if(hsItemCollisions() == true && currentScreen == houseGrid) {
      player1Row+=0;
    }
    // if((player1Col - 2 < 23 && player1Row + 2 > 4) && (player1Row - 2  < 19 && player1Col + 2 > 4)){
    //   
    // }
    else{
      player1Col-=1;
      p = p1;
      p.setAnimationSpeed(walkSpeed);
      GridLocation loc = new GridLocation(player1Row, player1Col);
      currentGrid.setTileSprite(loc, p);
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

  //Update the Background
  background(currentScreen.getBg());
  GridLocation player1Loc = new GridLocation(player1Row, player1Col);
  currentGrid.setTileSprite(player1Loc, p);
  
  //splashScreen update
  if(splashScreen.getScreenTime() > 3000 && splashScreen.getScreenTime() < 5000){
    currentScreen = mainGrid;
  }

  //skyGrid Screen Updates
  if(currentScreen == mainGrid){
    currentGrid = mainGrid;

    //Display the Player1 image
    

    //Display House
    image(hs, 0, 0, width/4, height/3);
    currentGrid.setTileSprite(player1Loc, p);
    //image(hs, 0, 0);

    //Switch screens when entering the house
    if(player1Row == 20 && player1Col ==  10){
      currentScreen = houseGrid;
      currentGrid = houseGrid;
      player1Row = 71;
      player1Col = 49;
    }

    if(currentScreen == houseGrid){
      
      currentGrid = houseGrid;
    }

    //update other screen elements
    // mainGrid.showSprites();
    // mainGrid.showImages();
    // mainGrid.showGridSprites();
    // checkExampleAnimation();

  }

  //Other Screen? House? End?


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

 public boolean mainItemCollisions() {
  if((player1Col - 2 < 20 && player1Row + 2 > 4) && (player1Row - 2  < 19 && player1Col + 2 > 4)){
    return true;
  }else{
    return false;
  }
  
}

public boolean hsItemCollisions() {
  if((player1Col - 2 < 12 && player1Row + 2 > 48) && (player1Row - 2 < 84 && player1Col - 2 < 15)){
    return true;
  }
  else if ((player1Col - 2 < 23 && player1Row - 2 < 29) && (player1Col - 2 < 23 && player1Row - 2 > 4)) {
    return true;
  }
  else{
    return false;
  }
  
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
    currentScreen = endScreen;
    //image(endBg, 100,100);

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