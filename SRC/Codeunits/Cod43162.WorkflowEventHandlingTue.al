codeunit 43162 "Workflow Event Handling Tue."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Tuesday Approval Mgt.", 'OnSendTuesdayWorkflowForApproval', '', FALSE, FALSE)]
    procedure RunOnSendTuesdayWorkflowForApproval(var Tuesday: Record "Tuesday Workflow")
    begin
        WorkflowMgt.HandleEvent(RunOnSendTuesdayWorkflowForApprovalCode, Tuesday);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Tuesday Approval Mgt.", 'OnCancelTuesdayWorkflowApprovalRequest', '', false, false)]
    local procedure RunOnCancelTuesdayWorkflowApprovalRequest(var Tuesday: Record "Tuesday Workflow")
    begin
        WorkflowMgt.HandleEvent(RunOnCancelTuesdayWorkflowApprovalRequestCode, Tuesday);
    end;

    procedure RunOnSendTuesdayWorkflowForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunOnSendTuesdayWorkflowForApproval'))
    end;

    procedure RunOnCancelTuesdayWorkflowApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunOnCancelTuesdayWorkflowApprovalRequest'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        Tuesday: Record "Tuesday Workflow";
    begin
        WorkflowEvntHan.AddEventToLibrary(RunOnSendTuesdayWorkflowForApprovalCode, Database::"Tuesday Workflow",
        TuesdayOnSendWorkflowForApprovalEventDescTxt, 0, false);
        WorkflowEvntHan.AddEventToLibrary(RunOnCancelTuesdayWorkflowApprovalRequestCode, Database::"Tuesday Workflow",
        TuesdayOnCancelWorkflowForApprovalRequestEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunOnCancelTuesdayWorkflowApprovalRequestCode:
                WorkflowEvntHan.AddEventPredecessor(RunOnCancelTuesdayWorkflowApprovalRequestCode, RunOnSendTuesdayWorkflowForApprovalCode);
            RunOnSendTuesdayWorkflowForApprovalCode:
                WorkflowEvntHan.AddEventPredecessor(RunOnCancelTuesdayWorkflowApprovalRequestCode, RunOnSendTuesdayWorkflowForApprovalCode);
        end;
    end;



    var
        WorkflowMgt: Codeunit "Workflow Management";
        WorkflowEvntHan: Codeunit "Workflow Event Handling";
        TuesdayOnCancelWorkflowForApprovalRequestEventDescTxt: Label 'An Approval request for Tuesday Approval request is cancelled.';

        TuesdayOnSendWorkflowForApprovalEventDescTxt: Label 'An Approval request for Tuesday  Approval  is requested.';
}
