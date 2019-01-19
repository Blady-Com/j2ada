--------------------------------------------------------------------------------
-- NOM DU CSU (corps)               : ObjSrc.adb
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.4a
-- DATE DE LA DERNIERE MISE A JOUR  : 23 décembre 2008
-- ROLE DU CSU                      : Unité de gestion des objets Java.
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

package body ObjSrc is

   -----------
   -- SetId --
   -----------

   procedure SetId (O : access TJavaClass; I : TText) is
   begin
      O.Id := I;
   end SetId;

   -----------
   -- GetId --
   -----------

   function GetId (O : access TJavaClass) return TText is
   begin
      return O.Id;
   end GetId;

   ---------
   -- Add --
   ---------

   procedure Add (O : access TJavaClass; To : PTextListMgr) is
   begin
      O.Closed := True;
      To.AddNew ("type Typ;");
      To.AddNew ("type Ref is access all Typ;");
      To.Add ("type Typ is ");
      O.ParentList.Depile;
      if O.ParentList.Current /= NullTText and not O.JInterface then
         O.ParentList.AddNew;
         To.Add ("new ");
         O.ParentList.CopyClass (To);
         To.Add (" with");
      elsif O.JInterface then
         To.Add ("interface");
         if O.ParentList.Current /= NullTText then
            O.ParentList.AddNew;
            To.Add (" and ");
            O.ParentList.CopyClass (To);
         end if;
      else
         if O.Modifiers (jabstract) then
            To.Add ("abstract ");
         end if;
         To.Add ("tagged");
      end if;
   end Add;

   -----------------
   -- SetModifier --
   -----------------

   procedure SetModifier (O : access TJavaClass; M : TText) is
   begin
      O.Modifiers (TModifier'Value ('j' & To_String (M)))   := True;
   end SetModifier;

   -----------------
   -- SetModifier --
   -----------------

   procedure SetModifier (O : access TJavaClass; From : access TJavaClass'Class) is
   begin
      O.Modifiers := From.Modifiers;
   end SetModifier;

   ------------------
   -- SetInterface --
   ------------------

   procedure SetInterface (O : access TJavaClass) is
   begin
      O.JInterface := True;
   end SetInterface;

   ------------------
   -- GetInterface --
   ------------------

   function GetInterface (O : access TJavaClass) return Boolean is
   begin
      return O.JInterface;
   end GetInterface;

   ------------
   -- Closed --
   ------------

   function IsClosed (O : access TJavaClass) return Boolean is
   begin
      return O.Closed;
   end IsClosed;

   ------------------
   -- GetFieldList --
   ------------------

   function GetFieldList (O : access TJavaClass) return PVarListMgr is
   begin
      return O.FieldList;
   end GetFieldList;

   -------------------
   -- GetParentList --
   -------------------

   function GetParentList (O : access TJavaClass) return PVarListMgr is
   begin
      return O.ParentList;
   end GetParentList;

   -------------
   -- SetType --
   -------------

   procedure SetType (O : access TJavaVar; N : TTypeNature; T : TText := NullTText) is
   begin
      O.JType := T;
      O.Id    := NullTText;
      Done (O.InitText);
      O.VarIndex  := 0;
      O.TypeIndex := 0;
      O.IntMods   := O.Modifiers;
      O.Modifiers := (others => False);
      O.Nature    := N;
   end SetType;

   ----------------
   -- SetNewType --
   ----------------

   procedure SetNewType (O : access TJavaVar; N : TTypeNature; T : TText) is
   begin
      if O.JType = NullTText then
         O.JType  := T;
         O.Nature := N;
      end if;
   end SetNewType;

   -------------
   -- GetType --
   -------------

   function GetType (O : access TJavaVar) return TText is
   begin
      if O.Nature = Class then
         return O.JType & ".Ref";
      else
         return O.JType;
      end if;
   end GetType;

   -------------------
   -- GetTypeNature --
   -------------------

   function GetTypeNature (O : access TJavaVar) return TTypeNature is
   begin
      return O.Nature;
   end GetTypeNature;

   -----------------
   -- GetBaseType --
   -----------------

   function GetBaseType (O : access TJavaVar) return TText is
   begin
      return O.JType;
   end GetBaseType;

   -------------------
   -- SetIdFromType --
   -------------------

   procedure SetIdFromType (O : access TJavaVar) is
   begin
      O.Id     := O.JType;
      O.JType  := NullTText;
      O.Nature := Void;
   end SetIdFromType;

   -----------------
   -- IncTabIndex --
   -----------------

   procedure IncTabIndex (O : access TJavaVar) is
   begin
      if O.Id = NullTText then
         O.TypeIndex := O.TypeIndex + 1;
      else
         O.VarIndex := O.VarIndex + 1;
      end if;
   end IncTabIndex;

   ----------------
   -- SetInitText --
   ----------------

   procedure SetInitText (O : access TJavaVar; I : TText) is
   begin
      null;
   end SetInitText;

   ----------------
   -- GetInitText --
   ----------------

   function GetInitText (O : access TJavaVar) return PTextListMgr is
   begin
      return O.InitText;
   end GetInitText;

   ---------
   -- Add --
   ---------

   procedure Add
     (O      : access TJavaVar;
      ToPack : PTextListMgr;
      ToObj  : access TTextListMgr'Class)
   is
   begin
      if O.TypeIndex + O.VarIndex /= 0 then
         Add (ToPack, "type j2a_" & O.Id & " is array (Natural range <>");
         for Index in 2 .. O.TypeIndex + O.VarIndex loop
            Add (ToPack, ", Natural range <>");
         end loop;
         Add (ToPack, ") of " & O.JType);
         if O.Nature = Class then
            Add (ToPack, ".Ref");
         end if;
         AddNew (ToPack, ';');
         if O.IntMods (jfinal) then
            Add (ToPack, O.Id & " : constant access j2a_" & O.Id);
            Copy (O.InitText, ToPack);
            AddNew (ToPack, ';');
         elsif O.IntMods (jstatic) then
            Add (ToPack, O.Id & " : access j2a_" & O.Id);
            Copy (O.InitText, ToPack);
            AddNew (ToPack, ';');
         else
            Add (ToObj, O.Id & " : access j2a_" & O.Id);
            Copy (O.InitText, ToObj);
            AddNew (ToObj, ';');
         end if;
      else
         if O.IntMods (jfinal) then
            Add (ToPack, O.Id & " : constant " & O.JType);
            if O.Nature = Class then
               Add (ToPack, ".Ref");
            end if;
            Copy (O.InitText, ToPack);
            AddNew (ToPack, ';');
         elsif O.IntMods (jstatic) then
            Add (ToPack, O.Id & " : " & O.JType);
            if O.Nature = Class then
               Add (ToPack, ".Ref");
            end if;
            Copy (O.InitText, ToPack);
            AddNew (ToPack, ';');
         else
            Add (ToObj, O.Id & " : " & O.JType);
            if O.Nature = Class then
               Add (ToObj, ".Ref");
            end if;
            Copy (O.InitText, ToObj);
            AddNew (ToObj, ';');
         end if;
      end if;
   end Add;

   -----------------
   -- GetAbstract --
   -----------------

   function IsAbstract (O : access TJavaVar) return Boolean is
   begin
      return O.IntMods (jabstract);
   end IsAbstract;

   ---------
   -- Add --
   ---------

   procedure Add (O : access TJavaPara; To : PTextListMgr) is
   begin
      if O.TypeIndex + O.VarIndex /= 0 then
         AddNew (To);
         Add (To, "type j2a_" & O.Id & " is array (Natural range <>");
         for Index in 2 .. O.TypeIndex + O.VarIndex loop
            Add (To, ", Natural range <>");
         end loop;
         Add (To, ") of " & O.JType);
         if O.Nature = Class then
            Add (To, ".Ref");
         end if;
         AddNew (To, "; --  Help J2Ada : put it before method");
         if O.IntMods (jfinal) then
            Add (To, O.Id & " : constant access j2a_" & O.Id);
         else
            Add (To, O.Id & " : access j2a_" & O.Id);
         end if;
      else
         if O.IntMods (jfinal) then
            Add (To, O.Id & " : constant " & O.JType);
            if O.Nature = Class then
               Add (To, ".Ref");
            end if;
         else
            Add (To, O.Id & " : " & O.JType);
            if O.Nature = Class then
               Add (To, ".Ref");
            end if;
         end if;
      end if;
   end Add;

   --------------------
   -- SetParaPresent --
   --------------------

   procedure SetParaPresent (O : access TJavaMeth; Present : Boolean) is
   begin
      O.ParaPresent.Replace_Element (O.ParaPresent.Last, Present);
   end SetParaPresent;

   --------------------
   -- GetParaPresent --
   --------------------

   function IsParaPresent (O : access TJavaMeth) return Boolean is
   begin
      return O.ParaPresent.Last_Element;
   end IsParaPresent;

   -----------------
   -- Push et Pop --
   -----------------

   procedure PushPara (O : access TJavaMeth) is
   begin
      O.ParaPresent.Append (False);
   end PushPara;

   procedure PopPara (O : access TJavaMeth) is
   begin
      O.ParaPresent.Delete_Last;
   end PopPara;

end ObjSrc;
