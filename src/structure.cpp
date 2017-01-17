/*!
 *	\file structure.cpp 
 *
 *	\brief  It contain definitions for member functions of class Structure
 *
 *      
 *  Compiler  g++
 *
 *  \author amarjeet singh kapoor
 *      
 */

#include "header/structure.h"

using namespace std;
using namespace sql;


Structure::Structure(){}
    
void Structure::insert(){
    //job.insert();
}


void Structure::print(){

	job->print();
	joint.print();
}
