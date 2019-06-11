import Stdio;//the standart library of io.
import Parser.C;
//import Parser.Pike;
static int i;
static int stop=1;
static string path="H:\\piker\\PofPLmaterial-5775\\Exercises\\Targil4\\project 10\\ExpressionlessSquare2\\SquareGame.xml";
static int Space;
static string word2=read_file("H:\\piker\\PofPLmaterial-5775\\Exercises\\Targil4\\project 10\\ExpressionlessSquare2\\SquareGameT.xml");
static array(string) myXmlT = word2/"\n";
string tokenPattern()
{
int p=i;
array(string) Tp=myXmlT[p] /" ";
write( myXmlT[p]+p);
return Tp[1];}
string tokenPattern_look()
{
int p=i+1;
array(string) Tp=myXmlT[p] /" ";
write( myXmlT[p]+p);
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
void Class ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<class>\n");
	append_file(path,myXmlT[i]+"\n");//'class'
	      i++;ClassName(spaces);//className
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//symbol '{'
		 while(tokenPattern()=="static" |tokenPattern()=="field" )
	 {ClassVarDec(spaces);}//ClassVarDec*
		while(tokenPattern()=="constructor" |tokenPattern()=="function" |tokenPattern()=="method" )
	{SubroutineDec(spaces);}//SubroutineDec*
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//symbol '}'
append_file(path," "*space);
append_file(path,"</class>\n");}

void ClassVarDec ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<classVarDec>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//(static |field)
	i++;
	Type(spaces);//type
	 VarName(spaces);//varName

	   while(tokenPattern()==",")
		{append_file(path," "*spaces);
		append_file(path,myXmlT[i]+"\n");//symbol ','
		 i++;VarName(spaces);}//varName
	
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//simbol ;
	i++;
append_file(path," "*space);
append_file(path,"</classVarDec>\n");
}

void Type ( int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<type>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//int |char|boolean|className
	i++;
//append_file(path," "*space);
//append_file(path,"</type>\n");
}



void SubroutineDec ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<subroutineDec>\n");

	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//(constructor |function|method)
	i++;
		if(tokenPattern()=="void")
	{append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//void
	i++;}
		else
	Type(spaces);//|type
	SubroutineName(spaces);//subroutineName
	
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//simbol '('
	i++;
	ParameterList(spaces);//parameterList
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//simbol ')'
	i++;

	SubroutineBody(spaces);//SubroutineBody
append_file(path," "*space);
append_file(path,"</subroutineDec>\n");}

void ParameterList ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<parameterList>\n");
if(tokenPattern()!=")")	
	{Type(spaces);//type
	 VarName(spaces);//varName

	   while(tokenPattern()==",")
		{append_file(path,myXmlT[i]+"\n");//symbol ','
		 i++;Type(spaces);//type
		VarName(spaces);}}//varName
append_file(path," "*space);
append_file(path,"</parameterList>\n");}

void SubroutineBody ( int space)
{int spaces=space+1;
append_file(path," "*space);
append_file(path,"<subroutineBody>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//symbol {
	while(tokenPattern()=="var")
	{VarDec(spaces);}
Statement(spaces);
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//symbol }
append_file(path," "*space);
append_file(path,"</subroutineBody>\n");}

void VarDec ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<varDec>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//(var)
	Type(spaces);//type
	VarName(spaces);
 		while(tokenPattern()==",")
		{append_file(path," "*spaces);
		append_file(path,myXmlT[i]+"\n");//symbol ','
		 i++;VarName(spaces);}//varName
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");i++;//symbol ;
append_file(path," "*space);
append_file(path,"</varDec>\n");
}

void ClassName ( int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<className>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
//append_file(path," "*space);
//append_file(path,"</className>\n");
}

void SubroutineName ( int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<subroutineName>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
//append_file(path," "*space);
//append_file(path,"</subroutineName>\n");
}


void VarName ( int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<varName>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
//append_file(path," "*space);
//append_file(path,"</varName>\n");
}

void Statement( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<statements>\n");
	while(stop==1)
{
Statements(spaces);

	}	
stop=1;
append_file(path," "*space);
append_file(path,"</statements>\n");
}

void Statements( int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<statements>\n");
	if(tokenPattern()=="let")
			{LetStatement(spaces);}
			else
			if(tokenPattern()=="if")			
			{IfStatement(spaces);}
			else
			if(tokenPattern()=="while")			
			{WhileStatement(spaces);}
			else
			if(tokenPattern()=="do")			
			{DoStatement(spaces);}
			else
			if(tokenPattern()=="return")			
			{ReturnStatement(spaces);}
			else
			{stop=0 ;}
		
//append_file(path," "*space);
//append_file(path,"</statements>\n");

}


