#pragma once
#ifndef SHADER_HH
#define SHADER_HH

#include <glad/glad.h>

#include <string>
#include <fstream>
#include <sstream>
#include <iostream>

static std::string* readShaderSource(std::string shaderPath) {
	std::string* source = new std::string;
	std::ifstream f(shaderPath, std::ios::in);
	if (!f)
	{
		std::cout << "���ļ�ʧ��: " << shaderPath << std::endl;
		return nullptr;
	}

	std::string line;
	while (getline(f, line))
	{
		line += "\n";
		*source += line;
	}
	return source;
}

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

};

#endif // !SHADER_HH
