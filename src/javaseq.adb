with Ada.Text_IO, FichSrc, OutSrc, InSrc, ObjSrc, ObjPar, BasicDef;
use  Ada.Text_IO, FichSrc, OutSrc, InSrc, ObjSrc, ObjPar, BasicDef;

package body javaseq is

  type TState is (stError, stQuit, compilation_unit, compilation_unit2, compilation_unit3, package_statement, package_statement1, import_statement, import_statement2, import_statement3, import_statement4, type_declaration
, type_declaration2, type_declaration3, class_declaration, class_declaration2, class_declaration3, class_declaration31, class_declaration4, class_declaration41, class_declaration5, interface_declaration
, interface_declaration2, interface_declaration3, interface_declaration31, interface_declaration5, field_declaration, field_declaration1, field_declaration2, field_declaration3, method_declaration, method_declaration41
, method_declaration5, method_declaration51, method_declaration52, method_declaration6, method_declaration7, constructor_declaration, constructor_declaration41, constructor_declaration5, constructor_declaration6, statement_block
, statement_block1, variable_declaration, variable_declaration1, variable_declaration11, variable_declaration2, variable_declaration3, variable_initializer, variable_initializer1, variable_initializer2, parameter_list
, parameter_list0, parameter_list1, parameter_list2, parameter_list21, parameter_list22, statement, R1, R2, T1, B1
, B2, C1, C2, E1, V1, if_statement, if_statement1, if_statement2, if_statement21, if_statement3
, do_statement, do_statement1, do_statement2, do_statement3, do_statement4, while_statement, while_statement1, while_statement2, while_statement3, for_statement
, for_statement1, for_statement2, for_statement3, for_statement31, for_statement4, for_statement5, try_statement, try_statement1, try_statement2, try_statement3
, try_statement4, try_statement5, switch_statement, switch_statement1, switch_statement2, switch_statement3, switch_statement4, switch_statement5, switch_statement6, assert_statement
, assert_statement1, assert_statement2, synchronized_statement, synchronized_statement1, synchronized_statement2, expression, expression1, inner_expression, inner_expression1, creating_expression
, creating_expression2, creating_expression21, creating_expression3, creating_expression41, creating_expression42, creating_expression5);

procedure Automate (TheState : TState; Event : in out TTokenId; Token : in out TTokenStr; Result : out Boolean; Debug : Boolean := False) is
  State : TState := TheState;

