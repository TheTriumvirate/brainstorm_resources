#version 100

precision mediump float;

void main() {
    if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;
    gl_FragColor = vec4(0.98, 0.12, 0.22, 1.0);
}
