#version 300 es

precision highp float;

in vec2 v_texpos;

uniform sampler3D uSampler;
uniform sampler3D uData;

uniform sampler2D uNoise;

uniform int u_layer;
uniform float u_size;

uniform float u_highpass;
uniform float u_lowpass;
uniform float u_speed;
uniform vec3 u_seedpos;
uniform float u_seedsize;

out vec4 color;

const float reset_threshold = 0.0004;

void main() {
    gl_Position = vec4(v_texpos * 2.0 - 1.0, 0.0, 1.0);
    vec4 data = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0);
    vec4 delta = texture(uData, data.xyz) * 2.0 - 1.0;
    color = vec4(data.xyz + (delta.xyz * u_speed), 1.0);

    float upper = u_speed * u_highpass;
    float lower = u_speed * u_lowpass;

    float moved = length(delta.xyz * u_speed);
    if(moved >= upper || moved <= lower) {
        vec4 spawn_noise = texture(uNoise, v_texpos);
        
        vec3 dir = (spawn_noise.xyz - u_seedpos);
        dir = dir / length(dir);
        color = vec4(dir * spawn_noise.w * u_seedsize + u_seedpos, 1.0);
        vec4 delta = texture(uData, color.xyz) * 2.0 - 1.0;

        float deltaf = length(delta.xyz * u_speed);
        if(deltaf >= upper || deltaf <= lower) {
            color = vec4(0.0, 0.0, 0.0, 1.0);
        }
    }
    //color = delta;
}
