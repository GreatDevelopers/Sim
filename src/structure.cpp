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


Structure::Structure(){
    driver =get_driver_instance();
    connection = driver->connect("localhost",USER,PASSWORD);
    stmt = connection->createStatement();
    stmt->execute("USE Sim");

}

Structure::~Structure(){
	delete stmt;
	delete connection;
}

void Structure::insert(){

    try{
		string message;
		stmt->execute("USE Sim");
		stmt->execute("start transaction");
		int z;
		job->insert(z,*connection);
		//for(int i=0;i<job_joints.size();i++){
		//	message=job_joints[i].insert(z,*connection);
		//}
		//insertMember(z);
		//insertMaterial(z);
		//insertMemberPro(z);

		message="ok";
		stmt->execute("commit");
	}
	catch (sql::SQLException &e) {
		stmt->execute("Rollback");
		cerr<<message;
		cerr<<" \n so transaction terminated \n";
	}
}


void Structure::print(){
    cout << "inside structure print" << endl;
//    job->print();
    job_joints.print();
//    joint->print();
//	joint.print();
}
