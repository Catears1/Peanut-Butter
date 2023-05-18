class Player{

    float x,y,w,h;
    float speedX, speedY, maxSpeed;

Player(){
    x = width/2;
    y = height/2;
    w = 32;
    h = 32;
    maxSpeed = 10;
    speedX = 0;
    speedY = 0;
 }

void update(){

    if(left){
        speedY = 0;
        speedX = -maxSpeed;
    }

    if(right){
        speedY = 0;
        speedX = maxSpeed;
    }

    if(!left && !right){
        speedX = 0;
    }

    

    if(up){
        speedY = -maxSpeed;
        speedX = 0;
    }

    if(down){
        speedY = maxSpeed;
        speedX = 0;
    }

    if(!up && !down){
        speedY = 0;
    }

    

    x += speedX;
    y += speedY;
 }

void display(){
    fill(255,0,0);
    rect(x, y, w, h);
 }
}

