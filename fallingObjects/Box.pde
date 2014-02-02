class Box {

  Body body;      

  float w,h;
  float shape;
  int r, g, b;
  int r1, g1, b1;
  int r2, g2, b2;
  boolean square; 
  boolean circle;
  boolean triangle;

  Box(float x, float y) {
    w = 16+incomingX;
    h = 16+incomingX;
    //color of squares
    r=150;
    g=0;
    b=150;
    //color of circles
    r1=0;
    g1=150;
    b1=150;
    //color of triangles
    r2=150;
    g2=150;
    b2=0;
    
    shape = random(0, 3);
    //what shape
    if(shape < 1) {
      square = true;
      circle = false;
      triangle = false;
    }
    else if(shape >= 1 && shape < 2){
      square = false;
      circle = true;
      triangle = false;
    }else if (shape >= 2) {
      square = false;
      circle = false;
      triangle = true;
    }

    // Build Body
    BodyDef bd = new BodyDef();			
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);


   // Define a polygon 
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);	
    sd.setAsBox(box2dW, box2dH);		        
                 					
                				
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach Fixture to Body						   
    body.createFixture(fd);
  }

 //remove the practicle from box2d
void killBody() {
 box2d.destroyBody(body);
}

 
 boolean done() {
   // find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }
  
  
  void display() {
    //Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);		
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);		
    rotate(-a);			        
    stroke(0);
    rectMode(CENTER);
    ellipseMode(CENTER);
    if(square){
      noStroke();
     // fill(150, random(0, 150), random(150, 255));
      fill(r, g, b, 200);
      rect(0,0,w,h);
    }
    else if (circle){
      noStroke();
      //fill(random(0, 150), random(150, 255), 150);
      fill(r1, g1, b1, 200); 
      ellipse(0,0,w,h);
    }else if (triangle){
      
      noStroke();
      //fill(random(150, 255), 150, random(0, 150));
      fill (r2, g2, b2, 200); 
      triangle(-w, h, 0, 0, w, h);
    }
    popMatrix();
  }

}