procedure Actioncompilation_unit is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PackageId =>
      declare
        LResult : Boolean;
      begin
        Automate(package_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit2;
            else
          State := stError;
          end if;
        end;
    when ImportId =>
      declare
        LResult : Boolean;
      begin
        Automate(import_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit2;
            else
          State := stError;
          end if;
        end;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId | ClassId | InterfaceId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(type_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit3;
            else
          State := stError;
          end if;
        end;
    when EotId =>
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncompilation_unit2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ImportId =>
      declare
        LResult : Boolean;
      begin
        Automate(import_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit2;
            else
          State := stError;
          end if;
        end;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId | ClassId | InterfaceId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(type_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit3;
            else
          State := stError;
          end if;
        end;
    when EotId =>
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncompilation_unit3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId | ClassId | InterfaceId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(type_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := compilation_unit3;
            else
          State := stError;
          end if;
        end;
    when EotId =>
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionpackage_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(PackageList, Token);
      State := package_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionpackage_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      Add(PackageList, '.');
      State := package_statement;
    when PointVirgId =>
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionimport_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      ImportUnit := Token;
      State := import_statement2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionimport_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      ImportUnit := ImportUnit & '.';
      State := import_statement3;
    when PointVirgId =>
      ImportClassList.Add (ImportUnit);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionimport_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      ImportUnit := ImportUnit & Token;
      State := import_statement2;
    when EtoileId =>
      ImportUnit := ImportUnit & '*';
      State := import_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionimport_statement4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      ImportClassList.AddAll (ImportUnit);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontype_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId =>
      ClassList.Append(new TJavaClass);
      ClassList.Last_Element.SetModifier(Token);
      State := type_declaration2;
    when ClassId =>
      ClassList.Append(new TJavaClass);
      declare
        LResult : Boolean;
      begin
        Automate(class_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := type_declaration3;
            else
          State := stError;
          end if;
        end;
    when InterfaceId =>
      ClassList.Append(new TJavaClass);
      ClassList.Last_Element.SetInterface;
      declare
        LResult : Boolean;
      begin
        Automate(interface_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := type_declaration3;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontype_declaration2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId =>
      ClassList.Last_Element.SetModifier(Token);
      State := type_declaration2;
    when ClassId =>
      declare
        LResult : Boolean;
      begin
        Automate(class_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := type_declaration3;
            else
          State := stError;
          end if;
        end;
    when InterfaceId =>
      ClassList.Last_Element.SetInterface;
      declare
        LResult : Boolean;
      begin
        Automate(interface_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := type_declaration3;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontype_declaration3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when others =>
      DumEvent := Event;
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      AddNew(ObjectSpecList, "package " & Current(PackageList) & Token & " is");
      AddNew(ObjectBodyList, "package body " & Current(PackageList) & Token & " is");
      ClassList.Last_Element.SetId(Token);
      State := class_declaration2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ExtendsId =>
      State := class_declaration3;
    when ImplementsId =>
      State := class_declaration4;
    when AccoladeGaucheId =>
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := class_declaration5;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(ClassList.Last_Element.GetParentList, Token);
      State := class_declaration31;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration31 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      Add(ClassList.Last_Element.GetParentList, '.');
      State := class_declaration3;
    when ImplementsId =>
      AddNew(ClassList.Last_Element.GetParentList);
      State := class_declaration4;
    when AccoladeGaucheId =>
      AddNew(ClassList.Last_Element.GetParentList);
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := class_declaration5;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(ClassList.Last_Element.GetParentList, Token);
      State := class_declaration41;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration41 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      Add(ClassList.Last_Element.GetParentList, '.');
      State := class_declaration4;
    when VirgId =>
      AddNew(ClassList.Last_Element.GetParentList);
      State := class_declaration4;
    when AccoladeGaucheId =>
      AddNew(ClassList.Last_Element.GetParentList);
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := class_declaration5;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionclass_declaration5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeDroiteId =>
      if not ClassList.Last_Element.IsClosed then
        ClassList.Last_Element.Add(ObjectSpecList);
        if not ClassList.Last_Element.GetInterface then
          if ClassList.Last_Element.GetFieldList.Vide then
            AddNew(ObjectSpecList, " null record;");
          else
            AddNew(ObjectSpecList, " record");
            Copy(ClassList.Last_Element.GetFieldList, ObjectSpecList);
            Done(ClassList.Last_Element.GetFieldList);
          AddNew(ObjectSpecList, "end record;");
          end if;
        else
            AddNew(ObjectSpecList, ';');
        end if;
      end if;
      AddNew(ObjectSpecList, "end " & ClassList.Last_Element.GetId & ';');
      AddNew(ObjectBodyList, "end " & ClassList.Last_Element.GetId & ';');
      ClassList.Delete_Last;
      State := stQuit;
    when EotId =>
      State := stQuit;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := class_declaration5;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actioninterface_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      AddNew(ObjectSpecList, "package " & Current(PackageList) & Token & " is");
      AddNew(ObjectBodyList, "package body " & Current(PackageList) & Token & " is");
      ClassList.Last_Element.SetId(Token);
      State := interface_declaration2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninterface_declaration2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ExtendsId =>
      State := interface_declaration3;
    when AccoladeGaucheId =>
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := interface_declaration5;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninterface_declaration3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(ClassList.Last_Element.GetParentList, Token);
      State := interface_declaration31;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninterface_declaration31 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      Add(ClassList.Last_Element.GetParentList, '.');
      State := interface_declaration3;
    when VirgId =>
      AddNew(ClassList.Last_Element.GetParentList);
      State := interface_declaration3;
    when AccoladeGaucheId =>
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := interface_declaration5;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninterface_declaration5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeDroiteId =>
      if not ClassList.Last_Element.IsClosed then
        ClassList.Last_Element.Add(ObjectSpecList);
        AddNew(ObjectSpecList, ';');
      end if;
      AddNew(ObjectSpecList, "end " & ClassList.Last_Element.GetId & ';');
      AddNew(ObjectBodyList, "end " & ClassList.Last_Element.GetId & ';');
      ClassList.Delete_Last;
      State := stQuit;
    when EotId =>
      State := stQuit;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(field_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := interface_declaration5;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionfield_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId =>
      SetModifier(VarObj, Token);
      State := field_declaration1;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId =>
      SetType(VarObj, Basic, Token);
      State := field_declaration2;
    when UndefId =>
      SetType(VarObj, Class, Token);
      State := field_declaration2;
    when VoidId =>
      SetType(VarObj, Void);
      State := field_declaration2;
    when ClassId =>
      ClassList.Append(new TJavaClass);
      declare
        LResult : Boolean;
      begin
        Automate(class_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when InterfaceId =>
      ClassList.Append(new TJavaClass);
      ClassList.Last_Element.SetInterface;
      declare
        LResult : Boolean;
      begin
        Automate(interface_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      State := stQuit;
    when others =>
      DumEvent := Event;
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actionfield_declaration1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PublicId | PrivateId | ProtectedId | StaticId | FinalId | NativeID | SynchronizedId | AbstractId | ThreadsafeId | TransientId =>
      SetModifier(VarObj, Token);
      State := field_declaration1;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId =>
      SetType(VarObj, Basic, Token);
      State := field_declaration2;
    when UndefId =>
      SetType(VarObj, Class, Token);
      State := field_declaration2;
    when VoidId =>
      SetType(VarObj, Void);
      State := field_declaration2;
    when ClassId =>
      ClassList.Append(new TJavaClass);
      ClassList.Last_Element.SetModifier(VarObj);
      declare
        LResult : Boolean;
      begin
        Automate(class_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when InterfaceId =>
      ClassList.Append(new TJavaClass);
      ClassList.Last_Element.SetModifier(VarObj);
      ClassList.Last_Element.SetInterface;
      declare
        LResult : Boolean;
      begin
        Automate(interface_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when AccoladeGaucheId =>
      DumEvent := Event;
      AddNew(ObjectBodyList, "begin");
      OutputList := ObjectBodyList;
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionfield_declaration2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      SetId(VarObj, Token);
      State := field_declaration3;
    when ParGaucheId =>
      if not ClassList.Last_Element.IsClosed then
        ClassList.Last_Element.Add(ObjectSpecList);
        if not ClassList.Last_Element.GetInterface then
          if ClassList.Last_Element.GetFieldList.Vide then
            AddNew(ObjectSpecList, " null record;");
          else
            AddNew(ObjectSpecList, " record");
            Copy(ClassList.Last_Element.GetFieldList, ObjectSpecList);
            Done(ClassList.Last_Element.GetFieldList);
          AddNew(ObjectSpecList, "end record;");
          end if;
        else
            AddNew(ObjectSpecList, ';');
        end if;
      end if;
      VarObj.SetIdFromType;
      Add(ObjectSpecList, "function New_" & VarObj.GetId & "(");
      Add(ObjectBodyList, "function New_" & VarObj.GetId & "(");
      State := constructor_declaration;
    when CrochetGaucheId | EgalId | VirgId =>
      DumEvent := Event;
      OutputList := ObjectSpecList;
      FieldList  := ClassList.Last_Element.GetFieldList;
      State := variable_declaration;
    when PointVirgId =>
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionfield_declaration3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      if not ClassList.Last_Element.IsClosed then
        ClassList.Last_Element.Add(ObjectSpecList);
        if not ClassList.Last_Element.GetInterface then
          if ClassList.Last_Element.GetFieldList.Vide then
            AddNew(ObjectSpecList, " null record;");
          else
            AddNew(ObjectSpecList, " record");
            Copy(ClassList.Last_Element.GetFieldList, ObjectSpecList);
            Done(ClassList.Last_Element.GetFieldList);
          AddNew(ObjectSpecList, "end record;");
          end if;
        else
            AddNew(ObjectSpecList, ';');
        end if;
      end if;
      if VarObj.GetTypeNature = Void then
        Add(ObjectSpecList, "procedure " & VarObj.GetId & "(This : access Typ");
        Add(ObjectBodyList, "procedure " & VarObj.GetId & "(This : access Typ");
      else
        Add(ObjectSpecList, "function " & VarObj.GetId & "(This : access Typ");
        Add(ObjectBodyList, "function " & VarObj.GetId & "(This : access Typ");
      end if;
      State := method_declaration;
    when CrochetGaucheId | EgalId | VirgId =>
      DumEvent := Event;
      OutputList := ObjectSpecList;
      FieldList  := ClassList.Last_Element.GetFieldList;
      State := variable_declaration;
    when PointVirgId =>
      VarObj.Add(ObjectSpecList, ClassList.Last_Element.GetFieldList);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId | BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId | VoidId | FinalId =>
      DumEvent := Event;
      Add(ObjectSpecList, "; ");
      Add(ObjectBodyList, "; ");
      declare
        LResult : Boolean;
      begin
        Automate(parameter_list, DumEvent, Token, LResult, Debug);
        if LResult then
      State := method_declaration41;
            else
          State := stError;
          end if;
        end;
    when ParDroiteId =>
      Add(ObjectSpecList, ')');
      Add(ObjectBodyList, ')');
      State := method_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration41 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      Add(ObjectSpecList, ')');
      Add(ObjectBodyList, ')');
      State := method_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetGaucheId =>
      State := method_declaration51;
    when AccoladeGaucheId =>
      DumEvent := Event;
      if VarObj.GetTypeNature /= Void then
        Add(ObjectBodyList, " return " & VarObj.GetType);
        Add(ObjectSpecList, " return " & VarObj.GetType);
      end if;
      AddNew(ObjectBodyList, " is");
      AddNew(ObjectBodyList, "begin");
      OutputList := ObjectBodyList;
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(ObjectBodyList, "end;");
      AddNew(ObjectSpecList, ';');
      OutputList := ObjectSpecList;
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      if VarObj.GetTypeNature /= Void then
        Add(ObjectSpecList, " return " & VarObj.GetType);
      end if;
      if VarObj.IsAbstract or else ClassList.Last_Element.GetInterface then
        AddNew(ObjectSpecList, " is abstract;");
        AddNew(ObjectBodyList, ';');
      else
        AddNew(ObjectSpecList, ';');
        AddNew(ObjectBodyList, ';');
      end if;
      State := stQuit;
    when ThrowsId =>
      State := method_declaration6;
    when VirgId =>
      State := method_declaration6;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration51 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetDroitId =>
      State := method_declaration52;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration52 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeGaucheId =>
      DumEvent := Event;
      if VarObj.GetTypeNature /= Void then
        Add(ObjectBodyList, " return " & VarObj.GetType);
        Add(ObjectSpecList, " return " & VarObj.GetType);
      end if;
      AddNew(ObjectBodyList, " is");
      AddNew(ObjectBodyList, "begin");
      OutputList := ObjectBodyList;
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(ObjectBodyList, "end;");
      AddNew(ObjectSpecList, ';');
      OutputList := ObjectSpecList;
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      State := stQuit;
    when ThrowsId =>
      State := method_declaration7;
    when VirgId =>
      State := method_declaration7;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration6 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      State := method_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionmethod_declaration7 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      State := method_declaration52;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionconstructor_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId | BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId | VoidId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(parameter_list, DumEvent, Token, LResult, Debug);
        if LResult then
      State := constructor_declaration41;
            else
          State := stError;
          end if;
        end;
    when ParDroiteId =>
      Add(ObjectSpecList, "aThis : Ref := null) return Ref");
      Add(ObjectBodyList, "aThis : Ref := null) return Ref");
      State := constructor_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionconstructor_declaration41 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      Add(ObjectSpecList, "; aThis : Ref := null) return Ref");
      Add(ObjectBodyList, "; aThis : Ref := null) return Ref");
      State := constructor_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionconstructor_declaration5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeGaucheId =>
      DumEvent := Event;
      AddNew(ObjectBodyList, " is");
      AddNew(ObjectBodyList, "  This : Ref := aThis;");
      AddNew(ObjectBodyList, "begin");
      AddNew(ObjectBodyList, "if This = null then");
      AddNew(ObjectBodyList, "  This := new Typ;");
      AddNew(ObjectBodyList, "end if;");
      OutputList := ObjectBodyList;
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(ObjectBodyList, "return This;");
      AddNew(ObjectBodyList, "end;");
      AddNew(ObjectSpecList, ';');
      OutputList := ObjectSpecList;
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      State := stQuit;
    when ThrowsId =>
      State := constructor_declaration6;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionconstructor_declaration6 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      State := constructor_declaration5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionstatement_block is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeGaucheId =>
      declare
        LResult : Boolean;
      begin
        Automate(statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := statement_block1;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionstatement_block1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeDroiteId =>
      State := stQuit;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := statement_block1;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_declaration is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetGaucheId =>
      IncTabIndex(VarObj);
      State := variable_declaration1;
    when EgalId =>
      SavedOutputList := OutputList;
      OutputList := GetInitText(VarObj);
      Add(OutputList, " := ");
      declare
        LResult : Boolean;
      begin
        Automate(variable_initializer, DumEvent, Token, LResult, Debug);
        if LResult then
      OutputList := SavedOutputList;
      State := variable_declaration2;
            else
          State := stError;
          end if;
        end;
    when VirgId =>
      VarObj.Add(OutputList, FieldList);
      State := variable_declaration3;
    when PointVirgId =>
      VarObj.Add(OutputList, FieldList);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_declaration1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetDroitId =>
      State := variable_declaration11;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_declaration11 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      SetId(VarObj, Token);
      State := variable_declaration11;
    when CrochetGaucheId =>
      IncTabIndex(VarObj);
      State := variable_declaration1;
    when EgalId =>
      SavedOutputList := OutputList;
      OutputList := GetInitText(VarObj);
      Add(OutputList, " := ");
      declare
        LResult : Boolean;
      begin
        Automate(variable_initializer, DumEvent, Token, LResult, Debug);
        if LResult then
      OutputList := SavedOutputList;
      State := variable_declaration2;
            else
          State := stError;
          end if;
        end;
    when VirgId =>
      VarObj.Add(OutputList, FieldList);
      State := variable_declaration3;
    when PointVirgId =>
      VarObj.Add(OutputList, FieldList);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_declaration2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when VirgId =>
      VarObj.Add(OutputList, FieldList);
      State := variable_declaration3;
    when PointVirgId =>
      VarObj.Add(OutputList, FieldList);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_declaration3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      SetId(VarObj, Token);
      State := variable_declaration;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_initializer is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeGaucheId =>
      Add(OutputList, "new j2a_" & GetId(VarObj) & "'(");
      State := variable_initializer1;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_initializer1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := variable_initializer2;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionvariable_initializer2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeDroiteId =>
      Add(OutputList, ')');
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when FinalId =>
      SetModifier(ParaObj, Token);
      State := parameter_list0;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId | VoidId =>
      ParaObj.SetType (Basic, Token);
      State := parameter_list1;
    when UndefId =>
      ParaObj.SetType (Class, Token);
      State := parameter_list1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list0 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId | VoidId =>
      ParaObj.SetType (Basic, Token);
      State := parameter_list1;
    when UndefId =>
      ParaObj.SetType (Class, Token);
      State := parameter_list1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      ParaObj.SetId (Token);
      State := parameter_list2;
    when CrochetGaucheId =>
      ParaObj.IncTabIndex;
      State := parameter_list21;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetGaucheId =>
      ParaObj.IncTabIndex;
      State := parameter_list21;
    when VirgId =>
      ParaObj.Add(ObjectSpecList);
      ParaObj.Add(ObjectBodyList);
      Add(ObjectSpecList, "; ");
      Add(ObjectBodyList, "; ");
      State := parameter_list;
    when others =>
      DumEvent := Event;
      ParaObj.Add(ObjectSpecList);
      ParaObj.Add(ObjectBodyList);
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list21 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetDroitId =>
      State := parameter_list22;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionparameter_list22 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      ParaObj.SetId (Token);
      State := parameter_list22;
    when VirgId =>
      ParaObj.Add(ObjectSpecList);
      ParaObj.Add(ObjectBodyList);
      Add(ObjectSpecList, "; ");
      Add(ObjectBodyList, "; ");
      State := parameter_list;
    when others =>
      DumEvent := Event;
      ParaObj.Add(ObjectSpecList);
      ParaObj.Add(ObjectBodyList);
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actionstatement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId | VoidId =>
      SetType(VarObj, Basic,  Token);
      State := V1;
    when UndefId =>
      SetType(VarObj, Class,  Token);
      State := V1;
    when AccoladeGaucheId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when IfId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(if_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when DoId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(do_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when WhileId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(while_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when ForId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(for_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when TryId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(try_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when SwitchId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(switch_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when AssertId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(assert_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when SynchronizedId =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(synchronized_statement, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when ReturnId =>
      Add(OutputList, Token);
      State := R1;
    when ThrowId =>
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := T1;
            else
          State := stError;
          end if;
        end;
    when BreakId =>
      Add(OutputList, Token);
      State := B1;
    when ContinueId =>
      Add(OutputList, Token);
      State := C1;
    when PointVirgId =>
      AddNew(OutputList, "null;");
      State := stQuit;
    when AccoladeDroiteId =>
      DumEvent := Event;
      State := stQuit;
    when CrochetDroitId =>
      State := stQuit;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := E1;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure ActionR1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := R2;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure ActionR2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionT1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionB1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(OutputList, ' ' & Token);
      State := B2;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionB2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionC1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(OutputList, ' ' & Token);
      State := C2;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionC2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionE1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when AccoladeDroiteId =>
      DumEvent := Event;
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure ActionV1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      SetId(VarObj, Token);
      FieldList := OutputList;
      AddNew(OutputList, "--  Help J2Ada : put it before begin");
      declare
        LResult : Boolean;
      begin
        Automate(variable_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when CrochetGaucheId =>
      DumEvent := Event;
      FieldList := OutputList;
      AddNew(OutputList, "--  Help J2Ada : put it before begin");
      declare
        LResult : Boolean;
      begin
        Automate(variable_declaration, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      SetIdFromType(VarObj);
      Add(OutputList, VarObj.GetId);
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := E1;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionif_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when IfId =>
      Add(OutputList, "if ");
      State := if_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionif_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      Add(OutputList, '(');
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := if_statement2;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionif_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      Add(OutputList, ')');
      State := if_statement21;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionif_statement21 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "then");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := if_statement3;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionif_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ElseId =>
      AddNew(OutputList, "else");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(OutputList, "end if;");
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "end if;");
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actiondo_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when DoId =>
      AddNew(OutputList, "loop");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := do_statement1;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiondo_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when WhileId =>
      Add(OutputList, "exit when ");
      State := do_statement2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiondo_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      Add(OutputList, '(');
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := do_statement3;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiondo_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      AddNew(OutputList, ");");
      State := do_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiondo_statement4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, "end loop;");
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionwhile_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when WhileId =>
      Add(OutputList, "while ");
      State := while_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionwhile_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      Add(OutputList, '(');
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := while_statement2;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionwhile_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      AddNew(OutputList, ')');
      State := while_statement3;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionwhile_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "loop");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(OutputList, "end loop;");
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ForId =>
      State := for_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      State := for_statement2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      State := for_statement3;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "declare");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := for_statement3;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, "begin");
      Add(OutputList, "while (True");
      State := for_statement4;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "begin");
      Add(OutputList, "while (");
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := for_statement31;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement31 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      State := for_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      State := for_statement5;
    when ParDroiteId =>
      AddNew(OutputList, ')');
      AddNew(OutputList, "loop");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      AddNew(OutputList, "end loop;");
      AddNew(OutputList, "end;");
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      SavedOutputList := OutputList;
      OutputList := TempList;
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      OutputList := SavedOutputList;
      State := for_statement5;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionfor_statement5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      AddNew(OutputList, ')');
      AddNew(OutputList, "loop");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      Copy(TempList, OutputList);
      Done(TempList);
      AddNew(OutputList, ";");
      AddNew(OutputList, "end loop;");
      AddNew(OutputList, "end;");
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when TryId =>
      AddNew(OutputList, "declare");
      AddNew(OutputList, "begin");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := try_statement1;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CatchId =>
      AddNew(OutputList, "exception");
      State := try_statement2;
    when FinallyId =>
      AddNew(OutputList, "end;");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      AddNew(OutputList, "end;");
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      State := try_statement3;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      Add(OutputList, "when " & Token & ':');
      State := try_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      AddNew(OutputList, Token & " =>");
      State := try_statement5;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actiontry_statement5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := try_statement1;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when SwitchId =>
      Add(OutputList, "case ");
      State := switch_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      Add(OutputList, '(');
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := switch_statement2;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      AddNew(OutputList, ") is");
      State := switch_statement3;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AccoladeGaucheId =>
      State := switch_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement4 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CaseId =>
      Add(OutputList, "when ");
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := switch_statement5;
            else
          State := stError;
          end if;
        end;
    when DefaultId =>
      AddNew(OutputList, "when others");
      State := switch_statement5;
    when AccoladeDroiteId =>
      AddNew(OutputList, "end case;");
      State := stQuit;
    when BreakId =>
      State := switch_statement6;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CaseId =>
      Add(OutputList, '|');
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := switch_statement5;
            else
          State := stError;
          end if;
        end;
    when DeuxPointsId =>
      Add(OutputList, " => ");
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := switch_statement4;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionswitch_statement6 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      State := switch_statement4;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionassert_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when AssertId =>
      Add(OutputList, "pragma Assert (");
      State := assert_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionassert_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when others =>
      DumEvent := Event;
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      Add(OutputList, ')');
      State := assert_statement2;
            else
          State := stError;
          end if;
        end;
    end case;
  Event := DumEvent;
  end;


procedure Actionassert_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointVirgId =>
      AddNew(OutputList, Token);
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionsynchronized_statement is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when SynchronizedId =>
      State := synchronized_statement1;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionsynchronized_statement1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParGaucheId =>
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := synchronized_statement2;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionsynchronized_statement2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      declare
        LResult : Boolean;
      begin
        Automate(statement_block, DumEvent, Token, LResult, Debug);
        if LResult then
      State := stQuit;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actionexpression is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when MoinsId | MoinsEgalId | PlusPlusId | MoinsMoinsId | PlusId | PlusEgalId | EtoileId | EtoileEgalId | BarreId | DivEgalId | PourcentId | PourcentEgalId | SupId | InfId | SupEgalId | InfEgalId | SupSupSupEgalId | EgalEgalId | ExclamEgalId | ExclamId | EtId | EtEgalId | PipeId | PipeEgalId | XorId | XorEgalId | EtEtId | PipePipeId | TrueId | FalseId | TildeId | InfInfId | SupSupId | SupSupSupId | IntegerId | RealId | StringId | CarId | NullId | SuperId | ThisId | EgalId | UndefId | PointId | VirgId =>
      Add(OutputList, ' ' & Token);
      State := expression;
    when NewId =>
      if GetTypeNature (VarObj) = Class then
        Add(OutputList, GetBaseType (VarObj) & ".New");
      else
        Add(OutputList, "new");
      end if;
      State := creating_expression;
    when CrochetDroitId =>
      DumEvent := Event;
      State := stQuit;
    when ParGaucheId =>
      MethObj.PushPara;
      declare
        LResult : Boolean;
      begin
        Automate(inner_expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := expression;
            else
          State := stError;
          end if;
        end;
    when InterroId =>
      Add(OutputList, ' ' & Token);
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := expression1;
            else
          State := stError;
          end if;
        end;
    when others =>
      DumEvent := Event;
      State := stQuit;
    end case;
  Event := DumEvent;
  end;


procedure Actionexpression1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when DeuxPointsId =>
      Add(OutputList, ' ' & Token);
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := expression;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninner_expression is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when MoinsId | MoinsEgalId | PlusPlusId | MoinsMoinsId | PlusId | PlusEgalId | EtoileId | EtoileEgalId | BarreId | DivEgalId | PourcentId | PourcentEgalId | SupId | InfId | SupEgalId | InfEgalId | SupSupSupEgalId | EgalEgalId | ExclamEgalId | ExclamId | EtId | EtEgalId | PipeId | PipeEgalId | XorId | XorEgalId | EtEtId | PipePipeId | TrueId | FalseId | TildeId | InfInfId | SupSupId | SupSupSupId | IntegerId | RealId | StringId | CarId | NullId | SuperId | ThisId | EgalId | UndefId | PointId | VirgId =>
      if not MethObj.IsParaPresent then
        Add(OutputList, '(');
      end if;
      MethObj.SetParaPresent(True);
      Add(OutputList, ' ' & Token);
      State := inner_expression;
    when NewId =>
      if not MethObj.IsParaPresent then
        Add(OutputList, '(');
      end if;
      MethObj.SetParaPresent(True);
      Add(OutputList, "new");
      declare
        LResult : Boolean;
      begin
        Automate(creating_expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := inner_expression;
            else
          State := stError;
          end if;
        end;
    when ParGaucheId =>
      MethObj.PushPara;
      declare
        LResult : Boolean;
      begin
        Automate(inner_expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := inner_expression;
            else
          State := stError;
          end if;
        end;
    when ParDroiteId =>
      if MethObj.IsParaPresent then
        Add(OutputList, ')');
      end if;
      MethObj.PopPara;
      State := stQuit;
    when InterroId =>
      Add(OutputList, ' ' & Token);
      declare
        LResult : Boolean;
      begin
        Automate(inner_expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := inner_expression1;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioninner_expression1 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when DeuxPointsId =>
      Add(OutputList, ' ' & Token);
      declare
        LResult : Boolean;
      begin
        Automate(inner_expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := inner_expression;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when BooleanId | ByteId | CharId | DoubleId | FloatId | IntId | LongId | ShortId =>
      SetNewType(VarObj, Basic, Token);
      State := creating_expression2;
    when UndefId =>
      SetNewType(VarObj, Class, Token);
      State := creating_expression2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression2 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when PointId =>
      State := creating_expression3;
    when ParGaucheId =>
      DumEvent := Event;
      Add(OutputList, '_' & GetBaseType(VarObj));
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := creating_expression42;
            else
          State := stError;
          end if;
        end;
    when CrochetGaucheId =>
      Add(OutputList, " j2a_" & GetId(VarObj) & "(0..");
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := creating_expression21;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      DumEvent := Event;
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression21 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetDroitId =>
      Add(OutputList, "-1");
      State := creating_expression5;
    when PointVirgId =>
      DumEvent := Event;
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression3 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when UndefId =>
      State := creating_expression2;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression41 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when VirgId =>
      AddNew(OutputList, Token);
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := creating_expression41;
            else
          State := stError;
          end if;
        end;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression42 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when ParDroiteId =>
      DumEvent := Event;
      State := stQuit;
    when PointVirgId =>
      DumEvent := Event;
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


procedure Actioncreating_expression5 is
  DumEvent : TTokenId;

  begin
  DumEvent := NullId;
  case Event is
    when CommentId =>
      AddNew(OutputList, Token);
      null;
    when NewLineId =>
      if Debug then
        Status(SrcAuto, NomFich, LigneFich);
        Put_Line("Fichier " & NomFich & ", ligne " & Integer'Image(LigneFich));
      end if;
      null;
    when CrochetGaucheId =>
      Add(OutputList, ", 0..");
      declare
        LResult : Boolean;
      begin
        Automate(expression, DumEvent, Token, LResult, Debug);
        if LResult then
      State := creating_expression21;
            else
          State := stError;
          end if;
        end;
    when PointVirgId =>
      DumEvent := Event;
      Add(OutputList, ')');
      State := stQuit;
    when others =>
      Status(SrcAuto, NomFich, LigneFich);
      Put_Line("Erreur de syntaxe à la ligne " & Integer'Image(LigneFich) & " , " & TTokenId'Image(Event) & " , " & Token);
      State := stError;
    end case;
  Event := DumEvent;
  end;


  begin
  Result := Event = NullId;
  while (State /= stError) and (State /= stQuit) loop
    while Event = NullId loop
      ReadToken(Event, Token);
    end loop;
    if Debug then
      Put(TState'Image(State) & "; " & TTokenId'Image(Event));
      if not Result then
        Put("+");
        Result := True;
      end if;
      Put_Line("; " & Token);
    end if;
    case State is
      when compilation_unit => Actioncompilation_unit;
      when compilation_unit2 => Actioncompilation_unit2;
      when compilation_unit3 => Actioncompilation_unit3;
      when package_statement => Actionpackage_statement;
      when package_statement1 => Actionpackage_statement1;
      when import_statement => Actionimport_statement;
      when import_statement2 => Actionimport_statement2;
      when import_statement3 => Actionimport_statement3;
      when import_statement4 => Actionimport_statement4;
      when type_declaration => Actiontype_declaration;
      when type_declaration2 => Actiontype_declaration2;
      when type_declaration3 => Actiontype_declaration3;
      when class_declaration => Actionclass_declaration;
      when class_declaration2 => Actionclass_declaration2;
      when class_declaration3 => Actionclass_declaration3;
      when class_declaration31 => Actionclass_declaration31;
      when class_declaration4 => Actionclass_declaration4;
      when class_declaration41 => Actionclass_declaration41;
      when class_declaration5 => Actionclass_declaration5;
      when interface_declaration => Actioninterface_declaration;
      when interface_declaration2 => Actioninterface_declaration2;
      when interface_declaration3 => Actioninterface_declaration3;
      when interface_declaration31 => Actioninterface_declaration31;
      when interface_declaration5 => Actioninterface_declaration5;
      when field_declaration => Actionfield_declaration;
      when field_declaration1 => Actionfield_declaration1;
      when field_declaration2 => Actionfield_declaration2;
      when field_declaration3 => Actionfield_declaration3;
      when method_declaration => Actionmethod_declaration;
      when method_declaration41 => Actionmethod_declaration41;
      when method_declaration5 => Actionmethod_declaration5;
      when method_declaration51 => Actionmethod_declaration51;
      when method_declaration52 => Actionmethod_declaration52;
      when method_declaration6 => Actionmethod_declaration6;
      when method_declaration7 => Actionmethod_declaration7;
      when constructor_declaration => Actionconstructor_declaration;
      when constructor_declaration41 => Actionconstructor_declaration41;
      when constructor_declaration5 => Actionconstructor_declaration5;
      when constructor_declaration6 => Actionconstructor_declaration6;
      when statement_block => Actionstatement_block;
      when statement_block1 => Actionstatement_block1;
      when variable_declaration => Actionvariable_declaration;
      when variable_declaration1 => Actionvariable_declaration1;
      when variable_declaration11 => Actionvariable_declaration11;
      when variable_declaration2 => Actionvariable_declaration2;
      when variable_declaration3 => Actionvariable_declaration3;
      when variable_initializer => Actionvariable_initializer;
      when variable_initializer1 => Actionvariable_initializer1;
      when variable_initializer2 => Actionvariable_initializer2;
      when parameter_list => Actionparameter_list;
      when parameter_list0 => Actionparameter_list0;
      when parameter_list1 => Actionparameter_list1;
      when parameter_list2 => Actionparameter_list2;
      when parameter_list21 => Actionparameter_list21;
      when parameter_list22 => Actionparameter_list22;
      when statement => Actionstatement;
      when R1 => ActionR1;
      when R2 => ActionR2;
      when T1 => ActionT1;
      when B1 => ActionB1;
      when B2 => ActionB2;
      when C1 => ActionC1;
      when C2 => ActionC2;
      when E1 => ActionE1;
      when V1 => ActionV1;
      when if_statement => Actionif_statement;
      when if_statement1 => Actionif_statement1;
      when if_statement2 => Actionif_statement2;
      when if_statement21 => Actionif_statement21;
      when if_statement3 => Actionif_statement3;
      when do_statement => Actiondo_statement;
      when do_statement1 => Actiondo_statement1;
      when do_statement2 => Actiondo_statement2;
      when do_statement3 => Actiondo_statement3;
      when do_statement4 => Actiondo_statement4;
      when while_statement => Actionwhile_statement;
      when while_statement1 => Actionwhile_statement1;
      when while_statement2 => Actionwhile_statement2;
      when while_statement3 => Actionwhile_statement3;
      when for_statement => Actionfor_statement;
      when for_statement1 => Actionfor_statement1;
      when for_statement2 => Actionfor_statement2;
      when for_statement3 => Actionfor_statement3;
      when for_statement31 => Actionfor_statement31;
      when for_statement4 => Actionfor_statement4;
      when for_statement5 => Actionfor_statement5;
      when try_statement => Actiontry_statement;
      when try_statement1 => Actiontry_statement1;
      when try_statement2 => Actiontry_statement2;
      when try_statement3 => Actiontry_statement3;
      when try_statement4 => Actiontry_statement4;
      when try_statement5 => Actiontry_statement5;
      when switch_statement => Actionswitch_statement;
      when switch_statement1 => Actionswitch_statement1;
      when switch_statement2 => Actionswitch_statement2;
      when switch_statement3 => Actionswitch_statement3;
      when switch_statement4 => Actionswitch_statement4;
      when switch_statement5 => Actionswitch_statement5;
      when switch_statement6 => Actionswitch_statement6;
      when assert_statement => Actionassert_statement;
      when assert_statement1 => Actionassert_statement1;
      when assert_statement2 => Actionassert_statement2;
      when synchronized_statement => Actionsynchronized_statement;
      when synchronized_statement1 => Actionsynchronized_statement1;
      when synchronized_statement2 => Actionsynchronized_statement2;
      when expression => Actionexpression;
      when expression1 => Actionexpression1;
      when inner_expression => Actioninner_expression;
      when inner_expression1 => Actioninner_expression1;
      when creating_expression => Actioncreating_expression;
      when creating_expression2 => Actioncreating_expression2;
      when creating_expression21 => Actioncreating_expression21;
      when creating_expression3 => Actioncreating_expression3;
      when creating_expression41 => Actioncreating_expression41;
      when creating_expression42 => Actioncreating_expression42;
      when creating_expression5 => Actioncreating_expression5;
      when others =>
        null;
      end case;
    end loop;
  Result := State /= stError;
  end Automate;

procedure Startjavaseq(Result : out Boolean; Debug : Boolean := False) is
  Event : TTokenId;
  Token : TTokenStr;
  begin
  ReadToken(Event, Token);
  Automate(compilation_unit, Event, Token, Result, Debug);
  end Startjavaseq;

end javaseq;
