codeunit 50150 TAB90Subscribers
{
    [EventSubscriber(ObjectType::Table, Database::"BOM Component", OnBeforeValidateAgainstRecursion, '', false, false)]
    local procedure "BOM Component_OnBeforeValidateAgainstRecursion"(var Sender: Record "BOM Component"; ItemNo: Code[20]; var IsHandled: Boolean; var BOMComponent: Record "BOM Component")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Component", OnBeforeCopyFromItem, '', false, false)]
    local procedure "BOM Component_OnBeforeCopyFromItem"(var BOMComponent: Record "BOM Component"; xBOMComponent: Record "BOM Component"; Item: Record Item; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        ParentItem: Record Item;
        CalcLowLevelCode: Codeunit "Calculate Low-Level Code";
    begin
        Item.CalcFields("Assembly BOM");
        BOMComponent."Assembly BOM" := Item."Assembly BOM";
        BOMComponent.Description := Item.Description;
        BOMComponent."Unit of Measure Code" := Item."Base Unit of Measure";
        ParentItem.Get(BOMComponent."Parent Item No.");
        CalcLowLevelCode.SetRecursiveLevelsOnItem(Item, ParentItem."Low-Level Code" + 1, true);
    end;

}
