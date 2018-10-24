#version 100

precision mediump float;
varying float t;
uniform float transparency;
const float radius = sqrt(2.0);
const float pi = 3.1415;

const vec3 nearCol = vec3(0.98, 0.12, 0.22);
const vec3 farCol = vec3(0.44, 0.26, 0.8);

varying vec3 v_light_dir;

void main() {
    vec2 center = gl_PointCoord - vec2(0.5, 0.5);
    if(length(center) > 0.5) discard;

    float angle = atan(center.y, center.x) / 2.0;
    float height = abs(cos((1.0 - length(center) / radius) * pi));

    vec4 startCol = vec4(farCol * height, transparency * height);
    vec4 endCol = vec4(nearCol * height, transparency * height);
    gl_FragColor = mix(startCol, endCol, height * t);
}
