--------------------------------------------------------------------------------
-- NOM DU CSU (corps)               : OutSrc.adb
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

with Ada.Unchecked_Deallocation;

package body OutSrc is

   -- Ajout d'une chaîne sans changer de ligne.
   procedure Add (Object : access TTextListMgr; S : TText) is
   begin
      Object.CurStr := Object.CurStr & S;
   end Add;

   -- Ajout d'une chaîne avec changement de ligne.
   procedure AddNew (Object : access TTextListMgr; S : TText := NullTText) is
   begin
      if Object.FirstElt = null then
         Object.FirstElt    := new TTextList;
         Object.CurElt      := Object.FirstElt;
         Object.CurElt.Prev := null;
      else
         Object.CurElt.Next      := new TTextList;
         Object.CurElt.Next.Prev := Object.CurElt;
         Object.CurElt           := Object.CurElt.Next;
      end if;
      Object.CurElt.Text := Object.CurStr & S;
      Object.CurStr      := NullTText;
      Object.CurElt.Next := null;
   end AddNew;

   -- Ajout d'une chaîne sans changer de ligne.
   procedure Add (Object : access TTextListMgr; S : String) is
   begin
      Object.CurStr := Object.CurStr & S;
   end Add;

   -- Ajout d'une chaîne avec changement de ligne.
   procedure AddNew (Object : access TTextListMgr; S : String) is
   begin
      AddNew (Object, To_Unbounded_String (S));
   end AddNew;

   -- Ajout d'un charactère sans changer de ligne.
   procedure Add (Object : access TTextListMgr; C : Character) is
   begin
      Object.CurStr := Object.CurStr & C;
   end Add;

   -- Ajout d'un charactère avec changement de ligne.
   procedure AddNew (Object : access TTextListMgr; C : Character) is
   begin
      AddNew (Object, To_Unbounded_String ((1 => C)));
   end AddNew;

   -- Ecriture du texte dans un fichier.
   procedure WriteToFile (Object : access TTextListMgr; F : File_Type) is
      P : PTextList := Object.FirstElt;
   begin
      while P /= null loop
         Put_Line (F, To_String (P.Text));
         P := P.Next;
      end loop;
      Put (F, To_String (Object.CurStr));
   end WriteToFile;

   -- Copie le texte dans un autre objet.
   procedure Copy (From : access TTextListMgr; To : access TTextListMgr'Class) is
      Dum : PTextList := From.FirstElt;
   begin
      while Dum /= null loop
         if Dum.Text /= "" then
            AddNew (To, Dum.Text);
         end if;
         Dum := Dum.Next;
      end loop;
      Add (To, From.CurStr);
   end Copy;

   -- Procédure de dépilement.
   procedure Depile (Object : access TTextListMgr) is
      S : TText;
      pragma Unreferenced (S);
   begin
      Depile (Object, S);
   end Depile;

   -- Procédure de dépilement du texte.
   procedure Depile (Object : access TTextListMgr; S : out TText) is
      procedure Free is new Ada.Unchecked_Deallocation (TTextList, PTextList);
      Dum : PTextList;
   begin
      S := Object.CurStr;
      if Object.FirstElt = null then
         Object.CurStr := NullTText;
      else
         Object.CurStr := Object.CurElt.Text;
         Dum           := Object.CurElt;
         Object.CurElt := Object.CurElt.Prev;
         Free (Dum);
         if Object.CurElt = null then
            Object.FirstElt := null;
         else
            Object.CurElt.Next := null;
         end if;
      end if;
   end Depile;

   -- fonction retournant la valeur courante.
   function Current (Object : access TTextListMgr) return TText is
   begin
      return Object.CurStr;
   end Current;

   -- fonction retournant l'état vide de la liste.
   function Vide (Object : access TTextListMgr) return Boolean is
   begin
      return Object.FirstElt = null;
   end Vide;

   -- Procédure de destruction du texte.
   procedure Done (Object : access TTextListMgr) is
      procedure Free is new Ada.Unchecked_Deallocation (TTextList, PTextList);
      Dum  : PTextList := Object.FirstElt;
      Dum2 : PTextList;
   begin
      while Dum /= null loop
         if Dum.Text /= "" then
            Dum.Text := NullTText;
         end if;
         Dum2 := Dum;
         Free (Dum2);
         Dum := Dum.Next;
      end loop;
      Object.FirstElt := null;
      Object.CurElt   := null;
      Object.CurStr   := NullTText;
   end Done;

   -- Ajoute un élément s'il ne l'a pas déjà été
   procedure AddUniq (Object : access TEnumListMgr; S : TText) is
      P     : PTextList := Object.FirstElt;
      Found : Boolean   := False;
   begin
      while (P /= null) and not Found loop
         if S = P.Text then
            Found := True;
         end if;
         P := P.Next;
      end loop;
      if not Found then
         AddNew (Object, S);
      end if;
   end AddUniq;

   -- Ecrit la liste sous forme d'un type énuméré
   procedure TWriteToFile (Object : access TEnumListMgr; F : File_Type) is
      Cpt : Integer   := 0;
      P   : PTextList := Object.FirstElt;
   begin
      while P /= null loop
         Cpt := (Cpt + 1) mod 10;
         Put (F, ", " & To_String (P.Text));
         if Cpt = 0 then
            New_Line (F);
         end if;
         P := P.Next;
      end loop;
   end TWriteToFile;

   -- Copie une déclaration de variables
   procedure CopyVar (From : access TVarListMgr; To : PTextListMgr) is
      P : PTextList := From.FirstElt;
   begin
      while P /= null and then P.Next /= null loop
         AddNew (To, P.Next.Text & ": " & P.Text & ';');
         P := P.Next.Next;
      end loop;
   end CopyVar;

   -- Copie une déclaration de paramètres
   procedure CopyPara (From : access TVarListMgr; To : PTextListMgr) is
      P : PTextList := From.FirstElt;
   begin
      while P /= null and then P.Next /= null loop
         Add (To, "; " & P.Next.Text & ": " & P.Text);
         P := P.Next.Next;
      end loop;
   end CopyPara;

   -- Copie une déclaration de classes
   procedure CopyClass (From : access TVarListMgr; To : PTextListMgr) is
      P : PTextList := From.FirstElt;
   begin
      while P /= null loop
         Add (To, P.Text & ".Typ");
         if P.Next /= null then
            Add (To, " and ");
         end if;
         P := P.Next;
      end loop;
   end CopyClass;

end OutSrc;
