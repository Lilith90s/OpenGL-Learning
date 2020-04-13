#pragma once
#include <string>
#include <iostream>
#include <fstream>

#ifndef SHADER_HH
#define SHADER_HH
std::string* readShaderSource(std::string shaderPath) {
	std::string* source = new std::string;
	std::ifstream f(shaderPath, std::ios::in);
	if (!f)
	{
		std::cout << "打开文件失败: " << shaderPath << std::endl;
		return nullptr;
	}
	
	std::string line;
	while (getline(f,line))
	{
		line += "\n";
		*source += line;
	}
	return source;
}
#endif // !SHADER_HH

