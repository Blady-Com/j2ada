# J2Ada

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/j2ada.json)](https://alire.ada.dev/crates/j2ada.html)

## Introduction
J2Ada translates a Java valid source code in Ada source code.
In this first version, a large part of Java syntax is translated.
But, up to now, both specification and body parts of the generated Ada code
become valid with few manual modifcations.

## Creation of translation program
### Source codes of J2Ada program
- arbmgr.adb
- arbmgr.ads
- basicdef.adb
- basicdef.ads
- fichsrc.adb
- fichsrc.ads
- importmgr.adb
- importmgr.ads
- insrc.adb
- insrc.ads
- j2ada.adb
- javaseq.adb
- javaseq.ads
- javaseq.auto
- javaseq.in
- objpar.ads
- objsrc.adb
- objsrc.ads
- outsrc.adb
- outsrc.ads

(From [J2Ada on GitHub](https://github.com/Blady-Com/j2ada)).

### Creation of the sequencer of Java interpretation
The sequencer unit in Ada is already created: javaseq.adb and javaseq.ads.
If necessary the sequencer may be modified in the file javaseq.auto
containing Java syntax and regenerated with the Automate sequencer compiler.

Download the sequencer compiler from [Automate on GiHub](https://github.com/Blady-Com/Automate).

Compile the program genauto then use it to generate the Ada units:

```
$ gnatmake genauto
$ ./genauto <javaseq.in
```

### Compilation of J2Ada translator

`$ gnatmake j2ada`

## Usage
The programs have been compiled and tested with GNAT GPL 2008 on Mac OS X 10.4.
Translation example of essai.java in essai.adb and essai.ads:

```
$ ./j2ada
Entrer les informations suivantes :

Nom du fichier source : essai.java
Lecture de essai.java ...
Temps passé :  108 millisecondes.
Nom de l'unité Ada : (essai.ads) : 
Nom de l'unité Ada : (essai.adb) : 
$ gnatmake -gnatc essai.adb
gcc -c -gnatc essai.adb
essai.adb:32:01: declarations must come before "begin"
essai.adb:55:01: declarations must come before "begin"
essai.adb:93:01: declarations must come before "begin"
essai.adb:96:04: loop or block statement must follow label
essai.adb:98:04: loop or block statement must follow label
essai.adb:100:04: loop or block statement must follow label
essai.adb:105:04: loop or block statement must follow label
essai.adb:107:04: loop or block statement must follow label
gnatmake: "essai.adb" compilation error
```

The residual first errors are inherent of object declarations mixed
with Java Code. A comment `--  Help J2Ada : put it before begin` has been
added to do the right modification.
The source code essai.ads uses Java libraries provided from
those of JGNAT (see also on Blady):
- Java-lang-string.ads
- Java-lang.ads
- java.ads

The display at each stage of the translation is activated by positioning at True
the Debug constant in j2ada.adb.

## Copyright and license of J2Ada source codes
All files are provided under terms of:

    (c) Pascal Pignard 2008-2010 (http://blady.pagesperso-orange.fr)
    CeCILL V2 (http://www.cecill.info)

See also attachments: Licence_CeCILL_V2-en.txt and Licence_CeCILL_V2-fr.txt.

## Using Alire

In your working folder, do:

```
% alr get j2ada
% cd j2ada_*
% alr run
```

## History
- 1.4b :
Add of importmgr.adb and importmgr.ads badly forgotten.
- 1.4a:
Management of empty parenthesis when a call is made without parameters.
Support of throws instruction and recursive reference in objects declaration.
Modification of static initializers, statements try, import and for.
- 1.3a:
Translation of Java control statements (assert, switch, for).
- 1.2a:
Translation of Java class into Ada package and object type.
Support of Java API.
- 1.1a:
Translation of simple classes is added.
- 1.0a:
First version for a demonstration of the translator.

Pascal Pignard, August-December 2008, April 2010.

