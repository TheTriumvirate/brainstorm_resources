#version 300 es

precision highp float;
precision highp sampler3D;

in vec2 v_texpos;

uniform mat4 MVP;
uniform sampler3D uSampler;
uniform sampler3D uOther;
uniform float u_size;
uniform int u_layer;

out vec4 color;
out float invalid;
out float transparency;

const int STREAMLINES = 16;

void main() {
    int selected = (gl_VertexID / int(u_size * u_size)) % 2;
    int offset = gl_VertexID / int(u_size * u_size);
    int layer = (u_layer - offset + STREAMLINES) % STREAMLINES;
    vec4 pos = vec4(0.0);
    if(selected == 0) {
        pos = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), layer), 0);
    } else {
        pos = texelFetch(uOther, ivec3(ivec2(v_texpos * u_size), layer), 0);
    }

    color = pos;

    // Uncomment to color by direction
    //layer = (u_layer - 1) % STREAMLINES;
    //vec3 prev = texelFetch(uOther, ivec3(ivec2(v_texpos * u_size), layer), 0).xyz;
    //vec3 cur = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0).xyz;
    //color = abs((cur - prev));
    //color = color / length(color);

    invalid = 0.0;
    if(pos.xyz == vec3(0.0, 0.0, 0.0))
        invalid = 1.0;
    //vec3 color = vec3(color.x, color.y, 1.0 - color.z);
    gl_Position = MVP * vec4(pos.xyz - 0.5, 1.0);
    gl_PointSize = 4.0 / length(gl_Position);
    transparency = 1.0 - float(offset) / float(STREAMLINES);
}
