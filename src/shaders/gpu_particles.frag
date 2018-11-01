#version 300 es

precision highp float;

in vec4 color;
out vec4 o_color;

void main() {
    if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;
    //o_color = vec4(0.98, 0.12, 0.22, 1.0);
    o_color = vec4(color.rgb, 0.5);
}