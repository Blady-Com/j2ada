// La plupart des examples sont adaptées du livre
// "The JavaTM Language Specification Third Edition"
// James Gosling, Bill Joy, Guy Steele and Gilad Bracha.

class essai {
  static int dum = 0XABCD;
  static int dum1 = 012; // erreur 98;
  static long dum3 = 1234L;
  static long dum4 = 0l;
  static long dum5 = 00l;
  static int dum6 = 0x0;
  static int dum7 = 0xDadaCafe;
  static long dum8 = 0xC0B0L;

  static float dum13 = 1e1f;
  static float dum14 = 2.f;
  static float dum15 = .3f;
  static float dum16 = 0f;
  static float dum17 = 3.14f;
  static float dum18 = 6.022137e+23f;

  static double dum20 = 03E4;
  static double dum21 = 1e12;
  static double dum22 = .30;
  static double dum24 = 30D;
  static double dum25 = 30;
  static double dum26 = 30.0;
  static double dum27 = 3.141e-9d;
  static double dum28 = 1e137;

  static char dum30 = ' ';
  static char dum31 = '%';
  static char dum32 = '\t';
  static char dum33 = '\\';
  static char dum34 = '\'';
  static char dum35 = '\u30a9';
  static char dum36 = '\177';
  static char dum37 = 'v';

  static final int f = 3;

  static String dum41 = ""; // the empty string
  static String dum42 = "\""; // a string containing " alone
  static String dum43 = "This is a string"; // a string containing 16 characters
  static String dum44 = "This is a \u30a9\177\t\'"; // actually a string-valued constant expression,

  static int[] ai; // array of int
  static int ai2[], ai3; // array of int and scalar
  static short[][] as; // array of array of short
  static char[] ao, // array of char
                otherAo; // array of char
  //Collection<?>[] ca;   // array of Collection of unknown type
  static short s, // scalar short
               aas[][]; // array of array of short

  static long ae[] = new long[3];
  static long aao[][] = new long[2][3];
  static final int[] factorial = { 1, 1, 2, 6, 24, 120, 720, 5040 };
  static char ac[] = { 'n', 'o', 't', ' ', 'a', ' ',
                       'S', 't', 'r', 'i', 'n', 'g' };
  static String[] aas2 = { "array", "of", "String" };
  static byte[] rowvector, colvector, matrix[];
  //This declaration is equivalent to:
  static byte rowvector1[], colvector1[], matrix1[][];

class Point {
int x, y;
Point() { System.out.println("default"); }
Point(int x, int y) { this.x = x; this.y = y; }
// A String can be implicitly created by a + operator:
public String toString() {
return "(" + x + "," + y + ")";
}
}
// A Point instance is explicitly created at class initialization time:
Point origin = new Point(0,0);

class Point2 {
int numPoints;
int x, y; // x and y are instance variables
int[] w = new int[10];// w[0] is an array component
int setX(int x) { // x is a method parameter
int oldx = this.x; // oldx is a local variable
this.x = x;
return oldx;
}
}
// A Point instance is explicitly created at class initialization time:
Point2 origin2 = new Point2();

public interface Colorable {
void setColor(byte r, byte g, byte b);
}
class Point3 { int x, y; }
class ColoredPoint extends Point3 implements Colorable {

byte r, g, b;
public void setColor(byte rv, byte gv, byte bv) {
r = rv; g = gv; b = bv;
}
}
class Test {
public void main(String args) {
Point3 p = new Point3();
ColoredPoint cp = new ColoredPoint();
p = cp;
Colorable c = cp;
}
}

abstract class Point4 {
int x = 1; int y = 1;
void move(int dx, int dy) {
x = dx;
y = dy;
alert();
}
abstract void alert();
}
abstract class ColoredPoint4 extends Point4 {
int color;
}

class SimplePoint extends Point4 {
void alert() {y=0; }
}

class HasStatic{
static final int j = 100;
}
class Inner extends HasStatic{
static final int x = 3;// ok - compile-time constant
}
static class NestedButNotInner{
static int z = 5; // ok, not an inner class
}
interface NeverInner{}// interfaces are never inner

int init_essai (boolean aa) {
origin2.numPoints = 99;
// var locale
int val = 99;
float[][] f[][], g[][][], h[];// Yechh!
int a, b[], c[][];
int two = 2;int three = two + 1;
RuntimeException RE = new RuntimeException();

// vide
;

// label
//L0 : val = val * 3;

/*Assignment 
PreIncrementExpression 
PreDecrementExpression 
PostIncrementExpression 
PostDecrementExpression 
MethodInvocation 
ClassInstanceCreationExpression */

// if
if (val == 0) val = val * 2;
if (val != 23)
  val = val * 3;
else
  val = val * 3;

// assert
assert (val == 4) && aa;
//assert Expression1 : Expression2 ;

// switch
switch (val) {
  case 0 : val = val * 3;
            break;
  case 3 : val = val * 3;
  case 5 : val = val * 3;
  default : val = val * 3;
}

// while
while (val > 5) val = val * 3;

// do
do val = val * 3; while (val > 5);

// for
for (int i = 0; i < 10; i=i+1) val = val * 3;

// break
//break Identifieropt ;

// continue
//continue Identifieropt ;

// throw
if (val == 0) throw RE ;

// synchronized
//synchronized ( Expression ) Block

try { 
val = val * 3; 
} catch (RuntimeException r) { 
val = val * 30; 
} finally { 
val = val * 39;} 

// return
return val;
}

}
