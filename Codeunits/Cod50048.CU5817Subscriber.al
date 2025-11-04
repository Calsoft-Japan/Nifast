codeunit 50048 CU5817Subscriber
{
    //Version NAVW17.00,NIF1.063;
    var
        Text010: Label 'You cannot undo line %1 because inventory pick lines have already been posted.', Comment = '%1=UndoLineNo';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Posting Management", OnBeforeTestPostedInvtPickLine, '', false, false)]
    local procedure OnBeforeTestPostedInvtPickLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean; UndoType: Integer; UndoID: Code[20])
    var
        PostedInvtPickLine: Record "Posted Invt. Pick Line";
    begin
        IsHandled := true;

        PostedInvtPickLine.SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, true);
        if ShouldThrowErrorForPostedInvtPickLine(PostedInvtPickLine, UndoType, UndoID) then
            //>> NIF 051506 RTT
            IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN
                //<< NIF 051506 RTT
                Error(Text010, UndoLineNo);
    end;

    local procedure ShouldThrowErrorForPostedInvtPickLine(var PostedInvtPickLine: Record "Posted Invt. Pick Line"; UndoType: Integer; UndoID: Code[20]): Boolean
    var
        PostedInvtPickHeader: Record "Posted Invt. Pick Header";
        CheckedPostedInvtPickHeaderList: List of [Text];
    begin
        if PostedInvtPickLine.IsEmpty() then
            exit(false);

        if not (UndoType in [Database::"Sales Shipment Line"]) then
            exit(true);

        PostedInvtPickLine.SetLoadFields("No.");
        if PostedInvtPickLine.FindSet() then
            repeat
                if not CheckedPostedInvtPickHeaderList.Contains(PostedInvtPickLine."No.") then begin
                    CheckedPostedInvtPickHeaderList.Add(PostedInvtPickLine."No.");

                    PostedInvtPickHeader.SetLoadFields("Source Type", "Source No.");
                    if not PostedInvtPickHeader.Get(PostedInvtPickLine."No.") then
                        exit(true);

                    case UndoType of
                        Database::"Sales Shipment Line":
                            begin
                                if PostedInvtPickHeader."Source Type" <> Database::"Sales Shipment Header" then
                                    exit(true);

                                if PostedInvtPickHeader."Source No." = UndoID then
                                    exit(true);
                            end;
                        else
                            exit(true);
                    end;
                end;
            until PostedInvtPickLine.Next() = 0;

        exit(false);
    end;
}