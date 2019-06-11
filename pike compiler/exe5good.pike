

import Stdio;//the standart library of io.
import Parser.C;
//import Parser.Pike;
static int i;
static int stop=1,argFunc;//?
static string path="H:\\piker\\PofPLmaterial-5775\\Exercises\\tecs-software-suite-2.5\\Square\\Main.vm";
static string className ,funcName,classNameTemp, varNameTemp;
static int varName=0;
static string word2=read_file("H:\\piker\\PofPLmaterial-5775\\Exercises\\tecs-software-suite-2.5\\Square\\Main.xml");

static array(string) myXmlT = word2/"\n";
mapping (string: int) strings = (['a':97,'b':98,'c':99,'d':100,'e':101,'f':102,'g':103
,'h':104,'i':105,'j':106,'k':107,'l':108,'m':109,'n':110,'o':111,'p':112,'q':113,'r':114,'s':115,'t':116
,'u':117,'v':118,'w':119,'x':120,'y':121,'z':122,'A':65,'B':66,'C':67,'D':68,'E':69,'F':70,'G':71,'H':72
,'I':73,'J':74,'K':75,'L':76,'M':77,'N':78,'O':79,'P':80,'Q':81,'R':82,'S':83,'T':84,'U':85
,'V':86,'W':87,'X':88,'Y':89,'Z':90,' ':32,'!':33,'(':40,')':41
,'*':42,'+':43,'-':45,',':44,'?':63,':':58,'0':48,'1':49,'2':50,'3':51,'4':52,'5':53,'6':54,'7':55,'8':56,'9':57,"    ":789]);
class Class_scope
{
int arg;
int  var;
int  statics;
int  field;
int i=0;
ADT.List table= ADT.List();
ADT.List table2= ADT.List();
void create()
{
arg=0;
var=0;
statics=0;
field=0;
//table=hashTable(100);
}
void method_return()
{
table2->flush();

arg=0;


var=0;
}
void addRow(  string name1, string type1,string kind1)
{
hashTable ht= hashTable (name1,  type1, kind1);

if(ht.kind=="argument")
{
	ht.num=arg++;
	table2->append(ht);
}
else if(ht.kind=="static")
{
	ht.num=statics++;
	table->append(ht);
}
else if(ht.kind=="field")
{
	ht.num=field++;
	table->append(ht);
}
else if(ht.kind=="local")
{	ht.num=var++;
table2->append(ht);
}

}
string getRow(  string name1)
{
	// hashTable (name1,  type1, kind1);
for(int i=0;i<(arg+var);i++ )
{
	hashTable ht=table2 [i];
	
if(ht.name==name1)
{
	//if(ht.kind=="argument"|ht.kind=="var")
		  return(ht.kind +" " +ht.num) ;
	
}

}
 
for(int i=0;i<(field+statics);i++ )
{
	hashTable ht=table [i];
	
if(ht.name==name1)
{
 if(ht.kind=="field")
			  return("this " +ht.num) ;
		  	  return("static" +ht.num) ;//static
}

}
} 
bool getfield(  string name1)
{
for(int i=0;i<(field+statics);i++ )
{
	hashTable ht=table [i];
	//return(ht.kind +" " +ht.num+"\n") ;
if(ht.name==name1)
{classNameTemp=ht.type;
 if(ht.kind=="field")
			  return(true) ;
}

}return false;
} 
bool getlocal(  string name1)
{
for(int i=0;i<(arg+var);i++ )
{
	hashTable ht=table2 [i];
if(ht.name==name1)
{
 if(ht.kind=="local")
 {classNameTemp=ht.type;
			  return(true) ;
 }
}
}return false;
}
}; 
 class hashTable
{
  string name, type, kind;
int num;
void create(  string name1, string type1,string kind1)
{
	name=name1;
type= type1;
kind= kind1;
}
 }  
string tokenPattern()
{
int p=i;
array(string) Tp=myXmlT[p] /" ";

return Tp[1];}
string returnToFile()
{
int p=i++;
array(string) Tp=myXmlT[p] /" ";
return  Tp[1];}
string returnToString()
{
int p=i++;
string s=myXmlT[p]-"<StringConstant> "-" </StringConstant>";

return  s;}
void appendToFile()
{
int p=i++;
array(string) Tp=myXmlT[p] /" ";
append_file(path," "+ Tp[1]);}
string tokenPattern_look()
{
int p=i+1;
array(string) Tp=myXmlT[p] /" ";

return Tp[1];}
string tokenKind()
{
int p=i;
array(string) Tp=myXmlT[p] /" ";
string kind= Tp[0];
string kind1="<";
string kind2=">";
string kind3=kind-kind1;
string kind4=kind3-kind2;
return kind4;
}
 Class_scope cs=Class_scope();
 int t=0; 
