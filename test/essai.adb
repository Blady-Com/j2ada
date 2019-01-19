package body essai is
package body Point is
function New_Point(aThis : Ref := null) return Ref is
  This : Ref := aThis;
begin
if This = null then
  This := new Typ;
end if;
System . out_K . println(  WS2JS("default"));
return This;
end;
function New_Point(x : int; y : int; aThis : Ref := null) return Ref is
  This : Ref := aThis;
begin
if This = null then
  This := new Typ;
end if;
 this . x := x;
 this . y := y;
return This;
end;
function toString(This : access Typ) return java.lang.string.Ref is
begin
return  WS2JS("(") + x +  WS2JS(",") + y +  WS2JS(")");
end;
end Point;
package body Point2 is
function setX(This : access Typ; x : int) return int is
begin
-- x is a method parameter
--  Help J2Ada : put it before begin
oldx : int :=  this . x;
-- oldx is a local variable
 this . x := x;
return oldx;
end;
end Point2;
package body Colorable is
procedure setColor(This : access Typ; r : byte; g : byte; b : byte);
end Colorable;
package body Point3 is
end Point3;
package body ColoredPoint is
procedure setColor(This : access Typ; rv : byte; gv : byte; bv : byte) is
begin
r := rv;
g := gv;
b := bv;
end;
end ColoredPoint;
package body Test is
procedure main(This : access Typ; args : java.lang.string.Ref) is
begin
--  Help J2Ada : put it before begin
p : Point3.Ref := Point3.New_Point3;
--  Help J2Ada : put it before begin
cp : ColoredPoint.Ref := ColoredPoint.New_ColoredPoint;
p := cp;
--  Help J2Ada : put it before begin
c : Colorable.Ref :=  cp;
end;
end Test;
package body Point4 is
procedure move(This : access Typ; dx : int; dy : int) is
begin
x := dx;
y := dy;
alert;
end;
procedure alert(This : access Typ);
end Point4;
package body ColoredPoint4 is
end ColoredPoint4;
package body SimplePoint is
procedure alert(This : access Typ) is
begin
y := 0;
end;
end SimplePoint;
package body HasStatic is
end HasStatic;
package body Inner is
end Inner;
package body NestedButNotInner is
end NestedButNotInner;
package body NeverInner is
end NeverInner;
function init_essai(This : access Typ; aa : boolean) return int is
begin
origin2 . numPoints := 99;
-- var locale
--  Help J2Ada : put it before begin
val : int :=  99;
--  Help J2Ada : put it before begin
type j2a_f is array (Natural range <>, Natural range <>, Natural range <>, Natural range <>) of float;
f : access j2a_f;
type j2a_g is array (Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>) of float;
g : access j2a_g;
type j2a_h is array (Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>, Natural range <>) of float;
h : access j2a_h;
-- Yechh!
--  Help J2Ada : put it before begin
a : int;
type j2a_b is array (Natural range <>) of int;
b : access j2a_b;
type j2a_c is array (Natural range <>, Natural range <>, Natural range <>) of int;
c : access j2a_c;
--  Help J2Ada : put it before begin
two : int :=  2;
--  Help J2Ada : put it before begin
three : int :=  two + 1;
--  Help J2Ada : put it before begin
RE : RuntimeException.Ref := RuntimeException.New_RuntimeException;
-- vide
null;
-- label
--L0 : val = val * 3;
--Assignment 
--PreIncrementExpression 
--PreDecrementExpression 
--PostIncrementExpression 
--PostDecrementExpression 
--MethodInvocation 
--ClassInstanceCreationExpression 
-- if
if ( val = 0)then
val := val * 2;
end if;
if ( val /= 23)then
val := val * 3;
else
val := val * 3;
end if;
-- assert
pragma Assert (( val = 4) and then aa);
--assert Expression1 : Expression2 ;
-- switch
case ( val) is
when  0 => val := val * 3;
when  3 => val := val * 3;
when  5 => val := val * 3;
when others
 => val := val * 3;
end case;
-- while
while ( val > 5)
loop
val := val * 3;
end loop;
-- do
loop
val := val * 3;
exit when ( val > 5);
end loop;
-- for
declare
--  Help J2Ada : put it before begin
i : int :=  0;
begin
while ( i < 10)
loop
val := val * 3;
 i := i + 1;
end loop;
end;
-- break
--break Identifieropt ;
-- continue
--continue Identifieropt ;
-- throw
if ( val = 0)then
 RE;
-- synchronized
--synchronized ( Expression ) Block
end if;
declare
begin
val := val * 3;
exception
when RuntimeException:r =>
val := val * 30;
end;
val := val * 39;
-- return
return val;
end;
end essai;
