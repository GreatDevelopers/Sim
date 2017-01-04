%{
#include <cstdio>
#include <iostream>
using namespace std;

std::string data;
<<<<<<< HEAD
std::string material_data;
#include "grammar.tab.h"  // to get the token types that we return

%}
%x Job rest material_job material_job_rest

%%
=======
#include "grammar.tab.h"  // to get the token types that we return

%}
%x Job rest

%%

"START JOB INFORMATION" {BEGIN(Job);}
<Job>{
"JOB NAME" { BEGIN(rest); return  JOB_NAME;}
"JOB CLIENT" { BEGIN(rest); return  JOB_CLIENT; }
"JOB NO" { BEGIN(rest); return  JOB_NO; }
"JOB REV" { BEGIN(rest); return  JOB_REV; }
"JOB PART" { BEGIN(rest); return  JOB_PART; }
"JOB REF" { BEGIN(rest); return  JOB_REF; }
"JOB COMMENT" { BEGIN(rest); return  JOB_COMMENT;  }
"APPROVED DATE" { BEGIN(rest); return  APPROVED_DATE;  }
"CHECKER DATE" { BEGIN(rest); return  CHECKER_DATE;  }
"APPROVED NAME" { BEGIN(rest); return  APPROVED_NAME;   }
"CHECKER NAME" { BEGIN(rest); return  CHECKER_NAME;  }
"ENGINEER NAME" { BEGIN(rest); return  ENGINEER_NAME;   }
"ENGINEER DATE" { BEGIN(rest); return ENGINEER_DATE;   }
"END JOB INFORMATION" { BEGIN(INITIAL); }
}

<rest>{

\n {  yylval.ch=strdup(data.c_str()); data.clear(); BEGIN(Job); return REST;  } 
^\n { cout<<yytext; data+=yytext; }
}

"UNIT" { BEGIN(rest); cout<<"asas"; BEGIN(INITIAL); return UNIT; }
"MEMBER INCIDENCES" {  return MEMBER;}
\n  { return yytext[0]; }
";"   { return yytext[0]; }
"JOINT COORDINATES" {  return JOINT;}
	
[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)([e]?[-+]?([0-9]*))? { yylval.dval = atof(yytext);  return FLOAT; }
>>>>>>> 70e7ff6da354ba341f0cbcb8eea14b1b82d46518

"START JOB INFORMATION" { BEGIN(Job); }

<Job>{
"JOB NAME" { BEGIN(rest); return  JOB_NAME; }
"JOB CLIENT" { BEGIN(rest); return  JOB_CLIENT; }
"JOB NO" { BEGIN(rest); return  JOB_NO; }
"JOB REV" { BEGIN(rest); return  JOB_REV; }
"JOB PART" { BEGIN(rest); return  JOB_PART; }
"JOB REF" { BEGIN(rest); return  JOB_REF; }
"JOB COMMENT" { BEGIN(rest); return  JOB_COMMENT;  }
"APPROVED DATE" { BEGIN(rest); return  APPROVED_DATE;  }
"CHECKER DATE" { BEGIN(rest); return  CHECKER_DATE;  }
"APPROVED NAME" { BEGIN(rest); return  APPROVED_NAME;   }
"CHECKER NAME" { BEGIN(rest); return  CHECKER_NAME;  }
"ENGINEER NAME" { BEGIN(rest); return  ENGINEER_NAME;   }
"ENGINEER DATE" { BEGIN(rest); return ENGINEER_DATE;   }
"END JOB INFORMATION" { BEGIN(INITIAL); }
}

<rest>{
\n {
    BEGIN(Job); 
    yylval.job_detail=strdup(data.c_str()); 
    data.clear();
    return REST; 
    }
. { data+=strdup(yytext); } 
}

"UNIT" { 
    BEGIN(rest);  
    BEGIN(INITIAL); 
    return UNIT; 
    }

"MEMBER INCIDENCES" { return MEMBER; }

\n  { return yytext[0]; }

";"   { return yytext[0]; }

"JOINT COORDINATES" { return JOINT; }
 
"DEFINE MATERIAL START" { BEGIN(material_job); }

<material_job>{ 
"ISOTROPIC" { BEGIN(material_job_rest); return ISOTROPIC; }
"E" { BEGIN(material_job_rest); return E; }
"POISSON" { BEGIN(material_job_rest); return POISSON; }
"DENSITY" { BEGIN(material_job_rest); return DENSITY; }
"ALPHA" { BEGIN(material_job_rest); return ALPHA; }
"DAMP" { BEGIN(material_job_rest); return DAMP; }
"TYPE" { BEGIN(material_job_rest); return TYPE; }
"STRENGTH" { BEGIN(material_job_rest); return STRENGTH; }
"G" { BEGIN(material_job_rest); return G; }
"END DEFINE MATERIAL" { BEGIN(INITIAL); }
}

<material_job_rest>{
\n {
    BEGIN(material_job); 
    yylval.material_detail=strdup(material_data.c_str()); 
    material_data.clear();
    return MATERIAL_JOB_REST; 
    }
. { material_data+=strdup(yytext); }    
}

"MEMBER PROPERTY"|"MEM PRO" { return MEMBER_PROP; }
"TO" { return TO; }
"PRIS" { return PRIS; }
"YD" { return YD; }
"ZD" { return ZD; }


"SUPPORTS" { return SUPPORTS; }
"GENERATE"|"GEN" { return GENERATE; }
"PINNED" { return PINNED; }
"FIXED" { return FIXED; }
"BUT" { return BUT; }
"ENFORCED" { return ENFORCED; }
"FX" { return FX; }
"FY" { return FY; }
"FZ" { return FZ; }
"MX" { return MX; }
"MY" { return MY; }
"MZ" { return MZ; }
"KFX" { return KFX; }
"KFY" { return KFY; }
"KFZ" { return KFZ; }
"KMX" { return KMX; }
"KMY" { return KMY; }
"KMZ" { return KMZ; }



[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)([e]?[-+]?([0-9]*))? { 
    yylval.dval = atof(yytext);  
    return FLOAT; 
    }
[a-zA-Z]+ {
    yylval.chval = yytext;
    return STRING;
    }
.
%%
