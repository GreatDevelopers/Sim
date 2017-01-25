/*!
 *	\file member.h  
 *
 *  \brief  It contain declarations for Member,MemberLoad,MemPro  to be defined
 *
 *      
 *	Compiler g++
 *
 *  \author amarjeet singh kapoor &
 *          Amritpal Singh
 *      
 */

#ifndef _MEMBER_H
#define _MEMBER_H

#include"header.h"
#include"joint.h"

class MemberLoad{
	public:
	string code,specCode;
	float spec;
	vector<int>f;
	
	MemberLoad();	
	void print();
};

class Member{
    public:
    vector<int> joint_id;
    int id;
    string material;
    string beta;
    MemberLoad *memberload;
	
	Member();
	void print();
};

class vectmem{
	public:
	vector<int> list;
};

class Memberlist:public base{
	public:
	vector<Member> list;

    void print();
    void insert(int &z, sql::Connection &con);
};

class MemPro{
	public:
	vector<int> member_id;
	string type;
	string country;
	double YD;
	double ZD;
	double ZB;
	
	void print();
};

class MemProlist: public base{
    public:
    vector<MemPro> list; 
	void print();
    string insert(int &z, sql::Connection &con);
};

#endif
