pageextension 43160 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("Testing Workflows Nos."; Rec."Tuesday Workflows Nos.")
            {
                Caption = 'Testing Workflows Nos.';
                ApplicationArea = All;

            }
        }
    }
}
