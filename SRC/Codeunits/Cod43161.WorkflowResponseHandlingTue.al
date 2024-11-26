codeunit 43161 "Workflow Response Handling Tue"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Tuesday: Record "Tuesday Workflow";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            Database::"Tuesday Workflow":
                begin
                    Tuesday.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.TuesdayRelease(VarVariant);
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Tuesday: Record "Tuesday Workflow";
    begin
        case 
            Recref.Number of 
            Database::"Tuesday Workflow":
            begin
                Tuesday.SetView(RecRef.GetView());
                Handled := true;
                ReleaseDoc.NextReopen(Tuesday);
        end;
    end;
    end;

    var
        ReleaseDoc: Codeunit "Document. Release";
}

