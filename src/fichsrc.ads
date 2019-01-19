--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : FichSrc.ads
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.0a
-- DATE DE LA DERNIERE MISE A JOUR  : 18 août 2008
-- ROLE DU CSU                      : Unité de gestion de la lecture du source.
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

with Ada.Direct_IO;
with BasicDef; use BasicDef;

package FichSrc is

   -- Objet assurant la gestion du fichier source.
   type TSourceMgr is tagged limited private;

   procedure Open (Object : in out TSourceMgr; Name : TText);
   procedure Read (Object : in out TSourceMgr; Ch1, Ch2 : out Character);
   procedure Status (Object : TSourceMgr; Name : out TText; Ligne : out Natural);
   procedure Close (Object : in out TSourceMgr);

private

   package SrcFile is new Ada.Direct_IO (Character);

   subtype Ttextbuff is TText;

   -- Objet assurant la gestion du fichier source.
   type TSourceMgr is tagged limited record
      FName            : TText;
      FRef             : SrcFile.File_Type;
      FLen             : SrcFile.Count;
      CptCar, CptLigne : Natural;
      TextBuff         : Ttextbuff;
      ChTemp           : Character;
   end record;

end FichSrc;
