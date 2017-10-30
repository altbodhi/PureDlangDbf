﻿module national.charsets;
/**
Author Nikolay Tolstokulakov 
https://bitbucket.org/sibnick/national-encoding
Thank you for russian encoding!
**/
import national.encoding;
	
enum CHARSETS = [
	"ibm-838" : IBMThai,
	"ibm838" : IBMThai,
	"838" : IBMThai,
	"cp838" : IBMThai,
	"cp858" : IBM00858,
	"858" : IBM00858,
	"PC-Multilingual-850+euro" : IBM00858,
	"cp00858" : IBM00858,
	"ccsid00858" : IBM00858,
	"cp1140" : IBM01140,
	"1140" : IBM01140,
	"cp01140" : IBM01140,
	"ebcdic-us-037+euro" : IBM01140,
	"ccsid01140" : IBM01140,
	"1141" : IBM01141,
	"cp1141" : IBM01141,
	"cp01141" : IBM01141,
	"ccsid01141" : IBM01141,
	"ebcdic-de-273+euro" : IBM01141,
	"1142" : IBM01142,
	"cp1142" : IBM01142,
	"cp01142" : IBM01142,
	"ccsid01142" : IBM01142,
	"ebcdic-no-277+euro" : IBM01142,
	"ebcdic-dk-277+euro" : IBM01142,
	"1143" : IBM01143,
	"cp01143" : IBM01143,
	"ccsid01143" : IBM01143,
	"cp1143" : IBM01143,
	"ebcdic-fi-278+euro" : IBM01143,
	"ebcdic-se-278+euro" : IBM01143,
	"cp01144" : IBM01144,
	"ccsid01144" : IBM01144,
	"ebcdic-it-280+euro" : IBM01144,
	"cp1144" : IBM01144,
	"1144" : IBM01144,
	"ccsid01145" : IBM01145,
	"ebcdic-es-284+euro" : IBM01145,
	"1145" : IBM01145,
	"cp1145" : IBM01145,
	"cp01145" : IBM01145,
	"ebcdic-gb-285+euro" : IBM01146,
	"1146" : IBM01146,
	"cp1146" : IBM01146,
	"cp01146" : IBM01146,
	"ccsid01146" : IBM01146,
	"cp1147" : IBM01147,
	"1147" : IBM01147,
	"cp01147" : IBM01147,
	"ccsid01147" : IBM01147,
	"ebcdic-fr-277+euro" : IBM01147,
	"cp1148" : IBM01148,
	"ebcdic-international-500+euro" : IBM01148,
	"1148" : IBM01148,
	"cp01148" : IBM01148,
	"ccsid01148" : IBM01148,
	"ebcdic-s-871+euro" : IBM01149,
	"1149" : IBM01149,
	"cp1149" : IBM01149,
	"cp01149" : IBM01149,
	"ccsid01149" : IBM01149,
	"cp037" : IBM037,
	"ibm037" : IBM037,
	"ibm-037" : IBM037,
	"csIBM037" : IBM037,
	"ebcdic-cp-us" : IBM037,
	"ebcdic-cp-ca" : IBM037,
	"ebcdic-cp-nl" : IBM037,
	"ebcdic-cp-wt" : IBM037,
	"037" : IBM037,
	"cpibm37" : IBM037,
	"cs-ebcdic-cp-wt" : IBM037,
	"ibm-37" : IBM037,
	"cs-ebcdic-cp-us" : IBM037,
	"cs-ebcdic-cp-ca" : IBM037,
	"cs-ebcdic-cp-nl" : IBM037,
	"cp1026" : IBM1026,
	"ibm-1026" : IBM1026,
	"1026" : IBM1026,
	"ibm1026" : IBM1026,
	"ibm-1047" : IBM1047,
	"1047" : IBM1047,
	"cp1047" : IBM1047,
	"ibm-273" : IBM273,
	"ibm273" : IBM273,
	"273" : IBM273,
	"cp273" : IBM273,
	"ibm277" : IBM277,
	"277" : IBM277,
	"cp277" : IBM277,
	"ibm-277" : IBM277,
	"cp278" : IBM278,
	"278" : IBM278,
	"ibm-278" : IBM278,
	"ebcdic-cp-se" : IBM278,
	"csIBM278" : IBM278,
	"ibm278" : IBM278,
	"ebcdic-sv" : IBM278,
	"ibm280" : IBM280,
	"280" : IBM280,
	"cp280" : IBM280,
	"ibm-280" : IBM280,
	"csIBM284" : IBM284,
	"ibm-284" : IBM284,
	"cpibm284" : IBM284,
	"ibm284" : IBM284,
	"284" : IBM284,
	"cp284" : IBM284,
	"csIBM285" : IBM285,
	"cp285" : IBM285,
	"ebcdic-gb" : IBM285,
	"ibm-285" : IBM285,
	"cpibm285" : IBM285,
	"ibm285" : IBM285,
	"285" : IBM285,
	"ebcdic-cp-gb" : IBM285,
	"ibm290" : IBM290,
	"290" : IBM290,
	"cp290" : IBM290,
	"EBCDIC-JP-kana" : IBM290,
	"csIBM290" : IBM290,
	"ibm-290" : IBM290,
	"297" : IBM297,
	"csIBM297" : IBM297,
	"cp297" : IBM297,
	"ibm297" : IBM297,
	"ibm-297" : IBM297,
	"cpibm297" : IBM297,
	"ebcdic-cp-fr" : IBM297,
	"ibm420" : IBM420,
	"420" : IBM420,
	"cp420" : IBM420,
	"csIBM420" : IBM420,
	"ibm-420" : IBM420,
	"ebcdic-cp-ar1" : IBM420,
	"ebcdic-cp-he" : IBM424,
	"csIBM424" : IBM424,
	"ibm-424" : IBM424,
	"ibm424" : IBM424,
	"424" : IBM424,
	"cp424" : IBM424,
	"ibm437" : IBM437,
	"437" : IBM437,
	"ibm-437" : IBM437,
	"cspc8codepage437" : IBM437,
	"cp437" : IBM437,
	"windows-437" : IBM437,
	"ibm-500" : IBM500,
	"ibm500" : IBM500,
	"500" : IBM500,
	"ebcdic-cp-bh" : IBM500,
	"ebcdic-cp-ch" : IBM500,
	"csIBM500" : IBM500,
	"cp500" : IBM500,
	"ibm-775" : IBM775,
	"ibm775" : IBM775,
	"775" : IBM775,
	"cp775" : IBM775,
	"cp850" : IBM850,
	"cspc850multilingual" : IBM850,
	"ibm850" : IBM850,
	"850" : IBM850,
	"ibm-850" : IBM850,
	"csPCp852" : IBM852,
	"ibm-852" : IBM852,
	"ibm852" : IBM852,
	"852" : IBM852,
	"cp852" : IBM852,
	"ibm855" : IBM855,
	"855" : IBM855,
	"ibm-855" : IBM855,
	"cp855" : IBM855,
	"cspcp855" : IBM855,
	"ibm857" : IBM857,
	"857" : IBM857,
	"cp857" : IBM857,
	"csIBM857" : IBM857,
	"ibm-857" : IBM857,
	"ibm860" : IBM860,
	"860" : IBM860,
	"cp860" : IBM860,
	"csIBM860" : IBM860,
	"ibm-860" : IBM860,
	"cp861" : IBM861,
	"ibm861" : IBM861,
	"861" : IBM861,
	"ibm-861" : IBM861,
	"cp-is" : IBM861,
	"csIBM861" : IBM861,
	"csIBM862" : IBM862,
	"cp862" : IBM862,
	"ibm862" : IBM862,
	"862" : IBM862,
	"cspc862latinhebrew" : IBM862,
	"ibm-862" : IBM862,
	"csIBM863" : IBM863,
	"ibm-863" : IBM863,
	"ibm863" : IBM863,
	"863" : IBM863,
	"cp863" : IBM863,
	"csIBM864" : IBM864,
	"ibm-864" : IBM864,
	"ibm864" : IBM864,
	"864" : IBM864,
	"cp864" : IBM864,
	"ibm-865" : IBM865,
	"csIBM865" : IBM865,
	"cp865" : IBM865,
	"ibm865" : IBM865,
	"865" : IBM865,
	"ibm866" : IBM866,
	"866" : IBM866,
	"ibm-866" : IBM866,
	"csIBM866" : IBM866,
	"cp866" : IBM866,
	"ibm868" : IBM868,
	"868" : IBM868,
	"cp868" : IBM868,
	"csIBM868" : IBM868,
	"ibm-868" : IBM868,
	"cp-ar" : IBM868,
	"cp869" : IBM869,
	"ibm869" : IBM869,
	"869" : IBM869,
	"ibm-869" : IBM869,
	"cp-gr" : IBM869,
	"csIBM869" : IBM869,
	"870" : IBM870,
	"cp870" : IBM870,
	"csIBM870" : IBM870,
	"ibm-870" : IBM870,
	"ibm870" : IBM870,
	"ebcdic-cp-roece" : IBM870,
	"ebcdic-cp-yu" : IBM870,
	"ibm871" : IBM871,
	"871" : IBM871,
	"cp871" : IBM871,
	"ebcdic-cp-is" : IBM871,
	"csIBM871" : IBM871,
	"ibm-871" : IBM871,
	"918" : IBM918,
	"ibm-918" : IBM918,
	"ebcdic-cp-ar2" : IBM918,
	"cp918" : IBM918,
	"819" : ISO88591,
	"ISO8859-1" : ISO88591,
	"l1" : ISO88591,
	"ISO_8859-1:1987" : ISO88591,
	"ISO_8859-1" : ISO88591,
	"8859_1" : ISO88591,
	"iso-ir-100" : ISO88591,
	"latin1" : ISO88591,
	"cp819" : ISO88591,
	"ISO8859_1" : ISO88591,
	"IBM819" : ISO88591,
	"ISO_8859_1" : ISO88591,
	"IBM-819" : ISO88591,
	"csISOLatin1" : ISO88591,
	"iso_8859-13" : ISO885913,
	"ISO8859-13" : ISO885913,
	"iso8859_13" : ISO885913,
	"8859_13" : ISO885913,
	"ISO8859-15" : ISO885915,
	"LATIN0" : ISO885915,
	"ISO8859_15_FDIS" : ISO885915,
	"ISO8859_15" : ISO885915,
	"cp923" : ISO885915,
	"8859_15" : ISO885915,
	"L9" : ISO885915,
	"ISO-8859-15" : ISO885915,
	"IBM923" : ISO885915,
	"csISOlatin9" : ISO885915,
	"ISO_8859-15" : ISO885915,
	"IBM-923" : ISO885915,
	"csISOlatin0" : ISO885915,
	"923" : ISO885915,
	"LATIN9" : ISO885915,
	"ISO8859-2" : ISO88592,
	"ibm912" : ISO88592,
	"l2" : ISO88592,
	"ISO_8859-2" : ISO88592,
	"8859_2" : ISO88592,
	"cp912" : ISO88592,
	"ISO_8859-2:1987" : ISO88592,
	"iso8859_2" : ISO88592,
	"iso-ir-101" : ISO88592,
	"latin2" : ISO88592,
	"912" : ISO88592,
	"csISOLatin2" : ISO88592,
	"ibm-912" : ISO88592,
	"ISO8859-3" : ISO88593,
	"ibm913" : ISO88593,
	"8859_3" : ISO88593,
	"l3" : ISO88593,
	"cp913" : ISO88593,
	"ISO_8859-3" : ISO88593,
	"iso8859_3" : ISO88593,
	"latin3" : ISO88593,
	"csISOLatin3" : ISO88593,
	"913" : ISO88593,
	"ISO_8859-3:1988" : ISO88593,
	"ibm-913" : ISO88593,
	"iso-ir-109" : ISO88593,
	"8859_4" : ISO88594,
	"latin4" : ISO88594,
	"l4" : ISO88594,
	"cp914" : ISO88594,
	"ISO_8859-4:1988" : ISO88594,
	"ibm914" : ISO88594,
	"ISO_8859-4" : ISO88594,
	"iso-ir-110" : ISO88594,
	"iso8859_4" : ISO88594,
	"csISOLatin4" : ISO88594,
	"iso8859-4" : ISO88594,
	"914" : ISO88594,
	"ibm-914" : ISO88594,
	"ISO_8859-5:1988" : ISO88595,
	"csISOLatinCyrillic" : ISO88595,
	"iso-ir-144" : ISO88595,
	"iso8859_5" : ISO88595,
	"cp915" : ISO88595,
	"8859_5" : ISO88595,
	"ibm-915" : ISO88595,
	"ISO_8859-5" : ISO88595,
	"ibm915" : ISO88595,
	"915" : ISO88595,
	"cyrillic" : ISO88595,
	"ISO8859-5" : ISO88595,
	"ASMO-708" : ISO88596,
	"8859_6" : ISO88596,
	"iso8859_6" : ISO88596,
	"ISO_8859-6" : ISO88596,
	"csISOLatinArabic" : ISO88596,
	"ibm1089" : ISO88596,
	"arabic" : ISO88596,
	"ibm-1089" : ISO88596,
	"1089" : ISO88596,
	"ECMA-114" : ISO88596,
	"iso-ir-127" : ISO88596,
	"ISO_8859-6:1987" : ISO88596,
	"ISO8859-6" : ISO88596,
	"cp1089" : ISO88596,
	"greek" : ISO88597,
	"8859_7" : ISO88597,
	"greek8" : ISO88597,
	"ibm813" : ISO88597,
	"ISO_8859-7" : ISO88597,
	"iso8859_7" : ISO88597,
	"ELOT_928" : ISO88597,
	"cp813" : ISO88597,
	"ISO_8859-7:1987" : ISO88597,
	"sun_eu_greek" : ISO88597,
	"csISOLatinGreek" : ISO88597,
	"iso-ir-126" : ISO88597,
	"813" : ISO88597,
	"iso8859-7" : ISO88597,
	"ECMA-118" : ISO88597,
	"ibm-813" : ISO88597,
	"8859_8" : ISO88598,
	"ISO_8859-8" : ISO88598,
	"ISO_8859-8:1988" : ISO88598,
	"cp916" : ISO88598,
	"iso-ir-138" : ISO88598,
	"ISO8859-8" : ISO88598,
	"hebrew" : ISO88598,
	"iso8859_8" : ISO88598,
	"ibm-916" : ISO88598,
	"csISOLatinHebrew" : ISO88598,
	"916" : ISO88598,
	"ibm916" : ISO88598,
	"ibm-920" : ISO88599,
	"ISO_8859-9" : ISO88599,
	"8859_9" : ISO88599,
	"ISO_8859-9:1989" : ISO88599,
	"ibm920" : ISO88599,
	"latin5" : ISO88599,
	"l5" : ISO88599,
	"iso8859_9" : ISO88599,
	"cp920" : ISO88599,
	"920" : ISO88599,
	"iso-ir-148" : ISO88599,
	"ISO8859-9" : ISO88599,
	"csISOLatin5" : ISO88599,
	"JIS0201" : JIS_X0201,
	"csHalfWidthKatakana" : JIS_X0201,
	"X0201" : JIS_X0201,
	"JIS_X0201" : JIS_X0201,
	"koi8_r" : KOI8R,
	"koi8" : KOI8R,
	"cskoi8r" : KOI8R,
	"koi8_u" : KOI8U,
	"tis620" : TIS620,
	"tis620.2533" : TIS620,
	"ANSI_X3.4-1968" : USASCII,
	"cp367" : USASCII,
	"csASCII" : USASCII,
	"iso-ir-6" : USASCII,
	"ASCII" : USASCII,
	"iso_646.irv:1983" : USASCII,
	"ANSI_X3.4-1986" : USASCII,
	"ascii7" : USASCII,
	"default" : USASCII,
	"ISO_646.irv:1991" : USASCII,
	"ISO646-US" : USASCII,
	"IBM367" : USASCII,
	"646" : USASCII,
	"us" : USASCII,
	"cp1250" : Windows1250,
	"cp5346" : Windows1250,
	"cp5347" : Windows1251,
	"ansi-1251" : Windows1251,
	"cp1251" : Windows1251,
	"cp5348" : Windows1252,
	"cp1252" : Windows1252,
	"cp1253" : Windows1253,
	"cp5349" : Windows1253,
	"cp1254" : Windows1254,
	"cp5350" : Windows1254,
	"cp1255" : Windows1255,
	"cp1256" : Windows1256,
	"cp1257" : Windows1257,
	"cp5353" : Windows1257,
	"cp1258" : Windows1258,
	"ibm1006" : XIBM1006,
	"ibm-1006" : XIBM1006,
	"1006" : XIBM1006,
	"cp1006" : XIBM1006,
	"ibm-1025" : XIBM1025,
	"1025" : XIBM1025,
	"cp1025" : XIBM1025,
	"ibm1025" : XIBM1025,
	"ibm1046" : XIBM1046,
	"ibm-1046" : XIBM1046,
	"1046" : XIBM1046,
	"cp1046" : XIBM1046,
	"ibm1097" : XIBM1097,
	"ibm-1097" : XIBM1097,
	"1097" : XIBM1097,
	"cp1097" : XIBM1097,
	"ibm-1098" : XIBM1098,
	"1098" : XIBM1098,
	"cp1098" : XIBM1098,
	"ibm1098" : XIBM1098,
	"ibm1112" : XIBM1112,
	"ibm-1112" : XIBM1112,
	"1112" : XIBM1112,
	"cp1112" : XIBM1112,
	"cp1122" : XIBM1122,
	"ibm1122" : XIBM1122,
	"ibm-1122" : XIBM1122,
	"1122" : XIBM1122,
	"ibm1123" : XIBM1123,
	"ibm-1123" : XIBM1123,
	"1123" : XIBM1123,
	"cp1123" : XIBM1123,
	"ibm-1124" : XIBM1124,
	"1124" : XIBM1124,
	"cp1124" : XIBM1124,
	"ibm1124" : XIBM1124,
	"cp1166" : XIBM1166,
	"ibm1166" : XIBM1166,
	"ibm-1166" : XIBM1166,
	"1166" : XIBM1166,
	"cp737" : XIBM737,
	"ibm737" : XIBM737,
	"737" : XIBM737,
	"ibm-737" : XIBM737,
	"ibm833" : XIBM833,
	"cp833" : XIBM833,
	"ibm-833" : XIBM833,
	"ibm856" : XIBM856,
	"856" : XIBM856,
	"cp856" : XIBM856,
	"ibm-856" : XIBM856,
	"ibm-874" : XIBM874,
	"ibm874" : XIBM874,
	"874" : XIBM874,
	"cp874" : XIBM874,
	"ibm-875" : XIBM875,
	"ibm875" : XIBM875,
	"875" : XIBM875,
	"cp875" : XIBM875,
	"ibm921" : XIBM921,
	"921" : XIBM921,
	"ibm-921" : XIBM921,
	"cp921" : XIBM921,
	"ibm922" : XIBM922,
	"922" : XIBM922,
	"cp922" : XIBM922,
	"ibm-922" : XIBM922,
	"iso-8859-11" : XIso885911,
	"iso8859_11" : XIso885911,
	"MacArabic" : XMacArabic,
	"MacCentralEurope" : XMacCentralEurope,
	"MacCroatian" : XMacCroatian,
	"MacCyrillic" : XMacCyrillic,
	"MacDingbat" : XMacDingbat,
	"MacGreek" : XMacGreek,
	"MacHebrew" : XMacHebrew,
	"MacIceland" : XMacIceland,
	"MacRoman" : XMacRoman,
	"MacRomania" : XMacRomania,
	"MacSymbol" : XMacSymbol,
	"MacThai" : XMacThai,
	"MacTurkish" : XMacTurkish,
	"MacUkraine" : XMacUkraine,
	"ms-874" : XWindows874,
	"ms874" : XWindows874,
	"windows-874" : XWindows874,

];


