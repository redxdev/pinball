import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.dynamics.joints.RevoluteJointDef;
import org.jbox2d.dynamics.joints.RevoluteJoint;
import org.jbox2d.common.Transform;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.BodyType;
import java.util.LinkedList;
import org.jbox2d.dynamics.BodyDef;
import shiffman.box2d.*;
import org.jbox2d.dynamics.Body;

GameWorld gameWorld;

PImage background;

void setup() {
  size(800, 600);
  gameWorld = new GameWorld(this);
  
  gameWorld.box2d.setGravity(0, -40);
  
  buildArena(gameWorld);
  buildDynamics(gameWorld);
  initializeControl(gameWorld);
  
  gameWorld.box2d.world.setContactListener(new CollisionHandler());
  
  background = loadImage("background.jpg");
}

void draw() {
  clear();
  updateControl(gameWorld);
  image(background, 0, 0);
  gameWorld.draw();
  updateGame();
}

void mousePressed() {
  ball.setPosition(new PVector(mouseX, mouseY));
  ball.body.setLinearVelocity(new Vec2(0, 0));
}
