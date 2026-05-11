codeunit 50115 "Share Point Integration Mgt."
{
    var
        DotNetUriBuilder: Codeunit Uri;
        DrivesUrl: Label 'https://graph.microsoft.com/v1.0/sites/root/drives/', Locked = true;
        DrivesItemsUrl: Label 'https://graph.microsoft.com/v1.0/sites/root/drives/%1/root/children', Comment = '%1 = Drive ID', Locked = true;
        DrivesChildItemsUrl: Label 'https://graph.microsoft.com/v1.0/sites/root/drives/%1/items/%2/children', Comment = '%1 = Drive ID, %2 = Item ID', Locked = true;
        DownloadUrl: Label 'https://graph.microsoft.com/v1.0/drives/%1/items/%2/content', Comment = '%1 = Drive ID, %2 = Item ID', Locked = true;
        DeleteUrl: Label 'https://graph.microsoft.com/v1.0/drives/%1/items/%2', Comment = '%1 = Drive ID, %2 = Item ID', Locked = true;
        UploadUrl: Label 'https://graph.microsoft.com/v1.0/drives/%1/items/root:/%2:/content', Comment = '%1 = Drive ID, %2 = File Name', Locked = true;

    procedure AcquireToken(
        ClientId: Text;
        ClientSecret: Text;
        Scope: Text;
        TokenEndpointURL: Text;
        var AccessToken: Text): Boolean;
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        ContentText: Text;
        IsSuccess: Boolean;
        JAccessToken: JsonObject;
        AccessTokenValue: JsonToken;
        ResponseText: Text;
    begin

        ContentText := 'grant_type=client_credentials' +
            '&client_id=' + DotNetUriBuilder.EscapeDataString(ClientId) +
            '&client_secret=' + DotNetUriBuilder.EscapeDataString(ClientSecret) +
            '&scope=' + DotNetUriBuilder.EscapeDataString(Scope);
        Content.WriteFrom(ContentText);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        Request.Method := 'POST';
        Request.SetRequestUri(TokenEndpointURL);
        Request.Content(Content);

        if Client.Send(Request, Response) then
            if Response.IsSuccessStatusCode() then begin
                if Response.Content.ReadAs(ResponseText) then
                    IsSuccess := JAccessToken.ReadFrom(ResponseText);
                if JAccessToken.Get('access_token', AccessTokenValue) then
                    AccessToken := AccessTokenValue.AsValue().AsText();
            end else
                if Response.Content.ReadAs(ResponseText) then
                    JAccessToken.ReadFrom(ResponseText);

        exit(IsSuccess);
    end;

    procedure UploadFile(
           AccessToken: Text;
           DriveID: Text;
           FolderPath: Text;
           FileName: Text;
           var Stream: InStream): Boolean
    var
        HttpClient: HttpClient;
        Headers: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        JsonResponse: JsonObject;
        IsSucces: Boolean;
        ResponseText: Text;
    begin
        Headers := HttpClient.DefaultRequestHeaders();
        Headers.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));

        RequestMessage.SetRequestUri(
            StrSubstNo(
                UploadUrl,
                DriveID,
                StrSubstNo('%1/%2', FolderPath, FileName)));
        RequestMessage.Method := 'PUT';

        RequestContent.WriteFrom(Stream);
        RequestMessage.Content := RequestContent;

        if HttpClient.Send(RequestMessage, ResponseMessage) then
            if ResponseMessage.IsSuccessStatusCode() then begin
                if ResponseMessage.Content.ReadAs(ResponseText) then begin
                    IsSucces := true;
                end;
            end else
                if ResponseMessage.Content.ReadAs(ResponseText) then
                    JsonResponse.ReadFrom(ResponseText);

        exit(IsSucces);
    end;

    procedure DownloadFile(AccessToken: Text; DriveID: Text; ItemID: Text; var Stream: InStream): Boolean
    var
        //TempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        JsonResponse: JsonObject;
        Content: Text;
        NewDownloadUrl: Text;
    begin
        NewDownloadUrl := StrSubstNo(DownloadUrl, DriveID, ItemID);
        if GetResponse(AccessToken, NewDownloadUrl, Stream) then
            exit(true);
    end;

    procedure FetchDrivesItems(AccessToken: Text; DriveID: Text; var DriveItem: Record "SharePoint Drive Item"): Boolean
    var
        JsonResponse: JsonObject;
        JToken: JsonToken;
        IsSucces: Boolean;
    begin
        if HttpGet(AccessToken, StrSubstNo(DrivesItemsUrl, DriveID), JsonResponse) then begin
            if JsonResponse.Get('value', JToken) then
                ReadDriveItems(JToken.AsArray(), DriveID, '', DriveItem);

            exit(true);
        end;
    end;

    procedure FetchDrivesChildItems(
    AccessToken: Text;
    DriveID: Text;
    ItemID: Text;
    var DriveItem: Record "SharePoint Drive Item" temporary): Boolean
    var
        JsonResponse: JsonObject;
        JToken: JsonToken;
        IsSucces: Boolean;
    begin
        if HttpGet(AccessToken, StrSubstNo(DrivesChildItemsUrl, DriveID, ItemID), JsonResponse) then begin
            if JsonResponse.Get('value', JToken) then
                ReadDriveItems(JToken.AsArray(), DriveID, ItemID, DriveItem);

            exit(true);
        end;
    end;

    procedure DeleteDriveItem(AccessToken: Text; DriveID: Text; ItemID: Text): Boolean
    var
        HttpClient: HttpClient;
        Headers: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
    begin
        Headers := HttpClient.DefaultRequestHeaders();
        Headers.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));

        RequestMessage.SetRequestUri(StrSubstNo(DeleteUrl, DriveID, ItemID));
        RequestMessage.Method := 'DELETE';


        if HttpClient.Send(RequestMessage, ResponseMessage) then
            if ResponseMessage.IsSuccessStatusCode() then
                exit(true);
    end;

    local procedure ReadDriveItems(
        JDriveItems: JsonArray;
        DriveID: Text;
        ParentID: Text;
        var DriveItem: Record "SharePoint Drive Item" temporary)
    var
        JToken: JsonToken;
    begin
        foreach JToken in JDriveItems do
            ReadDriveItem(JToken.AsObject(), DriveID, ParentID, DriveItem);
    end;

    local procedure ReadDriveItem(
        JDriveItem: JsonObject;
        DriveID: Text;
        ParentID: Text;
        var DriveItem: Record "SharePoint Drive Item" temporary)
    var
        JFile: JsonObject;
        JToken: JsonToken;
    begin

        DriveItem.Init();
        DriveItem.driveId := DriveID;
        DriveItem.parentId := ParentID;

        if JDriveItem.Get('id', JToken) then
            DriveItem.Id := JToken.AsValue().AsText();
        if JDriveItem.Get('name', JToken) then
            DriveItem.Name := JToken.AsValue().AsText();

        if JDriveItem.Get('size', JToken) then
            DriveItem.size := JToken.AsValue().AsBigInteger();

        if JDriveItem.Get('file', JToken) then begin
            DriveItem.IsFile := true;
            JFile := JToken.AsObject();
            if JFile.Get('mimeType', JToken) then
                DriveItem.mimeType := JToken.AsValue().AsText();
        end;

        if JDriveItem.Get('createdDateTime', JToken) then
            DriveItem.createdDateTime := JToken.AsValue().AsDateTime();
        if JDriveItem.Get('webUrl', JToken) then
            DriveItem.webUrl := JToken.AsValue().AsText();
        DriveItem.Insert();
    end;

    local procedure GetResponse(AccessToken: Text; Url: Text; var Stream: InStream): Boolean
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestContent: HttpContent;
        IsSucces: Boolean;
    begin
        Headers := Client.DefaultRequestHeaders();
        Headers.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));

        RequestMessage.SetRequestUri(Url);
        RequestMessage.Method := 'GET';

        if Client.Send(RequestMessage, ResponseMessage) then
            if ResponseMessage.IsSuccessStatusCode() then begin
                if ResponseMessage.Content.ReadAs(Stream) then
                    IsSucces := true;
            end else
                ResponseMessage.Content.ReadAs(Stream);

        exit(IsSucces);
    end;

    local procedure HttpGet(AccessToken: Text; Url: Text; var JResponse: JsonObject): Boolean
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestContent: HttpContent;
        ResponseText: Text;
        IsSucces: Boolean;
    begin
        Headers := Client.DefaultRequestHeaders();
        Headers.Add('Authorization', StrSubstNo('Bearer %1', AccessToken));


        RequestMessage.SetRequestUri(Url);
        RequestMessage.Method := 'GET';

        if Client.Send(RequestMessage, ResponseMessage) then
            if ResponseMessage.IsSuccessStatusCode() then begin
                if ResponseMessage.Content.ReadAs(ResponseText) then
                    IsSucces := true;
            end else
                ResponseMessage.Content.ReadAs(ResponseText);

        JResponse.ReadFrom(ResponseText);
        exit(IsSucces);
    end;
}