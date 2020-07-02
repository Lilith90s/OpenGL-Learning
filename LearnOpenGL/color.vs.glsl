#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aNormal; // 法向量

out vec3 Normal; // 法向量
out vec3 FragPos; // 片段位置


uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
void main()
{
	gl_Position = projection*view*model*vec4(aPos,1.0);
	Normal = mat3(transpose(inverse(model))) * aNormal; // 使用法线矩阵移除对法向量错误缩放的影响
	FragPos = vec3(model*vec4(aPos,1.0)); // 顶点位置属性乘以模型矩阵（不是观察和投影矩阵）来把它变换到世界空间坐标
}
