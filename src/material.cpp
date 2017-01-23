/*!
 *	\file material.cpp 
 *
 *	\brief  It contain definitions for member functions of class Material
 *
 *      
 *  Compiler  g++
 *
 *  \author amarjeet singh kapoor &
 * 			Amritpal Singh
 *      
 */
 
#include "header/material.h"

Material::Material(){
	E=0;poisson=0;alpha=0;density=0;damp=0;
	G=9.8;
}

void Material::print(){
	cout<<"material definition:\n";
	cout<<"name,"<<name<<endl;
	cout<<"E,"<<E<<endl;
	cout<<"poisson,"<<poisson<<endl;
	cout<<"density,"<<density<<endl;
	cout<<"alpha,"<<alpha<<endl;
	cout<<"damp,"<<damp<<endl;
	cout<<"type,"<<type<<endl;
	cout<<"strength,"<<strength<<endl;
	cout<<"G,"<<G<<endl;
}

string Material::insert(int &r,sql::Connection &con){
		string message;
		prep_stmt = con.prepareStatement("INSERT INTO Job_material(job_id,name,E,poisson,density,damp,alpha,G,strength,type) VALUES (?,?,?,?,?,?,?,?,?,?)");
		prep_stmt->setInt(1,r);
		message="No name of material";
		prep_stmt->setString(2,name);
		prep_stmt->setDouble(3,E);
		prep_stmt->setDouble(4,poisson);
		prep_stmt->setDouble(5,alpha);
		prep_stmt->setDouble(6,density);
		prep_stmt->setDouble(7,damp);
		prep_stmt->setDouble(8,G);
		prep_stmt->setString(9,strength);
		prep_stmt->setString(10,type);
		prep_stmt->execute();
		cout << "Job material in inserted" << endl;
		return message;
}