void Class ()
{

	//append_file(path,myXmlT[i]+"\n");//'class'
	      i++;
    className=ClassName();//className

	//append_file(path,myXmlT[i]+"\n");//symbol '{'
    i++;
		 while(tokenPattern()=="static" |tokenPattern()=="field" )
	 {ClassVarDec();}//ClassVarDec*
		while(tokenPattern()=="constructor" |tokenPattern()=="function" |tokenPattern()=="method" )
	{SubroutineDec();}//SubroutineDec*
	//append_file(path,myXmlT[i]+"\n");//symbol '}'
    i++;
}
void ClassVarDec ( )
{
    string name, type, kind;
	kind= returnToFile();//identifier;//(static |field)
	//i++;
	type=Type();//type
	name= VarName();//varName
  cs.addRow( name, type, kind);
   
    while(tokenPattern()==",")
	 {
	 //append_file(path,myXmlT[i]+"\n");//symbol ','
	 i++;
     name=VarName();//varName
   cs.addRow(name, type, kind);}
	//append_file(path,myXmlT[i]+"\n");//simbol ;
	i++;
}
string Type ()
{ 
	return returnToFile();//int |char|boolean|className
}
void SubroutineDec ( )
{ 

    if(tokenPattern()=="function")
    { t=1;
    i++;//appendToFile();
    }
    else//(constructor |method)
	if(tokenPattern()=="method")
    {i++;
     t=2;
    cs.addRow("this", className, "argument");
    }
    else//(constructor)
    { i++; //appendToFile() ;
t=3;
//push constant 3
//call Memory.alloc 1
    }

    if(tokenPattern()=="void")//לכאורה לא משנה בזמן ההחזרה לויד יחזיר אפס
	{
	
	i++;//append_file(path,myXmlT[i]+"\n");//void
    }
	else
	Type();//|type
    funcName=  SubroutineName();//subroutineName
  	
	i++;//simbol '('
	ParameterList();//parameterList
	i++;//simbol ')'
	SubroutineBody();//SubroutineBody
t=0;
cs.method_return();
	}
void ParameterList ( )
{
     string name, type, kind="argument";
if(tokenPattern()!=")")	
	{type=Type();//type
	 name=VarName();//varName
    cs.addRow(name, type, kind);
	   while(tokenPattern()==",")
		{//append_file(path,myXmlT[i]+"\n");//symbol ','
		 i++;
type=Type();//type
		name=VarName();
       cs.addRow(name, type, kind);

}
}//varName
//append_file(path,"var name\n");
//append_file(path,num+"\n");
}
void SubroutineBody ( )
{
	i++;//symbol {
	while(tokenPattern()=="var")
	{VarDec();}
  append_file(path,"function "+className+"."+funcName+" "+cs.var+" \n");//להוסיף כמות ארגומנטים
	if(t==3)
		  append_file(path,"push constant "+cs.field+" \ncall Memory.alloc 1 \npop pointer 0\n");
	if(t==2)
		  append_file(path,"push argument 0 \npop pointer 0\n");

Statement();
	i++;//symbol }
}
void VarDec ( )
{ 
    string name, type, kind="local";  
	//appendToFile();//append_file(path,myXmlT[i]+"\n");
	i++;//(var)
	type=Type();//type
	name=VarName();
        cs.addRow(name, type, kind);
 		while(tokenPattern()==",")
		{
		//append_file(path,myXmlT[i]+"\n");
		 i++;//symbol ','
         name=  VarName();
      cs.addRow(name, type, kind);}//varName
	//append_file(path,myXmlT[i]+"\n");
    i++;//symbol ;

}
string ClassName ( )
{
	return returnToFile();//identifier
}
string SubroutineName ( )
{
	return returnToFile();//identifier
}
string VarName ( )
{   
return returnToFile();//identifier
	
}
void Statement( )
{
	
while(tokenPattern()!="}")
{
Statements();
}	//stop=1;
}
void Statements( )
{
	if(tokenPattern()=="let")
	{LetStatement();}
	else
		if(tokenPattern()=="if")			
		{IfStatement();}
		else
			if(tokenPattern()=="while")			
			{WhileStatement();}
			else
				if(tokenPattern()=="do")			
				{DoStatement();}
				else
					if(tokenPattern()=="return")			
					{ReturnStatement();}
					//else
					//{stop=0 ;//i++;
				}//}
