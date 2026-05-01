codeunit 50100 "OAuth 2.0 Authorization"
{
    var
        DotNetUriBuilder: Codeunit Uri;

    procedure AcquireAuthorizationToken(
        ClientId: Text;
        ClientSecret: Text;
        AccessTokenURL: Text;
        AuthURLParms: Text;
        Scope: Text;
        JAccessToken: JsonObject): Boolean
    var
        AuthRequestURL: Text;
        AuthCode: Text;
        State: Text;
        IsSuccess: Boolean;
    begin
        //     exit(
        // AcquireToken(
        //     ClientId,
        //     ClientSecret,
        //     Scope,
        //     AccessTokenURL,
        //     JAccessToken));
    end;

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


    procedure AcquireTokenByRefreshToken(
        TokenEndpointURL: Text;
        ClientId: Text;
        ClientSecret: Text;
        RedirectURL: Text;
        RefreshToken: Text;
        JAccessToken: JsonObject): Boolean
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        ContentText: Text;
        ResponseText: Text;
        IsSuccess: Boolean;
    begin
        ContentText := 'grant_type=refresh_token' +
            '&refresh_token=' + DotNetUriBuilder.EscapeDataString(RefreshToken) +
            '&redirect_uri=' + DotNetUriBuilder.EscapeDataString(RedirectURL) +
            '&client_id=' + DotNetUriBuilder.EscapeDataString(ClientId) +
            '&client_secret=' + DotNetUriBuilder.EscapeDataString(ClientSecret);
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
            end else
                if Response.Content.ReadAs(ResponseText) then
                    JAccessToken.ReadFrom(ResponseText);

        exit(IsSuccess);
    end;

    local procedure ReadAuthCodeFromJson(var AuthorizationCode: Text)
    var
        JObject: JsonObject;
        JToken: JsonToken;
    begin
        if not JObject.ReadFrom(AuthorizationCode) then
            exit;

        if not JObject.Get('code', JToken) then
            exit;

        if not JToken.IsValue() then
            exit;

        if not JToken.WriteTo(AuthorizationCode) then
            exit;

        AuthorizationCode := AuthorizationCode.TrimStart('"').TrimEnd('"');
    end;

    local procedure GetPropertyFromCode(CodeTxt: Text; Property: Text): Text
    var
        PosProperty: Integer;
        PosValue: Integer;
        PosEnd: Integer;
    begin
        PosProperty := StrPos(CodeTxt, Property);
        if PosProperty = 0 then
            exit('');

        PosValue := PosProperty + StrPos(CopyStr(Codetxt, PosProperty), '=');
        PosEnd := PosValue + StrPos(CopyStr(CodeTxt, PosValue), '&');

        if PosEnd = PosValue then
            exit(CopyStr(CodeTxt, PosValue, StrLen(CodeTxt) - 1));

        exit(CopyStr(CodeTxt, PosValue, PosEnd - PosValue - 1));
    end;
}