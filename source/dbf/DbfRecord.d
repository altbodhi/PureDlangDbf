import national.charsets;
import national.encoding;
import DbfColumn;
import DbfHeader;
import std.stdio;
import std.conv;
import std.datetime;

    public class DbfRecord
    {

        /// <summary>
        /// Header provides information on all field types, sizes, precision and other useful information about the DBF.
        /// </summary>
        private DbfHeader _header = null;

        /// <summary>
        /// Dbf data are a mix of ASCII characters and binary, which neatly fit in a byte array.
        /// BinaryWriter would esentially perform the same conversion using the same Encoding class.
        /// </summary>
        private byte[] _data = null;

        /// <summary>
        /// Zero based record index. -1 when not set, new records for example.
        /// </summary>
        private long _recordIndex = -1;

        /// <summary>
        /// Empty Record array reference used to clear fields quickly (or entire record).
        /// </summary>
        private  byte[] _emptyRecord = null;


        /// <summary>
        /// Specifies whether we allow strings to be truncated. If false and string is longer than we can fit in the field, an exception is thrown.
        /// </summary>
        private bool _allowStringTruncate = true;

        /// <summary>
        /// Specifies whether we allow the decimal portion of numbers to be truncated. 
        /// If false and decimal digits overflow the field, an exception is thrown.
        /// </summary>
        private bool _allowDecimalTruncate = false;

        /// <summary>
        /// Specifies whether we allow the integer portion of numbers to be truncated.
        /// If false and integer digits overflow the field, an exception is thrown.
        /// </summary>
        private bool _allowIntegerTruncate = false;


        //array used to clear decimals, we can clear up to 40 decimals which is much more than is allowed under DBF spec anyway.
        //Note: 48 is ASCII code for 0.
        private static  byte[] _decimalClear =  [48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,
                                                               48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,
                                                               48,48,48,48,48,48,48,48,48,48,48,48,48,48,48];


        //Warning: do not make this one static because that would not be thread safe!! The reason I have 
        //placed this here is to skip small memory allocation/deallocation which fragments memory in .net.
        private int[] _tempIntVal = [ 0 ];


        //encoder
        private  OneByteCodePage encoding = Windows1251;

        /// <summary>
        /// Column Name to Column Index map
        /// </summary>
        private  int[string] _colNameToIdx;



        /// <summary>
        /// 
        /// </summary>
        /// <param name="oHeader">Dbf Header will be locked once a record is created 
        /// since the record size is fixed and if the header was modified it would corrupt the DBF file.</param>
        public this(DbfHeader oHeader)
        {
            _header = oHeader;
            _header.Locked = true;

            //create a buffer to hold all record data. We will reuse this buffer to write all data to the file.
            _data = new byte[_header.RecordLength];

            // Make sure mData[0] correctly represents 'not deleted'
            IsDeleted = false;

            _emptyRecord = _header.EmptyDataRecord;
            encoding = oHeader.encoding;

            for (int i = 0; i < oHeader._fields.Count; i++)
                _colNameToIdx[oHeader._fields[i].Name] = i;
        }

          public string  get(int nColIndex)
         {
                DbfColumn ocol = _header[nColIndex];
                return new string(encoding.GetChars(_data, ocol.DataAddress, ocol.Length));

        }
        
        /// <summary>
        /// Set string data to a column, if the string is longer than specified column length it will be truncated!
        /// If dbf column type is not a string, input will be treated as dbf column 
        /// type and if longer than length an exception will be thrown.
        /// </summary>
        /// <param name="nColIndex"></param>
        /// <returns></returns>
        public void set(int nColIndex, string value)
        {

                DbfColumn ocol = _header.get(nColIndex);
                DbfColumn.DbfColumnType ocolType = ocol.ColumnType;


                //
                //if an empty value is passed, we just clear the data, and leave it blank.
                //note: test have shown that testing for null and checking length is faster than comparing to "" empty str :)
                //------------------------------------------------------------------------------------------------------------
                if (string.IsNullOrEmpty(value))
                {
                    //this is like NULL data, set it to empty. i looked at SAS DBF output when a null value exists 
                    //and empty data are output. we get the same result, so this looks good.
                    Buffer.BlockCopy(_emptyRecord, ocol.DataAddress, _data, ocol.DataAddress, ocol.Length);

                }
                else
                {

                    //set values according to data type:
                    //-------------------------------------------------------------
                    if (ocolType == DbfColumn.DbfColumnType.Character)
                    {
                        if (!_allowStringTruncate && value.Length > ocol.Length)
                            throw new DbfDataTruncateException("Value not set. String truncation would occur and AllowStringTruncate flag is set to false. To supress this exception change AllowStringTruncate to true.");

                        //BlockCopy copies bytes.  First clear the previous value, then set the new one.
                        Buffer.BlockCopy(_emptyRecord, ocol.DataAddress, _data, ocol.DataAddress, ocol.Length);
                        encoding.GetBytes(value, 0, value.Length > ocol.Length ? ocol.Length : value.Length, _data, ocol.DataAddress);

                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Number)
                    {

                        if (ocol.DecimalCount == 0)
                        {

                            //integers
                            //----------------------------------

                            //throw an exception if integer overflow would occur
                            if (!_allowIntegerTruncate && value.Length > ocol.Length)
                                throw new DbfDataTruncateException("Value not set. Integer does not fit and would be truncated. AllowIntegerTruncate is set to false. To supress this exception set AllowIntegerTruncate to true, although that is not recomended.");


                            //clear all numbers, set to [space].
                            //-----------------------------------------------------
                            Buffer.BlockCopy(_emptyRecord, 0, _data, ocol.DataAddress, ocol.Length);


                            //set integer part, CAREFUL not to overflow buffer! (truncate instead)
                            //-----------------------------------------------------------------------
                            int nNumLen = value.Length > ocol.Length ? ocol.Length : value.Length;
                            encoding.GetBytes(value, 0, nNumLen, _data, (ocol.DataAddress + ocol.Length - nNumLen));

                        }
                        else
                        {

                            ///TODO: we can improve perfomance here by not using temp char arrays cDec and cNum,
                            ///simply directly copy from source string using encoding!


                            //break value down into integer and decimal portions
                            //--------------------------------------------------------------------------
                            int nidxDecimal = value.IndexOf('.'); //index where the decimal point occurs
                            char[] cDec = null; //decimal portion of the number
                            char[] cNum = null; //integer portion

                            if (nidxDecimal > -1)
                            {
                                cDec = value.Substring(nidxDecimal + 1).Trim().ToCharArray();
                                cNum = value.Substring(0, nidxDecimal).ToCharArray();

                                //throw an exception if decimal overflow would occur
                                if (!_allowDecimalTruncate && cDec.Length > ocol.DecimalCount)
                                    throw new DbfDataTruncateException("Value not set. Decimal does not fit and would be truncated. AllowDecimalTruncate is set to false. To supress this exception set AllowDecimalTruncate to true.");

                            }
                            else
                                cNum = value.ToCharArray();


                            //throw an exception if integer overflow would occur
                            if (!_allowIntegerTruncate && cNum.Length > ocol.Length - ocol.DecimalCount - 1)
                                throw new DbfDataTruncateException("Value not set. Integer does not fit and would be truncated. AllowIntegerTruncate is set to false. To supress this exception set AllowIntegerTruncate to true, although that is not recomended.");


                            //------------------------------------------------------------------------------------------------------------------
                            // NUMERIC TYPE
                            //------------------------------------------------------------------------------------------------------------------
                                
                            //clear all decimals, set to 0.
                            //-----------------------------------------------------
                            Buffer.BlockCopy(_decimalClear, 0, _data, (ocol.DataAddress + ocol.Length - ocol.DecimalCount), ocol.DecimalCount);

                            //clear all numbers, set to [space].
                            Buffer.BlockCopy(_emptyRecord, 0, _data, ocol.DataAddress, (ocol.Length - ocol.DecimalCount));



                            //set decimal numbers, CAREFUL not to overflow buffer! (truncate instead)
                            //-----------------------------------------------------------------------
                            if (nidxDecimal > -1)
                            {
                                int nLen = cDec.Length > ocol.DecimalCount ? ocol.DecimalCount : cDec.Length;
                                encoding.GetBytes(cDec, 0, nLen, _data, (ocol.DataAddress + ocol.Length - ocol.DecimalCount));
                            }

                            //set integer part, CAREFUL not to overflow buffer! (truncate instead)
                            //-----------------------------------------------------------------------
                            int nNumLen = cNum.Length > ocol.Length - ocol.DecimalCount - 1 ? (ocol.Length - ocol.DecimalCount - 1) : cNum.Length;
                            encoding.GetBytes(cNum, 0, nNumLen, _data, ocol.DataAddress + ocol.Length - ocol.DecimalCount - nNumLen - 1);


                            //set decimal point
                            //-----------------------------------------------------------------------
                            _data[ocol.DataAddress + ocol.Length - ocol.DecimalCount - 1] = cast(byte)'.';
                            

                        }


                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Float)
                    {
                        //------------------------------------------------------------------------------------------------------------------
                        // FLOAT TYPE
                        // example:   value=" 2.40000000000e+001"  Length=19   Decimal-Count=11
                        //------------------------------------------------------------------------------------------------------------------


                        // check size, throw exception if value won't fit:
                        if (value.Length > ocol.Length)
                            throw new DbfDataTruncateException("Value not set. Float value does not fit and would be truncated.");

                        
                        double parsed_value =to!double(value);
                       
                        //clear value that was present previously
                        Buffer.BlockCopy(_decimalClear, 0, _data, ocol.DataAddress, ocol.Length);

                        //copy new value at location
                        char[] valueAsCharArray = value.ToCharArray();
                        encoding.GetBytes(valueAsCharArray, 0, valueAsCharArray.Length, _data, ocol.DataAddress);

                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Integer)
                    {
                        //note this is a binary Integer type!
                        //----------------------------------------------

                        ///TODO: maybe there is a better way to copy 4 bytes from int to byte array. Some memory function or something.
                        _tempIntVal[0] = Convert.ToInt32(value);
                        Buffer.BlockCopy(_tempIntVal, 0, _data, ocol.DataAddress, 4);

                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Memo)
                    {
                        //copy 10 digits...
                        ///TODO: implement MEMO

                        throw new NotImplementedException("Memo data type functionality not implemented yet!");

                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Boolean)
                    {
                        if (String.Compare(value, "true", true) == 0 || String.Compare(value, "1", true) == 0 ||
                            String.Compare(value, "T", true) == 0 || String.Compare(value, "yes", true) == 0 ||
                            String.Compare(value, "Y", true) == 0)
                            _data[ocol.DataAddress] = cast(byte)'T';
                        else if (value == " " || value == "?")
                            _data[ocol.DataAddress] = cast(byte)'?';
                        else
                            _data[ocol.DataAddress] = cast(byte)'F';

                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Date)
                    {
                        //try to parse out date value using Date.Parse() function, then set the value
                        DateTime dateval = to!datetime(value);
                            SetDateValue(nColIndex, dateval);
                    }
                    else if (ocolType == DbfColumn.DbfColumnType.Binary)
                        throw new Exception("Can not use string source to set binary data. Use SetBinaryValue() and GetBinaryValue() functions instead.");

                    else
                        throw new Exception("Unrecognized data type: " ~ to!string(ocolType));

                }

            }

 

        /// <summary>
        /// Set string data to a column, if the string is longer than specified column length it will be truncated!
        /// If dbf column type is not a string, input will be treated as dbf column 
        /// type and if longer than length an exception will be thrown.
        /// </summary>
        /// <param name="nColName"></param>
        /// <returns></returns>
        public string get(string nColName)
            {
                if (_colNameToIdx.ContainsKey(nColName))
                    return get(_colNameToIdx[nColName]);
                     throw new Exception(format("There's no column with name '%s'", nColName));
                
            }

        public void set(string nColName,string value)
            {
                if (_colNameToIdx.ContainsKey(nColName))
                   set( _colNameToIdx[nColName] , value);
                else
                    throw new Exception(format("There's no column with name '%s'", nColName));
            }
       

        /// <summary>
        /// Get date value.
        /// </summary>
        /// <param name="nColIndex"></param>
        /// <returns></returns>
        public DateTime GetDateValue(int nColIndex)
        {
            DbfColumn ocol = _header[nColIndex];

            if (ocol.ColumnType == DbfColumn.DbfColumnType.Date)
            {
                string sDateVal = encoding.GetString(_data, ocol.DataAddress, ocol.Length);
                return DateTime.ParseExact(sDateVal, "yyyyMMdd", CultureInfo.InvariantCulture);

            }
            else
                throw new Exception("Invalid data type. Column '" + ocol.Name + "' is not a date column.");

        }


        /// <summary>
        /// Get date value.
        /// </summary>
        /// <param name="nColIndex"></param>
        /// <returns></returns>
        public void SetDateValue(int nColIndex, DateTime value)
        {

            DbfColumn ocol = _header[nColIndex];
            DbfColumn.DbfColumnType ocolType = ocol.ColumnType;


            if (ocolType == DbfColumn.DbfColumnType.Date)
            {

                //Format date and set value, date format is like this: yyyyMMdd
                //-------------------------------------------------------------
                encoding.GetBytes(value.ToString("yyyyMMdd"), 0, ocol.Length, _data, ocol.DataAddress);

            }
            else
                throw new Exception("Invalid data type. Column is of '" + ocol.ColumnType.ToString() + "' type, not date.");


        }


        /// <summary>
        /// Clears all data in the record.
        /// </summary>
        public void Clear()
        {
            Buffer.BlockCopy(_emptyRecord, 0, _data, 0, _emptyRecord.Length);
            _recordIndex = -1;

        }


        /// <summary>
        /// returns a string representation of this record.
        /// </summary>
        /// <returns></returns>
        public override string toString()
        {
            return new string(encoding.encode(_data));
        }


        /// <summary>
        /// Gets/sets a zero based record index. This information is not directly stored in DBF. 
        /// It is the location of this record within the DBF. 
        /// </summary>
        /// <remarks>
        /// This property is managed from outside this object,
        /// CDbfFile object updates it when records are read. The reason we don't set it in the Read() 
        /// function within this object is that the stream can be forward-only so the Position property 
        /// is not available and there is no way to figure out what index the record was unless you 
        /// count how many records were read, and that's exactly what CDbfFile does.
        /// </remarks>
        @property long RecordIndex()
        {
                return _recordIndex;
            }
           @property void RecordIndex(long value)
            {
                _recordIndex = value;
            }
        


        /// <summary>
        /// Returns/sets flag indicating whether this record was tagged deleted. 
        /// </summary>
        /// <remarks>Use CDbf4File.Compress() function to rewrite dbf removing records flagged as deleted.</remarks>
        /// <seealso cref="CDbf4File.Compress() function"/>
        @property bool IsDeleted()
                     {
                          return _data[0] == '*'; 
                          }
                             @property void IsDeleted(bool value)
             { 
                 _data[0] = value ? cast(byte)'*' : cast(byte)' '; 
             }
      

        /// <summary>
        /// Specifies whether strings can be truncated. If false and string is longer than can fit in the field, an exception is thrown.
        /// Default is True.
        /// </summary>
        @property bool AllowStringTurncate()
                    { return _allowStringTruncate; }
            @property void AllowStringTurncate(bool value)
             { _allowStringTruncate = value; }
       

        /// <summary>
        /// Specifies whether to allow the decimal portion of numbers to be truncated. 
        /// If false and decimal digits overflow the field, an exception is thrown. Default is false.
        /// </summary>
        @property bool AllowDecimalTruncate()
             { return _allowDecimalTruncate; }
            @property void AllowDecimalTruncate(bool value)
             { _allowDecimalTruncate = value; }
        

        /// <summary>
        /// Specifies whether integer portion of numbers can be truncated.
        /// If false and integer digits overflow the field, an exception is thrown. 
        /// Default is False.
        /// </summary>
        @property bool AllowIntegerTruncate()
       
             { return _allowIntegerTruncate; }
               @property void AllowIntegerTruncate(bool value)
           { _allowIntegerTruncate = value; }
       


        /// <summary>
        /// Returns header object associated with this record.
        /// </summary>
        public @property DbfHeader Header()
        {
                return _header;
        }


        /// <summary>
        /// Get column by index.
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public DbfColumn Column(int index)
        {
            return _header[index];
        }

        /// <summary>
        /// Get column by name.
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public DbfColumn Column(string sName)
        {
            return _header[sName];
        }

        /// <summary>
        /// Gets column count from header.
        /// </summary>
        @property int ColumnCount()
        {
                return _header.ColumnCount;
        }

        /// <summary>
        /// Finds a column index by searching sequentially through the list. Case is ignored. Returns -1 if not found.
        /// </summary>
        /// <param name="sName">Column name.</param>
        /// <returns>Column index (0 based) or -1 if not found.</returns>
        public int FindColumn(string sName)
        {
            return _header.FindColumn(sName);
        }

        /// <summary>
        /// Writes data to stream. Make sure stream is positioned correctly because we simply write out the data to it.
        /// </summary>
        /// <param name="osw"></param>
        public  void Write(File osw)
        {
           // osw.Write(_data, 0, _data.Length);
           osw.rawWrite(_data);

        }


        /// <summary>
        /// Writes data to stream. Make sure stream is positioned correctly because we simply write out data to it, and clear the record.
        /// </summary>
        /// <param name="osw"></param>
        public  void Write(File obw, bool bClearRecordAfterWrite)
        {
           // obw.Write(_data, 0, _data.Length);
            osw.rawWrite(_data);
            if (bClearRecordAfterWrite)
                Clear();

        }


        /// <summary>
        /// Read record from stream. Returns true if record read completely, otherwise returns false.
        /// </summary>
        /// <param name="obr"></param>
        /// <returns></returns>
        public  bool Read(File obr)
        {
           // return obr.Read(_data, 0, _data.Length) >= _data.Length;
           _data = obr.byChunk(_data.Length);
           return  _data >= _data.Length;
        }

        public  string ReadValue(File obr, int colIndex)
        {
            DbfColumn ocol = _header[colIndex];
            return new string(encoding.GetChars(_data, ocol.DataAddress, ocol.Length));
        }

    }

