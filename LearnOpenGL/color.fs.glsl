#version 330 core

in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform vec3 lightPos; // ��Դλ��
uniform vec3 lightColor;
uniform vec3 objectColor;
uniform vec3 viewPos; // �۲��߿ռ�λ��

void main()
{
	/*��ӻ�������*/
	float abient = 0.1;
	vec3 abientStrength = abient * lightColor;
	vec3 result = abientStrength * objectColor;
	/*************/

	/*��������ռ���*/
	vec3 norm = normalize(Normal);  // normalize:ת��Ϊ��λ�������б�׼��
	vec3 lightDir = normalize(lightPos - FragPos);  // ��ķ��������ǹ�Դλ��������Ƭ��λ������֮���������
	float diff = max(dot(norm,lightDir),0.0);  // ����֮��нǵ����������е�ˣ��������90������Ϊ����
	vec3 diffuse = diff * lightColor; // ���ֵ�ٳ��Թ����ɫ���õ��������������������֮��ĽǶ�Խ������������ͻ�ԽС
	result  = (abientStrength + diffuse)*objectColor;
	/**************/
	
	/*���淴����ռ���*/
	float specularStrength = 0.5; // �߹�ǿ��
	vec3 viewDir = normalize(viewPos-FragPos); // �������߷�������
	vec3 reflectDir = reflect(-lightDir,norm);  // ���㷴��������reflect�ĵ�һ���������ǹ�Դ��Ƭ�εķ�������ȡ��
	float spec = pow(max(dot(viewDir,reflectDir),0.0),32); // ���㾵Ƭ������32�Ǹ߹�ķ����
	vec3 specular = specularStrength*spec*lightColor;
	result = (abientStrength + diffuse + specular)*objectColor;
	/****************/

	FragColor = vec4(result,1.0);
}