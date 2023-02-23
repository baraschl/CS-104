
//establish all variables
int circley=50;                             // y-coordinate of the ball
int GAP=50;                                 // space from bottom of window to center of paddle
int paddley;                                // paddle's height is GAP subtracted from height
int circlex=(int)random(11, 789);           // ball's initial x coordinate is random 
int startDirection= (int) random(-2, 2);    // ball starts in a random direction; denotes horizontal speed
int speed=1;                                // denotes speed of vertical movement of the ball
int score = 0;                              // number in top right corner
int diameter= 20;                           // diameter of the ball
int paddleWidth=100;                        // width of paddle
int paddleLength=20;                        // length of paddle

// size of window and height of the paddle won't change, so put them in void setup()
void setup() {
  size(800, 400);
  paddley=height-GAP;
}

void draw() {

  //crazy rainbow ball feature
  if (!mousePressed) {
    background(0);
  }

  // establish random colors
  float red=random(0, 255);
  float green=random(0, 255);
  float blue=random(0, 255);


  // if start direction is 0, rerun the random function until startDirection = -1 or 1
  if (startDirection==0) {
    startDirection= (int) random(-2, 2);
  }

  // press any button to continue after losing
  if (circley>=390 && keyPressed) {
    circley=50;
    circlex= (int) random(11, 789);
    startDirection= (int) random(-2, 2);
    if (startDirection==0) {
      startDirection=(int) random(-2, 2);
    }
    score=0;
    speed=1;
  }

  // paddle cannot exceed bounds of the window
  if (mouseX<=paddleWidth/2) {
    mouseX=paddleWidth/2;
  } else if (mouseX>=width-paddleWidth/2) {
    mouseX=width-paddleWidth/2;
  } 

  // make paddle  
  rectMode(CENTER);
  fill(255);
  rect(mouseX, paddley, paddleWidth, paddleLength);

  // make ball
  fill(red, green, blue);
  circle(circlex, circley, diameter);

  // ball movement
  circley=circley+speed;
  circlex=circlex+startDirection;

  // if ball touches side walls then change direction
  if (circlex<=diameter/2 || circlex>=width-diameter/2) {
    startDirection*=-1;
  }

  // if ball touches ceiling then change direction
  if (circley<=10) {
    speed*=-1;
  }

  // if ball touches bottom of window display game over
  textAlign(CENTER);
  textSize(90);
  fill(255);
  if (circley>=390) {
    text("GAME OVER", 400, 200);
    textSize(20);
    text("PRESS ANY KEY TO CONTINUE", 400, 250);
  }

  // display score
  textSize(20);
  text("SCORE:", 700, 30);
  text(score, 750, 30);

  // when ball hits paddle, bounce, increase speed, and increase score
  if (circley==height-GAP-diameter && circlex<mouseX+paddleWidth/2 && circlex>mouseX-paddleWidth/2) {
    speed*=-1;
    speed-=1;
    if (startDirection>0) {
      startDirection+=1;
    } else if (startDirection<0) {
      startDirection-=1;
    }
    score+=1;
  }
}
