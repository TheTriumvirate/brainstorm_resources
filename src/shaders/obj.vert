#version 100

precision mediump float;
attribute vec3 a_position;
attribute vec3 a_normal;

varying vec3 v_normal;
varying vec3 v_light_dir;

uniform mat4 MVP;
uniform vec3 lightDir;

void main(void) {
    gl_Position = MVP * vec4(a_position, 1.0);

    v_normal = ( vec4(a_normal, 0.0)).xyz;

    v_light_dir = lightDir;
}
