#version 300 es
precision mediump float;

out vec4 o_FragColor;

void main() {
  if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;
  o_FragColor = vec4(1.0, 1.0, 1.0, 0.2);
}
