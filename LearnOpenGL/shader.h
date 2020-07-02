#pragma once
#ifndef SHADER_HH
#define SHADER_HH

#include <glad/glad.h>

#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <glm/glm.hpp>

class Shader
{
public:
	// ����ID
	unsigned int ID;

	// ��������ȡ��������ɫ��
	Shader(const GLchar* vertexPath, const GLchar* fragmentPath);

	// ʹ��/�������
	void use();

	// uniform ���ߺ���
	template<typename T>
	void setValue(const std::string&name,T value);

	// ���þ���uniform
	void setMat4(std::string& name, glm::mat4& mat);

	void setVec3(const std::string &name, const glm::vec3 &value) const;

	void setFloat(const std::string &name, float value) const;
private:
	void checkCompileErrors(unsigned int shader, std::string type)
	{
		int success;
		char infoLog[1024];
		if (type != "PROGRAM")
		{
			glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
			if (!success)
			{
				glGetShaderInfoLog(shader, 1024, NULL, infoLog);
				std::cout << "ERROR::SHADER_COMPILATION_ERROR of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
			}
		}
		else
		{
			glGetProgramiv(shader, GL_LINK_STATUS, &success);
			if (!success)
			{
				glGetProgramInfoLog(shader, 1024, NULL, infoLog);
				std::cout << "ERROR::PROGRAM_LINKING_ERROR of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
			}
		}
	}

};

template<typename T>
void Shader::setValue(const std::string&name, T value)
{
	glUniform1i(glGetUniformLocation(ID, name.c_str()), value);
}

#endif // !SHADER_HH
