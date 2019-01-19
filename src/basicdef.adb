-------------------------------------------------------------------------------
---
-- NOM DU CSU (corps)               : BasicDef.adb
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.1a
-- DATE DE LA DERNIERE MISE A JOUR  : 18 octobre 2008
-- ROLE DU CSU                      : Unité de définition de types et procédures.
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

with Ada.Calendar;             use Ada.Calendar;
with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Directories;          use Ada.Directories;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;
with Ada.Characters.Handling;  use Ada.Characters.Handling;

package body BasicDef is

   -- Fonction qui, à partir du chemin complet d'un fichier, retourne le nom du fichier seul.
   function FSplitName (WithPath : TText) return TText is
   begin
      return To_Unbounded_String (To_Lower (Simple_Name (To_String (WithPath))));
   end FSplitName;

   --Renvoie le compteur horaire interne en milisecondes.
   function HorlogeMS return Natural is
   begin
      return Natural (Seconds (Clock) * 1000.0);
   end HorlogeMS;

   procedure Get_Line (Item : out TText) is
   begin
      Get_Line (Unbounded_String (Item));
   end Get_Line;

   procedure Put_Line (Item : TText) is
   begin
      Put_Line (Unbounded_String (Item));
   end Put_Line;

   -- Fonction retournant une chaîne sans le dernier élément séparé par un point
   function TruncLast (S : TText) return TText is
   begin
      return Head (S, Index (S, ".", Ada.Strings.Backward) - 1);
   end TruncLast;

   -- Renvoie la chaîne en minuscule.
   function LowStr (S : TText) return TText is
   begin
      return To_Unbounded_String (To_Lower (To_String (S)));
   end LowStr;

end BasicDef;
