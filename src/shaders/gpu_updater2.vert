#version 300 es

precision highp float;
precision highp sampler3D;
precision highp sampler2D;

in vec3 v_pos;

uniform mat4 MVP;
uniform sampler3D u_data;
uniform sampler2D u_noise;

uniform float u_size;

uniform float u_highpass;
uniform float u_lowpass;
uniform float u_speed;
uniform vec3 u_seedpos;
uniform float u_seedsize;

out vec3 o_pos;

const float reset_threshold = 0.04;

float pyth(vec3 v) {
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

void main() {
    vec4 delta = texture(u_data, v_pos.zyx) * 2.0 - 1.0;
    float moved = length(delta.xyz);

    // TODO: Could be pre-computed
    float h_pass = (u_highpass + reset_threshold);
    float l_pass = u_lowpass;
    
    if(!(moved >= h_pass && moved <= l_pass)) {
        int iSize = int(u_size);
        vec4 spawn_noise = texelFetch(u_noise, ivec2(gl_VertexID % iSize, gl_VertexID / iSize), 0);
        
        vec3 dir = (spawn_noise.xyz - u_seedpos);
        dir = dir / length(dir);
        o_pos = vec3(dir * spawn_noise.w * u_seedsize + u_seedpos);

        vec4 delta = texture(u_data, o_pos.zyx) * 2.0 - 1.0;
        moved = length(delta.xyz);
        
        if(!(moved >= h_pass && moved <= l_pass)) {
            o_pos = vec3(0.0);
        }

        return;
    }

    o_pos = (MVP * vec4(v_pos.xyz + delta.xyz * u_speed, 1.0)).xyz;


}
