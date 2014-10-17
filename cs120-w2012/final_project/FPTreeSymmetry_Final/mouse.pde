void mouseReleased() {
  float[] rot = cam.getRotations(); // get rotations
  xRotation = rot[0];
  yRotation = rot[1];
  zRotation = rot[2];
  xRotationTarget = rot[0];
  yRotationTarget = rot[1];
  zRotationTarget = rot[2];
}
