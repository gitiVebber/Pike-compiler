import Stdio;//the standart library of io.
import Parser.C;
//import Parser.Pike;
static int i;
static string path="H:\\piker\\PofPLmaterial-5775\\Exercises\\Targil4\\project 10\\Square2\\Square.xml";
static int Space;
static string word2=read_file("H:\\piker\\PofPLmaterial-5775\\Exercises\\Targil4\\project 10\\Square2\\SquareT.xml");
static array(string) myXmlT = word2/"\n";
string tokenPattern()
{
int p=i;
array(string) Tp=myXmlT[p] /" ";
write( myXmlT[p]+p);
return Tp[1];}

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
append_file(path," "*space);
append_file(path,"<type>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//int |char|boolean|className
	i++;
append_file(path," "*space);
append_file(path,"</type>\n");}



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
Statemaents(spaces);
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
append_file(path,"</varDec>\n");}

void ClassName ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<className>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
append_file(path," "*space);
append_file(path,"</className>\n");}

void SubroutineName ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<subroutineName>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
append_file(path," "*space);
append_file(path,"</subroutineName>\n");}


void VarName ( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<varName>\n");
	append_file(path," "*spaces);
	append_file(path,myXmlT[i]+"\n");//identifier
	i++;
append_file(path," "*space);
append_file(path,"</varName>\n");}

void Statemaents( int space)
{
int spaces=space+1;
append_file(path," "*space);
append_file(path,"<statemaents>\n");
	

append_file(path," "*space);
append_file(path,"</statemaents>\n");
}

int main()
{
i++;//tokens
Class(0);

string wohrd=Stdio.Readline()->read(" enter...   ");
return 0;}