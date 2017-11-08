public enum DbfColumnType : int
{

    /// <summary>
    /// C Character   All OEM code page characters - padded with blanks to the width of the field.
    /// Character  less than 254 length
    /// ASCII text less than 254 characters long in dBASE. 
    /// 
    /// Character fields can be up to 32 KB long (in Clipper and FoxPro) using decimal 
    /// count as high byte in field length. It's possible to use up to 64KB long fields 
    /// by reading length as unsigned.
    /// 
    /// </summary>
    Character = 0,

    /// <summary>
    /// Number 	Length: less than 18 
    ///   ASCII text up till 18 characters long (include sign and decimal point). 
    /// 
    /// Valid characters: 
    ///    "0" - "9" and "-". Number fields can be up to 20 characters long in FoxPro and Clipper. 
    /// </summary>
    /// <remarks>
    /// We are not enforcing this 18 char limit.
    /// </remarks>
    Number = 1,

    /// <summary>
    ///  L  Logical  Length: 1    Boolean/byte (8 bit) 
    ///  
    ///  Legal values: 
    ///   ? 	Not initialised (default)
    ///   Y,y 	Yes
    ///   N,n 	No
    ///   F,f 	False
    ///   T,t 	True
    ///   Logical fields are always displayed using T/F/?. Some sources claims 
    ///   that space (ASCII 20h) is valid for not initialised. Space may occur, but is not defined. 	 
    /// </summary>
    Boolean = 2,

    /// <summary>
    /// D 	Date 	Length: 8  Date in format YYYYMMDD. A date like 0000-00- 00 is *NOT* valid. 
    /// </summary>
    Date = 3,

    /// <summary>
    /// M 	Memo 	Length: 10 	Pointer to ASCII text field in memo file 10 digits representing a pointer to a DBT block (default is blanks). 
    /// </summary>
    Memo = 4,

    /// <summary>
    /// B 	Binary 	 	(dBASE V) Like Memo fields, but not for text processing.
    /// </summary>
    Binary = 5,

    /// <summary>
    /// I 	Integer 	Length: 4 byte little endian integer 	(FoxPro)
    /// </summary>
    Integer = 6,

    /// <summary>
    /// F	Float	Number stored as a string, right justified, and padded with blanks to the width of the field. 
    /// example: 
    /// value = " 2.40000000000e+001" Length=19  Decimal_Count=11
    /// 
    /// This type was added in DBF V4.
    /// </summary>
    Float = 7,/// <summary>
    /// O       Double         8 bytes - no conversions, stored as a double.
    /// </summary>
    //Double = 8

}