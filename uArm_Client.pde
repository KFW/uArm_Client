/************************************************************************
* File Name          : uArm_Client
* Author             : Evan
* Updated            : Evan
* Version            : V0.5
* Date               : 2 Feb, 2015
* Description        : Processing to control uArm using LeapMotion
                       using the "Standard.ino" on uArm.
                       Need G4P library and LeapMotionForProcessing library.
* License            : 
* Copyright(C) 2014 UFactory Team. All right reserved.
*************************************************************************/

import g4p_controls.*;
import processing.serial.*;
import de.voidplus.leapmotion.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

boolean LEAPMOTION_EN  = false;
boolean CAMERA_EN  = false;
boolean UPDATE_EN = false;
byte suctionCup = 0;

public void setup()
{
  size(995, 450, JAVA2D);
 
  createGUI();
  customGUI();
  scanPort();
}

public void draw()
{
  background(220);
  if(LEAPMOTION_EN)
  {
    readLeapMotion();
  }
  if(CAMERA_EN)
  {
    readCamera();
  }
  if(UPDATE_EN)
  {
    sendPos(slider2d2.getValueYI(), slider1.getValueI(), slider2d2.getValueXI(), knob1.getValueI(), suctionCup);
    label4.setText(slider2d2.getValueXS());
    label4.setTextBold();
    label5.setText(slider2d2.getValueYS());
    label5.setTextBold();
    label7.setText(knob1.getValueS());
    label7.setTextBold();
    UPDATE_EN = false;
  }
}

void setUIPos(int _handPosX, int _handPosY, int _handPosZ, int _handRot)
{
  knob1.setValue(_handRot);
  slider1.setValue(_handPosY);
  slider2d2.setValueX(_handPosX);
  slider2d2.setValueY(_handPosZ);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI()
{
  slider2d2.setEasing(8.0);
  frame.setTitle("uArm Control Panel");
}

