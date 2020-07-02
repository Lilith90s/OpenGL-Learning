#version 330 core

in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform vec3 lightPos; // 光源位置
uniform vec3 lightColor;
uniform vec3 objectColor;
uniform vec3 viewPos; // 观察者空间位置

void main()
{
	/*添加环境光照*/
	float abient = 0.1;
	vec3 abientStrength = abient * lightColor;
	vec3 result = abientStrength * objectColor;
	/*************/

	/*漫反射光照计算*/
	vec3 norm = normalize(Normal);  // normalize:转换为单位向量进行标准化
	vec3 lightDir = normalize(lightPos - FragPos);  // 光的方向向量是光源位置向量与片段位置向量之间的向量差
	float diff = max(dot(norm,lightDir),0.0);  // 向量之间夹角等于向量进行点乘，如果大于90度则会成为负数
	vec3 diffuse = diff * lightColor; // 结果值再乘以光的颜色，得到漫反射分量。两个向量之间的角度越大，漫反射分量就会越小
	result  = (abientStrength + diffuse)*objectColor;
	/**************/
	
	/*镜面反射光照计算*/
	float specularStrength = 0.5; // 高光强度
	vec3 viewDir = normalize(viewPos-FragPos); // 计算视线方向向量
	vec3 reflectDir = reflect(-lightDir,norm);  // 计算反射向量，reflect的第一参数必须是光源到片段的方向，所以取反
	float spec = pow(max(dot(viewDir,reflectDir),0.0),32); // 计算镜片分量，32是高光的反光度
	vec3 specular = specularStrength*spec*lightColor;
	result = (abientStrength + diffuse + specular)*objectColor;
	/****************/

	FragColor = vec4(result,1.0);
}