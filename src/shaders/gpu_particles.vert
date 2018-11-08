#version 300 es

precision highp float;
precision highp sampler2DArray;

in vec2 v_texpos;

uniform mat4 MVP;
uniform sampler2DArray uSampler;
uniform float u_size;
uniform int u_layer;

out vec4 color;
out float invalid;
out float transparency;

const int STREAMLINES = 4;

void main() {
    int offset = gl_VertexID / int(u_size * u_size);
    int layer = (u_layer - offset + STREAMLINES) % STREAMLINES;
    color = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), layer), 0);
    invalid = 0.0;
    if(color.rgb == vec3(0.0, 0.0, 0.0))
        invalid = 1.0;
    //vec3 color = vec3(color.x, color.y, 1.0 - color.z);
    gl_Position = MVP * vec4(color.xyz - 0.5, 1.0);
    gl_PointSize = 4.0 / length(gl_Position);
    transparency = 1.0 - float(offset) / float(STREAMLINES);
}
