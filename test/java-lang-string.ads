with Ada.Strings.Wide_Unbounded; use Ada.Strings.Wide_Unbounded;
package Java.Lang.String is
   pragma Preelaborate;

   type Typ;
   type Ref is access all Typ'Class;
   type Typ is tagged null record;

   type String_Access is access all Standard.String;
   function "+" (S : Ref) return String_Access;
   -- function "+" (S : Standard.String) return Ref;
   function "+" (S : Standard.Wide_String) return Ref;
   function WS2JS (S : Standard.Wide_String) return Ref;
   function "+" (S1, S2 : Ref) return Ref;
   function "+" (S1 : Standard.Wide_String; S2 : Ref) return Ref;
   function "+" (S1 : Ref; S2 : Standard.Wide_String) return Ref;
   function "+" (S1 : Standard.String; S2 : Ref) return Ref;
   function "+" (S1 : Ref; S2 : Standard.String) return Ref;

end Java.Lang.String;
