module national.encoding;

/**
Author Nikolay Tolstokulakov 
https://bitbucket.org/sibnick/national-encoding
Thank you for russian encoding!
**/
import std.range.primitives;
import std.algorithm;
import std.array;
import std.traits;
import std.conv:to;

auto loadOneByteCodepage(dstring codepage) pure nothrow
{
	ubyte[dchar] tmp;
	foreach(idx, c; codepage)
		tmp[c] = cast(ubyte)idx;
	return OneByteCodePage(tmp, codepage);
}


struct OneByteCodePage{

	private {
		ubyte[dchar] encodeDict;
		dstring decodeDict;
		char replaceBad = '?';
	}

	public{
		import std.array;
		auto decode(UbyteRange)(UbyteRange input) pure nothrow
			if (is(ElementType!UbyteRange == ubyte))
		{
			return input.map!(x => decodeDict[x]);
		}
		
		auto encode(CharRange)(CharRange input) pure nothrow 
			if (isSomeString!CharRange || isInputRange!CharRange && isSomeChar!(ElementEncodingType!CharRange))
		{
			return input.map!(x => encodeChar(x));
		}

		bool canEncode(dchar c) pure nothrow 
		{
			return !!(c in encodeDict);
		}

		ubyte encodeChar(C)(C c) pure nothrow
			if (isSomeChar!C)
		{
			dchar dc = to!dchar(c);
			auto code = canEncode(dc)? encodeDict[dc]: replaceBad;
			assert (code<=ubyte.max);
			return cast(ubyte)(code);
		}
	}
}



