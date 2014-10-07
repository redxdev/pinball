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
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 110, height / 2 + 200));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 20, height, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // top right edges
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 20, 110));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  bd.angle = -PI / 3.5;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 100, 20, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // top right edges
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 70, 60));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  bd.angle = -PI / 6;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 100, 20, bd, fd);
  gameWorld.addObject(obj);
  
  bd = new BodyDef(); // top right edges
  bd.position.set(gameWorld.box2d.coordPixelsToWorld(width - 130, 30));
  bd.fixedRotation = true;
  bd.bullet = false;
  bd.type = BodyType.STATIC;
  bd.angle = -PI / 8.5;
  
  fd = new FixtureDef();
  fd.friction = 0.3;
  fd.density = 1.0;
  
  obj = new RectangleObject(gameWorld, 130, 20, bd, fd);
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
}
