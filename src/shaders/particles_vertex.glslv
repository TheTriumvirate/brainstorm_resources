#version 100

precision mediump float;

attribute vec4 position;

varying float lifetime;
varying float t;

uniform mat4 MVP;
uniform float max_dist;
uniform float min_dist;
uniform float part_size;

void main() {
    gl_Position = MVP * vec4(position.xyz, 1.0);
    gl_PointSize = part_size / length(gl_Position);
    lifetime = position.a;
    
    float dist = length(gl_Position.xyz);
    t = (dist - min_dist) / (max_dist - min_dist); 
}
