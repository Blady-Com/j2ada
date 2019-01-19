--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : ImportMgr.ads
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

with BasicDef; use BasicDef;
with Ada.Containers.Doubly_Linked_Lists;

package ImportMgr is

   -- Objet assurant la gestion des unités importées
   type TImportUnit is tagged private;
   type PImportUnit is access TImportUnit;

   -- Positionne le chemin de la bibliothèque Java en Ada
   procedure SetAPILocation (O : in out TImportUnit; JavaAPILocation : TText);
   -- Ajout une unité externe
   procedure Add (O : in out TImportUnit; Unit : TText);
   -- Ajout d'une série d'unités externes
   procedure AddAll (O : in out TImportUnit; Unit : TText);
   -- Recherche d'une classe
   function Search (O : TImportUnit; Class : TText) return Boolean;
   -- Renvoie la dernière classe trouvée
   function GetLast (O : TImportUnit) return TText;

private
   package DirectoryLists is new Ada.Containers.Doubly_Linked_Lists (TText);
   type TClass is record
      PackageName : TText := NullTText;
      ClassName   : TText := NullTText;
   end record;
   package ClassLists is new Ada.Containers.Doubly_Linked_Lists (TClass);

   type TImportUnit is tagged record
      Directories : DirectoryLists.List;
      Classes     : ClassLists.List;
      APIPath     : TText := +".";
   end record;

end ImportMgr;