void LetStatement(int space)
{
int spaces=space+1;
append_file(path," "*spaces);
append_file(path,"<letStatement>"+"\n");//letStatement
spaces++;
			append_file(path," "*spaces);//<keyword> let </keyword>
			append_file(path,myXmlT[i]+"\n");
			i++;
			VarName(spaces);//varName
			if(tokenPattern()=="[")
			{
			append_file(path," "*spaces);//<symbol> [ </symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
			  Expressions(spaces);
			append_file(path," "*spaces);//<symbol> ]</symbol>
			append_file(path,myXmlT[i]+"\n");i++;	
			}
 			append_file(path," "*spaces);//<symbol> = </symbol>
			append_file(path,myXmlT[i]+"\n");i++;
			Expressions(spaces);
			append_file(path," "*spaces);//<symbol> ; </symbol>
			append_file(path,myXmlT[i]+"\n");i++;
			spaces--;	
            append_file(path," "*spaces);
			append_file(path,"</letStatement>"+"\n");			
}
void IfStatement(int space)
{
int spaces=space+1;
append_file(path," "*spaces);
			append_file(path,"<ifStatement>"+"\n");
			spaces++;
			append_file(path," "*spaces);//<keyword> if </keyword>
			append_file(path,myXmlT[i]+"\n");
			i++;
			append_file(path," "*spaces);////<symbol> (</symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
		Expressions(spaces);
			append_file(path," "*spaces);//<symbol> ) </symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
			append_file(path," "*spaces);//<symbol> {</symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
		Statement(spaces);
			append_file(path," "*spaces);//<symbol> }</symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
			if(tokenPattern()=="else")
				{
				append_file(path," "*spaces);//<symbol> {</symbol>
				append_file(path,myXmlT[i]+"\n");i++;
			Statement(spaces);
				append_file(path," "*spaces);//<symbol> }</symbol>
				append_file(path,myXmlT[i]+"\n");i++;
				}
			append_file(path," "*spaces);
			append_file(path,"</ifStatement>"+"\n");//<ifStatement>
}

void WhileStatement(int space)
{
int spaces=space+1;
append_file(path," "*spaces);
			append_file(path,"<whileStatement>"+"\n");
			spaces++;
			append_file(path," "*spaces);//<keyword> while</keyword>
			append_file(path,myXmlT[i]+"\n");
			i++;append_file(path," "*spaces);////<symbol> (</symbol>
			append_file(path,myXmlT[i]+"\n");i++;
			Expressions(spaces);
			append_file(path," "*spaces);//<symbol> ) </symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
			append_file(path," "*spaces);//<symbol> {</symbol>
			append_file(path,myXmlT[i]+"\n");
			i++;
Statement(spaces);
append_file(path," "*spaces);//<symbol> }</symbol>
			append_file(path,myXmlT[i]+"\n");i++;
			spaces--;	
                                          append_file(path," "*spaces);
			append_file(path,"</whileStatement>"+"\n");
}
void DoStatement(int space)
{
int spaces=space+1;
append_file(path," "*spaces);
			append_file(path,"<doStatement>"+"\n");
			spaces++;
			append_file(path," "*spaces);//<keyword> do</keyword>
			append_file(path,myXmlT[i]+"\n");
			i++;
			SubroutineCall(spaces);
			append_file(path," "*spaces);////<symbol> ;</symbol>
			append_file(path,myXmlT[i]+"\n");i++;
			spaces--;	
                                          append_file(path," "*spaces);
			append_file(path,"</doStatement>"+"\n");
}
void ReturnStatement(int space)
{
int spaces=space+1;
append_file(path," "*spaces);
			append_file(path,"<ReturnStatement>"+"\n");
			spaces++;
			append_file(path," "*spaces);//<keyword>return</keyword>
			append_file(path,myXmlT[i]+"\n");
			i++;
			if(tokenPattern()!=";")
			{
			Expressions(spaces);
			}
			append_file(path," "*spaces);//;
			append_file(path,myXmlT[i]+"\n");
			i++;
			spaces--;	
                                          append_file(path," "*spaces);
			append_file(path,"</ReturnStatement>"+"\n");
}

void Expressions(int space)
{
	int spaces=space+1;
	append_file(path," "*space);
	append_file(path,"<expression>"+"\n");//<expression>
	
	Term(spaces);
	string op=tokenPattern();
	while(op=="+" |op=="-"|op=="*"|op=="/"|op=="&amp;"|op=="|"|op=="&lt;"|op=="&gt;"|op=="=")
	{
	append_file(path," "*spaces);//<simbol> +</simbol>
	append_file(path,myXmlT[i]+"\n");i++;
	Term(spaces);
 	op=tokenPattern();
	}
	append_file(path," "*space);
	append_file(path,"</expression>"+"\n");
}


