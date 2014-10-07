GameObject plunger = null;
GameObject ball = null;
GameObject leftPaddle = null;
GameObject rightPaddle = null;

RevoluteJoint leftJoint = null;
RevoluteJoint rightJoint = null;

boolean plungerDown = false;
float plungerRestingPoint = 0;

void initializeControl(GameWorld world) {
  plungerRestingPoint = height - 100;
  BodyDef bd = new BodyDef(); // plunger
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 60, plungerRestingPoint));
  bd.fixedRotation = true;
  bd.bullet = true;
  bd.type = BodyType.KINEMATIC;
  
  FixtureDef fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  plunger = new RectangleObject(world, 100, 10, bd, fd);
  world.addObject(plunger);
  
  bd = new BodyDef(); // ball
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 60, 400));
  bd.fixedRotation = true;
  bd.bullet = true;
  bd.type = BodyType.DYNAMIC;
  bd.allowSleep = false;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 0.3;
  
  ball = new CircleObject(world, 30, bd, fd);
  world.addObject(ball);
  
  bd = new BodyDef(); // bottom left edge
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(127, height - 70));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  bd.angle = PI / 3.5;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  GameObject obj = new RectangleObject(gameWorld, 25, 300, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // left paddle
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(180, height - 100));
  bd.fixedRotation = false;
  bd.bullet = true;
  bd.type = BodyType.DYNAMIC;
  bd.angle = 0;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  leftPaddle = new RectangleObject(world, 200, 15, bd, fd);
  world.addObject(leftPaddle);
  
  RevoluteJointDef rjd = new RevoluteJointDef();
  Vec2 rjPos = leftPaddle.body.getWorldCenter();
  rjPos.x -= 10;
  rjd.initialize(leftPaddle.body, obj.body, rjPos);
  rjd.enableLimit = true;
  rjd.lowerAngle = -PI / 8;
  rjd.upperAngle = PI / 8;
  rjd.motorSpeed = PI * 7;
  rjd.maxMotorTorque = 999999;
  rjd.enableMotor = true;
  leftJoint = (RevoluteJoint)world.box2d.world.createJoint(rjd);
  
  bd = new BodyDef(); // bottom right edge
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 227, height - 70));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  bd.angle = -PI / 3.5;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 25, 300, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // right paddle
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 280, height - 100));
  bd.fixedRotation = false;
  bd.bullet = true;
  bd.type = BodyType.DYNAMIC;
  bd.angle = 0;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  rightPaddle = new RectangleObject(world, 200, 15, bd, fd);
  world.addObject(rightPaddle);
  
  rjd = new RevoluteJointDef();
  rjPos = rightPaddle.body.getWorldCenter();
  rjPos.x += 10;
  rjd.initialize(rightPaddle.body, obj.body, rjPos);
  rjd.enableLimit = false;
  rjd.lowerAngle = PI;
  rjd.upperAngle = PI;
  rjd.motorSpeed = -PI * 7;
  rjd.maxMotorTorque = 999999;
  rjd.enableMotor = true;
  rightJoint = (RevoluteJoint)world.box2d.world.createJoint(rjd);
}

void updateControl(GameWorld world) {
  PVector pos = plunger.getPosition();
  if(plungerDown) {
    if(pos.y > height - 10) {
      plunger.body.setLinearVelocity(new Vec2(0, 0));
    }
    else {
      plunger.body.setLinearVelocity(new Vec2(0, -10));
    }
  }
  else {
    if(pos.y < plungerRestingPoint) {
      plunger.body.setLinearVelocity(new Vec2(0, 0));
    }
    else {
      plunger.body.setLinearVelocity(new Vec2(0, 70));
    }
  }
}
void keyPressed() {
  if(key == ' ') {
    plungerDown = true;
  }
  else if(keyCode == LEFT) {
    leftJoint.setMotorSpeed(-PI * 7);
  }
}

void keyReleased() {
  if(key == ' ') {
    plungerDown = false;
  }
  else if(keyCode == LEFT) {
    leftJoint.setMotorSpeed(PI * 7);
  }
}
