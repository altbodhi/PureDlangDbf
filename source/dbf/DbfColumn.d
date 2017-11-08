import std.stdio;
import DbfColumnType;

/// <summary>
/// This class represents a DBF Column.
/// </summary>
/// 
/// <remarks>
/// Note that certain properties can not be modified after creation of the object. 
/// This is because we are locking the header object after creation of a data row,
/// and columns are part of the header so either we have to have a lock field for each column,
/// or make it so that certain properties such as length can only be set during creation of a column.
/// Otherwise a user of this object could modify a column that belongs to a locked header and thus corrupt the DBF file.
/// </remarks>

/*
         (FoxPro/FoxBase) Double integer *NOT* a memo field
         G 	General 	(dBASE V: like Memo) OLE Objects in MS Windows versions 
         P 	Picture 	(FoxPro) Like Memo fields, but not for text processing. 
         Y 	Currency 	(FoxPro)
         T 	DateTime 	(FoxPro)
         I 	Integer 	Length: 4 byte little endian integer 	(FoxPro)
        */

/// <summary>
///  Great information on DBF located here: 
///  http://www.clicketyclick.dk/databases/xbase/format/data_types.html
///  http://www.clicketyclick.dk/databases/xbase/format/dbf.html
///  
/// also take a look at this: http://www.dbase.com/Knowledgebase/INT/db7_file_fmt.htm
/// </summary>


public class DbfColumn
{

    /// <summary>
    /// Column (field) name
    /// </summary>
    private string _name;

    /// <summary>
    /// Field Type (Char, number, boolean, date, memo, binary)
    /// </summary>
    private DbfColumnType _type;

    /// <summary>
    /// Offset from the start of the record
    /// </summary>
    int _dataAddress;

    /// <summary>
    /// Length of the data in bytes; some rules apply which are in the spec (read more above).
    /// </summary>
    private int _length;

    /// <summary>
    /// Decimal precision count, or number of digits afer decimal point. This applies to Number types only.
    /// </summary>
    private int _decimalCount;

    /// <summary>
    /// Full spec constructor sets all relevant fields.
    /// </summary>
    /// <param name="sName"></param>
    /// <param name="type"></param>
    /// <param name="nLength"></param>
    /// <param name="nDecimals"></param>
    public this(string sName, DbfColumnType type, int nLength, int nDecimals)
    {

        Name = sName;
        _type = type;
        _length = nLength;

        if (type == DbfColumnType.Number || type == DbfColumnType.Float)
            _decimalCount = nDecimals;
        else
            _decimalCount = 0;

        //perform some simple integrity checks...
        //-------------------------------------------

        //decimal precision:
        //we could also fix the length property with a statement like this: mLength = mDecimalCount + 2;
        if (_decimalCount > 0 && _length - _decimalCount <= 1)
            throw new Exception("Decimal precision can not be larger than the length of the field.");

        if (_type == DbfColumnType.Integer)
            _length = 4;

        if (_type == DbfColumnType.Binary)
            _length = 1;

        if (_type == DbfColumnType.Date)
            _length = 8; //Dates are exactly yyyyMMdd

        if (_type == DbfColumnType.Memo)
            _length = 10; //Length: 10 Pointer to ASCII text field in memo file. pointer to a DBT block.

        if (_type == DbfColumnType.Boolean)
            _length = 1;

        //field length:
        if (_length <= 0)
            throw new Exception(
                    "Invalid field length specified. Field length can not be zero or less than zero.");
        else if (type != DbfColumnType.Character && type != DbfColumnType.Binary && _length > 255)
            throw new Exception("Invalid field length specified. For numbers it should be within 20 digits, but we allow up to 255. For Char and binary types, length up to 65,535 is allowed. For maximum compatibility use up to 255.");
        else if ((type == DbfColumnType.Character || type == DbfColumnType.Binary) && _length > 65535)
            throw new Exception("Invalid field length specified. For Char and binary types, length up to 65535 is supported. For maximum compatibility use up to 255.");

    }

