extern vec3 lightPos;
// extern float ao_toggle;

vec3 dark = vec3(0.0, 0.0, 1);
vec3 fullColor = vec3(1, 1, 0);


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {

   // Récupération de la Diffuse
   vec4 diffuse  = Texel(texture, texture_coords);

   // Recupération de la troisi§me texture
   vec4 channels = Texel(texture, texture_coords + vec2(0.66667, 0));
   float ao = channels.r;
   float bypass = channels.g;

   // Récupération de la deuxieme texture
   vec3 normal  = Texel(texture, texture_coords + vec2(0.3333, 0)).rgb;
       // Inversion de l'axe Y
       normal.y = 1 - normal.y;


       normal = normalize(mix(vec3(-1), vec3(1), normal));


   //Définition de la direction de la lumière
   vec3 light_direction = lightPos - vec3(pixel_coords, 0);

   // Récupération de la distance par rapport à l'objet (Norme du vecteur)
   float light_distance = length(light_direction);

   // Formule pour l'atténuation
   float attenuation = 4000/pow(light_distance, 2);

   // Norme du vecteur d'attenuation
   light_direction = normalize(light_direction);

   //Caulcul de la valeur de l'illumination pour un point donné
   float light = clamp(attenuation * dot(normal, light_direction), 0.0, 1.0);

   // Ce qui est en rouge sur l'obstruation doit être illuminé 
   // if (ao_toggle == 1) {
   //    light = light * (0.4 + ao*0.6);
   // }

   
   light *= bypass;

   // Génération de la couleur pour le pixel donné
   vec3 brillance = mix(dark,fullColor,light )* 0.15;
   brillance *= bypass;

   // Ombrage
   float cel_light = smoothstep(0.49, 0.52, light)*0.6 + 0.4;


   return vec4(cel_light* diffuse.rgb + brillance, diffuse.a);
}