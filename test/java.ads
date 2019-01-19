package Java is
   pragma Pure;

   -- subtype boolean is Boolean;
   type byte is range -128 .. 127;
   type short is range -32768 .. 32767;
   type int is range -2147483648 .. 2147483647;
   type long is range -9223372036854775808 .. 9223372036854775807;
   subtype char is Wide_Character;
   -- subtype float is Float;
   subtype double is Long_Float;

   BS : constant char := char'Val (8);
   HT : constant char := char'Val (9);
   LF : constant char := char'Val (10);
   FF : constant char := char'Val (12);
   CR : constant char := char'Val (13);
end Java;
