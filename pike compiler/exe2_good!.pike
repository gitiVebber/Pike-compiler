import Stdio;//the standart library of io.
int main()
{
//C:\Users\משפחה\Desktop\piker\execc22!.pike


mapping (string: int) command = (["static":16,"temp":5,"pointer":3]);
int ramPlace;a

string path=Stdio.Readline()->read(" enter path   ");

array(string) fh2=path/"\\";
string className=fh2[sizeof(fh2)-1];
string word2=path;
path+="\\"+"\\"+className;
path+=".asm";
 string myVm;
array(string) getDirFromPath=get_dir(word2);
string Sys=Stdio.Readline()->read(" Sys?   ");
if( Sys=="sys")
append_file(path,"@256\nD=A\n@SP\nM=D\n@RTA\n
D=A
\n@SP
\nA=M
\nM=D
\n@SP
\nM=M+1
\n@LCL\n
D=M
\n@SP\n
A=M
\nM=D
\n@SP
\nM=M+1
\n@ARG\n
D=M\n
@SP\n
A=M\n
M=D
\n@SP\n
M=M+1
\n@THIS
\nD=M
\n@SP\n
A=M
\nM=D
\n@SP
\nM=M+1
\n@THAT
\nD=M
\n@SP\n
A=M\n
M=D
\n@SP
\nM=M+1\n
@0
D=A
@5
D=A+D
@SP
\nA=M
\nD=A-D
\n@ARG
\nM=D
\n@SP
\nD=M
\n@LCL\n
M=D\n
@Sys.init
\n0;JMP\n
(RTA)");

for (int i=0;i<sizeof(getDirFromPath) ;i++)//לעבור  על כל אחד ואחד מקבצי vm שבתיקיה
{
myVm=word2;
array(string) fh=getDirFromPath[i]/".";
if(fh[1]=="vm")
{
//break;
myVm+="\\"+"\\"+getDirFromPath[i];
write(myVm+"\n");
className+=fh[0];
string word=read_file(myVm);

array(mixed)temp;
string lable;
string t;
int i=0;//counter
array(string) commands = word/"\n";
string space="\n";
for (int i=0; i<sizeof(commands);i++)
{
commands[i]=commands[i]-"\r";
commands[i]=commands[i]+" "; //commands[i];//להוסיף בכל מקרה רווח

t=" ";
if(commands[i]=="\n"||commands[i]==""||commands[i]=="//")
break;
temp= commands[i]/" ";
append_file(path,"\n\//"+commands[i]+"\n");

 if(temp[0]=="push")
{

if(temp [1]=="constant")
{
t="@"+temp [2]+"\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1";

}  

else
{   switch(temp[1])
   {
case "local":
lable="LCL";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\nA=D";
break;
case "argument":
lable="ARG";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\nA=D";
break;
case "this":
lable="THIS";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\nA=D";
break;
case "that":
lable="THAT";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\nA=D";
break;
case "static":
lable=className;
t="@"+lable+"."+temp[2];
break;
default://new lable 
ramPlace=command[temp [1]] ;
ramPlace+=(int)temp[2];
t="@"+ramPlace;
    }
t+="\nD=M\n @SP\n A=M\n M=D\n @SP\n M=M+1";

}
}

else if(temp[0]=="pop")
{
t="@SP\nM=M-1 \nA=M\nD=M \n@";
 switch(temp[1])
   {
case "local":
lable="LCL";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\n@SP\nA=M\nM=D\n@SP\nA=M\nA=A-1\nD=M\nA=A+1\nA=M\nM=D\n@SP\n M=M-1";
break;
case "argument":
lable="ARG";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\n@SP\nA=M\nM=D\n@SP\nA=M\nA=A-1\nD=M\nA=A+1\nA=M\nM=D\n@SP\n M=M-1";
break;
case "this":
lable="THIS";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\n@SP\nA=M\nM=D\n@SP\nA=M\nA=A-1\nD=M\nA=A+1\nA=M\nM=D\n@SP\n M=M-1";
break;
case "that":
lable="THAT";
t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\n@SP\nA=M\nM=D\n@SP\nA=M\nA=A-1\nD=M\nA=A+1\nA=M\nM=D\n@SP\n M=M-1";
break;
case "static":
lable=className;
t="@SP\nM=M-1 \nA=M\nD=M \n@"+lable+"."+temp[2]+"  \nM=D \n ";
break;
//t="@"+lable+"\nD=M\n@"+temp[2]+"\nD=D+A\nA=D";
default://new lable 
ramPlace=command[temp [1]] ;
ramPlace+=(int)temp[2];
t="@SP\nM=M-1 \nA=M\nD=M \n@"+ramPlace+"  \nM=D \n ";
    }
}

else
{    //aritmetic
switch(temp[0])
{
case "add":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D+M\nM=D\n@SP\nM=M+1";
break;
case "sub":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=M-D\nM=D\n@SP\nM=M+1";
break;
case "neg":
t="@SP\nM=M-1\nA=M\nD=M\nM=D\nD=M-D\nD=D-M\nM=D\n@SP\nM=M+1";
break;
case "eq":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\n@EQEND"+i+"\nD;JEQ\n @0\nD=A\nA=M\nM=D\n@SP\nM=M+1\n@EQEND2"+i+"\n0;JMP\n(EQEND"+i+")\n@0\nD=A\nD=D-1\n@SP\nA=M\nM=D\n@SP\nM=M+1\n(EQEND2"+i+")";
break;
case "gt":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\n@GTEND"+i+"\nD;JLT\n @0\nD=A\nA=M\nM=D\n@SP\nM=M+1\n@GTEND2"+i+"\n0;JMP\n(GTEND"+i+")\n@0\nD=A\nD=D-1\n@SP\nA=M\nM=D\n@SP\nM=M+1\n(GTEND2"+i+")";
break;
case "lt":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\n@LTEND"+i+"\nD;JGT\n @0\nD=A\nA=M\nM=D\n@SP\nM=M+1\n@LTEND2"+i+"\n0;JMP\n(LTEND"+i+")\n@0\nD=A\nD=D-1\n@SP\nA=M\nM=D\n@SP\nM=M+1\n(LTEND2"+i+")";
break;
case "and":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=M&D\n@SP\nA=M\nM=D\n@SP\nM=M+1";
break;
case "or":
t="@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=M|D\n@SP\nA=M\nM=D\n@SP\nM=M+1";
break;
case "not":
t="@SP\nM=M-1\nA=M\nD=!M\n@SP\nA=M\nM=D\n@SP\nM=M+1";
break;
case "label":
t="("+temp[1]+")";
break;
case "if-goto":
t="@SP\nM=M-1\nA=M\nD=M\n@"+temp[1]+"\nD;JNE";
break;
case "goto":
t="@"+temp[1]+"\n0;JMP";
break;
case "return":
t="@LCL\nD=M\n@5\nM=D\n @5\nA=D-A\nD=M\n@6\nM=D\n  @SP\nM=M-1\nA=M\nD=M\n@ARG\nA=M\nM=D\nD=A\n@SP\nM=D+1\n@5\nM=M-1\nA=M\nD=M\n@THAT\nM=D\n@5\nM=M-1\nA=M\nD=M\n@THIS\nM=D\n@5\nM=M-1\nA=M\nD=M\n@ARG\nM=D\n@5\nM=M-1\nA=M\nD=M\n@LCL\nM=D\n@6\nA=M\n0;JMP";
break;
case "function":
t="("+temp[1]+")";
for(int n=0;n<(int)temp[2];n++)
t+="\n@"+n+"\nD=A\n@LCL\nD=D+M\nA=D\nM=0\n@SP\nM=M+1";
break;
case "call":
t="@RTA"+i+"\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@LCL\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@ARG\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@THIS\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@THAT\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@"+temp[2]+"\nD=A\n@5\nD=A+D\n@SP\nA=M\nD=A-D\n@ARG\nM=D\n@SP\nD=M\n@LCL\nM=D\n@"+temp[1]+"\n0;JMP\n(RTA"+i+")";
break;
default:
break;
}

}
append_file(path,t);
}}

}//for
string wohrd=Stdio.Readline()->read(" enter...   ");
return 0;}