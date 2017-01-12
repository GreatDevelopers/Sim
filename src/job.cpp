/*!
 *	\file job.cpp
 *
 *	\brief  It contain definitions for member functions of class Job
 *
 *      
 *  Compiler  g++
 *
 *  \author amarjeet singh kapoor
 *      
 */

#include"header/job.h"

using namespace std;
using namespace sql;

void Job::print()
{
	cout<<"STAAD,"<<type<<endl;
	cout<<"TITLE,"<<title<<endl;
    cout<<"date,"<<date<<endl;
    cout<<"JOB NAME,"<<name<<endl;
    cout<<"JOB CLIENT,"<<client<<endl;
    cout<<"JOB NO,"<<job_id<<endl;
    cout<<"JOB COMMENT,"<<comment<<endl;
    cout<<"CHECKER NAME,"<<checker_name<<endl;
    cout<<"ENGINEER NAME,"<<engineer_name<<endl;
    cout<<"APPROVED NAME,"<<approved_name<<endl;
    cout<<"CHECKER DATE,"<<checker_date<<endl;
    cout<<"JOB REF,"<<ref<<endl;
    cout<<"JOB PART,"<<part<<endl;
    cout<<"JOB REV,"<<rev<<endl;
    cout<<"APPROVED DATE,"<<approved_date<<endl;

}



void Job::insert(int &r,sql::Connection &con )
{
	//create a database connection using the Driver 
	stmt = con.createStatement();
	prep_stmt = con.prepareStatement("INSERT INTO Job(idd, name, date,client ,comment, checker_name, engineer_name, approved_name, checker_date, ref, part, rev, approved_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
	prep_stmt->setString(1,job_id);
	prep_stmt->setString(2,name);
	prep_stmt->setString(3,date);
	prep_stmt->setString(4,client);
	prep_stmt->setString(5,comment);
	prep_stmt->setString(6,checker_name);
	prep_stmt->setString(7,engineer_name);
	prep_stmt->setString(8,approved_name);
	prep_stmt->setString(9,checker_date);
	prep_stmt->setString(10,ref);
	prep_stmt->setString(11,part);
	prep_stmt->setString(12,rev);
	prep_stmt->setString(13,approved_date);
	prep_stmt->execute();
	result=stmt->executeQuery("select max(job_id) from Job");
	result->next();
	r=result->getInt(1);
	delete stmt;
}
