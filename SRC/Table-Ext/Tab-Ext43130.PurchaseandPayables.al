tableextension 43160 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    fields
    {
        field(431334; "Tuesday Workflows Nos.";code[20])
        {
            Caption = 'TUesday Workflows Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
