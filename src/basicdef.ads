--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : BasicDef.ads
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

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package BasicDef is

   type TText is new Unbounded_String;
   NullTText : constant TText := TText (Null_Unbounded_String);
   function "+" (S : String) return TText renames To_Unbounded_String;

   procedure Get_Line (Item : out TText);

   procedure Put_Line (Item : TText);

   -- Fonction qui, à partir du chemin complet d'un fichier, retourne le nom du fichier seul.
   function FSplitName (WithPath : TText) return TText;

   --Renvoie le compteur horaire interne en milisecondes.
   function Horlogems return Natural;

   -- Fonction retournant une chaîne sans le dernier élément séparé par un point
   function TruncLast (S : TText) return TText;

   -- Renvoie la chaîne en minuscule.
   function LowStr (S : TText) return TText;

end BasicDef;
