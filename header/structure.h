/*!
 *	\file structure.h  
 *
 *  \brief  It contain declarations for structure to be defined
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



struct joint{
    int id;
    double x, y, z;
};

struct member{
    vector<int> joint_id;
    int id;
};

struct material{
    string name, type, strength;
    double E,poisson, alpha, density, damp , G=NULL;
};

struct mem_pro{
	vector<int> member_id;
	string type;
	double YD;
	double ZD;
};

struct code_type{
	string code;
	string section;
	vector<int> member_id;
};

struct concrete_design{
	string code;
	vector<code_type> cty;
};

class structure{

	job job1;
	sql::Driver *driver;
	sql::Statement *stmt;
	sql::Connection *con;
	sql::PreparedStatement  *prep_stmt;
	string width, unit, group;
    vector<joint> job_joints;
    vector<member> job_members;
    vector<material> job_material;
	string units;
	string widht;
	joint jo;
	string x;
	vector<int> beam;
	vector<int> column;
	vector<mem_pro> member_pr;
	concrete_design con_des;
	public:
		
		/*!
			\brief This is constructor that is used initialize all member
			variables.
    	*/
		structure(fstream &file);
		
		/*!
			\brief This member function is used to print all properties 
			of job and calls job::print() 
    	*/
		void print();	
		
		/*!
			\brief This member function is used to initialize material 
			property and is called in structure()
			\param temp string to be parsed
    	*/
		void get_material(string);
		
		/*!
			\brief This member function is used to initialize member property 
			and is called in structure() 
			\param temp string to be parsed
    	*/
		void get_member_pro(string);
		
		/*!
			\brief This member function is used to initialize design property 
			and is called in structure() 
			\param temp string to be parsed
    	*/
		void get_design(string);
		
		/*!
			\brief This member function is used to initialize joints 
			and is called in structure()
			\param temp string to be parsed
    	*/
		void get_joint(string str);
		
		/*!
			\brief This member function is used to insert data into DB.
    	*/
		void insert();
		
		/*!
			\brief This member function is used to insert members 
				into Database.
    	*/
		void insert_member(int );
		
		/*!
			\brief This member function is used to insert material 
			property into Database.
      		\param z unique id of job generated by job::insert()
    	*/
		void insert_material(int);
		
		/*!
			\brief This function is used to insert member property
				into Database.
      \param z unique id of job generated by job::insert()
    	*/
		void insert_member_pro(int);
		
		/*!
			\brief This destructure for structure that frees pointers.
    */
		~structure();
		
};

#endif