void Term(int space)
{
int spaces=space+1;

append_file(path," "*space);
append_file(path,"<term>"+"\n");//<term>


if(tokenKind()=="integerConstant"|tokenKind()=="stringConstant")//stringConstant
{
	append_file(path," "*spaces);//<integerConstant> +</integerConstant>|<stringConstant> +</stringConstant>
	append_file(path,myXmlT[i]+"\n");
	i++;
}
else
{
string tp=tokenPattern();
if(tp=="true"|tp=="false"|tp=="null"|tp=="this")
{
	KeywordConstant(spaces);
}
else
if(tokenKind()=="identifier")
{

	if(tokenPattern_look()=="("|tokenPattern_look()==".")
		{
		
		SubroutineCall(spaces);
		}
	else
	{
   	
	VarName(spaces);
	if(tokenPattern()=="[")
	{
		append_file(path," "*spaces);//<symbol> [ </symbol>
		append_file(path,myXmlT[i]+"\n");i++;
		Expressions(spaces);
		append_file(path," "*spaces);//<symbol> ]</symbol>
		append_file(path,myXmlT[i]+"\n");i++;
	}
	}
}
else
if(tokenPattern()=="(")
	{
	append_file(path," "*spaces);//<symbol> ( </symbol>
	append_file(path,myXmlT[i]+"\n");i++;
	Expressions(spaces);
	append_file(path," "*spaces);//<symbol> )</symbol>
	append_file(path,myXmlT[i]+"\n");i++;
	}
else
if(tokenPattern()=="-"|tokenPattern()=="~")
{
	UnaryOp(spaces);
	Term(spaces);
	
}}
append_file(path," "*space);
append_file(path,"</term>"+"\n");//</term>
}
 

void SubroutineCall(int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<subroutineCall>"+"\n");//<subroutineCall>
append_file(path," "*spaces);
append_file(path,myXmlT[i]+"\n");// <identifier> Keyboard </identifier>
i++;
if(tokenPattern()=="(")
{
	//SubroutineName(spaces);
	append_file(path," "*spaces);////<symbol> (</symbol>
	append_file(path,myXmlT[i]+"\n");
	i++;
	ExpressionList(spaces);
	append_file(path," "*spaces);////<symbol> )</symbol>
	append_file(path,myXmlT[i]+"\n");
}
else
if(tokenPattern()==".")
{
	//append_file(path," "*spaces);//<className> </className>
	//append_file(path,myXmlT[i]+"\n");
	
	
//i++;

append_file(path," "*spaces);//<simbol>.</simbol>
append_file(path,myXmlT[i]+"\n");
i++;
SubroutineName(spaces);
append_file(path," "*spaces);//<simbol>(</simbol>
append_file(path,myXmlT[i]+"\n");
i++;
ExpressionList(spaces);
append_file(path," "*spaces);//<simbol>)</simbol>
append_file(path,myXmlT[i]+"\n");
}
i++;
//append_file(path," "*space);
//append_file(path,"</subroutineCall>"+"\n");//</subroutineCall>

}
void ExpressionList(int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<ExpressionList>"+"\n");//<ExpressionList>
if(tokenPattern()!=")")	
	{Expressions(spaces);//Expression
	
	   while(tokenPattern()==",")
		{append_file(path,myXmlT[i]+"\n");//symbol ','
		 i++;
		Expressions(spaces);}}//Expression

append_file(path," "*space);
append_file(path,"</ExpressionList>"+"\n");//</ExpressionList>
}
void UnaryOp(int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<uneryOp>"+"\n");//<uneryOp>
append_file(path," "*spaces);//<keywod> true</keywod>
append_file(path,myXmlT[i]+"\n");
i++;
//append_file(path," "*space);
//append_file(path,"</uneryOp>"+"\n");//</uneryOp>
}
void KeywordConstant(int space)
{
int spaces=space+1;
//append_file(path," "*space);
//append_file(path,"<KeywordConstant>"+"\n");
append_file(path," "*spaces);//<keywod> true</keywod>
append_file(path,myXmlT[i]+"\n");
i++;
//append_file(path," "*space);
//append_file(path,"</KeywordConstant>"+"\n");
}



int main()
{
i++;//tokens
Class(0);

string wohrd=Stdio.Readline()->read(" enter...   ");
return 0;}