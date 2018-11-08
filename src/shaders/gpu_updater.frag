#version 300 es

precision highp float;

in vec3 color;
out vec4 o_color;

void main() {
    //if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;
    //gl_FragColor = vec4(0.98, 0.12, 0.22, 1.0);
    o_color = vec4(color, 1.0);
}
