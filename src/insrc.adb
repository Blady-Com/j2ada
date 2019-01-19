--------------------------------------------------------------------------------
-- NOM DU CSU (corps)               : InSrc.adb
-- AUTEUR DU CSU                    : P. Pignard
-- VERSION DU CSU                   : 1.3a
-- DATE DE LA DERNIERE MISE A JOUR  : 9 novembre 2008
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

with Ada.Text_IO;                use Ada.Text_IO;
with Ada.Strings.Maps;           use Ada.Strings.Maps;
with Ada.Characters.Latin_1;
with Ada.Strings.Maps.Constants; use Ada.Strings.Maps.Constants;
with ArbMgr;
with ObjPar;                     use ObjPar;

package body InSrc is
   use BasicDef;
   use FichSrc;

   Asciinul : constant Character := Ada.Characters.Latin_1.NUL;
   Asciietx : constant Character := Ada.Characters.Latin_1.ETX;
   Asciieot : constant Character := Ada.Characters.Latin_1.EOT;
   Asciibel : constant Character := Ada.Characters.Latin_1.BEL;
   Asciitab : constant Character := Ada.Characters.Latin_1.HT;
   Asciilf  : constant Character := Ada.Characters.Latin_1.LF;
   Asciiff  : constant Character := Ada.Characters.Latin_1.FF;
   Asciicr  : constant Character := Ada.Characters.Latin_1.CR;
   --  Asciinak : constant Character := Ada.Characters.Latin_1.Nak;
   Asciisp : constant Character := ' ';

   -- caractère séparateur de ligne pour le système considéré
   Newlinechar : constant Character := Asciilf;

   NormAsciiCharRange : constant Character_Range :=
     (Low  => Ada.Characters.Latin_1.Space,
      High => Ada.Characters.Latin_1.LC_Y_Diaeresis);
   Normasciicharset   : constant Character_Set   := To_Set ((NormAsciiCharRange));

   Identcharset   : constant Character_Set :=
      To_Set ('$') or To_Set ('_') or Decimal_Digit_Set or Letter_Set;
   Chiffrecharset : constant Character_Set := Decimal_Digit_Set;
   Hexacharset    : constant Character_Set := Hexadecimal_Digit_Set;
   Octalcharset   : constant Character_Set :=
      Decimal_Digit_Set and not To_Set ('8') and not To_Set ('9');
   Blanccharset   : constant Character_Set :=
      (To_Set (Asciibel) or
       To_Set (Asciitab) or
       To_Set (Asciilf) or
       To_Set (Asciiff) or
       To_Set (Asciicr) or
       To_Set (Asciisp)) and
      not To_Set (Newlinechar);
   Escape_Set     : constant Character_Set :=
     To_Set ('b') -- \b /*\u0008: backspace BS */
 or
     To_Set ('t') -- \t /*\u0009: horizontal tab HT */
 or
     To_Set ('n') -- \n /*\u000a: linefeed LF */
 or
     To_Set ('f') -- \f /*\u000c: form feed FF */
 or
     To_Set ('r') -- \r /*\u000d: carriage return CR */
 or
     To_Set ('"') -- \" /*\u0022: double quote " */
 or
     To_Set (''') -- \' /*\u0027: single quote ' */
 or
     To_Set ('\') -- \\ /*\u005c: backslash \ */
 or
     To_Set ('u') -- \u /*unicode u */
 or
     Octalcharset;

   type TGenericErr is (ManqueApos, ManqueComment);

   -- Référence du package assurant la gestion des mots clés Java
   package IdJava is new ArbMgr (Ttokenstr, TTokenId, UndefId);

   -- Référence du package assurant la gestion des mots clés Ada
   package IdAda is new ArbMgr (Ttokenstr, Boolean, False);

   -- Procédure de génération des mots clés Java et Ada
   procedure InitJavaAda (JavaAPILocation : BasicDef.TText) is
   begin
      -- Génération des mots clés Java.
      IdJava.Ajoute (+"abstract", abstractID);
      IdJava.Ajoute (+"assert", assertID);
      IdJava.Ajoute (+"boolean", booleanID);
      IdJava.Ajoute (+"break", breakID);
      IdJava.Ajoute (+"byte", byteID);
      IdJava.Ajoute (+"case", caseID);
      IdJava.Ajoute (+"catch", catchID);
      IdJava.Ajoute (+"char", charID);
      IdJava.Ajoute (+"class", classID);
      IdJava.Ajoute (+"const", constID);
      IdJava.Ajoute (+"continue", continueID);
      IdJava.Ajoute (+"default", defaultID);
      IdJava.Ajoute (+"do", doID);
      IdJava.Ajoute (+"double", doubleID);
      IdJava.Ajoute (+"else", elseID);
      IdJava.Ajoute (+"enum", enumID);
      IdJava.Ajoute (+"extends", extendsID);
      IdJava.Ajoute (+"final", finalID);
      IdJava.Ajoute (+"finally", finallyID);
      IdJava.Ajoute (+"float", floatID);
      IdJava.Ajoute (+"for", forID);
      IdJava.Ajoute (+"if", ifID);
      IdJava.Ajoute (+"goto", gotoID);
      IdJava.Ajoute (+"implements", implementsID);
      IdJava.Ajoute (+"import", importID);
      IdJava.Ajoute (+"instanceof", instanceofID);
      IdJava.Ajoute (+"int", intID);
      IdJava.Ajoute (+"interface", interfaceID);
      IdJava.Ajoute (+"long", longID);
      IdJava.Ajoute (+"native", nativeID);
      IdJava.Ajoute (+"new", newID);
      IdJava.Ajoute (+"package", packageID);
      IdJava.Ajoute (+"private", privateID);
      IdJava.Ajoute (+"protected", protectedID);
      IdJava.Ajoute (+"public", publicID);
      IdJava.Ajoute (+"return", returnID);
      IdJava.Ajoute (+"short", shortID);
      IdJava.Ajoute (+"static", staticID);
      IdJava.Ajoute (+"strictfp", strictfpID);
      IdJava.Ajoute (+"super", superID);
      IdJava.Ajoute (+"switch", switchID);
      IdJava.Ajoute (+"synchronized", synchronizedID);
      IdJava.Ajoute (+"this", thisID);
      IdJava.Ajoute (+"throw", throwID);
      IdJava.Ajoute (+"throws", throwsID);
      IdJava.Ajoute (+"transient", transientID);
      IdJava.Ajoute (+"try", tryID);
      IdJava.Ajoute (+"void", voidID);
      IdJava.Ajoute (+"volatile", volatileID);
      IdJava.Ajoute (+"while", whileID);

      IdJava.Ajoute (+"true", trueId);
      IdJava.Ajoute (+"false", falseId);

      -- Génération des mots clés Ada.
      IdAda.Ajoute (+"abort", True);
      IdAda.Ajoute (+"abs", True);
      IdAda.Ajoute (+"abstract", True);
      IdAda.Ajoute (+"accept", True);
      IdAda.Ajoute (+"access", True);
      IdAda.Ajoute (+"aliased", True);
      IdAda.Ajoute (+"all", True);
      IdAda.Ajoute (+"and", True);
      IdAda.Ajoute (+"array", True);
      IdAda.Ajoute (+"at", True);
      IdAda.Ajoute (+"begin", True);
      IdAda.Ajoute (+"body", True);
      IdAda.Ajoute (+"case", True);
      IdAda.Ajoute (+"constant", True);
      IdAda.Ajoute (+"declare", True);
      IdAda.Ajoute (+"delay", True);
      IdAda.Ajoute (+"delta", True);
      IdAda.Ajoute (+"digits", True);
      IdAda.Ajoute (+"do", True);
      IdAda.Ajoute (+"else", True);
      IdAda.Ajoute (+"elsif", True);
      IdAda.Ajoute (+"end", True);
      IdAda.Ajoute (+"entry", True);
      IdAda.Ajoute (+"exception", True);
      IdAda.Ajoute (+"exit", True);
      IdAda.Ajoute (+"for", True);
      IdAda.Ajoute (+"function", True);
      IdAda.Ajoute (+"generic", True);
      IdAda.Ajoute (+"goto", True);
      IdAda.Ajoute (+"if", True);
      IdAda.Ajoute (+"in", True);
      IdAda.Ajoute (+"interface", True);
      IdAda.Ajoute (+"is", True);
      IdAda.Ajoute (+"limited", True);
      IdAda.Ajoute (+"loop", True);
      IdAda.Ajoute (+"mod", True);
      IdAda.Ajoute (+"new", True);
      IdAda.Ajoute (+"not", True);
      --  IdAda.Ajoute (+"null", True); idem Java ;-)
      IdAda.Ajoute (+"of", True);
      IdAda.Ajoute (+"or", True);
      IdAda.Ajoute (+"others", True);
      IdAda.Ajoute (+"out", True);
      IdAda.Ajoute (+"overriding", True);
      IdAda.Ajoute (+"package", True);
      IdAda.Ajoute (+"pragma", True);
      IdAda.Ajoute (+"private", True);
      IdAda.Ajoute (+"procedure", True);
      IdAda.Ajoute (+"protected", True);
      IdAda.Ajoute (+"raise", True);
      IdAda.Ajoute (+"range", True);
      IdAda.Ajoute (+"record", True);
      IdAda.Ajoute (+"rem", True);
      IdAda.Ajoute (+"renames", True);
      IdAda.Ajoute (+"requeue", True);
      IdAda.Ajoute (+"return", True);
      IdAda.Ajoute (+"reverse", True);
      IdAda.Ajoute (+"select", True);
      IdAda.Ajoute (+"separate", True);
      IdAda.Ajoute (+"subtype", True);
      IdAda.Ajoute (+"synchronized", True);
      IdAda.Ajoute (+"tagged", True);
      IdAda.Ajoute (+"task", True);
      IdAda.Ajoute (+"terminate", True);
      IdAda.Ajoute (+"then", True);
      IdAda.Ajoute (+"type", True);
      IdAda.Ajoute (+"until", True);
      IdAda.Ajoute (+"use", True);
      IdAda.Ajoute (+"when", True);
      IdAda.Ajoute (+"while", True);
      IdAda.Ajoute (+"with", True);
      IdAda.Ajoute (+"xor", True);

      ImportClassList.SetAPILocation (JavaAPILocation);
      ImportClassList.AddAll (+"java.lang.*");
   end InitJavaAda;

   -- Affiche la raison de l'erreur.
   procedure AffGenericErr (Id : TGenericErr) is
   begin
      Put_Line ("Erreur generique : " & TGenericErr'Image (Id));
   end AffGenericErr;

   -- Affiche une chaîne à la suite d'une erreur.
   procedure AffChaineErr (Chaine : String) is
   begin
      Put_Line (Chaine);
   end AffChaineErr;

   -- Lit un ou plusieurs caractère dans le texte source et le ou les transforme en éléments
   --lexicaux.
   procedure ReadToken (TokenId : out TTokenId; Token : out Ttokenstr) is
      Ch, ChSuivant : Character;

      -- Lit une chaîne de caractères.
      procedure ReadChaine is
         type Escape_Range is (
            'b',
            't',
            'n',
            'f',
            'r',
            '"',
            ''',
            '\');
         Escape_Conv : constant array (Escape_Range) of TText :=
           (+""" & Java.BS & """,
            +""" & Java.Ht & """,
            +""" & Java.Lf & """,
            +""" & Java.Ff & """,
            +""" & Java.Cr & """,
            +"""""",
            +"'",
            +"\");
      begin
         Token := Token & " WS2JS(""";
         if ChSuivant /= '"' then
            while Is_In (ChSuivant, Normasciicharset) loop
               Read (SrcAuto, Ch, ChSuivant);
               if Ch = '\' and then Is_In (ChSuivant, Escape_Set) then
                  Read (SrcAuto, Ch, ChSuivant);
                  if Ch = 'u' then
                     Token := Token & """ & Wide_Character'Val(16#";
                     while Is_In (ChSuivant, Hexacharset) loop
                        Read (SrcAuto, Ch, ChSuivant);
                        Token := Token & Ch;
                     end loop;
                     Token := Token & "#) & """;
                  elsif Is_In (Ch, Octalcharset) then
                     Token := Token & """ & Wide_Character'Val(8#" & Ch;
                     while Is_In (ChSuivant, Octalcharset) loop
                        Read (SrcAuto, Ch, ChSuivant);
                        Token := Token & Ch;
                     end loop;
                     Token := Token & "#) & """;
                  else
                     Token := Token & Escape_Conv (Escape_Range'Value (''' & Ch & '''));
                  end if;
               else
                  Token := Token & Ch;
               end if;
               if ChSuivant = '"' then
                  ChSuivant := Asciietx;
               end if;
            end loop;
         else
            ChSuivant := Asciietx;
         end if;
         case ChSuivant is
            when Asciieot =>
               AffGenericErr (ManqueApos);
               TokenId := ErrorId;
            when Asciietx =>
               Read (SrcAuto, Ch, ChSuivant);
               TokenId := StringId;
               Token   := Token & """)";
            when others =>
               AffChaineErr ((1 => Ch));
               TokenId := ErrorId;
         end case;
      end ReadChaine;

      -- Lit un caractère.
      procedure ReadChar is
         type Escape_Range is (
            'b',
            't',
            'n',
            'f',
            'r',
            '"',
            ''',
            '\');
         Escape_Conv : constant array (Escape_Range) of TText :=
           (+"Java.BS",
            +"Java.Ht",
            +"Java.Lf",
            +"Java.Ff",
            +"Java.Cr",
            +"'""'",
            +"'''",
            +"'\'");
      begin
         Read (SrcAuto, Ch, ChSuivant);
         if Ch = '\' and then Is_In (ChSuivant, Escape_Set) then
            Read (SrcAuto, Ch, ChSuivant);
            if Ch = 'u' then
               Token := +"Wide_Character'Val(16#";
               while Is_In (ChSuivant, Hexacharset) loop
                  Read (SrcAuto, Ch, ChSuivant);
                  Token := Token & Ch;
               end loop;
               Token := Token & "#)";
            elsif Is_In (Ch, Octalcharset) then
               Token := +"Wide_Character'Val(8#" & Ch;
               while Is_In (ChSuivant, Octalcharset) loop
                  Read (SrcAuto, Ch, ChSuivant);
                  Token := Token & Ch;
               end loop;
               Token := Token & "#)";
            else
               Token := Escape_Conv (Escape_Range'Value (''' & Ch & '''));
            end if;
         else
            Token := +(''' & Ch & ''');
         end if;
         if ChSuivant = ''' then
            TokenId := CarId;
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := ErrorId;
         end if;
      end ReadChar;

      -- Lit un commentaire.
      procedure ReadComment is
      begin
         Token := +"--";
         Read (SrcAuto, Ch, ChSuivant); --  lecture *
         Read (SrcAuto, Ch, ChSuivant); --  lecture car courant
         while not Is_In (Ch, To_Set (Asciieot) or To_Set (Asciietx)) loop
            if Ch = Newlinechar then
               Token := Token & Ch & "--";
               Read (SrcAuto, Ch, ChSuivant);
            end if;
            if Ch = Asciietx then
               Ch := Asciinul;
            end if;
            if (Ch = '*') and (ChSuivant = '/') then
               Read (SrcAuto, Ch, ChSuivant);
               Ch := Asciietx;
            end if;
            if Ch /= Asciietx then
               Token := Token & Ch;
               Read (SrcAuto, Ch, ChSuivant);
            end if;
         end loop;
         if Ch = Asciietx then
            TokenId := CommentId;
         else
            AffGenericErr (ManqueComment);
            TokenId := ErrorId;
         end if;
      end ReadComment;

      -- Lit un commentaire d'une ligne.
      procedure ReadCommentSingleLine is
      begin
         Token := +"--";
         Read (SrcAuto, Ch, ChSuivant); --  lecture second /
         while not Is_In (ChSuivant, To_Set (Asciieot) or To_Set (Newlinechar)) loop
            Read (SrcAuto, Ch, ChSuivant);
            Token := Token & Ch;
         end loop;
         if ChSuivant = Newlinechar then
            TokenId := CommentId;
         else
            AffGenericErr (ManqueComment);
            TokenId := ErrorId;
         end if;
      end ReadCommentSingleLine;

      -- Lit un identificateur.
      procedure ReadIdent is
         IsAda : Boolean;
      begin
         Token := Token & Ch;
         while Is_In (ChSuivant, Identcharset) loop
            Read (SrcAuto, Ch, ChSuivant);
            Token := Token & Ch;
         end loop;
         IdJava.Recherche (Token, TokenId);
         if TokenId = UndefId then
            IdAda.Recherche (LowStr (Token), IsAda);
            if IsAda then
               Token := Token & "_K";
            end if;
            if ImportClassList.Search (Token) then
               Token := ImportClassList.GetLast;
               WithList.AddUniq (Token);
            end if;
         end if;
      end ReadIdent;

      -- Lit un nombre.
      procedure ReadNombre is
         HasPoint : Boolean := False;
      begin
         TokenId := ErrorId;
         if Ch = '0' and then (ChSuivant = 'x' or ChSuivant = 'X') then
            Read (SrcAuto, Ch, ChSuivant);
            while Is_In (ChSuivant, Hexacharset) loop
               Read (SrcAuto, Ch, ChSuivant);
               Token := Token & Ch;
            end loop;
            Token   := "16#" & Token & '#';
            TokenId := IntegerId;
            if ChSuivant = 'L' or else ChSuivant = 'l' then
               Read (SrcAuto, Ch, ChSuivant);
            end if;
         elsif Ch = '0' and then Is_In (ChSuivant, Octalcharset) then
            while Is_In (ChSuivant, Octalcharset) loop
               Read (SrcAuto, Ch, ChSuivant);
               Token := Token & Ch;
            end loop;
            if ChSuivant /= '8'
              and then ChSuivant /= '9'
              and then ChSuivant /= '.'
              and then ChSuivant /= 'e'
              and then ChSuivant /= 'E'
            then
               Token   := "8#" & Token & '#';
               TokenId := IntegerId;
               if ChSuivant = 'L' or else ChSuivant = 'l' then
                  Read (SrcAuto, Ch, ChSuivant);
               end if;
            end if;
         elsif Ch = '0' then
            Token   := +"0";
            TokenId := IntegerId;
            if ChSuivant = 'L' or else ChSuivant = 'l' then
               Read (SrcAuto, Ch, ChSuivant);
            end if;
            if ChSuivant = 'F'
              or else ChSuivant = 'f'
              or else ChSuivant = 'D'
              or else ChSuivant = 'd'
            then
               Read (SrcAuto, Ch, ChSuivant);
               Token   := +"0.0";
               TokenId := RealId;
            end if;
         else
            Token := Token & Ch;
         end if;
         if TokenId = ErrorId and then Ch /= '.' then
            while Is_In (ChSuivant, Chiffrecharset) loop
               Read (SrcAuto, Ch, ChSuivant);
               Token := Token & Ch;
            end loop;
            if ChSuivant /= '.' and then ChSuivant /= 'e' and then ChSuivant /= 'E' then
               TokenId := IntegerId;
               if ChSuivant = 'L' or else ChSuivant = 'l' then
                  Read (SrcAuto, Ch, ChSuivant);
               end if;
               if ChSuivant = 'F'
                 or else ChSuivant = 'f'
                 or else ChSuivant = 'D'
                 or else ChSuivant = 'd'
               then
                  Read (SrcAuto, Ch, ChSuivant);
                  Token   := Token & ".0";
                  TokenId := RealId;
               end if;
            end if;
         end if;
         if TokenId = ErrorId then
            if Ch = '.' then
               HasPoint := True;
            end if;
            if ChSuivant = '.' then
               Read (SrcAuto, Ch, ChSuivant);
               Token    := Token & Ch;
               HasPoint := True;
            end if;
            if HasPoint and then not Is_In (ChSuivant, Chiffrecharset) then
               Token := Token & '0';
            end if;
            while Is_In (ChSuivant, Chiffrecharset) loop
               Read (SrcAuto, Ch, ChSuivant);
               Token := Token & Ch;
            end loop;
            TokenId := RealId;
            if ChSuivant = 'F'
              or else ChSuivant = 'f'
              or else ChSuivant = 'D'
              or else ChSuivant = 'd'
            then
               Read (SrcAuto, Ch, ChSuivant);
            end if;
            if ChSuivant = 'e' or ChSuivant = 'E' then
               if not HasPoint then
                  Token := Token & ".0";
               end if;
               Read (SrcAuto, Ch, ChSuivant);
               Token := Token & Ch;
               if ChSuivant = '+' or ChSuivant = '-' then
                  Read (SrcAuto, Ch, ChSuivant);
                  Token := Token & Ch;
               end if;
               while Is_In (ChSuivant, Chiffrecharset) loop
                  Read (SrcAuto, Ch, ChSuivant);
                  Token := Token & Ch;
               end loop;
               TokenId := RealId;
               if ChSuivant = 'F'
                 or else ChSuivant = 'f'
                 or else ChSuivant = 'D'
                 or else ChSuivant = 'd'
               then
                  Read (SrcAuto, Ch, ChSuivant);
               end if;
            end if;
         end if;
      end ReadNombre;

   begin
      Token   := NullTText;
      TokenId := ErrorId;
      Read (SrcAuto, Ch, ChSuivant);
      while Is_In (Ch, Blanccharset) loop
         Read (SrcAuto, Ch, ChSuivant);
      end loop;
      case Ch is
      when Asciieot =>
         TokenId := EotId;
      when Newlinechar =>
         TokenId := NewlineId;
      when '"' =>
         ReadChaine;
      when ''' =>
         ReadChar;
      when '/' =>
         if ChSuivant = '*' then
            ReadComment;
         elsif ChSuivant = '/' then
            ReadCommentSingleLine;
         elsif ChSuivant = '=' then
            TokenId := DivEgalId;
            Token   := +":= / (";
         else
            TokenId := BarreId;
            Token   := +"/";
         end if;
      when '+' =>
         if ChSuivant = '=' then
            TokenId := PlusEgalId;
            Token   := +":= + (";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '+' then
            TokenId := PlusPlusId;
            Token   := +":= + + 1";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := PlusId;
            Token   := +"+";
         end if;
      when '-' =>
         if ChSuivant = '=' then
            TokenId := MoinsEgalId;
            Token   := +":= - ";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '+' then
            TokenId := MoinsMoinsId;
            Token   := +":= - - 1";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := MoinsId;
            Token   := +"-";
         end if;
      when '*' =>
         if ChSuivant = '=' then
            TokenId := EtoileEgalId;
            Token   := +":= * (";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := EtoileId;
            Token   := +"*";
         end if;
      when '%' =>
         if ChSuivant = '=' then
            TokenId := PourcentEgalId;
            Token   := +":= mod (";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := PourcentId;
            Token   := +"mod";
         end if;
      when '!' =>
         if ChSuivant = '=' then
            TokenId := ExclamEgalId;
            Token   := +"/=";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := ExclamId;
            Token   := +"not";
         end if;
      when '&' =>
         if ChSuivant = '=' then
            TokenId := EtEgalId;
            Token   := +":= and (";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '&' then
            TokenId := EtEtId;
            Token   := +"and then";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := EtId;
            Token   := +"and";
         end if;
      when '|' =>
         if ChSuivant = '=' then
            TokenId := PipeEgalId;
            Token   := +":= or (";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '|' then
            Read (SrcAuto, Ch, ChSuivant);
            TokenId := PipePipeId;
            Token   := +"or else";
         else
            TokenId := PipeId;
            Token   := +"or";
         end if;
      when '^' =>
         if ChSuivant = '=' then
            TokenId := XorEgalId;
            Token   := +":= xor (";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := XorId;
            Token   := +"xor";
         end if;
      when '>' =>
         if ChSuivant = '=' then
            TokenId := SupEgalId;
            Token   := +">=";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '>' then
            Read (SrcAuto, Ch, ChSuivant);
            if ChSuivant = '=' then
               TokenId := SupSupEgalId;
               Token   := +">>=";
               Read (SrcAuto, Ch, ChSuivant);
            elsif ChSuivant = '>' then
               if ChSuivant = '=' then
                  TokenId := SupSupSupEgalId;
                  Token   := +">>>=";
                  Read (SrcAuto, Ch, ChSuivant);
               else
                  TokenId := SupSupSupId; -- >>>=
                  Token   := +">>>";
                  Read (SrcAuto, Ch, ChSuivant);
               end if;
            else
               TokenId := SupSupId;
               Token   := +">>";
            end if;
         else
            TokenId := SupId;
            Token   := +">";
         end if;
      when '<' =>
         if ChSuivant = '=' then
            TokenId := InfEgalId;
            Token   := +"<=";
            Read (SrcAuto, Ch, ChSuivant);
         elsif ChSuivant = '<' then
            Read (SrcAuto, Ch, ChSuivant);
            if ChSuivant = '=' then
               TokenId := InfInfEgalId;
               Token   := +"<<=";
               Read (SrcAuto, Ch, ChSuivant);
            else
               TokenId := InfInfId;
               Token   := +"<<";
            end if;
         else
            TokenId := InfId;
            Token   := +"<";
         end if;
      when '=' =>
         if ChSuivant = '=' then
            TokenId := EgalEgalId;
            Token   := +"=";
            Read (SrcAuto, Ch, ChSuivant);
         else
            TokenId := EgalId;
            Token   := +":=";
         end if;
      when '~' =>
         TokenId := TildeId;
         Token   := +"~";
      when ';' =>
         TokenId := PointVirgId;
         Token   := +";";
      when '.' =>
         if Is_In (ChSuivant, Chiffrecharset) then
            Token := +"0";
            ReadNombre;
         else
            TokenId := PointId;
            Token   := +".";
         end if;
      when '{' =>
         TokenId := AccoladeGaucheId;
         Token   := +"begin";
      when '}' =>
         TokenId := AccoladeDroiteId;
         Token   := +"end";
      when '(' =>
         TokenId := ParGaucheId;
         Token   := +"(";
      when ')' =>
         TokenId := ParDroiteId;
         Token   := +")";
      when '[' =>
         TokenId := CrochetGaucheId;
         Token   := +"(";
      when ']' =>
         TokenId := CrochetDroitId;
         Token   := +")";
      when ':' =>
         TokenId := DeuxPointsId;
         Token   := +":";
      when '?' =>
         TokenId := InterroId;
         Token   := +"?";
      when ',' =>
         TokenId := VirgId;
         Token   := +",";
      when 'A' .. 'Z' | 'a' .. 'z' | '_' | '$' =>
         ReadIdent;
      when '0' .. '9' =>
         ReadNombre;
      when others =>
         TokenId := UnknownId;
      end case;
   end ReadToken;

end InSrc;
