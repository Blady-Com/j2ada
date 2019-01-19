with Java, java.lang.string;
use  Java, java.lang.string;
-- La plupart des examples sont adaptées du livre
-- "The JavaTM Language Specification Third Edition"
-- James Gosling, Bill Joy, Guy Steele and Gilad Bracha.
package essai is
dum : int :=  16#ABCD#;
dum1 : int :=  8#12#;
-- erreur 98;
dum3 : long :=  1234;
dum4 : long :=  0;
dum5 : long :=  8#0#;
dum6 : int :=  16#0#;
dum7 : int :=  16#DadaCafe#;
dum8 : long :=  16#C0B0#;
dum13 : float :=  1.0e1;
dum14 : float :=  2.0;
dum15 : float :=  0.3;
dum16 : float :=  0.0;
dum17 : float :=  3.14;
dum18 : float :=  6.022137e+23;
dum20 : double :=  3.0E4;
dum21 : double :=  1.0e12;
dum22 : double :=  0.30;
dum24 : double :=  30.0;
dum25 : double :=  30;
dum26 : double :=  30.0;
dum27 : double :=  3.141e-9;
dum28 : double :=  1.0e137;
dum30 : char :=  ' ';
dum31 : char :=  '%';
dum32 : char :=  Java.Ht;
dum33 : char :=  '\';
dum34 : char :=  ''';
dum35 : char :=  Wide_Character'Val(16#30a9#);
dum36 : char :=  Wide_Character'Val(8#177#);
dum37 : char :=  'v';
f : constant int :=  3;
dum41 : java.lang.string.Ref :=   WS2JS("");
-- the empty string
dum42 : java.lang.string.Ref :=   WS2JS("""");
-- a string containing " alone
dum43 : java.lang.string.Ref :=   WS2JS("This is a string");
-- a string containing 16 characters
dum44 : java.lang.string.Ref :=   WS2JS("This is a " & Wide_Character'Val(16#30a9#) & "" & Wide_Character'Val(8#177#) & "" & Java.Ht & "'");
-- actually a string-valued constant expression,
type j2a_ai is array (Natural range <>) of int;
ai : access j2a_ai;
-- array of int
type j2a_ai2 is array (Natural range <>) of int;
ai2 : access j2a_ai2;
type j2a_ai3 is array (Natural range <>) of int;
ai3 : access j2a_ai3;
-- array of int and scalar
type j2a_as is array (Natural range <>, Natural range <>) of short;
as : access j2a_as;
-- array of array of short
type j2a_ao is array (Natural range <>) of char;
ao : access j2a_ao;
-- array of char
type j2a_otherAo is array (Natural range <>) of char;
otherAo : access j2a_otherAo;
-- array of char
--Collection<?>[] ca;   // array of Collection of unknown type
s : short;
-- scalar short
type j2a_aas is array (Natural range <>, Natural range <>) of short;
aas : access j2a_aas;
-- array of array of short
type j2a_ae is array (Natural range <>) of long;
ae : access j2a_ae := new j2a_ae(0.. 3-1);
type j2a_aao is array (Natural range <>, Natural range <>) of long;
aao : access j2a_aao := new j2a_aao(0.. 2-1, 0.. 3-1);
type j2a_factorial is array (Natural range <>) of int;
factorial : constant access j2a_factorial := new j2a_factorial'( 1 , 1 , 2 , 6 , 24 , 120 , 720 , 5040);
type j2a_ac is array (Natural range <>) of char;
ac : access j2a_ac := new j2a_ac'( 'n' , 'o' , 't' , ' ' , 'a' , ' ' , 'S' , 't' , 'r' , 'i' , 'n' , 'g');
type j2a_aas2 is array (Natural range <>) of java.lang.string.Ref;
aas2 : access j2a_aas2 := new j2a_aas2'(  WS2JS("array") ,  WS2JS("of") ,  WS2JS("String"));
type j2a_rowvector is array (Natural range <>) of byte;
rowvector : access j2a_rowvector;
type j2a_colvector is array (Natural range <>) of byte;
colvector : access j2a_colvector;
type j2a_matrix is array (Natural range <>, Natural range <>) of byte;
matrix : access j2a_matrix;
--This declaration is equivalent to:
type j2a_rowvector1 is array (Natural range <>) of byte;
rowvector1 : access j2a_rowvector1;
type j2a_colvector1 is array (Natural range <>, Natural range <>) of byte;
colvector1 : access j2a_colvector1;
type j2a_matrix1 is array (Natural range <>, Natural range <>, Natural range <>, Natural range <>) of byte;
matrix1 : access j2a_matrix1;
package Point is
type Typ;
type Ref is access all Typ;
type Typ is tagged record
x : int;
y : int;
end record;
function New_Point(aThis : Ref := null) return Ref;
function New_Point(x : int; y : int; aThis : Ref := null) return Ref;
-- A String can be implicitly created by a + operator:
function toString(This : access Typ) return java.lang.string.Ref;
end Point;
-- A Point instance is explicitly created at class initialization time:
package Point2 is
-- x and y are instance variables
type j2a_w is array (Natural range <>) of int;
-- w[0] is an array component
type Typ;
type Ref is access all Typ;
type Typ is tagged record
numPoints : int;
x : int;
y : int;
w : access j2a_w := new j2a_w(0.. 10-1);
end record;
function setX(This : access Typ; x : int) return int;
end Point2;
-- A Point instance is explicitly created at class initialization time:
package Colorable is
type Typ;
type Ref is access all Typ;
type Typ is interface;
procedure setColor(This : access Typ; r : byte; g : byte; b : byte) is abstract;
end Colorable;
package Point3 is
type Typ;
type Ref is access all Typ;
type Typ is tagged record
x : int;
y : int;
end record;
end Point3;
package ColoredPoint is
type Typ;
type Ref is access all Typ;
type Typ is new Point3.Typ and Colorable.Typ with record
r : byte;
g : byte;
b : byte;
end record;
procedure setColor(This : access Typ; rv : byte; gv : byte; bv : byte);
end ColoredPoint;
package Test is
type Typ;
type Ref is access all Typ;
type Typ is tagged null record;
procedure main(This : access Typ; args : java.lang.string.Ref);
end Test;
package Point4 is
type Typ;
type Ref is access all Typ;
type Typ is abstract tagged record
x : int :=  1;
y : int :=  1;
end record;
procedure move(This : access Typ; dx : int; dy : int);
procedure alert(This : access Typ) is abstract;
end Point4;
package ColoredPoint4 is
type Typ;
type Ref is access all Typ;
type Typ is new Point4.Typ with record
color : int;
end record;
end ColoredPoint4;
package SimplePoint is
type Typ;
type Ref is access all Typ;
type Typ is new Point4.Typ with null record;
procedure alert(This : access Typ);
end SimplePoint;
package HasStatic is
j : constant int :=  100;
type Typ;
type Ref is access all Typ;
type Typ is tagged null record;
end HasStatic;
package Inner is
x : constant int :=  3;
-- ok - compile-time constant
type Typ;
type Ref is access all Typ;
type Typ is new HasStatic.Typ with null record;
end Inner;
package NestedButNotInner is
z : int :=  5;
-- ok, not an inner class
type Typ;
type Ref is access all Typ;
type Typ is tagged null record;
end NestedButNotInner;
package NeverInner is
type Typ;
type Ref is access all Typ;
type Typ is interface;
end NeverInner;
-- interfaces are never inner
type Typ;
type Ref is access all Typ;
type Typ is tagged record
origin : Point.Ref := Point.New_Point( 0 , 0);
origin2 : Point2.Ref := Point2.New_Point2;
end record;
function init_essai(This : access Typ; aa : boolean) return int;
end essai;
