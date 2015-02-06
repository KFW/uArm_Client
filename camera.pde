// Camera

Capture video;
OpenCV opencv;
GWindow[] cameraWindow;

void initCamera()
{
  video = new Capture(this, 320, 240);
  opencv = new OpenCV(this, 320, 240);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void exitCamera()
{
  noTint(); // Disable tint
  video.stop();
}

void readCamera()
{
 // scale(2);
  int xCoord = 87;
  int yCoord = 52;
  opencv.loadImage(video);
  tint(255, 200);  // Display at half opacity
  image(video, xCoord, yCoord, 516, 386);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
  //println(faces.length);
  for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x * 1.625 + xCoord, faces[i].y * 1.625 + yCoord, faces[i].width * 1.5, faces[i].height * 1.5, 20);
    setUIPos(
    (int)map(constrain(faces[i].x,      0, 240),  0, 240, -75,   75),  // min: -90   max: 90
    (int)map(constrain(faces[i].y,      0, 180),  0, 180, 150,  -55),  // min: -180  max: 150
    (int)map(constrain(faces[i].width, 70, 100), 70, 100,   0,  210),  // min: 0     max: 210
    0);
  }
}

void captureEvent(Capture c)
{
  c.read();
}


