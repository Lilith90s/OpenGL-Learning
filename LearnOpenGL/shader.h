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
		std::cout << "打开文件失败: " << shaderPath << std::endl;
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
	// 程序ID
	unsigned int ID;

	// 构造器读取并构建着色器
	Shader(const GLchar* vertexPath, const GLchar* fragmentPath);

	// 使用/激活程序
	void use();

	// uniform 工具函数
	template<typename T>
	void setValue(const std::string&name,T value);

};

#endif // !SHADER_HH
