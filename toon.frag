precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

void main()
{
    vec3 objectColor = vec3(1.0, 0.1, 0.1);
    vec3 lightPos = vec3(1., 2., -5.);
    vec3 viewPos = vec3(0.);
    
  vec4 Color = vec4(objectColor, 1.0);
  
  vec3 norm = normalize(fNormal);
  vec3 light_dir = normalize(fPosition - lightPos);
  vec3 eye_dir = normalize(-fPosition);
  vec3 reflect_dir = normalize(reflect(light_dir, norm));
  
  float spec = max(dot(reflect_dir, eye_dir), 0.0);
	float diffuse = max(dot(-light_dir, norm), 0.0);

  float intensity = 0.6 * diffuse + 0.4 * spec;

  if (intensity > 0.4 && intensity < .6) {
    intensity = .6;
  }
  else if (intensity > 0.855) {
    intensity = 1.1;
  }
 	else if (intensity > 0.8) {
 		intensity = 0.9;
 	}
 	else if (intensity > 0.5) {
 		intensity = 0.7;
 	}
  else if (intensity > 0.25) {
    intensity = 0.55;
  }
  else if (intensity > 0.1) {
    intensity = 0.4;
  }
  else if (intensity > 0.05) {
    intensity = 0.35;
  }
  else if (intensity > 0.01) {
    intensity = 0.3;
  }
  else if (intensity > 0.0) {
    intensity = 0.25;
  }
 	else if (intensity == 0.0) {
 		intensity = 0.15;
  } else {
    intensity = 0.0;
  }
  
	gl_FragColor = Color * intensity;
}
