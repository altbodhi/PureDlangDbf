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
	string enc;
	bool info;
	int count;
	auto result = getopt(args, "dbf|d", &dbf, "web|w", &web, "csv|c", &csv,
			"enc|e", &enc, "info|i", &info, "rec|r", &count);
	if (result.helpWanted) // проверяем, не был ли передан ключ --help|h
	{
		writeln("Help:");
		writeln("puredlangdbf.exe -d pathto.dbf -w export.html | -c export.csv | -i(print head info) -r recordcountInt -e cp866");
	}

       auto tm_before = Clock.currTime();

	auto reader = new DbfReader(CHARSETS[enc]);
	reader.openDbf(dbf);
	if (info)
	{
		writeln("recordCount = ", reader.recordCount);
		writeln("size File = ", reader.dbSize);
		writeln("version File = ", reader.versionDbf);
		writeln("lastUpdate = ", reader.lastUpdate);

		writeln("headSize = ", reader.headSize);
		writeln("recordSize = ", reader.recordSize);
		writeln("fieldCount = ", reader.fieldCount);

		reader.readFieldInfo();

		foreach (i, fi; reader.fieldInfo)
		{
			writeln("[", i, "] name = ", fi.name, "; type = ", fi.type,
					"; len = ", fi.len, "; offSet = ", fi.offSet);

		}
	}

	reader.loadRows(count);
	if (csv)
		reader.exportToCsv(csv);
	else if (web)
		reader.exportToHtml(web);

 auto time = Clock.currTime() - tm_before;
  writefln("scalar products: %i ", time);

}
