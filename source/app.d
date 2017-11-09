import std.stdio;
import Dbf;

void main(string[] args)
{
   
	/*dstring s = "Жил-были дед да баба.";
	auto cp1251 = Windows1251.encode(s).array;
	write("1251.txt",cp1251);*/
	//dauto db = new DbfFile();
	//new DbfColumn("fio", DbfColumnType.Character, 100, 0);
	//write(col);
	 auto reader = new DbfReader();
     reader.openDbf("PIndx16.dbf");
	 writeln("version File = ",reader.versionDbf());
	 writeln("lastUpdate = ",reader.lastUpdate());
	 writeln("recordCount = ",reader.recordCount());
	 writeln("headSize = ",reader.headSize());
	  writeln("recordSize = ",reader.recordSize());
}
