#version 100

precision mediump float;
varying float lifetime;
varying float t;
uniform float transparency;

void main() {
    if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;

    const vec3 nearCol = vec3(0.98, 0.12, 0.22);
    const vec3 farCol = vec3(0.44, 0.26, 0.8);
    
    vec4 startCol = vec4(nearCol, transparency);
    vec4 endCol = vec4(farCol, transparency);
    gl_FragColor = mix(startCol, endCol, t);
}
