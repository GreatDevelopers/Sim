
List Rule to be used:
List:	{ $$=new List(); }
	| FLOAT TO FLOAT List{
		for(int i= $1; i<=$3;i++){
			$4->point.push_back(i);
		}
		$$=$4;
	}
	| FLOAT TO FLOAT BY FLOAT List {
		for(int i= $1; i<=$3;i++){
			$4->point.push_back(i);
		}
		$$=$4;
	}
	| FLOAT List{
		$2->point.push_back($1);
		$$=$2;
	}	
	;



Rep:INT "*" FLOAT{
	while($1){
		std::cout<<FLOAT;
	}
	}



JOINT:
	JOINT  COORDINATES System band-spec
	JOI  COO System band-spec

Corrdinate: x y z
	


System : 
	| CYLINDRICAL 
	| CYLINDRICAL  REVERSE 

band-spec: 
	| NOREDUCE BAND
	| NO BAND


(NOCHECK)
band-spec
i 1 , x 1 , y 1 , z 1 , ( i 2 , x 2 , y 2 , z 2 , i 3 )


