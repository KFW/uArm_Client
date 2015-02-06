// leap motion

LeapMotion leap;
boolean RESET_ARM = false;

void initLeapMotion()
{
  leap = new LeapMotion(this);
}

void readLeapMotion()
{
  int fps = leap.getFrameRate();
  ArrayList hands = leap.getHands();
  PVector thumbTip = new PVector(0,0,0);
  PVector indexTip = new PVector(0,0,0);
  
  // ========= HANDS =========
  if(!hands.isEmpty())
  {
    Hand hand = (Hand) hands.toArray()[0];

    // ----- BASICS -----
    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition();
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    boolean hand_is_left     = hand.isLeft();
    boolean hand_is_right    = hand.isRight();
    float   hand_grab        = hand.getGrabStrength();
    float   hand_pinch       = hand.getPinchStrength();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();

    //if(hand_time>0.5)
      RESET_ARM = true;
  
  // ========= FINGERS =========
    for(Finger finger : hand.getFingers()) {
      // Alternatives:
      // hand.getOutstrechtedFingers();
      // hand.getOutstrechtedFingersByAngle();

      // ----- BASICS -----
      int     finger_id         = finger.getId();
      PVector finger_position   = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition(); 
      PVector finger_velocity   = finger.getVelocity();
      PVector finger_direction  = finger.getDirection();
      float   finger_time       = finger.getTimeVisible();
      PVector finger_PositionOfJointTip  = finger.getPositionOfJointTip();
      PVector finger_PositionOfJointDip  = finger.getPositionOfJointDip();
      PVector finger_PositionOfJointPip  = finger.getPositionOfJointPip();
      PVector finger_PositionOfJointMcp  = finger.getPositionOfJointMcp();
      

      // ----- SPECIFIC FINGER ----- //
      switch(finger.getType())
      {
      case 0:
        //System.out.println("thumb");
        break;
      case 1:
        //System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }
    }
    // pinch
    if(hand_pinch > 0.3)
    {
      suctionCup = 0x01;
      button1.setText("Catch");
      button1.setTextBold();
    }
    else
    {
      suctionCup = 0x02;
      button1.setText("Release");
      button1.setTextBold();
    }
    // draw
    hand.draw(8.0, false);
    tint(255, 200);  // Display at half opacity
    
    if(RESET_ARM && hand_grab < 0.8)
    {
      int xP = (int)map(constrain(hand_stabilized.x,     0, 1100),   0, 1100, -90,   90);  // min: -90   max: 90
      int yP = (int)map(constrain(hand_stabilized.y,   100,  250), 100,  250, 150,  -55);  // min: -180  max: 150
      int zP = (int)map(constrain(hand_position.z,       0,   80),   0,   80,   0,  210);  // min: 0     max: 210
      int rP = (int)map(constrain(hand_yaw - xP * 0.5, -40,   40), -40,   40, -90,   90);   // min: -90   max: 90
      setUIPos(xP, yP, zP, rP);
    } 
  }
  else
  {
    if(RESET_ARM)
    {
      noTint(); // Disable tint
      UPDATE_EN = true;
      RESET_ARM = false;
      suctionCup = 0x02;
      button1.setText("Release");
      button1.setTextBold();
    }
  }
}

