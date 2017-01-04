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
%token JOINT MEMBER
%token JOB_NAME JOB_CLIENT JOB_NO JOB_REV JOB_PART JOB_REF JOB_COMMENT
%token APPROVED_DATE CHECKER_DATE APPROVED_NAME CHECKER_NAME 
%token ENGINEER_NAME ENGINEER_DATE 
%token MEMBER_PROP TO PRIS YD ZD
%token ISOTROPIC E POISSON DENSITY ALPHA DAMP TYPE STRENGTH G 
%token SUPPORTS GENERATE PINNED FIXED BUT ENFORCED FX FY FZ MX MY MZ KFX
%token KFY KFZ KMX KMY KMZ
%token <job_detail> REST
%token <material_detail> MATERIAL_JOB_REST
%token <chval> STRING
%token UNIT
%type <joint> points
%type <joints> number
%type <joints> joint_coordinates
%type <job> job
%type <str> string
%type <vec> member;
%type <member> Member


%%

structure:
    | structure end
{/*    | UNIT REST structure {mainstructure->unit=std::string($2); */ }
    | job structure {/*mainstructure->job=*$1; */} 
    | joint_coordinates structure {/*mainstructure->job_joints=*$1;*/ }
    | member_coordinates structure {/* mainstructure->job_members=*$1;*/ }
    | material_job structure
    | member_prop structure
    | supports structure
    ;
job:                                                                    
    | JOB_NAME REST end job {cout << "job name " << $2<<endl;/*$$->name=$2;*/ }
    | JOB_CLIENT REST end job{cout << "job client " << $2<<endl; /*$$->client = $2;*/}
    | JOB_NO REST end job{cout << "job no " << $2<<endl; /*$$->job_id = $2;*/}
    | JOB_REV REST end job{cout << "job rev " << $2 << endl; /* $$->rev = $2;*/}
    | JOB_PART REST end job{cout << "job part " << $2 << endl; /* $$->part = $2;*/}
    | JOB_REF REST end job{cout << "job ref " << $2 << endl;/* $$->ref = $2;*/}
    | JOB_COMMENT REST end job{cout << "job comment " << $2 << endl;/* $$->comment = $2;*/}
    | APPROVED_DATE REST end job{cout << "approved date " << $2 << endl; /*$$->approved_date=$2;*/ }
    | CHECKER_DATE REST end job{cout << "checker date " << $2 << endl; /* $$->checker_date= $2;*/}
    | APPROVED_NAME REST end job{cout << "approved name " << $2 << endl; /* $$->approved_name  = $2;*/}
    | CHECKER_NAME REST end job{cout << "checker name " << $2 << endl; /* $$->CHECKERNAME = $2;*/}
    | ENGINEER_NAME REST end job{cout << "engineer name " << $2 << endl; /* $$->engineer_name = $2;*/}
    | ENGINEER_DATE REST end job{cout << "engineer date " << $2 << endl; /* $$->date = $2;*/}
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
    | MEMBER '\n' Member {}  

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


joint_coordinates: 
    | JOINT '\n' number { $$=$3; }
    ;

number:
    |points ';' end number { /*$$->list.push_back(*$1);*/ }
    ;

points:
    |FLOAT FLOAT FLOAT FLOAT 
    {/*cout<<$1<<" "<<$2<<" "<<$3<<" "<<$4<<endl;
        Joint *joint = new Joint();  
        joint->id=$1;
            joint->x=$2; 
        joint->y=$3; 
        joint->z=$4;
        $$=joint;*/ 
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
    cout << "EEK, parse error!  Message: " << s << endl;
    // might as well halt now:
    exit(-1);
}
