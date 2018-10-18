#version 100

precision mediump float;
uniform float u_transparency;

void main() {
    gl_FragColor = vec4(1.0, 1.0, 1.0, u_transparency);
}
