--------------------------------------------------------------------------------
-- NOM DU CSU (corps)               : ImportMgr.adb
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.0a
-- DATE DE LA DERNIERE MISE A JOUR  : 8 octobre 2008
-- ROLE DU CSU                      : Unité de gestion des unités importées.
--
--
-- FONCTIONS EXPORTEES DU CSU       :
--
--
-- FONCTIONS LOCALES DU CSU         :
--
--
-- NOTES                            :
--
-- COPYRIGHT                        : (c) Pascal Pignard 2008
-- LICENCE                          : CeCILL V2 (http://www.cecill.info)
-- CONTACT                          : http://blady.pagesperso-orange.fr
--------------------------------------------------------------------------------

with Ada.Directories;  use Ada.Directories;
with Ada.Strings;
with Ada.Strings.Maps;
--with text_io; use text_io;
package body ImportMgr is

   LastFoundClass : TText := NullTText;

   procedure SetAPILocation (O : in out TImportUnit; JavaAPILocation : TText) is
   begin
      O.APIPath := JavaAPILocation;
   end SetAPILocation;

   procedure Add (O : in out TImportUnit; Unit : TText) is
      -- java-lang-reflect-method.ads
      PackageName : constant TText :=
         Translate
           (Head (Unit, Index (Unit, "-", Ada.Strings.Backward) - 1),
            Ada.Strings.Maps.To_Mapping ("-", "."));
      ClassName   : constant TText :=
         Unbounded_Slice
           (Unit,
            Index (Unit, "-", Ada.Strings.Backward) + 1,
            Index (Unit, ".", Ada.Strings.Backward) - 1);
   begin
      --Put_line(to_string(PackageName));
      --Put_line(to_string(ClassName));
      O.Classes.Append ((PackageName, ClassName));
   end Add;

   procedure AddAll (O : in out TImportUnit; Unit : TText) is
      -- java.io.*
      ST : Search_Type;
      --Path : constant String := "../java-API-1.0";
      Pattern         : constant String      :=
         To_String (Translate (Unit, Ada.Strings.Maps.To_Mapping (".", "-"))) & ".ads";
      Filter          : constant Filter_Type :=
        (Directory     => False,
         Ordinary_File => True,
         Special_File  => False);
      Directory_Entry : Directory_Entry_Type;
   begin
      Start_Search (ST, To_String (O.APIPath), Pattern, Filter);
      while More_Entries (ST) loop
         Get_Next_Entry (ST, Directory_Entry);
         --Put_Line (Simple_Name (Directory_Entry));
         O.Add (+Simple_Name (Directory_Entry));
      end loop;
      End_Search (ST);
   end AddAll;

   function Search (O : TImportUnit; Class : TText) return Boolean is
      LowerClass : constant TText := LowStr (Class);
      Found      : Boolean        := False;
      procedure Iterator (Pos : in ClassLists.Cursor) is
         E : constant TClass := ClassLists.Element (Pos);
      begin
         if E.ClassName = LowerClass then
            Found          := True;
            LastFoundClass := E.PackageName & '.' & E.ClassName;
         end if;
      end Iterator;
   begin
      O.Classes.Iterate (Iterator'Access);
      return Found;
   end Search;

   function GetLast (O : TImportUnit) return TText is
   begin
      return LastFoundClass;
   end GetLast;

end ImportMgr;
