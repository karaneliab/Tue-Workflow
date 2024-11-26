table 43160 "Tuesday Workflow"
{
    Caption = 'Tuesday Workflow';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Tuesday Workflows Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Descrition; Text[250])
        {
            Caption = 'Descrition';
        }
        field(3; Status; Enum "Approval Status")
        {
            Caption = 'Status';
        }
        field(4; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    begin
        PurchSetup.Get();
        PurchSetup.TestField("Tuesday Workflows Nos.");
        if "No." = '' then
            "No." := NoSeerie.GetNextNo(PurchSetup."Tuesday Workflows Nos.", Today);
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeerie: Codeunit "No. Series";


}
