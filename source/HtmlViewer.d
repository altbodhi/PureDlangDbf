import std.stdio;
import Dbf;
import national.charsets;
import national.encoding;
import std.process;
import std.file;

class HtmlViewer
{
    DbfReader reader;
    auto fmt = import("index.html");

    void open(string pathToDbf)
    {
        reader = new DbfReader(IBM866);
        reader.openDbf(pathToDbf);
        reader.readFieldInfo();
        reader.loadRows(100);
        print();
    }

    void print()
    {
        auto fn = tempDir() ~ "\\" ~ reader.db.name ~ ".html";
        auto file = File(fn, "w");
        auto res = "<tr>";
        res ~= "<td>N</td>";
        res ~= "<td>*</td>";
        foreach (fi; reader.fieldInfo)
            res ~= std.conv.to!string("<td>" ~ fi.name ~ "</td>");
        res ~= "</tr>";
        int count = 0;
        foreach (row; reader.rows)
        {
            res ~= "<tr>";
            res ~= "<td>" ~ std.conv.to!string(++count) ~ "</td>";
            auto mark = row["*"].length > 0 ? "-" : "+";
            res ~= "<td>" ~ mark ~ "</td>";
            foreach (fi; reader.fieldInfo)
            {
                res ~= std.conv.to!string("<td>" ~ row[fi.name] ~ "</td>");
            }
            res ~= "</tr>";
        }
        file.writef(fmt, reader.db.name, res);
        file.close();
        executeShell(fn);
        scope (exit)
            std.file.remove(fn);
    }
}
