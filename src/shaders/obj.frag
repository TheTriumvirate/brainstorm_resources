#version 100

precision mediump float;

varying vec3 v_normal;
varying vec3 v_light_dir;

uniform float u_transparency;

// TODO: uniform value 
const vec3 c_color = vec3(1.0, 1.0, 1.0);

void main(void) {
    vec3 ambientColor = vec3(c_color * 0.5);

    gl_FragColor = vec4(c_color * ambientColor, u_transparency);
}