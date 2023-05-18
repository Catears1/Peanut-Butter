//Test file for some basic processing commands
boolean left, right, up, down;
Player p = new Player();
String s = "";

public void setup(){
    size(800,600);
    background(255);

    left = false;
    right = false;
    up = false;
    down = false;

}

public void draw(){  
    background(255);
    p.update();
    p.display();

    fill(0);
    textSize(24);
    text(s, 100, 50);
}

public void keyPressed(){
    s = "key: " + keyCode;
    switch(keyCode) {
        case 65: //left
            left = true;
            break;

        case 87: 
            up = true;
            break;

        case 83:
            down = true;
            break;

        case 68:
            right = true;
            break;
    }
}

    // if(keyCode == 65){
    //     left = true;
    // else if(keyCode == 87){
    //     up = true;
    // }
    // else if(keyCode == 83){
    //     down = true;
    // }
    // else if(keyCode == 68){
    //     right = true;  
    // }

    public void keyReleased() {
    switch (keyCode) {
        case 65: //left
            left = false;
            break;

        case 87: 
            up = false;
            break;

        case 83:
            down = false;
            break;

        case 68:
            right = false;
            break;
    }
    }
    
