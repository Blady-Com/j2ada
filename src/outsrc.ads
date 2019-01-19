--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : OutSrc.ads
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.1a
-- DATE DE LA DERNIERE MISE A JOUR  : 8 septembre 2008
-- ROLE DU CSU                      : Unité de gestion du package résultat.
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

with Ada.Text_IO; use Ada.Text_IO;
with BasicDef;    use BasicDef;

package OutSrc is

   -- Objet assurant l'écriture du package Ada
   type TTextListMgr is tagged private;
   type PTextListMgr is access TTextListMgr;

   procedure Add (Object : access TTextListMgr; S : TText);
   procedure Add (Object : access TTextListMgr; S : String);
   procedure Add (Object : access TTextListMgr; C : Character);
   procedure AddNew (Object : access TTextListMgr; S : TText := NullTText);
   procedure AddNew (Object : access TTextListMgr; S : String);
   procedure AddNew (Object : access TTextListMgr; C : Character);
   procedure WriteToFile (Object : access TTextListMgr; F : File_Type);
   procedure Copy (From : access TTextListMgr; To : access TTextListMgr'Class);
   procedure Depile (Object : access TTextListMgr; S : out TText);
   procedure Depile (Object : access TTextListMgr);
   function Current (Object : access TTextListMgr) return TText;
   function Vide (Object : access TTextListMgr) return Boolean;
   procedure Done (Object : access TTextListMgr);

   -- Objet assurant l'écriture d'énumérés
   type TEnumListMgr is new TTextListMgr with private;
   type PEnumListMgr is access TEnumListMgr;

   -- Ajoute un élément s'il ne l'a pas déjà été
   procedure AddUniq (Object : access TEnumListMgr; S : TText);
   -- Ecrit le type des énumérés dans le fichier F
   procedure TWriteToFile (Object : access TEnumListMgr; F : File_Type);

   -- Objet assurant l'écriture des déclarations de variables
   type TVarListMgr is new TTextListMgr with private;
   type PVarListMgr is access TVarListMgr;

   -- Copie une déclaration de variables
   procedure CopyVar (From : access TVarListMgr; To : PTextListMgr);

   -- Copie une déclaration de paramètres
   procedure CopyPara (From : access TVarListMgr; To : PTextListMgr);

   -- Copie une déclaration de classes
   procedure CopyClass (From : access TVarListMgr; To : PTextListMgr);

private

   type TTextList;
   type PTextList is access TTextList;
   -- Ligne de texte du package Ada
   type TTextList is record
      Prev, Next : PTextList := null;
      Text       : TText     := NullTText;
   end record;

   -- Objet assurant l'écriture du package Ada
   type TTextListMgr is tagged record
      FirstElt, CurElt : PTextList := null;
      CurStr           : TText     := NullTText;
   end record;

   -- Objet assurant l'écriture d'énumérés
   type TEnumListMgr is new TTextListMgr with null record;

   -- Objet assurant l'écriture des déclarations de variables
   type TVarListMgr is new TTextListMgr with null record;
end OutSrc;
