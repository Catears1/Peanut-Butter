/* Player class
 * Authors: Tahlei Richardson & Aiden Sing
 * Last Edit: 5/22/2023
 */

class Player extends AnimatedSprite{

    //Test code for some basic processing commands
    boolean left, right, up, down;

    float x,y,w,h;
    float speedX, speedY, maxSpeed;
    String png;
    String json;

Player(String png, String json){
    super(png,0.0,0.0,json);
    //(String png, float x, float y, String json) {
    x = width/2;
    y = height/2;
    w = 32;
    h = 32;
    maxSpeed = 10;
    speedX = 0;
    speedY = 0;

    left = false;
    right = false;
    up = false;
    down = false;
 }


void update(){

    //Horizantal Movement
    if(left){
         speedY = 0;
         speedX = -maxSpeed;
    }

    if(right){
        
        speedY = 0;
        speedX = maxSpeed;
    }

    // If both left and right are being pressed or both arent, the player character  wont move.
    if(!left && !right || left && right){
        speedX = 0;
    }

    // Vertical Movement
    if(up){
        speedY = -maxSpeed;
        speedX = 0;
    }
 
    if(down){
        speedY = maxSpeed;
        speedX = 0;
    }

    //If both up and down are being pressed or both arent, the player character wont move.
    if(!up && !down || up && down){
        speedY = 0;
        super.setAnimationSpeed(0);
    }

    if(!up && !down && !left && !right){
        //speedY = 0;
        super.setAnimationSpeed(0);
    }


    // Diagnol Controls
    if(up && right){
        speedY -= 2;
        speedX += 2;
    }

    if(up && left){
        speedY = -maxSpeed;
        speedX = - maxSpeed;
    }    

    //Updates The Character's Position
    x += speedX;
    y += speedY;
 }

// void display(){
//     //The Game display Size
//     fill(255,0,0);
//     rect(x, y, w, h);
//  }

void checkBounds(){
    
 }
}