    /// <summary>
    /// Create a new column fully specifying all properties.
    /// </summary>
    /// <param name="sName">column name</param>
    /// <param name="type">type of field</param>
    /// <param name="nLength">field length including decimal places and decimal point if any</param>
    /// <param name="nDecimals">decimal places</param>
    /// <param name="nDataAddress">offset from start of record</param>
    public this(string sName, DbfColumnType type, int nLength, int nDecimals, int nDataAddress)
    {
        this(sName, type, nLength, nDecimals);
        _dataAddress = nDataAddress;
    }

    public this(string sName, DbfColumnType type)

    {
        this(sName, type, 0, 0);
        if (type == DbfColumnType.Number || type == DbfColumnType.Float
                || type == DbfColumnType.Character)
            throw new Exception(
                    "For number and character field types you must specify Length and Decimal Precision.");

    }

    /// <summary>
    /// Field Name.
    /// </summary>
    @property string Name()

    {
        return _name;
    }

    @property void Name(string value)
    {
        //name:
        if (value==null || value.length==0)
            throw new Exception("Field names must be at least one char long and can not be null.");

        if (value.length > 11)
            throw new Exception("Field names can not be longer than 11 chars.");

        _name = value;

    }

    /// <summary>
    /// Field Type (C N L D or M).
    /// </summary>
    @property DbfColumnType ColumnType()
    {
        return _type;
    }

    /// <summary>
    /// Returns column type as a char, (as written in the DBF column header)
    /// N=number, C=char, B=binary, L=boolean, D=date, I=integer, M=memo
    /// </summary>
    @property char ColumnTypeChar()
    {
        switch (_type)
        {
        case DbfColumnType.Number:
            return 'N';

        case DbfColumnType.Character:
            return 'C';

        case DbfColumnType.Binary:
            return 'B';

        case DbfColumnType.Boolean:
            return 'L';

        case DbfColumnType.Date:
            return 'D';

        case DbfColumnType.Integer:
            return 'I';

        case DbfColumnType.Memo:
            return 'M';

        case DbfColumnType.Float:
            return 'F';
        }

        throw new Exception("Unrecognized field type!");

    }

    /// <summary>
    /// Field Data Address offset from the start of the record.
    /// </summary>
    @property int DataAddress()
    {
        return _dataAddress;
    }

    /// <summary>
    /// Length of the data in bytes.
    /// </summary>
    @property int Length()
    {
        return _length;
    }

    /// <summary>
    /// Field decimal count in Binary, indicating where the decimal is.
    /// </summary>
    @property int DecimalCount()
    {
        return _decimalCount;
    }

    /// <summary>
    /// Returns corresponding dbf field type given a .net Type.
    /// </summary>
    /// <param name="type"></param>
    /// <returns></returns>
    public static DbfColumnType GetDbaseType(T)(T type)
    {

        if (is(typeof(type) == string))
            return DbfColumnType.Character;
        if (is(typeof(type) == double))
            return DbfColumnType.Number;
        if (is(typeof(type) == float))
            return DbfColumnType.Number;
        if (is(typeof(type) == bool))
            return DbfColumnType.Boolean;
        if (is(typeof(type) == datetime))
            return DbfColumnType.Date;

        throw new Exception(type.stringof ~ "  does not have a corresponding dbase type.");

    }

    public static DbfColumnType GetDbaseType(char c)
    {
        switch (c.toString().ToUpper())
        {
        case "C":
            return DbfColumnType.Character;
        case "N":
            return DbfColumnType.Number;
        case "B":
            return DbfColumnType.Binary;
        case "L":
            return DbfColumnType.Boolean;
        case "D":
            return DbfColumnType.Date;
        case "I":
            return DbfColumnType.Integer;
        case "M":
            return DbfColumnType.Memo;
        case "F":
            return DbfColumnType.Float;
        }

        throw new Exception("does not have a corresponding dbase type. = " ~ c);

    }

    /// <summary>
    /// Returns shp file Shape Field.
    /// </summary>
    /// <returns></returns>
    public static DbfColumn ShapeField()
    {
        return new DbfColumn("Geometry", DbfColumnType.Binary);

    }

    /// <summary>
    /// Returns Shp file ID field.
    /// </summary>
    /// <returns></returns>
    public static DbfColumn IdField()
    {
        return new DbfColumn("Row", DbfColumnType.Integer);

    }

}
