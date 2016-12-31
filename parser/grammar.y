%{
#include <cstdio>
#include <iostream>
#include "joint.cpp"
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%union {
    double ival;
}

%token <ival> INT
%token EF
%token SC
%token JC

%%
joint_coordinates: 
    |JC EF number
    ;
number:
    |points SC end number 
    ;
points:
    |INT INT INT INT {joint j1; j1.i=$1; j1.x=$2; j1.y=$3;j1.z=$4;j1.show();}
    ;
end:
    |EF end
    ;
%%

int main(int, char**) {
    // open a file handle to a particular file:
    FILE *myfile = fopen("a.std", "r");
    // make sure it is valid:
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
