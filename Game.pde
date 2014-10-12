int currentScore = 0;
int lives = 3;

boolean gameOver = false;

void updateGame() {
  textSize(32);
  fill(255);
  if(gameOver) {
    text("Game over. Final score: " + currentScore, width / 2 - 200, 100);
  }
  else {
    text("Lives: " + lives + " - Score: " + currentScore, width / 2 - 200, 100);
  }
  
  if(ball.getPosition().y > height + 50) {
    lives--;
    
    if(lives <= 0) {
      gameOver = true;
    }
    else {
      // reset ball
      ball.body.setLinearVelocity(new Vec2(0,0));
      ball.setPosition(new PVector(width - 60, 400));
    }
  }
}

void addScore(int amount) {
 currentScore += amount;
}
