﻿using System;
using System.Data.SqlTypes;
using System.Linq;
using static System.BitConverter;

namespace Microsoft.Data.Encryption.Cryptography.Serializers
{
    /// <inheritdoc/>
    public sealed class SqlDecimalSerializer : Serializer<decimal>
    {
        private const int SignIndex = 3;
        private const int MaxPrecision = 38;
        private const int MinPrecision = 1;
        private const int DefaultPrecision = 18;
        private const int MinScale = 0;
        private const int DefaultScale = 0;
        private static readonly byte[] positiveSign = { 1 };
        private static readonly byte[] negativeSign = { 0 };
        private static readonly byte[] padding = { 0, 0, 0, 0 };

        /// <inheritdoc/>
        public override string Identifier => "SQL_Decimal";

        private int precision;

        /// <summary>
        /// Gets or sets the maximum number of digits used to represent the value. The default precision is 18.
        /// </summary>
        /// <remarks>
        /// The <see cref="Precision"/> represents the maximum total number of decimal digits to be stored. 
        /// This number includes both the left and the right sides of the decimal point. 
        /// The precision must be a value from 1 through the maximum precision of 38.
        /// </remarks>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Thrown when set to a value that is out of the valid range [1 - 38] for this setting.
        /// </exception>
        public int Precision
        {
            get => precision;
            set
            {
                if (value < MinPrecision || value > MaxPrecision)
                {
                    throw new ArgumentOutOfRangeException($"Parameter value {value} is out of range");
                }

                precision = value;
            }
        }

        private int scale;

        /// <summary>
        /// Gets or sets the number of decimal places to which Value is resolved.
        /// </summary>
        /// <remarks>
        /// The number of decimal digits that are stored to the right of the decimal point. This number is subtracted from the <see cref="Precision"/>
        /// to determine the maximum number of digits to the left of the decimal point. <see cref="Scale"/> must be a value from 0 through <see cref="Precision"/>. 
        /// The default scale is 0 and so 0 &#8804; <see cref="Scale"/> &#8804; <see cref="Precision"/>.
        /// </remarks>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Thrown when set to a value that is out of the valid range [0 - <see cref="Precision"/>] for this setting.
        /// </exception>
        public int Scale
        {
            get => scale;
            set
            {
                if (value < MinScale || value > Precision)
                {
                    throw new ArgumentOutOfRangeException($"Parameter value {value} is out of range");
                }

                scale = value;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SqlDecimalSerializer"/> class.
        /// </summary>
        /// <param name="precision">The maximum number of digits used to represent the value. The default precision is 18.</param>
        /// <param name="scale">The number of decimal places to which Value is resolved. The default scale is 0.</param>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Thrown when <paramref name="precision"/> is set to a value that is out of the valid range [1 - 38] or when <paramref name="scale"/> 
        /// is set to a value that is out of the valid range [0 -  <paramref name="precision"/>] for this setting.
        /// </exception>
        public SqlDecimalSerializer(int precision = DefaultPrecision, int scale = DefaultScale)
        {
            Precision = precision;
            Scale = scale;
        }

        /// <inheritdoc/>
        /// <exception cref="ArgumentNullException">
        /// Thrown when <paramref name="bytes"/> is null.
        /// </exception>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Thrown when the length of <paramref name="bytes"/> is less than 17.
        /// </exception>
        public override decimal Deserialize(byte[] bytes)
        {
            const int SizeOfDecimal = 17;

            bytes.ValidateNotNull(nameof(bytes));
            bytes.ValidateSize(SizeOfDecimal, nameof(bytes));

            int low = ToInt32(bytes.Skip(1).Take(4).ToArray(), 0);
            int middle = ToInt32(bytes.Skip(5).Take(4).ToArray(), 0);
            int high = ToInt32(bytes.Skip(9).Take(4).ToArray(), 0);
            bool isNegative = bytes[0] == negativeSign[0];

            return new decimal(low, middle, high, isNegative, (byte)Scale);
        }

        /// <inheritdoc/>
        /// <returns>
        /// An array of bytes with length 17.
        /// </returns>
        /// <exception cref="ArgumentOutOfRangeException">
        /// Thrown when the <paramref name="value"/> is out of range.
        /// </exception>
        public override byte[] Serialize(decimal value)
        {
            SqlDecimal sqlDecimal = new SqlDecimal(value);

            if (sqlDecimal.Precision > Precision)
            {
                throw new ArgumentOutOfRangeException($"Parameter value {value} is out of range");
            }

            int[] decimalBits = decimal.GetBits(value);
            byte[] sign = IsPositive(decimalBits[SignIndex]) ? positiveSign : negativeSign;
            byte[] integerPart = decimalBits.Take(3).SelectMany(GetBytes).ToArray();
            return sign.Concat(integerPart).Concat(padding).ToArray();
        }

        private bool IsPositive(int i) => i > -1;
    }
}
