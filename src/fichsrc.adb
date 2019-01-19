--------------------------------------------------------------------------------
-- NOM DU CSU (corps)               : FichSrc.adb
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

with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Characters.Latin_1;

package body FichSrc is

   -- Procédure donnant le nom et la ligne courante du fichier source.
   procedure Status (Object : TSourceMgr; Name : out TText; Ligne : out Natural) is
   begin
      Name  := FSplitName (Object.FName);
      Ligne := Object.CptLigne;
   end Status;

   procedure FileRead (F : SrcFile.File_Type; Buffer : out Ttextbuff; Len : SrcFile.Count) is
      Ch : Character;
   begin
      for Ind in 1 .. Len loop
         SrcFile.Read (F, Ch);
         Append (Buffer, Ch);
      end loop;
   exception
      when E : others =>
         Raise_Exception
           (Exception_Identity (E),
            "Erreur de lecture du fichier source : """ & SrcFile.Name (F) & """.");
   end FileRead;

   -- Procédure de lecture du contenu du fichier source.
   procedure Open (Object : in out TSourceMgr; Name : TText) is
   begin
      Object.FName    := Name;
      Object.CptCar   := 0;
      Object.CptLigne := 1;
      SrcFile.Open (Object.FRef, SrcFile.In_File, To_String (Name));
      Object.FLen := SrcFile.Size (Object.FRef);
      Put_Line ("Lecture de " & To_String (FSplitName (Name)) & " ...");
      FileRead (Object.FRef, Object.TextBuff, Object.FLen);
      SrcFile.Close (Object.FRef);
      Append (Object.TextBuff, Ada.Characters.Latin_1.EOT);
      Object.ChTemp := Element (Object.TextBuff, 1);
   exception
      when E : others =>
         Raise_Exception
           (Exception_Identity (E),
            "Erreur d'ouverture du fichier source """ & To_String (Name) & """.");
   end Open;

   -- Procédure de lecture d'un caractère du buffer contenant le texte source.
   -- Le caractère lu est dans Ch1, le suivant est dans Ch2.
   procedure Read (Object : in out TSourceMgr; Ch1, Ch2 : out Character) is
   begin
      Ch1           := Object.ChTemp;
      Object.CptCar := Object.CptCar + 1;
      if Object.ChTemp = Ada.Characters.Latin_1.LF then
         Object.CptLigne := Object.CptLigne + 1;
      end if;
      if Object.ChTemp /= Ada.Characters.Latin_1.EOT then
         Object.ChTemp := Element (Object.TextBuff, Integer'Succ (Object.CptCar));
      end if;
      Ch2 := Object.ChTemp;
   end Read;

   -- Procédure de destruction du buffer.
   procedure Close (Object : in out TSourceMgr) is
   begin
      Object.FName    := NullTText;
      Object.TextBuff := To_Unbounded_String ((1 => Ada.Characters.Latin_1.EOT));
   end Close;

end FichSrc;
