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

	reader.loadRows(1000);

	auto report = File("db.csv", "w");

	foreach (key; reader.rows[0].keys)
		report.write(key, ";");
	report.write("\n\r");

	foreach (row; reader.rows)
	{
		foreach (key; row.keys)
		{
			writeln(key, " = ", row[key]);
			report.write(row[key], ";");
		}
		report.write("\n\r");
	}
	report.close();
	writeln("loaded rows = ", reader.rows.length);

}
