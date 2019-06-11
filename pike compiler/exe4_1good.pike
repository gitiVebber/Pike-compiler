import Stdio;//the standart library of io.
import Parser.C;
//import Parser.Pike;
int main()
{

multiset(string) keyword=(<"class","constructor","function","method","field","static","var","int","char","boolean","void","true","false","null","this","let","do","if","else","while","return">);
multiset(string) symbol=(<"{","}","(",")","[","]",".",",",";","+","-","*","/","|","=","~">);
multiset(string) symbol2=(<"&","<",">","\"">);

//multiset(string) integer=(<"0","1","2","3","4","5","6","7","8","9">);
string word=read_file("H:\\piker\\PofPLmaterial-5775\\Exercises\\tecs-software-suite-2.5\\Square\\SquareGame.jack");
string path="H:\\piker\\PofPLmaterial-5775\\Exercises\\tecs-software-suite-2.5\\Square\\SquareGame.xml";
append_file(path,"<tokens>"+"\n");
string t;
array(string) commands = split(word);
for (int i=0; i<sizeof(commands);i++)
{
commands[i]=commands[i]-"\r";
t="";
if(keyword[commands[i]])
t="<keyword> "+commands[i]+" </keyword>"+"\n";
else if(symbol[commands[i]])
t="<symbol> "+commands[i]+" </symbol>"+"\n";
else
 if(symbol2[commands[i]]){
t="<symbol> ";
string temp;
if(commands[i]=="<")
temp="&lt;";
else  if(commands[i]==">")
temp="&gt;";
else  if(commands[i]=="\"")
temp="&quot;";
else
 if(commands[i]=="&")
temp="&amp;";
t+=temp+" </symbol>"+"\n";
}
else if(commands[i][0]==34&commands[i][sizeof(commands[i])-1]==34)
t="<StringConstant> "+commands[i]-"\""+" </StringConstant>"+"\n";
else 
if (commands[i][0]<58&commands[i][0]>47)
t="<integerConstant> "+commands[i]+" </integerConstant>"+"\n";
else 
if ((commands[i][0]>96&commands[i][0]<123)|(commands[i][0]>64&commands[i][0]<91)|commands[i][0]==95)
t="<identifier> "+commands[i]+" </identifier>"+"\n";
append_file(path,t);
}
append_file(path,"</tokens>");
string wohrd=Stdio.Readline()->read(" enter...   ");
return 0;}