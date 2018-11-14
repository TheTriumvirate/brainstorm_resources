#version 300 es

precision highp float;

in vec3 color;
out vec4 o_color;

void main() {
    o_color = vec4(color, 1.0);
}
