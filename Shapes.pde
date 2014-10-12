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

class ChainObject extends GameObject {
  PVector[] vertices = null;
  
  public ChainObject(GameWorld world, PVector[] verts, BodyDef bd, FixtureDef fd) {
    super(world, bd);
    
    this.vertices = verts;
    
    ChainShape chain = new ChainShape();
    
    Vec2[] bVerts = new Vec2[vertices.length];
    for(int i = 0; i < vertices.length; i++) {
      bVerts[i] = world.box2d.coordPixelsToWorld(vertices[i]);
    }
    
    chain.createChain(bVerts, bVerts.length);
    fd.shape = chain;
    body.createFixture(fd);
  }
  
  public void onDraw() {
    noFill();
    stroke(0, 0, 0, 255);
    beginShape();
    for(int i = 0; i < vertices.length; i++) {
      PVector v = vertices[i];
      vertex(v.x, v.y);
    }
    endShape();
  }
}
