#include<iostream>
#include<fstream>
#include<cstring>
#include <vector>
#include <sstream>
#include<cctype>
/*#include"job.h"*/

using namespace std;

struct joint{
    int id;
    double x, y, z;
};

struct member{
    vector<int> joint_id;
    int id;
};

struct material{
    string name, E, alfa, type, strength, G;
    double poison, density, damp;
};


class structure{

	//job job_d;
	string engineer, date, width, unit, group;
    vector<joint> job_joints;
    vector<member> job_members;
    material job_material;
	string units;
	string widht;
	joint jo;
	string x;
	//group gr;
	//matrial m;
	public:
		structure(fstream &file);
		void print();	

};

vector<string> split(string str, string del);