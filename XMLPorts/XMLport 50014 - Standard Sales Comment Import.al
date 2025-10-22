// xmlport 50014 "Standard Sales Comment Import"
// {
//     Direction = Import;
//     Format = VariableText;

//     schema
//     {
//         textelement(Root)
//         {
//             tableelement(Table14017610; 14017610)
//             {
//                 AutoSave = true;
//                 AutoUpdate = false;
//                 XmlName = 'StdSalesCmntImp';
//                 UseTemporary = false;
//                 fieldelement(DocType; "Sales Line Comment Line"."Document Type")
//                 {
//                 }
//                 fieldelement(Numb; "Sales Line Comment Line"."No.")
//                 {
//                 }
//                 fieldelement(DocLnNo; "Sales Line Comment Line"."Doc. Line No.")
//                 {
//                 }
//                 fieldelement(LineNo; "Sales Line Comment Line"."Line No.")
//                 {
//                 }
//                 textelement(Date)
//                 {
//                 }
//                 textelement(Comment)
//                 {
//                 }
//                 fieldelement(PrintOnQuote; "Sales Line Comment Line"."Print On Quote")
//                 {
//                 }
//                 fieldelement(PrintOnPickTic; "Sales Line Comment Line"."Print On Pick Ticket")
//                 {
//                 }
//                 fieldelement(PrintOnOrdConf; "Sales Line Comment Line"."Print On Order Confirmation")
//                 {
//                 }
//                 fieldelement(PrintOnShipment; "Sales Line Comment Line"."Print On Shipment")
//                 {
//                 }
//                 fieldelement(PrintOnInv; "Sales Line Comment Line"."Print On Invoice")
//                 {
//                 }
//                 fieldelement(PrintOnCM; "Sales Line Comment Line"."Print On Credit Memo")
//                 {
//                 }
//                 fieldelement(PrintOnWS; "Sales Line Comment Line"."Print On Worksheet")
//                 {
//                 }
//                 fieldelement(PrintOnBlanket; "Sales Line Comment Line"."Print On Blanket")
//                 {
//                 }

//                 trigger OnBeforeInsertRecord()
//                 begin
//                 end;
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     trigger OnPostXmlPort()
//     begin
//         MESSAGE('Import Completed');
//     end;
// }//TODO