import std.stdio;
import national.charsets;
import national.encoding;
import std.array;
import std.file;
import std.string;
import std.datetime;
import std.bitmanip;
import std.conv;

class DbfReader
{
    File db;
    FieldInfo[] fieldInfo;
    dstring[dstring][] rows;
    OneByteCodePage enc;
    /**
    * Windows1251 by default or IBM866(for example, see charsets.d)
    **/
    this(OneByteCodePage _enc)
    {
        enc = _enc;
    }

    void openDbf(string path)
    {
        db = File(path, "r");
    }

    @property int versionDbf()
    {
        db.seek(0);
        return oneByte();
    }

    @property DateTime lastUpdate()
    {
        db.seek(1);
        auto year = oneByte();
        db.seek(2);
        auto mm = oneByte();
        db.seek(3);
        auto dd = oneByte();
        return DateTime(year < 70 ? year + 2000 : year + 1900, mm, dd);
    }

    private uint _recordCount = -1;
    @property uint recordCount()
    {
        if (_recordCount < 0)
        {
            db.seek(4);
            _recordCount = Int32();
        }
        return _recordCount;
    }

    private int _headSize = -1;
    @property int headSize()
    {
        if (_headSize < 0)
        {
            db.seek(8);
            _headSize = Int16();
        }
        return _headSize;
    }

    private int _recordSize = -1;
    @property int recordSize()
    {
        if (_recordSize < 0)
        {
            db.seek(10);
            _recordSize = Int16();
        }
        return _recordSize;
    }

    @property int fieldCount()
    {
        import std.math;

        return cast(int) round(headSize / 33);
    }

    void readFieldInfo()
    {

        for (int i = 1; i <= fieldCount; i++)
        {
            db.seek(i * 32);
            ubyte[] b;
            b.length = 33;
            auto a = db.rawRead(b);
            fieldInfo ~= FieldInfo(enc.decode(a[0 .. 10]).array, a[11], cast(int) a[16]);
        }
    }

    void loadRows(int max = 0)
    {
        for (int i = 0; i < (max > 0 ? max : recordCount); i++)
        {
            db.seek(32 + headSize + i * recordSize);
            ubyte[] b;
            b.length = recordSize;
            auto a = db.rawRead(b);
            dstring[dstring] row;
            row["[*]"] = enc.decode(a[0 .. 0]).array;
            int point = 1;
            foreach (fi; fieldInfo)
            {
                auto from = point;
                auto to = from + fi.len - 1;
                writeln(fi.name, " f = ", from, " t = ", to);
                row[fi.name] = strip(enc.decode(a[from .. to]).array);
                point += fi.len;
            }
            rows ~= row;
        }
    }

    uint Int32()
    {
        ubyte[] buffer;
        buffer.length = 4;
        auto a = db.rawRead(buffer);
        return peek!(uint, Endian.littleEndian)(a);
    }

    ushort Int16()
    {
        ubyte[] buffer;
        buffer.length = 2;
        auto a = db.rawRead(buffer);
        return peek!(ushort, Endian.littleEndian)(a);
    }

    uint oneByte()
    {
        byte[] buffer;
        buffer.length = 1;
        auto data = db.rawRead(buffer);
        return cast(uint) data[0];
    }

}

struct FieldInfo
{
    dstring name;
    char type;
    int len;
}
