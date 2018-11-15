#version 300 es

precision highp float;
precision highp sampler3D;

in vec3 v_color;
in vec2 v_texture;

uniform sampler3D uSampler;
uniform float u_progress;
uniform vec2 u_test;
uniform vec3 u_up;
uniform float u_size;

out vec4 color;

vec3 translate() {
    if(u_up.z > 0.5) {
        return vec3(v_texture.x, v_texture.y, u_progress);
    }
    else if(u_up.x > 0.5) {
        return vec3(u_progress, -v_texture.y, v_texture.x);
    } else {
        return vec3(v_texture.x, u_progress, v_texture.y);
    }
}

void main(void) {
    vec3 tex_pos = translate();
    vec4 c = texture(uSampler, tex_pos);
    
    color = vec4(c.rgb * c.a, 1.0);

    vec2 len = vec2(length(v_texture.x - u_test.x), length(v_texture.y - u_test.y));
    if((len.x < 0.005 || len.y < 0.005) && len.x < 0.05 && len.y < 0.05) {
        color = vec4(1.0,0.0,0.0,1.0);
    }

    if(abs(length(len) - u_size) < 0.005) {
        color = color + vec4(0.5,0.0, 0.0, 0.0);
    }
}