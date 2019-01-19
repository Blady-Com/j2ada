--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : ObjPar.ads
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.4a
-- DATE DE LA DERNIERE MISE A JOUR  : 23 décembre 2008
-- ROLE DU CSU                      : Unité des objets partagés de l'automate.
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
with ObjSrc;                             use ObjSrc;
with ImportMgr;
with Ada.Containers.Doubly_Linked_Lists;

package ObjPar is

   -- Variables utilisées dans l'automate :

   -- Référence de l'objet assurant la gestion du nom des clauses de contexte
   WithList : PEnumListMgr := new TEnumListMgr;

   -- Référence de l'objet assurant la gestion du texte spé de l'unité Ada
   ObjectSpecList : PTextListMgr := new TTextListMgr;

   -- Référence de l'objet assurant la gestion du texte corps de l'unité Ada
   ObjectBodyList : PTextListMgr := new TTextListMgr;

   -- Référence de l'objet assurant la gestion d'un texte temporaire
   TempList : PTextListMgr := new TTextListMgr;

   -- Référence de l'objet texte courant
   OutputList, SavedOutputList : PTextListMgr := ObjectSpecList;

   -- Objet assurant la gestion du nom des unités importées
   ImportUnit : TText;

   -- Référence de l'objet assurant la gestion des classes des unités importées
   ImportClassList : ImportMgr.TImportUnit;

   -- Référence de l'objet assurant la gestion du nom des paquetages pères
   PackageList : PTextListMgr := new TTextListMgr;

   -- Référence de l'objet assurant la gestion du nom des classes
   package ClassLists is new Ada.Containers.Doubly_Linked_Lists (ObjSrc.PJavaClass);
   ClassList : ClassLists.List;

   -- Référence de l'objet assurant la gestion du nom des champs ou var locales
   FieldList : access TTextListMgr'Class;

   -- Référence de l'objet assurant la gestion du nom des variables
   VarObj : PJavaVar := new TJavaVar;

   -- Référence de l'objet assurant la gestion du nom des paramètres
   ParaObj : PJavaPara := new TJavaPara;

   -- Référence de l'objet assurant la gestion du nom des methodes
   MethObj : PJavaMeth := new TJavaMeth;

   -- Utilisées en mode débug
   NomFich   : TText;
   LigneFich : Natural;

end ObjPar;
