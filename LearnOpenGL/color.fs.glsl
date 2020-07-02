#version 330 core
// ���ʽṹ��
struct Material {
    vec3 ambient;  // ��������
    vec3 diffuse;	// ���������
    vec3 specular;	// �߹�ǿ��
    float shininess;	// �������
}; 

struct Light{
	vec3 position;	// ��Դλ��
	// ��Դ�����ԣ�����������ɫǿ��
	vec3 ambient;	
	vec3 diffuse;
	vec3 specular;
};
in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform vec3 viewPos; // �۲��߿ռ�λ��

uniform Material material;
uniform Light light;

void main()
{
	/*��ӻ�������*/
	vec3 abientStrength = material.ambient * light.ambient;
	vec3 result = abientStrength;
	/*************/

	/*��������ռ���*/
	vec3 norm = normalize(Normal);  // normalize:ת��Ϊ��λ�������б�׼��
	vec3 lightDir = normalize(light.position - FragPos);  // ��ķ��������ǹ�Դλ��������Ƭ��λ������֮���������
	float diff = max(dot(norm,lightDir),0.0);  // ����֮��нǵ����������е�ˣ��������90������Ϊ����
	vec3 diffuse = light.diffuse*(diff * material.diffuse); // ���ֵ�ٳ��Թ����ɫ���õ��������������������֮��ĽǶ�Խ������������ͻ�ԽС
	result  = (abientStrength + diffuse);
	/**************/
	
	/*���淴����ռ���*/
	vec3 viewDir = normalize(viewPos-FragPos); // �������߷�������
	vec3 reflectDir = reflect(-lightDir,norm);  // ���㷴��������reflect�ĵ�һ���������ǹ�Դ��Ƭ�εķ�������ȡ��
	float spec = pow(max(dot(viewDir,reflectDir),0.0),material.shininess); // ���㾵Ƭ������32�Ǹ߹�ķ����
	vec3 specular = light.specular * (spec * material.specular);  
	result = (abientStrength + diffuse + specular);
	/****************/

	FragColor = vec4(result,1.0);
}