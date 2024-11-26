codeunit 43160 "Tuesday Approval Mgt."
{
    procedure CheckWorkflowEnabled(var Tuesday: Record "Tuesday Workflow"): Boolean
    begin
        if not IsWorkflowEnabled(Tuesday) then
            Error(NoWorkflowEnabledErr);
        exit(true)
    end;

    Procedure IsWorkflowEnabled(var Tuesday: Record "Tuesday Workflow"): Boolean
    begin
       exit(WorkflowMgmt.CanExecuteWorkflow(Tuesday, WorkflowEventHandling.RunOnSendTuesdayWorkflowForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTuesdayWorkflowForApproval(var Tuesday: Record "Tuesday Workflow")
    begin
    end;


    [IntegrationEvent(false, false)]
    procedure OnCancelTuesdayWorkflowApprovalRequest(var Tuesday: Record "Tuesday Workflow")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)

    var
        Tuesday: Record "Tuesday Workflow";
    begin
        case
            Recref.Number of
            Database::"Tuesday Workflow":
                begin
                    RecRef.SetTable(Tuesday);
                    Tuesday.Status := Tuesday.Status::"Pending Approvall";
                    Tuesday.Validate(Status, Tuesday.Status::"Pending Approvall");
                    IsHandled := true;
                    Variant := Tuesday;
                    Tuesday.Modify(true)
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Tuesday: Record "Tuesday Workflow";
    begin
        if RecRef.Number = Database::"Tuesday Workflow" then begin
            RecRef.SetTable(Tuesday);
            ApprovalEntryArgument."Document No." := Tuesday."No.";
            ApprovalEntryArgument."Table ID" := RecRef.Number;
            ApprovalEntryArgument.Insert(true)
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Tuesday: Record "Tuesday Workflow";
        Recref: RecordRef;
    begin
        Recref.Get(ApprovalEntry."Record ID to Approve");
        case
            Recref.Number of
            Database::"Tuesday Workflow":
                begin
                    Recref.SetTable(Tuesday);
                    Tuesday.Status := Tuesday.Status::"Rejected";
                    Tuesday.Modify(true)
                end;


        end;
    end;




    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling Tue.";
        WorkflowMgmt: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No Approval Workflow for this record type is enabled';
        TuesdayOnCancelWorkflowForApprovalRequestEventDescTxt: Label 'An Approval request for Tuesday Approval request is cancelled.';

        TuesdayOnSendWorkflowForApprovalEventDescTxt: Label 'An Approval request for Tuesday  Approval  is requested.';
}