void LetStatement()
{
  			i++;//<keyword> let </keyword>
			
		string	varNameTemp2=VarName();//varName  שליחה לפונקציה
			if(tokenPattern()=="[")
			{
			//<symbol> [ </symbol>//append_file(path,myXmlT[i]+"\n");
			i++;
			  Expressions();
			i++;	//<symbol> ]</symbol>//append_file(path,myXmlT[i]+"\n");
append_file(path,"push "+cs.getRow(varNameTemp2)+"\n");
append_file(path,"add \n");

i++;//<symbol> = </symbol>//append_file(path,myXmlT[i]+"\n");
			Expressions();
			i++;			//<symbol> ; </symbol>//append_file(path,myXmlT[i]+"\n");
			append_file(path,"pop temp 0\npop pointer 1\npush temp 0\npop that 0\n");
			}
			else{
 		//<symbol> = </symbol>//append_file(path,myXmlT[i]+"\n");
		i++;
			Expressions();
			//<symbol> ; </symbol>//append_file(path,myXmlT[i]+"\n");
			i++;

	append_file(path,"pop "+cs.getRow(varNameTemp2)+"\n");
	
			}
						
}
void IfStatement()
{
int num=i;
i++;//if
i++;//<symbol> (</symbol>
Expressions();
i++;//<symbol> ) </symbol> 
append_file(path,"if-goto IF_TRUE"+num+"\ngoto IF_FALSE"+num+"\nlabel IF_TRUE"+num+"\n");
i++;//<symbol> {</symbol>
Statement();
i++;//<symbol> }</symbol> 
if(tokenPattern()!="else")
{
	append_file(path,"label IF_FALSE"+num+"\n");
}
else//(tokenPattern()=="else")
{
i++;//else
 append_file(path,"goto IF_END"+num+"\nlabel IF_FALSE"+num+"\n");
			i++;//<symbol> {</symbol>
			Statement();
			i++;//<symbol> }</symbol>
			append_file(path,"label IF_END"+num+"\n");
 }
}
void WhileStatement()
{
int index=i;

			i++;//while
			append_file(path,"label WHILE_EXP"+index+"\n");
		
			//append_file(path,myXmlT[i]+"\n");//<symbol> (</symbol>
			i++;	
			Expressions();
			append_file(path,"not\n");
			//append_file(path,myXmlT[i]+"\n");//<symbol> ) </symbol>
		
			i++;
			append_file(path,"if-goto WHILE_END"+index+"\n");//<symbol> {</symbol>
			
			i++;
			Statement();

		append_file(path,"goto WHILE_EXP"+index+" \nlabel WHILE_END"+index+"\n");
			i++;//<symbol> }</symbol>
		
			
}
void DoStatement()
{
    int arg=0;
			i++;	//<keyword> do</keyword>
			classNameTemp="null";
			SubroutineCall();
			i++;//<symbol> ;</symbol>
append_file(path,"pop temp 0\n");

}
void ReturnStatement()
{
			i++;//<keyword>return</keyword>
			if(tokenPattern()!=";")
			{
			Expressions();
			}
			else
			append_file(path,"push constant 0\n");	
			i++;//;
	append_file(path,"return \n");
}
void Expressions()
{
	Term();
	string op=tokenPattern();
	
	while(op=="+" |op=="-"|op=="*"|op=="/"|op=="&amp;"|op=="|"|op=="&lt;"|op=="&gt;"|op=="=")
	{
		i++;
	Term();
	switch (op)
		{
			case "+":
			append_file(path,"add"+"\n");
			break;
			case "-":
			append_file(path,"sub"+"\n");
			break;
			case "*":
			append_file(path,"call Math.multiply 2"+"\n");
			break;
			case "/":
			append_file(path,"call Math.divide 2"+"\n");
			break;
			case "&lt;":
			append_file(path,"lt"+"\n");
			break;
			case "&gt;":
			append_file(path,"gt"+"\n");
			break;
			case "|":
			append_file(path,"or"+"\n");
			break;
			case "&amp;":
			append_file(path,"and"+"\n");
			break;
			case "=":
			append_file(path,"eq"+"\n");	
			break;
			
		}	
	//<simbol> +</simbol>
	//append_file(path,myXmlT[i]+"\n");

 	op=tokenPattern();
	}
	
	//append_file(path,"</expression>"+"\n");
}
void Term()
{
if(tokenKind()=="integerConstant"|tokenKind()=="StringConstant")//stringConstant
{
	if(tokenKind()=="integerConstant")
	{varNameTemp=returnToFile();
	append_file(path,"push constant "+varNameTemp+"\n");
	//append_file(path,myXmlT[i]+"\n");//<integerConstant> +</integerConstant>|<stringConstant> +</stringConstant>
	//i++;
	
	}
	else
	{
		varNameTemp=returnToString();
	append_file(path,"push  constant "+strlen(varNameTemp)+"\ncall String.new 1\n");
	
	
	for(int i;i<strlen(varNameTemp);i++)
	{
	
		append_file(path,"push  constant "+strings[varNameTemp[i]]	+"\ncall String.appendChar 2\n");//מסובך נורא
		}
	
}}
else
{
string tp=tokenPattern();
if(tp=="true"|tp=="false"|tp=="null"|tp=="this")
{
	
	append_file(path,KeywordConstant());
}
else
if(tokenKind()=="identifier")
{

	if(tokenPattern_look()=="("|tokenPattern_look()==".")
		{
		SubroutineCall();
		}
	else
	{
   	string varNameTemp2;
	varNameTemp2=VarName();
	if(tokenPattern()=="[")
	{
		//append_file(path,myXmlT[i]+"\n")//<symbol> [ </symbol>;
		i++;
		Expressions();
		i++;//<symbol> ]</symbol>
		append_file(path,"push "+cs.getRow(varNameTemp2)+"\n");
		append_file(path,"add\npop pointer 1\npush that 0\n");//
		

	}
		else {append_file(path,"push "+cs.getRow(varNameTemp2)+"\n");}
	}
}
else
if(tokenPattern()=="(")
	{
	i++;//<symbol> ( </symbol>
	Expressions();
	i++;//<symbol> )</symbol>
	}
else
if(tokenPattern()=="-"|tokenPattern()=="~")
{
	if(tokenPattern()=="~")
	{
		UnaryOp();
		Term();
		append_file(path,"not"+"\n");
}
else if(tokenPattern()=="-")
{
	UnaryOp();
	Term();
	append_file(path,"neg"+"\n");
}}}}
void SubroutineCall()
{string classNameTemp2;
// <identifier> Keyboard </identifier>
funcName=SubroutineName();// className\varName\subroutineName
if(tokenPattern()==".")
{
	i++;
	
	classNameTemp=funcName;
    funcName=SubroutineName();
	classNameTemp2=classNameTemp;
}
	i++;//<symbol> (</symbol>
	argFunc=0;
	if(cs.getfield(classNameTemp))
		{argFunc++;
			append_file(path,"push "+cs.getRow(classNameTemp2)+"\n");
		}
		else if(cs.getlocal(classNameTemp))
		{argFunc++;
			append_file(path,"push "+cs.getRow(classNameTemp2)+"\n");
		}
		else
			if (classNameTemp=="null")
			{argFunc++;
		classNameTemp=className;
			append_file(path,"push pointer 0\n");
			}
					ExpressionList();
					append_file(path,"call "+classNameTemp+"."+funcName+" "+argFunc+"\n");

	
	i++;//<symbol> )</symbol>
}
void ExpressionList()
{
	
if(tokenPattern()!=")")	
	{
		Expressions();//Expression
		argFunc++;
	   while(tokenPattern()==",")
		{
		 i++;//symbol ','
		Expressions();
		argFunc++;
		}
	}//Expression
}
void UnaryOp()
{
i++;
}
string KeywordConstant()
{
//append_file(path,myXmlT[i]+"\n");//<keywod> true</keywod>

string temp=returnToFile();
if(temp =="false")
return "push constant 0\n";
if(temp =="true")
return "push constant 0\nnot\n";
if(temp =="null")
return "push constant 0\n";
if(temp =="this")
return "push pointer 0\n";
}
int main()
{
i++;//tokens
Class();

string wohrd=Stdio.Readline()->read(" enter...   ");
return 0;}

