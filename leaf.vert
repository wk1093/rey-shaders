precision highp float;
attribute vec3 position;
attribute vec3 normal;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
varying vec3 fNormal;
varying vec3 fPosition;
uniform float time;

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}



void main()
{
  fNormal = normalize(normalMatrix * normal);
  vec4 pos = modelViewMatrix * vec4(position, 1.0);
  fPosition = pos.xyz;
  gl_Position = projectionMatrix * pos;
  gl_Position = vec4(
    gl_Position.x+noise(gl_Position.zy*noise(gl_Position.xy)
                    *sin(time*2.82234)*cos(time*5.6983))*.5,
    gl_Position.y+noise(gl_Position.ab*noise(gl_Position.yz)
                    *sin(time*6.74534)*cos(time*2.8773))*.5,
    gl_Position.z+noise(gl_Position.ra*noise(gl_Position.ba)
                    *sin(time*5.93271)*cos(time*4.5857))*.5,
    gl_Position.a+noise(gl_Position.yx*noise(gl_Position.ar)
                    *sin(time*7.29834)*cos(time*2.4877))*.5
    );
}
