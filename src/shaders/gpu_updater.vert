#version 300 es

precision highp float;
precision highp sampler3D;
precision highp sampler2DArray;

in vec2 v_texpos;


uniform sampler2DArray uSampler;
uniform sampler3D uData;

uniform sampler2D uNoise;

uniform int u_layer;
uniform float u_size;

uniform float u_highpass;
uniform float u_lowpass;
uniform float u_speed;
uniform vec3 u_seedpos;
uniform float u_seedsize;

uniform mat4 MVP;

out vec3 color;

const float reset_threshold = 0.04;

float pyth(vec3 v) {
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

void main() {
    gl_Position = vec4(v_texpos * 2.0 - 1.0, 0.0, 1.0);

    vec4 data = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0);

    // TODO: Could be pre-computed
    float upper = u_speed * (u_highpass + reset_threshold);
    upper = upper * upper;
    float lower = u_speed * u_lowpass;
    lower = lower * lower;

    if(data == vec4(0.0, 0.0, 0.0, 1.0)) {
        vec4 spawn_noise = texture(uNoise, v_texpos);
        
        vec3 dir = (spawn_noise.xyz - u_seedpos);
        dir = dir / length(dir);
        color = vec3(dir * spawn_noise.w * u_seedsize + u_seedpos);
        color = clamp(color, 0.0, 1.0);
        vec4 delta = texture(uData, color.zyx) * 2.0 - 1.0;

        float deltaf = pyth(delta.xyz * u_speed);
        color *= step(upper, deltaf) * (1.0 - step(lower, deltaf));
        return;
    }

    vec4 delta = texture(uData, data.zyx) * 2.0 - 1.0;
    color = vec3(data.xyz + (delta.xyz * u_speed));

    float moved = pyth(delta.xyz * u_speed);
    color *= step(upper, moved) * (1.0 - step(lower, moved));

    //color = delta;z
}
