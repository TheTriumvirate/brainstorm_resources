#version 300 es

precision highp float;
precision highp sampler3D;

in vec2 v_texpos;

uniform mat4 MVP;
uniform sampler3D uSampler;
uniform float u_size;
uniform int u_layer;

out vec4 color;

void main() {
    color = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0);
    gl_Position = MVP * vec4(color.xyz - 0.5, 1.0);
    gl_PointSize = 4.0 / length(gl_Position);
}
