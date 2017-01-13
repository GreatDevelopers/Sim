/*!
 *	\file structure.h  
 *
 *  \brief  It contain declarations for Structure to be defined
 *
 *      
 *	Compiler g++
 *
 *  \author amarjeet singh kapoor 
 *      
 */

#ifndef _STRUCTURE_H
#define _STRUCTURE_H

#include"header.h"
#include"job.h"
#include"joint.h"
#include"member.h"
#include"material.h"
#include"ConcreteDesign.h"


class Load{
	public:
	int id;
	string type,title;
	bool reduce;
	
	void print();		
};	
    

class Structure: public base{

	
		vector<Material> job_material;
		string units;
		string widht;
		string x;
		vector<int> beam;
		vector<int> column;
		vector<MemPro> member_pr;
		ConcreteDesign con_des;
		string message;
		vector <Load> load;
		vector<MemberLoad> memberload;
	public:	
		string width, unit, group;
		vectJoint job_joints;
		Memberlist job_members;
		Job *job;
		Structure();
		void insert();
		void print();
	
};

#endif


