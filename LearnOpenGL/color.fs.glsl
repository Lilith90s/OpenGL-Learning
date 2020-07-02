#version 330 core
// 材质结构体
struct Material {
    vec3 ambient;  // 环境光照
    vec3 diffuse;	// 漫反射光照
    vec3 specular;	// 高光强度
    float shininess;	// 镜面光照
}; 

struct Light{
	vec3 position;	// 光源位置
	// 光源的属性，控制物体颜色强度
	vec3 ambient;	
	vec3 diffuse;
	vec3 specular;
};
in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform vec3 viewPos; // 观察者空间位置

uniform Material material;
uniform Light light;

void main()
{
	/*添加环境光照*/
	vec3 abientStrength = material.ambient * light.ambient;
	vec3 result = abientStrength;
	/*************/

	/*漫反射光照计算*/
	vec3 norm = normalize(Normal);  // normalize:转换为单位向量进行标准化
	vec3 lightDir = normalize(light.position - FragPos);  // 光的方向向量是光源位置向量与片段位置向量之间的向量差
	float diff = max(dot(norm,lightDir),0.0);  // 向量之间夹角等于向量进行点乘，如果大于90度则会成为负数
	vec3 diffuse = light.diffuse*(diff * material.diffuse); // 结果值再乘以光的颜色，得到漫反射分量。两个向量之间的角度越大，漫反射分量就会越小
	result  = (abientStrength + diffuse);
	/**************/
	
	/*镜面反射光照计算*/
	vec3 viewDir = normalize(viewPos-FragPos); // 计算视线方向向量
	vec3 reflectDir = reflect(-lightDir,norm);  // 计算反射向量，reflect的第一参数必须是光源到片段的方向，所以取反
	float spec = pow(max(dot(viewDir,reflectDir),0.0),material.shininess); // 计算镜片分量，32是高光的反光度
	vec3 specular = light.specular * (spec * material.specular);  
	result = (abientStrength + diffuse + specular);
	/****************/

	FragColor = vec4(result,1.0);
}