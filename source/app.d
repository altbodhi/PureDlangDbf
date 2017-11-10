import std.stdio;
import Dbf;
import national.charsets;
import national.encoding;
import std.getopt;
import std.datetime;

void main(string[] args)
{
	string dbf;
	string web;
	string csv;
	int enc;
	int info;
	int count;
	auto result = getopt(args, "dbf|d", &dbf, "web|w", &web, "csv|c", &csv,
			"enc|e", &enc, "info|i", &info, "rec|r", &count);
	if (result.helpWanted) // проверяем, не был ли передан ключ --help|h
	{
		showUsage();
		return;
	}
	if (dbf.length == 0)
	{
		showUsage();
		return;
	}

	auto tm_before = Clock.currTime();

	auto reader = new DbfReader(enc == 866 ? IBM866 : Windows1251);
	reader.openDbf(dbf);
	reader.readFieldInfo();

	if (info > 0)
	{
		writeln("recordCount = ", reader.recordCount);
		writeln("size File = ", reader.dbSize);
		writeln("version File = ", reader.versionDbf);
		writeln("lastUpdate = ", reader.lastUpdate);
		writeln("headSize = ", reader.headSize);
		writeln("recordSize = ", reader.recordSize);
		writeln("fieldCount = ", reader.fieldCount);

		foreach (i, fi; reader.fieldInfo)
		{
			writeln("[", i, "] name = ", fi.name, "; type = ", fi.type,
					"; len = ", fi.len, "; offSet = ", fi.offSet);

		}
		return;
	}

	reader.loadRows(count);
	if (csv.length > 0)
		reader.exportToCsv(csv);
	else if (web.length > 0)
		reader.exportToHtml(web);

	auto time = Clock.currTime() - tm_before;
	writefln("duration: %s", time);

}

void showUsage()
{
	writeln("Help:");
	writeln("puredlangdbf.exe -d PIndx16.dbf -w export.html  -r 0 -e 866");
	writeln("puredlangdbf.exe -d PIndx16.dbf -c export.csv  -r 0 -e 866");
	writeln("puredlangdbf.exe -d PIndx16.dbf -i 1  -r 0 -e 866");
}
