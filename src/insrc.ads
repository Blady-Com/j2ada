--------------------------------------------------------------------------------
-- NOM DU CSU (spécification)       : InSrc.ads
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.1a
-- DATE DE LA DERNIERE MISE A JOUR  : 18 octobre 2008
-- ROLE DU CSU                      : Unité de gestion des textes sources.
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

with BasicDef;
with FichSrc;

package InSrc is

   -- Eléments lexicaux
   type TTokenId is (
      NullId,
      EotId,
      NewlineId,
      ErrorId,
      UnknownId,
      CommentId,
      UndefId,
      StringId,
      CarId,
      IntegerId,
      RealId,
      DivEgalId,
      BarreId,
      PlusEgalId,
      PlusPlusId,
      PlusId,
      MoinsEgalId,
      MoinsMoinsId,
      MoinsId,
      EtoileEgalId,
      EtoileId,
      PourcentEgalId,
      PourcentId,
      ExclamEgalId,
      ExclamId,
      EtEgalId,
      EtId,
      PipeEgalId,
      PipeId,
      XorEgalId,
      XorId,
      SupEgalId,
      SupSupEgalId,
      SupSupSupId,
      SupSupId,
      SupId,
      InfEgalId,
      InfInfId,
      InfId,
      EgalEgalId,
      EgalId,
      TildeId,
      EtEtId,
      PipePipeId,
      InfInfEgalId,
      PointVirgId,
      PointId,
      AccoladeGaucheId,
      SupSupSupEgalId,
      AccoladeDroiteId,
      ParGaucheId,
      ParDroiteId,
      CrochetGaucheId,
      CrochetDroitId,
      DeuxPointsId,
      InterroId,
      VirgId,
      abstractID,
      assertID,
      booleanID,
      breakID,
      byteID,
      caseID,
      catchID,
      charID,
      classID,
      constID,
      continueID,
      defaultID,
      doID,
      doubleID,
      elseID,
      enumID,
      extendsID,
      finalID,
      finallyID,
      floatID,
      forID,
      ifID,
      gotoID,
      implementsID,
      importID,
      instanceofID,
      intID,
      interfaceID,
      longID,
      nativeID,
      newID,
      packageID,
      privateID,
      protectedID,
      publicID,
      returnID,
      shortID,
      staticID,
      strictfpID,
      superID,
      switchID,
      synchronizedID,
      thisID,
      throwID,
      throwsID,
      transientID,
      tryID,
      voidID,
      volatileID,
      whileID,
      threadsafeId,
      trueId,
      falseId);

   -- Contexte de l'élément lexical
   subtype Ttokenstr is BasicDef.TText;

   -- Référence de l'objet assurant la gestion du texte source de l'automate
   SrcAuto : FichSrc.TSourceMgr;

   -- Lit un ou plusieurs caractères dans le texte source et le ou les transforme en éléments
   --lexicaux.
   procedure ReadToken (TokenId : out TTokenId; Token : out Ttokenstr);

   -- Procédure de génération des mots clés Java et Ada
   procedure InitJavaAda (JavaAPILocation : BasicDef.TText);

end InSrc;
