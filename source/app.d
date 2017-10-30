//import std.stdio;
import national.charsets;
import national.encoding;
import std.array;
import std.file;	
import std.string;

void main(string[] args)
{
   
	dstring s = "Жил-были дед да баба.";
	auto cp1251 = Windows1251.encode(s).array;
	write("1251.txt",cp1251);

}
