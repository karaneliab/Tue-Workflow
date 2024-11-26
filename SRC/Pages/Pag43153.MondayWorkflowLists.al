page 43163 "Tuesday Workflow Lists"
{
    ApplicationArea = All;
    Caption = 'Tuesday Workflow Lists';
    PageType = List;
    SourceTable = "Tuesday Workflow";
    UsageCategory = Lists;
    CardPageId = "Tuesday Workflow card";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Descrition; Rec.Descrition)
                {
                    ToolTip = 'Specifies the value of the Descrition field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
            }
        }
    }
}
