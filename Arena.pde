void buildArena(GameWorld gameWorld) {
  
  // basic walls //
  BodyDef bd = new BodyDef(); // left wall
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(10, height / 2));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  FixtureDef fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  GameObject obj = new RectangleObject(gameWorld, 20, height, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // right wall
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 10, height / 2));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 20, height, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // second right wall
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 110, height / 2 + 150));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 20, height, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // top edge
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width / 2, 0));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, width, 25, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // curved corner
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 200, 200));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  int vCount = 20;
  PVector[] verts = new PVector[vCount];
  for(int i = 0; i < vCount; i++) {
    verts[i] = new PVector(
      (float)(200*Math.cos(i * (PI / 2 / vCount) - PI / 2)),
      (float)(200*Math.sin(i * (PI / 2 / vCount) - PI / 2))
    );
  }
  
  obj = new ChainObject(gameWorld, verts, bd, fd);
  gameWorld.addObject(obj);
}

void buildDynamics(GameWorld world) {
  BodyDef bd = new BodyDef(); // left bumper
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(80, 80));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  FixtureDef fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  GameObject obj = new CircleBumperObject(gameWorld, 30, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // lower right
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 230, height - 295));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new CircleBumperObject(gameWorld, 35, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // middle
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width / 2, 130));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new CircleBumperObject(gameWorld, 30, bd, fd);
  gameWorld.addObject(obj);
}
