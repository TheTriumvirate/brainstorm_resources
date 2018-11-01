#version 300 es

precision highp float;

in vec2 v_texpos;

uniform sampler3D uSampler;
uniform sampler3D uData;

uniform sampler2D uNoise;

uniform int u_layer;
uniform float u_size;

out vec4 color;

const float e = 0.001;
const float reset_threshold = 0.0005;

void main() {
    gl_Position = vec4(v_texpos * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    vec4 data = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0);
    vec3 pos = vec3(1.0 - data.z, data.y, data.x);
    vec4 delta = texture(uData, pos) * 2.0 - 1.0;
    color = vec4(data.xyz + (delta.xyz * e), 1.0);
    if(length(color.rgb - data.rgb) <= reset_threshold) {
        vec4 spawn_noise = texture(uNoise, v_texpos);
        color = spawn_noise;
        if(length(spawn_noise.rgb - data.rgb) <= reset_threshold || length(data.rgb) <= reset_threshold) {
            color = vec4(0.0, 0.0, 0.0, 1.0);   
        }
    }
    //color = delta;
}
