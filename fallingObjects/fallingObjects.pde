import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import spacebrew.*;

float incomingX = 0;
float incomingY = 0;
boolean shaking = false;
int yThresh = 100;

String server="sandbox.spacebrew.cc";
String name="Joy_FallObjects";
String description ="This is an blank example client that publishes .... and also listens to ...";

// A list for all shapes
ArrayList<Box> boxes;

PBox2D box2d;
Spacebrew sb;		

void setup() {
  size(960,640);
  
  // instantiate the sb variable
  sb = new Spacebrew( this );
  
  // add each thing you publish to
   sb.addPublish( "shaking", "boolean", false ); 
   sb.addPublish("accel_x", "range", 0);
 
 // add each thing you subscribe to
   sb.addSubscribe("shaking", "boolean");
   sb.addSubscribe( "x", "range" );
   sb.addSubscribe( "y", "range" );
 
 // connect to spacebrew
  sb.connect(server, name, description );
  
  // Initialize Box2D
  box2d = new PBox2D(this);	
  box2d.createWorld();
  
  // Create ArrayLists
  boxes = new ArrayList<Box>();
  
  smooth();
}

void draw() {
  background(255);
  
  box2d.step();    

  if (shaking){
    Box p = new Box(incomingY, 10); 
    boxes.add(p);
  }

  // Display all the shapes
  for (Box b: boxes) {
    b.display();
  }
}

void onRangeMessage( String name, int value ){

  println("got range message " + name + " : " + value);
if(name.equals("x")){
  
  if(value > yThresh) { 
    shaking = true;
  }else{
    shaking = false;
  }
    incomingX = map(value, 0, 360, 0, 50);
    sb.send("shaking", true);
  }else if(name.equals("y")){
    incomingY = map(value, 0, 360, 0, width);
  }else{
    sb.send("shaking", false);
  }
}

void onBooleanMessage( String name, boolean value ){
  println("got boolean message " + name + " : " + value); 
 if(name.equals("shaking")){
   shaking = value;
 }
}


