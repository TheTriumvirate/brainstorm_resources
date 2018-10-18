#version 100

precision mediump float;

varying vec3 v_normal;
varying vec3 v_light_dir;

uniform float u_transparency;

// TODO: uniform value 
const vec3 c_color = vec3(1.0, 1.0, 1.0);

void main(void) {
    vec3 ambientColor = vec3(c_color * 0.5);
    float diffuseFactor = dot(normalize(v_normal), -v_light_dir);

    vec3 diffuseColor;
    if(diffuseFactor > 0.0) {
        diffuseColor = c_color * diffuseFactor * 0.1;
    } else {
        diffuseColor = vec3(0.0, 0.0, 0.0);
    }

    gl_FragColor = vec4(clamp(c_color * (ambientColor + diffuseColor * u_transparency), 0.0, 1.0), u_transparency);
}