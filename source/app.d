import std.stdio;
import Dbf;
import national.charsets;
import national.encoding;

void main(string[] args)
{
	auto reader = new DbfReader(IBM866);
	reader.openDbf("PIndx16.dbf");
	writeln("recordCount = ", reader.recordCount);
	writeln("size File = ", reader.dbSize);
	writeln("version File = ", reader.versionDbf);
	writeln("lastUpdate = ", reader.lastUpdate);

	writeln("headSize = ", reader.headSize);
	writeln("recordSize = ", reader.recordSize);
	writeln("fieldCount = ", reader.fieldCount);

	reader.readFieldInfo();
	//	int recSize = 0;
	foreach (i, fi; reader.fieldInfo)
	{
		writeln("[", i, "] name = ", fi.name, "; type = ", fi.type, "; len = ",
				fi.len, "; offSet = ", fi.offSet);
		//	recSize += fi.len;
	}
	//	writeln("sum len = ", recSize);

	reader.loadRows(10);
	reader.exportToCsv("db.csv");

	writeln("loaded rows = ", reader.rows.length);
import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
Main.init(args);
	MainWindow win = new MainWindow("Hello World");
	win.setDefaultSize(200, 100);
	win.add(new Label("Hello World"));
	win.showAll();

	Main.run();
}
