--------------------------------------------------------------------------------
-- NOM DU CSU (principal)           : J2Ada.adb
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.1a
-- DATE DE LA DERNIERE MISE A JOUR  : 18 octobre 2008
-- ROLE DU CSU                      : Programme de traduction automatique
--                                    du langage Java en Ada.
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

with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with BasicDef;         use BasicDef;
with ObjPar;           use ObjPar;
with InSrc;            use InSrc;
with javaseq;          use javaseq;

procedure J2Ada is

   Debug : constant Boolean := True;

   FName, UName, JavaAPILocation : TText;
   FObject                       : File_Type;
   Ok                            : Boolean;
   Time                          : Natural;

begin
   Put_Line ("Entrer les informations suivantes :");
   New_Line;

   Put ("Nom du fichier source : ");
   Get_Line (FName);

   Put ("Chemin de la bibiliothèque Java en Ada : ");
   Get_Line (JavaAPILocation);
   if JavaAPILocation = NullTText then
      JavaAPILocation := +".";
   end if;

   InitJavaAda (JavaAPILocation);
   Time := Horlogems;

   SrcAuto.Open (FName);
   -- Exécution de l'automate.
   Startjavaseq (Ok, Debug);
   SrcAuto.Close;

   Put_Line ("Temps passé : " & Integer'Image (Horlogems - Time) & " millisecondes.");

   if Ok then
      UName := TruncLast (FSplitName (FName));

      -- Création de la spécification du package
      Put ("Nom de l'unité Ada (spec : " & To_String (UName) & ".ads) : ");
      Get_Line (FName);
      if FName = NullTText then
         FName := UName & ".ads";
      end if;

      Create (FObject, Out_File, To_String (FName));

      Put (FObject, "with Java");
      WithList.TWriteToFile (FObject);
      Put_Line (FObject, ";");
      Put (FObject, "use  Java");
      WithList.TWriteToFile (FObject);
      Put_Line (FObject, ";");
      ObjectSpecList.WriteToFile (FObject);

      Close (FObject);

      -- Création du corps du package
      Put ("Nom de l'unité Ada (corps : " & To_String (UName) & ".adb) : ");
      Get_Line (FName);
      if FName = NullTText then
         FName := UName & ".adb";
      end if;

      Create (FObject, Out_File, To_String (FName));

      ObjectBodyList.WriteToFile (FObject);

      Close (FObject);
   else
      Set_Exit_Status (Failure);
   end if;

end J2Ada;
