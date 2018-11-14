#version 300 es

precision mediump float;
precision mediump sampler3D;

in vec3 v_color;
in vec2 v_texture;

uniform sampler3D uSampler;
uniform int u_layer;

out vec4 color;

void main(void) {
    color = texelFetch(uSampler, ivec3(ivec2(v_texture * 512.0), u_layer), 0) + vec4(v_color, 1.0);
}