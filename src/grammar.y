%{
#include <cstdio>
#include <iostream>
#include <vector>
#include <string>
#include "header/structure.h"
#include "header/joint.h"
#include "header/job.h"
#include "header/member.h"

using namespace std;

// stuff from flex that bison needs to know about:
int yylex();
int yyparse();
extern FILE *yyin;
 
void yyerror(const char *s);

class Structure *mainstructure;

%}

%union {
    double dval;
    int ival;
    char *job_detail; 
    char *chval;
    char *material_detail;
    class Joint *joint;
    class vectJoint *joints;
    class Job* job;
    class vectmem *vec;
    class Memberlist * member;
}


%token <dval> FLOAT
%token JOINT MEMBER_INCIDENCES BY
%token END_JOB JOB_NAME JOB_CLIENT JOB_NO JOB_REV JOB_PART JOB_REF JOB_COMMENT
%token APPROVED_DATE CHECKER_DATE APPROVED_NAME CHECKER_NAME 
%token ENGINEER_NAME ENGINEER_DATE 
%token MEMBER_PROP TO PRIS YD ZD
%token ISOTROPIC E POISSON DENSITY ALPHA DAMP TYPE STRENGTH G 
%token SUPPORTS GENERATE PINNED FIXED BUT ENFORCED FX FY FZ MX MY MZ KFX
%token KFY KFZ KMX KMY KMZ
%token CONSTANTS MEMBER MATERIAL ALL BETA ANGLE RANGLE 
%token CDAMP BEAM PLATE SOLID REF REFJT REFVECTOR
%token <job_detail> REST
%token <material_detail> MATERIAL_JOB_REST
%token <chval> STRING
%token UNIT
%type <joint> points
%type <joints> number
%type <joints> joint_coordinates
%type <job> job
%type <vec> member
%type <member> Member


%%

structure: end
    | UNIT REST structure {/* mainstructure->unit=std::string($2);*/ }
    | job structure { mainstructure->job=$1; }
    | joint_coordinates structure { mainstructure->job_joints=*$1; cout << "jdosjlfjdslhjldhls"; }
    | member_coordinates structure {/* mainstructure->job_members=*$1;*/ }
    | material_job structure
    | member_prop structure
    | supports structure
    | constants structure
    ;

job:  END_JOB {$$=new Job();}
    | JOB_NAME REST end job { $4->name=string($2); $$=$4; }
    | JOB_CLIENT REST end job { $4->client=string($2); $$=$4; }
    | JOB_NO REST end job { $4->job_id=string($2); $$=$4; }
    | JOB_REV REST end job { $4->rev=string($2); $$=$4; }
    | JOB_PART REST end job { $4->part=string($2); $$=$4; }
    | JOB_REF REST end job { $4->ref=string($2); $$=$4; }
    | JOB_COMMENT REST end job { $4->comment=string($2); $$=$4; }
    | APPROVED_DATE REST end job { $4->approved_date=string($2); $$=$4; }
    | CHECKER_DATE REST end job { $4->checker_date=string($2); $$=$4; }
    | APPROVED_NAME REST end job { $4->approved_name=string($2); $$=$4;}
    | CHECKER_NAME REST end job { $4->checker_name=string($2); $$=$4; }
    | ENGINEER_NAME REST end job { $4->engineer_name=string($2); $$=$4; }
    | ENGINEER_DATE REST end job { $4->date=string($2); $$=$4; }
    ; 


material_job:
    | ISOTROPIC MATERIAL_JOB_REST end material_job {cout << $2 << endl;} 
    | E MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | POISSON MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | DENSITY MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | ALPHA MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | DAMP MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | TYPE MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | STRENGTH MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    | G MATERIAL_JOB_REST end material_job {cout << $2 << endl;}
    ; 


member_coordinates:
    | MEMBER_INCIDENCES '\n' Member {}  

Member:
    | member ';' end Member { 
       /* Member m;
        while($1->list.size()!=1){
            int i =$1->list.back();
            m.joint_id.push_back(i);
            $1->list.pop_back();
        }
        m.id= $1->list.back();
        $$->list.push_back(m);
    */    }
    ;

member: 
    | FLOAT FLOAT FLOAT {/* $$->list.push_back($1);*/
       // cout<<"member: "<<$1<<" "<<$2<<" "<<$3<<endl;
         } 


joint_coordinates: JOINT '\n' number { cout << "numb "; $$=$3; }
    ;

