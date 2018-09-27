#version 100

precision mediump float;
varying float lifetime;
varying float t;

void main() {
    if(length(gl_PointCoord - vec2(0.5, 0.5)) > 0.5) discard;
    
    const vec4 startCol = vec4(0.98, 0.12, 0.22, 0.5);
    const vec4 endCol = vec4(0.44, 0.26, 0.8, 0.5);
    gl_FragColor = mix(startCol, endCol, t);
}
