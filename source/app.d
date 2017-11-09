import std.stdio;
import Dbf;
import national.charsets;
import national.encoding;

void main(string[] args)
{
	auto reader = new DbfReader(IBM866);
	reader.openDbf("PIndx16.dbf");
	writeln("version File = ", reader.versionDbf);
	writeln("lastUpdate = ", reader.lastUpdate);
	writeln("recordCount = ", reader.recordCount);
	writeln("headSize = ", reader.headSize);
	writeln("recordSize = ", reader.recordSize);
	writeln("fieldCount = ", reader.fieldCount);
	reader.readFieldInfo();
	int recSize = 0;
	foreach (i, fi; reader.fieldInfo)
	{
		writeln("[", i, "] name = ", fi.name, "; type = ", fi.type, "; len = ", fi.len);
		recSize += fi.len;
	}
	writeln("sum len = ", recSize);
	reader.loadRows(1);
	foreach (row; reader.rows)
	{
		foreach (key; row.keys)
		{
			writefln("%s = %s", key, row[key]);
		}
	}
	writeln("loaded rows = ", reader.rows.length);

}
