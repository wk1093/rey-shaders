precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

void main()
{
    vec3 objectColor = vec3(1.0, 0.1, 0.1);
    vec3 lightColor = vec3(1.0, 1.0, 0.9);
    vec3 lightPos = vec3(1., 2., -5.);
    vec3 viewPos = vec3(0.);
    vec3 FragPos = fPosition;
    vec3 Normal = fNormal;
    
  
    float ambientStrength = 0.13;
    vec3 ambient = ambientStrength * lightColor;
    
    // diffuse 
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), -0.03);
    vec3 diffuse = diff * lightColor;
    
    // specular
    float specularStrength = 1.5;
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32.0);
    vec3 specular = specularStrength * spec * lightColor;  
        
    vec3 result = (ambient + diffuse + specular) * objectColor;
  
  gl_FragColor = vec4(result, 1.0);
}
