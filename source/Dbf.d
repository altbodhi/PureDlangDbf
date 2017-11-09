import std.stdio;
import national.charsets;
import national.encoding;
import std.array;
import std.file;	
import std.string;
import std.datetime;
import std.bitmanip;

class DbfReader
{
File db;

void openDbf(string path)
{
    db = File(path, "r");
}

int versionDbf()
{
    db.seek(0);
    return oneByte();
}
DateTime lastUpdate()
{
    db.seek(1);
    auto year = oneByte();
    db.seek(2);
    auto mm = oneByte();
    db.seek(3);
    auto dd = oneByte();
    return DateTime(year<70 ? year+2000 : year + 1900,mm,dd);
}

uint  recordCount()
{
    db.seek(4); 
    return Int32();
 }
 int headSize()
 {
     db.seek(8); 
    return Int16();
 }
 int recordSize()
 {
     db.seek(10);
     return Int16();
 }
 uint Int32()
 {
     ubyte[] buffer;
     buffer.length = 4;
     auto a = db.rawRead(buffer);
     return  peek!(uint, Endian.littleEndian)(a);
 }
  ushort Int16()
 {
     ubyte[] buffer;
     buffer.length = 2;
     auto a = db.rawRead(buffer);
     return   peek!(ushort, Endian.littleEndian)(a);
 }
 uint oneByte()
 {
    byte[] buffer;
    buffer.length = 1;
    auto data = db.rawRead(buffer);
    return cast(uint)data[0];
 }
}


	 