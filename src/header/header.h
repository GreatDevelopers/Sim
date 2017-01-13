/*!
 *	\file header.h 
 *
 *  \brief It contain directives to include all necessary headers and bases 
 *	function split used to parse.    
 *
 *      
 *	compiler g++
 *
 *  \author amarjeet singh kapoor
 *      
 */
#ifndef _HEADER_H_
#define _HEADER_H_

#include<iostream>
#include<fstream>
#include<cstring>
#include <vector>
#include <sstream>
#include<cctype>
#include<string>


#include <mysql_connection.h>

#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>

#define USER "root"
#define PASSWORD "a"

using namespace std;

class base{
	public:
	sql::Driver *driver;
	sql::Statement *stmt;
	sql::Connection *connection;
	sql::PreparedStatement  *prep_stmt;
	sql::ResultSet *result;
	
};

  
#endif