enum IBMThai = loadOneByteCodepage(import("national/codepages/ibm-thai_utf8.bin"));
enum IBM00858 = loadOneByteCodepage(import("national/codepages/ibm00858_utf8.bin"));
enum IBM01140 = loadOneByteCodepage(import("national/codepages/ibm01140_utf8.bin"));
enum IBM01141 = loadOneByteCodepage(import("national/codepages/ibm01141_utf8.bin"));
enum IBM01142 = loadOneByteCodepage(import("national/codepages/ibm01142_utf8.bin"));
enum IBM01143 = loadOneByteCodepage(import("national/codepages/ibm01143_utf8.bin"));
enum IBM01144 = loadOneByteCodepage(import("national/codepages/ibm01144_utf8.bin"));
enum IBM01145 = loadOneByteCodepage(import("national/codepages/ibm01145_utf8.bin"));
enum IBM01146 = loadOneByteCodepage(import("national/codepages/ibm01146_utf8.bin"));
enum IBM01147 = loadOneByteCodepage(import("national/codepages/ibm01147_utf8.bin"));
enum IBM01148 = loadOneByteCodepage(import("national/codepages/ibm01148_utf8.bin"));
enum IBM01149 = loadOneByteCodepage(import("national/codepages/ibm01149_utf8.bin"));
enum IBM037 = loadOneByteCodepage(import("national/codepages/ibm037_utf8.bin"));
enum IBM1026 = loadOneByteCodepage(import("national/codepages/ibm1026_utf8.bin"));
enum IBM1047 = loadOneByteCodepage(import("national/codepages/ibm1047_utf8.bin"));
enum IBM273 = loadOneByteCodepage(import("national/codepages/ibm273_utf8.bin"));
enum IBM277 = loadOneByteCodepage(import("national/codepages/ibm277_utf8.bin"));
enum IBM278 = loadOneByteCodepage(import("national/codepages/ibm278_utf8.bin"));
enum IBM280 = loadOneByteCodepage(import("national/codepages/ibm280_utf8.bin"));
enum IBM284 = loadOneByteCodepage(import("national/codepages/ibm284_utf8.bin"));
enum IBM285 = loadOneByteCodepage(import("national/codepages/ibm285_utf8.bin"));
enum IBM290 = loadOneByteCodepage(import("national/codepages/ibm290_utf8.bin"));
enum IBM297 = loadOneByteCodepage(import("national/codepages/ibm297_utf8.bin"));
enum IBM420 = loadOneByteCodepage(import("national/codepages/ibm420_utf8.bin"));
enum IBM424 = loadOneByteCodepage(import("national/codepages/ibm424_utf8.bin"));
enum IBM437 = loadOneByteCodepage(import("national/codepages/ibm437_utf8.bin"));
enum IBM500 = loadOneByteCodepage(import("national/codepages/ibm500_utf8.bin"));
enum IBM775 = loadOneByteCodepage(import("national/codepages/ibm775_utf8.bin"));
enum IBM850 = loadOneByteCodepage(import("national/codepages/ibm850_utf8.bin"));
enum IBM852 = loadOneByteCodepage(import("national/codepages/ibm852_utf8.bin"));
enum IBM855 = loadOneByteCodepage(import("national/codepages/ibm855_utf8.bin"));
enum IBM857 = loadOneByteCodepage(import("national/codepages/ibm857_utf8.bin"));
enum IBM860 = loadOneByteCodepage(import("national/codepages/ibm860_utf8.bin"));
enum IBM861 = loadOneByteCodepage(import("national/codepages/ibm861_utf8.bin"));
enum IBM862 = loadOneByteCodepage(import("national/codepages/ibm862_utf8.bin"));
enum IBM863 = loadOneByteCodepage(import("national/codepages/ibm863_utf8.bin"));
enum IBM864 = loadOneByteCodepage(import("national/codepages/ibm864_utf8.bin"));
enum IBM865 = loadOneByteCodepage(import("national/codepages/ibm865_utf8.bin"));
enum IBM866 = loadOneByteCodepage(import("national/codepages/ibm866_utf8.bin"));
enum IBM868 = loadOneByteCodepage(import("national/codepages/ibm868_utf8.bin"));
enum IBM869 = loadOneByteCodepage(import("national/codepages/ibm869_utf8.bin"));
enum IBM870 = loadOneByteCodepage(import("national/codepages/ibm870_utf8.bin"));
enum IBM871 = loadOneByteCodepage(import("national/codepages/ibm871_utf8.bin"));
enum IBM918 = loadOneByteCodepage(import("national/codepages/ibm918_utf8.bin"));
enum ISO88591 = loadOneByteCodepage(import("national/codepages/iso-8859-1_utf8.bin"));
enum ISO885913 = loadOneByteCodepage(import("national/codepages/iso-8859-13_utf8.bin"));
enum ISO885915 = loadOneByteCodepage(import("national/codepages/iso-8859-15_utf8.bin"));
enum ISO88592 = loadOneByteCodepage(import("national/codepages/iso-8859-2_utf8.bin"));
enum ISO88593 = loadOneByteCodepage(import("national/codepages/iso-8859-3_utf8.bin"));
enum ISO88594 = loadOneByteCodepage(import("national/codepages/iso-8859-4_utf8.bin"));
enum ISO88595 = loadOneByteCodepage(import("national/codepages/iso-8859-5_utf8.bin"));
enum ISO88596 = loadOneByteCodepage(import("national/codepages/iso-8859-6_utf8.bin"));
enum ISO88597 = loadOneByteCodepage(import("national/codepages/iso-8859-7_utf8.bin"));
enum ISO88598 = loadOneByteCodepage(import("national/codepages/iso-8859-8_utf8.bin"));
enum ISO88599 = loadOneByteCodepage(import("national/codepages/iso-8859-9_utf8.bin"));
enum JIS_X0201 = loadOneByteCodepage(import("national/codepages/jis_x0201_utf8.bin"));
enum KOI8R = loadOneByteCodepage(import("national/codepages/koi8-r_utf8.bin"));
enum KOI8U = loadOneByteCodepage(import("national/codepages/koi8-u_utf8.bin"));
enum TIS620 = loadOneByteCodepage(import("national/codepages/tis-620_utf8.bin"));
enum USASCII = loadOneByteCodepage(import("national/codepages/us-ascii_utf8.bin"));
enum Windows1250 = loadOneByteCodepage(import("national/codepages/windows-1250_utf8.bin"));
enum Windows1251 = loadOneByteCodepage(import("national/codepages/windows-1251_utf8.bin"));
enum Windows1252 = loadOneByteCodepage(import("national/codepages/windows-1252_utf8.bin"));
enum Windows1253 = loadOneByteCodepage(import("national/codepages/windows-1253_utf8.bin"));
enum Windows1254 = loadOneByteCodepage(import("national/codepages/windows-1254_utf8.bin"));
enum Windows1255 = loadOneByteCodepage(import("national/codepages/windows-1255_utf8.bin"));
enum Windows1256 = loadOneByteCodepage(import("national/codepages/windows-1256_utf8.bin"));
enum Windows1257 = loadOneByteCodepage(import("national/codepages/windows-1257_utf8.bin"));
enum Windows1258 = loadOneByteCodepage(import("national/codepages/windows-1258_utf8.bin"));
enum XIBM1006 = loadOneByteCodepage(import("national/codepages/x-ibm1006_utf8.bin"));
enum XIBM1025 = loadOneByteCodepage(import("national/codepages/x-ibm1025_utf8.bin"));
enum XIBM1046 = loadOneByteCodepage(import("national/codepages/x-ibm1046_utf8.bin"));
enum XIBM1097 = loadOneByteCodepage(import("national/codepages/x-ibm1097_utf8.bin"));
enum XIBM1098 = loadOneByteCodepage(import("national/codepages/x-ibm1098_utf8.bin"));
enum XIBM1112 = loadOneByteCodepage(import("national/codepages/x-ibm1112_utf8.bin"));
enum XIBM1122 = loadOneByteCodepage(import("national/codepages/x-ibm1122_utf8.bin"));
enum XIBM1123 = loadOneByteCodepage(import("national/codepages/x-ibm1123_utf8.bin"));
enum XIBM1124 = loadOneByteCodepage(import("national/codepages/x-ibm1124_utf8.bin"));
enum XIBM1166 = loadOneByteCodepage(import("national/codepages/x-ibm1166_utf8.bin"));
enum XIBM737 = loadOneByteCodepage(import("national/codepages/x-ibm737_utf8.bin"));
enum XIBM833 = loadOneByteCodepage(import("national/codepages/x-ibm833_utf8.bin"));
enum XIBM856 = loadOneByteCodepage(import("national/codepages/x-ibm856_utf8.bin"));
enum XIBM874 = loadOneByteCodepage(import("national/codepages/x-ibm874_utf8.bin"));
enum XIBM875 = loadOneByteCodepage(import("national/codepages/x-ibm875_utf8.bin"));
enum XIBM921 = loadOneByteCodepage(import("national/codepages/x-ibm921_utf8.bin"));
enum XIBM922 = loadOneByteCodepage(import("national/codepages/x-ibm922_utf8.bin"));
enum XIso885911 = loadOneByteCodepage(import("national/codepages/x-iso-8859-11_utf8.bin"));
enum XMacArabic = loadOneByteCodepage(import("national/codepages/x-macarabic_utf8.bin"));
enum XMacCentralEurope = loadOneByteCodepage(import("national/codepages/x-maccentraleurope_utf8.bin"));
enum XMacCroatian = loadOneByteCodepage(import("national/codepages/x-maccroatian_utf8.bin"));
enum XMacCyrillic = loadOneByteCodepage(import("national/codepages/x-maccyrillic_utf8.bin"));
enum XMacDingbat = loadOneByteCodepage(import("national/codepages/x-macdingbat_utf8.bin"));
enum XMacGreek = loadOneByteCodepage(import("national/codepages/x-macgreek_utf8.bin"));
enum XMacHebrew = loadOneByteCodepage(import("national/codepages/x-machebrew_utf8.bin"));
enum XMacIceland = loadOneByteCodepage(import("national/codepages/x-maciceland_utf8.bin"));
enum XMacRoman = loadOneByteCodepage(import("national/codepages/x-macroman_utf8.bin"));
enum XMacRomania = loadOneByteCodepage(import("national/codepages/x-macromania_utf8.bin"));
enum XMacSymbol = loadOneByteCodepage(import("national/codepages/x-macsymbol_utf8.bin"));
enum XMacThai = loadOneByteCodepage(import("national/codepages/x-macthai_utf8.bin"));
enum XMacTurkish = loadOneByteCodepage(import("national/codepages/x-macturkish_utf8.bin"));
enum XMacUkraine = loadOneByteCodepage(import("national/codepages/x-macukraine_utf8.bin"));
enum XWindows874 = loadOneByteCodepage(import("national/codepages/x-windows-874_utf8.bin"));



