class RectangleObject extends GameObject {

  float w;
  float h;

  public RectangleObject(GameWorld world, float w, float h, BodyDef bd, FixtureDef fd) {
    super(world, bd);
    
    this.w = w;
    this.h = h;
    
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(
      world.box2d.scalarPixelsToWorld(w / 2),
      world.box2d.scalarPixelsToWorld(h / 2)
    );
    
    fd.shape = shape;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
  }
}

class CircleObject extends GameObject {
  float r;
  
  public CircleObject(GameWorld world, float r, BodyDef bd, FixtureDef fd) {
    super(world, bd);
    
    this.r = r;
    
    CircleShape shape = new CircleShape();
    shape.m_radius = world.box2d.scalarPixelsToWorld(r);
    
    fd.shape = shape;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    fill(255);
    stroke(0);
    ellipseMode(RADIUS);
    ellipse(0, 0, r, r);
  }
}

class CircleBumperObject extends CircleObject implements Bumper {
  public CircleBumperObject(GameWorld world, float r, BodyDef bd, FixtureDef fd) {
    super(world, r, bd, fd);
  }
  
  public void applyBump(Contact contact, GameObject other) {
    PVector v = other.getPosition();
    v.sub(this.getPosition());
    v.mult(50);
    Vec2 bv = new Vec2(v.x, v.y);
    bv = world.box2d.coordPixelsToWorld(bv);
    other.body.setLinearVelocity(bv);
    addScore(100);
  }
}

class LightObject extends GameObject implements Bumper {
  float r;
  float lightTime = -1;
  float maxLightTime = -1;
  int currentColor = 0;
  int outline = 255;
  int score = 0;
  
  public LightObject(GameWorld world, float r, BodyDef bd, FixtureDef fd, int score, int outline) {
    super(world, bd);
    
    this.r = r;
    this.score = score;
    this.outline = outline;
    
    CircleShape shape = new CircleShape();
    shape.m_radius = world.box2d.scalarPixelsToWorld(r);
    
    fd.shape = shape;
    fd.isSensor = true;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    if(lightTime > 0) {
      fill(lerpColor(0, currentColor, lightTime / maxLightTime));
      lightTime--;
    }
    else {
      fill(0);
    }
    
    stroke(outline);
    ellipseMode(RADIUS);
    ellipse(0, 0, r, r);
  }
  
  public void applyBump(Contact contact, GameObject other) {
    addScore(score);
    currentColor = color(random(50, 255), random(50, 255), random(50, 255));
    lightTime = 60 * 2;
    maxLightTime = 60 * 2;
  }
}

class ProtectionObject extends GameObject implements Bumper {
  float w;
  float h;

  public ProtectionObject(GameWorld world, float w, float h, BodyDef bd, FixtureDef fd) {
    super(world, bd);
    
    this.w = w;
    this.h = h;
    
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(
      world.box2d.scalarPixelsToWorld(w / 2),
      world.box2d.scalarPixelsToWorld(h / 2)
    );
    
    fd.shape = shape;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
  }
  
  public void applyBump(Contact contact, GameObject other) {
    if(other.body.getLinearVelocity().x > 0)
      other.body.setLinearVelocity(new Vec2(-10, 0));
  }
}

class ChainObject extends GameObject {
  PVector[] vertices = null;
  
  public ChainObject(GameWorld world, PVector[] verts, BodyDef bd, FixtureDef fd) {
    super(world, bd);
    
    this.vertices = verts;
    
    ChainShape chain = new ChainShape();
    
    Vec2[] bVerts = new Vec2[vertices.length];
    for(int i = 0; i < vertices.length; i++) {
      bVerts[i] = world.box2d.coordPixelsToWorld(vertices[i]).add(world.box2d.coordPixelsToWorld(width, height));
    }
    
    chain.createChain(bVerts, bVerts.length);
    fd.shape = chain;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    noFill();
    stroke(255);
    beginShape();
    for(int i = 0; i < vertices.length; i++) {
      PVector v = vertices[i];
      vertex(v.x, v.y);
    }
    endShape();
  }
}
