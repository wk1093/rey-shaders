#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

 float surface_y = 65.0;
 float wave_height = 30.0;
 float wave_length = 12.0;
 float wave_speed = 0.2;

float time = u_time;
vec4 color = vec4(0.1,0.1,1.0,1.0);
void main(void)
{
    float pi = 3.14159265358979323846264;
    vec2 tex_coord = vec2(gl_FragCoord[0]);
    float x = tex_coord.x;
    float y = tex_coord.y;
    if (y < surface_y + 0.5 * wave_height) {
        if (y < surface_y - 0.5 * wave_height) {
            gl_FragColor = color;
        } else if (y < surface_y + 0.2 * wave_height -
                   0.7 * wave_height * abs(sin(2.0 * pi * -wave_speed * time + 2.0 * pi * x / wave_length)) +
                   0.3 * wave_height * pow(sin(4.0 * pi * -wave_speed * time + pi * x / wave_length), 2.0))
        {
            gl_FragColor = color;
        }
    }
}
