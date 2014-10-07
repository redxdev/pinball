abstract class GameObject {
  GameWorld world;
  Body body;
  
  public GameObject(GameWorld world, BodyDef bd) {
    this.world = world;
    body = world.box2d.createBody(bd);
    body.setUserData(this);
  }
  
  public void draw() {
    Transform transform = body.getTransform();
    Vec2 pos = world.box2d.coordWorldToPixels(transform.p);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-transform.q.getAngle());
    onDraw();
    popMatrix();
  }
  
  public PVector getPosition() {
    Transform transform = body.getTransform();
    Vec2 pos = world.box2d.coordWorldToPixels(transform.p);
    return new PVector(pos.x, pos.y);
  }
  
  public void setPosition(PVector pos) {
    Transform transform = body.getTransform();
    Vec2 bPos = world.box2d.coordPixelsToWorld(pos.x, pos.y);
    body.setTransform(bPos,transform.q.getAngle());
  }
  
  public abstract void onDraw();
}

public class GameWorld {
  Box2DProcessing box2d;
  
  LinkedList<GameObject> objects = new LinkedList<GameObject>();
  
  public GameWorld(PApplet applet) {
    box2d = new Box2DProcessing(applet);
    box2d.createWorld();
  }
  
  public void draw() {
    box2d.step();
    
    for(GameObject obj : objects) {
      obj.draw();
    }
  }
  
  public void addObject(GameObject obj) {
    objects.add(obj);
  }
  
  public void removeObject(GameObject obj) {
    objects.remove(obj);
    if(obj.body != null)
      box2d.destroyBody(obj.body);
  }
}
