#version 300 es

precision mediump float;

in vec3 v_pos;

uniform mat4 MVP;

void main() {
    gl_Position = MVP * vec4(v_pos.xyz - 0.5, 1.0);
    gl_PointSize = 4.0 / length(gl_Position);
}
