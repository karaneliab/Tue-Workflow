codeunit 43164 "Document. Release"
{
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenNext(var Tuesday: Record "Tuesday Workflow")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenNext(var Tuesday: Record "Tuesday Workflow")
    begin
    end;

    procedure NextReopen(var Tuesday: Record "Tuesday Workflow")
    begin
        OnBeforeReopenNext(Tuesday);
        if Tuesday.Status = Tuesday.Status::Created then
            exit;
        Tuesday.Status := Tuesday.Status::Created;
        Tuesday.modify(true);
        OnAfterReopenNext(Tuesday);

    end;

    procedure TuesdayRelease(var Tuesday: Record "Tuesday Workflow")
    begin
        Tuesday.Status := Tuesday.Status::Approved;
        Tuesday.Validate(Status,Tuesday.Status::Approved);
        Tuesday.Modify(True)
    end;

    var
        ReleaseDoc: Codeunit "Document. Release";
}
