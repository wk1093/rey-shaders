// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float noiseo (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +(c - a)* u.y * (1.0 - u.x) +(d - b) * u.x * u.y;
}


// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(10.0, 0.0));
    float c = random(i + vec2(0.0, 10.0));
    float d = random(i + vec2(10.0, 10.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +(c - a)* u.y * (1.0 - u.x) +(d - b) * u.x *
        u.y;
}

#define NUM_OCTAVES 5

float fbm ( in vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(10.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

vec4 mainF(in vec2 a) {
    vec2 st = a.xy/u_resolution.xy*3.;
    // st += st * abs(sin(u_time*0.1)*3.0);
    st += st * 3.0;
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.);
    q.x = fbm( st + 0.50*u_time);
    q.y = fbm( st + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = fbm( st + 10.0*q + vec2(10.7,90.2)+ 0.15*u_time );
    r.y = fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = fbm(st+r);

    color = mix(vec3(0.955,0.057,0.084),
                vec3(0.213,0.955,0.046),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0.955,0.145,0.063),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.955,0.097,0.922),
                clamp(length(r.x),0.0,1.0));
    
    	if (gl_FragCoord.y/u_resolution.y > .5)
    gl_FragColor = vec4((f*f*f+.7*f*f+.8*f)*color,1.);
    return vec4(color, 1.0);
}//+(2.*random(gl_FragCoord.xy))-1

void main() {
    vec4 a = mainF(gl_FragCoord.xy);
    float b = (a.r + a.g + a.b)/3.0;
    gl_FragColor = vec4(b, b, b, 1.00);
}
