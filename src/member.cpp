/*!
 *	\file member.cpp 
 *
 *	\brief  It contain definitions for member functions of class Member, MemPro,
 *	MemberLoad
 *      
 *  Compiler  g++
 *
 *  \author amarjeet singh kapoor &
 *          Amritpal Singh
 *      
 */

#include"header/member.h"

void MemPro::print(){
	cout<<country<<",";
	cout<<type<<","<<YD<<",";
	cout<<ZD;
	for(int j=0;j<member_id.size();j++)
		cout<<","<<member_id[j];
}

Member::Member(){
	beta="0";
	material="None";
	memberload=NULL;
}

void Member::print(){
	cout<<id<<","<<beta<<","<<material<<",";
	if(memberload!=NULL)
		memberload->print();
    for(int j=0;j<joint_id.size();j++)
    {
        cout<<joint_id[j]<<",";
    }
}



MemberLoad::MemberLoad(){
	specCode=" ";
	spec=0;
}


void MemberLoad::print(){
	cout<<code<<","<<spec<<","<<specCode<<",";
	for(int i=0;i<f.size();i++)
		cout<<f[i]<<",";
}

void Memberlist::print(){
    cout << "inside memberlist " << endl;
    cout << list.size() << endl; 
    for(vector<Member>::iterator i=list.begin(); i!=(list.end()); i++){
        cout << "id: " << i->id << endl;
        for(vector<int>::iterator j=i->joint_id.begin(); j!=(i->joint_id.end()); j++){
            cout <<"Joint id: " << *j << endl;
        }
    }
}


void Memberlist::insert(int &z, sql::Connection &con){
	stmt = con.createStatement();
	string message;
	for(vector<Member>::iterator i=list.begin(); i!=list.end(); i++){
		prep_stmt = con.prepareStatement("INSERT INTO Member(job_id,member_id) VALUES (?,?)");
		prep_stmt->setInt(1,z);
		stringstream sstm;
		sstm<<"Duplicate Member id = "<<i->id;
		//message = sstm.str();
		message = "Joint not Present";
		prep_stmt->setInt(2,i->id);
		prep_stmt->execute();
		for(vector<int>::iterator j=i->joint_id.begin(); j!=(i->joint_id.end()); j++){
			prep_stmt = con.prepareStatement("INSERT INTO Member_incidence(job_id,member_id,joint_id) VALUES (?,?,?)");
			prep_stmt->setInt(1,z);
			prep_stmt->setInt(2,i->id);
			stringstream sstm1;
			sstm1<<" wrong Joint id "<<*j<<" in member ="<<*j;
			message = sstm1.str();
			prep_stmt->setInt(3,*j);
			prep_stmt->execute();
		}
	  }
	cout << "Member incidences in inserted" << endl;
}
