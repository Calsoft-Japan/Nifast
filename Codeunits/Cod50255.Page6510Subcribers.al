codeunit 50255 Page6510Subcriber
{
    [EventSubscriber(ObjectType::page, 6510, 'OnSetSourceSpecOnAfterAssignCurrentEntryStatus', '', True, false)]
    local procedure OnSetSourceSpecOnAfterAssignCurrentEntryStatus(var TrackingSpecification: Record "Tracking Specification"; var CurrentEntryStatus: Option; ItemTrackingCode: Record "Item Tracking Code"; var InsertIsBlocked: Boolean)
    begin
        //>> NIF #9851 RTT 03-22-05
        MfgLotNoVisible := ((TrackingSpecification."Source Type" = DATABASE::"Purchase Line") OR
                            //(TrackingSpecification."Source Type"=DATABASE::Table14017900) OR  //NF1.00:CIS.CM 09-29-15
                            //>>
                            ((TrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
                               (TrackingSpecification."Source Subtype" = 2)) OR
                            //<<
                            ((TrackingSpecification."Source Type" = DATABASE::"Sales Line") AND
                                (TrackingSpecification."Source Subtype" = 5)));
        //<< NIF #9851 RTT 03-22-05

    end;

    [EventSubscriber(ObjectType::page, 6510, 'OnRegisterChangeOnAfterInsert', '', True, false)]
    local procedure OnRegisterChangeOnAfterInsert(var NewTrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; CurrentPageIsOpen: Boolean)
    var
        Item_lc: Record Item;
    begin
        //>>NF1.00:CIS.NG  12-15-15
        //OldTrackingSpecification.Description+'~'+OldTrackingSpecification."Mfg. Lot No.",
        Item_lc.GET(OldTrackingSpecification."Item No.");
        // NF2.00:CIS.RAM >>>
        //COPYSTR(OldTrackingSpecification.Description+'~'+OldTrackingSpecification."Mfg. Lot No.",1,50),
        // (Item_lc.Description) + '~' + (OldTrackingSpecification."Mfg. Lot No."),
        // NF2.00:CIS.RAM <<<

        //<<NF1.00:CIS.NG  12-15-15
        //<< NIF #9851 RTT 03-22-05
    end;

    [EventSubscriber(ObjectType::page, 6510, 'OnAfterCopyTrackingSpec', '', True, false)]

    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    begin
        //>> NIF #9851 RTT 03-22-05
        SourceTrackingSpec."Mfg. Lot No." := DestTrkgSpec."Mfg. Lot No.";
        //<< NIF #9851 RTT 03-22-05
    end;

    [EventSubscriber(ObjectType::page, 6510, 'OnAfterMoveFields', '', True, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    begin
        //>> NIF #9851 RTT 03-22-05
        ReservEntry."Mfg. Lot No." := TrkgSpec."Mfg. Lot No.";
        //<< NIF #9851 RTT 03-22-05
    end;

    [EventSubscriber(ObjectType::page, 6510, 'OnAfterCreateReservEntryFor', '', True, false)]
    local procedure OnAfterCreateReservEntryFor(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; var CreateReservEntry: Codeunit "Create Reserv. Entry")
    begin
        //>> NIF #9851 RTT 03-22-05
        OldTrackingSpecification."Mfg. Lot No." := NewTrackingSpecification."Mfg. Lot No.";
        //<< NIF #9851 RTT 03-22-05
    end;

    var
        MfgLotNoVisible: Boolean;

}
