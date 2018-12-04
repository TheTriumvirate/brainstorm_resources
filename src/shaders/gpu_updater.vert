#version 300 es

precision highp float;
precision highp sampler3D;

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

uniform int u_spawnIdx;
uniform int u_spawnCount;

out vec4 color;

const float reset_threshold = 0.04;

float pyth(vec3 v) {
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

void main() {
    gl_Position = vec4(v_texpos * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    vec4 data = texelFetch(uSampler, ivec3(ivec2(v_texpos * u_size), u_layer), 0);
    
    // TODO: Could be pre-computed
    float upper = u_speed * (u_highpass + reset_threshold);
    upper = upper * upper;
    float lower = u_speed * u_lowpass;
    lower = lower * lower;

    int idx = gl_VertexID;
    if(data.xyz == vec3(0.0, 0.0, 0.0) && (idx >= u_spawnIdx && idx < u_spawnIdx + u_spawnCount)) {
        vec4 spawn_noise = texture(uNoise, v_texpos);
        
        vec3 dir = (spawn_noise.xyz - u_seedpos);
        dir = dir / length(dir);
        color = vec4(dir * spawn_noise.a * u_seedsize + u_seedpos, 0.0);
        color = clamp(color, 0.0, 1.0);
        vec4 delta = texture(uData, color.xyz);
        delta.xyz = (delta.xyz * 2.0 - 1.0) * delta.a;

        float deltaf = pyth(delta.xyz * u_speed);
        color *= step(upper, deltaf) * (1.0 - step(lower, deltaf));
        color.w = 1.0;
        return;
    }

    if(data.xyz == vec3(0.0, 0.0, 0.0)) {
        color = vec4(0.0);
        return;
    }

    vec4 delta = texture(uData, data.xyz);
    delta.xyz = (delta.xyz * 2.0 - 1.0) * delta.a;
    color.xyz = data.xyz + (delta.xyz * u_speed);

    float moved = pyth(delta.xyz * u_speed);
    color *= step(upper, moved) * (1.0 - step(lower, moved));
    color.w = data.w - 0.004;

    if(color.w <= 0.0 || color.x > 1.0 || color.y > 1.0 || color.z > 1.0 || color.x < 0.0 || color.y < 0.0 || color.z < 0.0) {
        color = vec4(0.0, 0.0, 0.0, 0.0);
    }
    //color = delta;z
}
