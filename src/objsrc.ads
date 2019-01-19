--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : ObjSrc.ads
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

with BasicDef;                           use BasicDef;
with OutSrc;                             use OutSrc;
with Ada.Containers.Doubly_Linked_Lists;

package ObjSrc is

   -- Objet assurant la gestion des objets Java
   type TJavaObj is tagged private;
   type PJavaObj is access TJavaObj;

   -- Objet assurant la gestion des classes Java
   type TJavaClass is new TJavaObj with private;
   type PJavaClass is access TJavaClass;

   -- Procédure définissant le nom de l'objet java
   procedure SetId (O : access TJavaClass; I : TText);
   -- Fonction renvoyant le nom de l'objet java
   function GetId (O : access TJavaClass) return TText;
   -- Procédure d'écriture de l'objet complet
   procedure Add (O : access TJavaClass; To : PTextListMgr);
   -- Procédure définissant l'attribut de l'objet Java
   procedure SetModifier (O : access TJavaClass; M : TText);
   -- Procédure définissant l'attribut de l'objet Java
   procedure SetModifier (O : access TJavaClass; From : access TJavaClass'Class);
   -- Procédure définissant le type Interface
   procedure SetInterface (O : access TJavaClass);
   -- Fonction renvoyant le type Interface
   function GetInterface (O : access TJavaClass) return Boolean;
   -- Fonction renvoyant l'état fermé du type objet
   function IsClosed (O : access TJavaClass) return Boolean;
   -- Fonction renvoyant la référence des champs de l'objet
   function GetFieldList (O : access TJavaClass) return PVarListMgr;
   -- Fonction renvoyant la référence des classes parent de l'objet
   function GetParentList (O : access TJavaClass) return PVarListMgr;

   -- Objet assurant la gestion des variables Java
   type TJavaVar is new TJavaClass with private;
   type PJavaVar is access TJavaVar;
   type TTypeNature is (Void, Basic, Class);

   -- Procédure initialisant le type de l'objet Java
   procedure SetType (O : access TJavaVar; N : TTypeNature; T : TText := NullTText);
   -- Procédure initialisant le type du new
   procedure SetNewType (O : access TJavaVar; N : TTypeNature; T : TText);
   -- Fonction renvoyant le type java
   function GetType (O : access TJavaVar) return TText;
   -- Fonction renvoyant la nature du type java
   function GetTypeNature (O : access TJavaVar) return TTypeNature;
   -- Fonction renvoyant le type de base de l'objet java (sans .ref)
   function GetBaseType (O : access TJavaVar) return TText;
   -- Procédure définissant le nom de l'objet java à la place du type
   procedure SetIdFromType (O : access TJavaVar);
   -- Procédure incrémentant le nombre d'index du type ou de l'objet Java
   procedure IncTabIndex (O : access TJavaVar);
   -- Procédure definissant la valeur initiale de l'objet Java
   procedure SetInitText (O : access TJavaVar; I : TText);
   -- Fonction renvoyant l'objet de récupération de la valeur initiale
   function GetInitText (O : access TJavaVar) return PTextListMgr;
   -- Procédure d'écriture de l'objet complet
   procedure Add
     (O      : access TJavaVar;
      ToPack : PTextListMgr;
      ToObj  : access TTextListMgr'Class);
   -- Fonction renvoyant l'attribut abstract
   function IsAbstract (O : access TJavaVar) return Boolean;

   -- Objet assurant la gestion des paramétres Java
   type TJavaPara is new TJavaVar with private;
   type PJavaPara is access TJavaPara;

   -- Procédure d'écriture de l'objet complet
   procedure Add (O : access TJavaPara; To : PTextListMgr);

   -- Objet assurant la gestion des méthodes Java
   type TJavaMeth is new TJavaObj with private;
   type PJavaMeth is access TJavaMeth;

   -- Procédure definissant la présence de paramètres
   procedure SetParaPresent (O : access TJavaMeth; Present : Boolean);

   -- Fonction renvoyan la présence de paramètres
   function IsParaPresent (O : access TJavaMeth) return Boolean;

   -- Procédures empilant et dépilant la présence de paramètres
   procedure PushPara (O : access TJavaMeth);
   procedure PopPara (O : access TJavaMeth);

private
   type TJavaObj is tagged null record;

   type TModifier is (
      jpublic,
      jprivate,
      jprotected,
      jstatic,
      jfinal,
      jnative,
      jsynchronized,
      jabstract,
      jthreadsafe,
      jtransient);
   type TTabModifiers is array (TModifier) of Boolean;
   type TJavaClass is new TJavaObj with record
      Id                 : TText         := NullTText;
      Modifiers, IntMods : TTabModifiers := (others => False);
      Closed             : Boolean       := False;
      JInterface         : Boolean       := False;
      FieldList          : PVarListMgr   := new TVarListMgr;
      ParentList         : PVarListMgr   := new TVarListMgr;
   end record;

   type TJavaVar is new TJavaClass with record
      JType     : TText        := NullTText;
      TypeIndex : Natural      := 0;
      VarIndex  : Natural      := 0;
      InitText  : PTextListMgr := new TTextListMgr;
      Nature    : TTypeNature  := Void;
   end record;

   type TJavaPara is new TJavaVar with null record;

   package ParaLists is new Ada.Containers.Doubly_Linked_Lists (Boolean);
   type TJavaMeth is new TJavaObj with record
      ParaPresent : ParaLists.List;
   end record;

end ObjSrc;
