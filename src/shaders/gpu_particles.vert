#version 100

precision mediump float;

attribute vec2 v_texpos;
uniform mat4 MVP;
uniform sampler2D uSampler;

void main() {
    vec4 pos = texture2D(uSampler, v_texpos);
    gl_Position = MVP * vec4(pos.xyz, 1.0);
    gl_PointSize = 1.0 / length(gl_Position);
}
