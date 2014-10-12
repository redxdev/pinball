public class CollisionHandler implements ContactListener {
  void beginContact(Contact contact) {
    GameObject obj1 = null;
    GameObject obj2 = null;
    
    Body body1 = contact.getFixtureA().getBody();
    Body body2 = contact.getFixtureB().getBody();
    
    if(body1.getUserData() instanceof GameObject)
      obj1 = (GameObject)body1.getUserData();
    else
      return;
    
    if(body2.getUserData() instanceof GameObject)
      obj2 = (GameObject)body2.getUserData();
    else
      return;
      
    if(obj1 instanceof Bumper) {
      ((Bumper)obj1).applyBump(contact, obj2);
    }
    
    if(obj2 instanceof Bumper) {
      ((Bumper)obj2).applyBump(contact, obj1);
    }
  }
  
  void endContact(Contact contact) {
  }
  
  void preSolve(Contact contact, Manifold oldManifold) {
  }
  
  void postSolve(Contact contact, ContactImpulse impulse) {
  }
}
