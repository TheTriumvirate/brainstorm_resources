#version 100

precision mediump float;

attribute vec3 position;

varying float t;

uniform mat4 MVP;
uniform float max_dist;
uniform float min_dist;

void main() {
    gl_Position = MVP * vec4(position.xyz, 1.0);
    gl_PointSize = 8.0 / length(gl_Position);
    
    float dist = length(gl_Position.xyz);
    t = (dist - min_dist) / (max_dist - min_dist); 
}
