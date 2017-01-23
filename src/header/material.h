/*!
 *	\file material.h  
 *
 *  \brief  It contain declarations for Material to be defined
 *
 *      
 *	Compiler g++
 *
 *  \author amarjeet singh kapoor
 *      
 */

#ifndef _MATERIAL_H
#define _MATERIAL_H

#include"header.h"

class Material:public base{
	public:
    string name, type, strength;
    double E,poisson, alpha, density, damp, G;
    
    Material();
    void print();
    string insert(int &r,sql::Connection &con);
};

#endif