number: 
    | points ';' end number { cout << "fdsa "; $$->list.push_back(*$1); cout << "rest" << endl; cout << "*$$: " << $$->list.size() << endl;
             for(vector<Joint>::iterator i=$$->list.begin(); i<($$->list.end()); i++){
                cout << "id: " << i->id << endl;
                }
    }
    ;

points: 
    | FLOAT FLOAT FLOAT FLOAT
    {   
        cout << $1 << $2 << $3 << $4 << endl;

        Joint *joint = new Joint();  
        joint->id=$1;
        joint->x=$2;
        joint->y=$3; 
        joint->z=$4;
        $$=joint;
        cout << $$ << endl;
    }
    ;

end:
    |'\n' end
    ;

member_prop:
    | MEMBER_PROP member_prop_standard '\n' member_prop_group { cout << "workind" ; }
    ;
member_prop_standard:
    | STRING {cout << $1 << endl;} 
    ;
member_prop_group:
    | member_group end member_prop_group
    

member_group:
    | member_points PRIS member_axis  { } 
    ;

member_points:
    | FLOAT member_points { cout << $1 << endl; }
    | FLOAT TO FLOAT member_points { cout << $1 << " " << $3 << endl; }
    ;

member_axis:
    | YD FLOAT member_axis
    | ZD FLOAT member_axis
    ;

supports:
    | SUPPORTS '\n' supports_group
    ;

supports_group:
    | FLOAT end supports_group
    | FLOAT TO FLOAT supports_generate_optional end supports_group
    | PINNED end supports_group
    | PINNED BUT supports_release_specs supports_spring_specs_optional end supports_group
    | FIXED end supports_group
    | FIXED BUT supports_release_specs supports_spring_specs_optional end supports_group 
    | ENFORCED end supports_group
    | ENFORCED BUT supports_release_specs end supports_group    
    ;

supports_generate_optional:
    | GENERATE
    ;

supports_spring_specs_optional:
    | supports_spring_specs
    ;

supports_release_specs:
    | FX supports_release_specs
    | FY supports_release_specs 
    | FZ supports_release_specs 
    | MX supports_release_specs 
    | MY supports_release_specs 
    | MZ supports_release_specs 
    ;

supports_spring_specs:
    | KFX FLOAT supports_spring_specs
    | KFY FLOAT supports_spring_specs
    | KFZ FLOAT supports_spring_specs
    | KMX FLOAT supports_spring_specs
    | KMY FLOAT supports_spring_specs
    | KMZ FLOAT supports_spring_specs
    ;

constants:
    | CONSTANTS '\n' constants_group
    ;

constants_group:
    | MATERIAL STRING constants_material end constants_group
    | E constants_group_f end constants_group
    | G constants_group_f end constants_group
    | POISSON constants_group_f end constants_group
    | DENSITY constants_group_f end constants_group
    | BETA constants_group_f end constants_group
    | BETA ANGLE end constants_group 
    | BETA RANGLE end constants_group 
    | ALPHA constants_group_f end constants_group
    | CDAMP constants_group_f end constants_group
    | MEMBER constants_member_list end constants_group  
    | MEMBER BEAM end constants_group
    | MEMBER PLATE end constants_group
    | MEMBER SOLID end constants_group
    | MEMBER ALL end constants_group
    ;

constants_material:
    | MEMBER constants_material_member 
    | ALL 
    ;

constants_material_member:
    | FLOAT constants_material_member { cout << $1 << endl; }
    | FLOAT TO FLOAT constants_material_member { cout << $1 << " " << $3 << endl; }
    ;
constants_group_f: STRING
    | FLOAT
    ;


constants_member_list:
    | FLOAT constants_member_list { cout << $1 << endl; }
    | FLOAT TO FLOAT constants_member_list { cout << $1 << " " << $3 << endl; }
    ;

%%
int main(int, char**) {
    // open a file handle to a particular file:
    mainstructure=new Structure();
    FILE *myfile = fopen("aa.std", "r");
    // make sure it is valid:    int id;
    double x, y, z;
    if (!myfile) {
        cout << "I can't open a.snazzle.file!" << endl;
        return -1;
    }
    // set flex to read from it instead of defaulting to STDIN:
    yyin = myfile;
  
    // parse through the input until there is no more:
    do {
        yyparse();
    } while (!feof(yyin));


}

void yyerror(const char *s) {
    cout << "hello1" << endl;
	mainstructure->print();
	//mainstructure->insert();
    cout << "EEK, parse error!  Message: " << s << endl;
    // might as well halt now:
    exit(-1);
}
