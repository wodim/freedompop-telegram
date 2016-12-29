.class public interface abstract Lcom/freedompop/acl/FreedomPop;
.super Ljava/lang/Object;
.source "FreedomPop.java"


# virtual methods
.method public abstract addInternationalPlan(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/Purchase;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "voicePlanSku"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/plan/order/international/{voicePlanSku}"
    .end annotation
.end method

.method public abstract addService(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/Purchase;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "sku"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/service/add/{sku}"
    .end annotation
.end method

.method public abstract addServiceStatus(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/ServiceOrderStatus;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "sku"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/service/add/status/{sku}"
    .end annotation
.end method

.method public abstract authWithDeviceId(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/PhoneRadioType;Lcom/freedompop/acl/model/GrantType;)Lcom/freedompop/acl/model/OAuthToken;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "device_id"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "device_id2"
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "deviceSid"
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "deviceSid2"
        .end annotation
    .end param
    .param p6    # Lcom/freedompop/acl/model/PhoneRadioType;
        .annotation runtime Lretrofit/http/Field;
            value = "radioType"
        .end annotation
    .end param
    .param p7    # Lcom/freedompop/acl/model/GrantType;
        .annotation runtime Lretrofit/http/Field;
            value = "grant_type"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/auth/token"
    .end annotation
.end method

.method public abstract authWithRefreshToken(Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/GrantType;)Lcom/freedompop/acl/model/OAuthToken;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "refresh_token"
        .end annotation
    .end param
    .param p3    # Lcom/freedompop/acl/model/GrantType;
        .annotation runtime Lretrofit/http/Field;
            value = "grant_type"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/auth/token"
    .end annotation
.end method

.method public abstract authWithUsernameAndPassword(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/GrantType;)Lcom/freedompop/acl/model/OAuthToken;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "username"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "password"
        .end annotation
    .end param
    .param p4    # Lcom/freedompop/acl/model/GrantType;
        .annotation runtime Lretrofit/http/Field;
            value = "grant_type"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/auth/token"
    .end annotation
.end method

.method public abstract balance(Ljava/lang/String;)Ljava/util/List;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/freedompop/acl/model/Plan;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/GET;
        value = "/phone/balance"
    .end annotation
.end method

.method public abstract createOttAccount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/OAuthTokenWithPhoneNumber;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "first_name"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "last_name"
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "email"
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "password"
        .end annotation
    .end param
    .param p6    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "device_serial"
        .end annotation
    .end param
    .param p7    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "country_code"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/account"
    .end annotation
.end method

.method public abstract dataCallCredit(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "from"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "to"
        .end annotation
    .end param
    .param p4    # Ljava/lang/Long;
        .annotation runtime Lretrofit/http/Query;
            value = "time"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/dataCallCredit"
    .end annotation
.end method

.method public abstract deleteCall(Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "callIds"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/DELETE;
        value = "/phone/call"
    .end annotation
.end method

.method public abstract deleteSms(Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "messageIds"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/DELETE;
        value = "/phone/sms"
    .end annotation
.end method

.method public abstract deleteVoiceMailByUrl(Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "url"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/api/phone/vm/delete"
    .end annotation
.end method

.method public abstract emailVerifyFinalize(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)Lcom/freedompop/acl/model/OAuthTokenWithPhoneNumber;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Header;
            value = "Authorization"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "email"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "password"
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "deviceSerial"
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "verificationCode"
        .end annotation
    .end param
    .param p6    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "custom"
        .end annotation
    .end param
    .param p7    # Ljava/util/Map;
        .annotation runtime Lretrofit/http/QueryMap;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/freedompop/acl/model/OAuthTokenWithPhoneNumber;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/email/verify/finalize"
    .end annotation
.end method

.method public abstract emailVerifyInitialize(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "firstName"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "lastName"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "email"
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "password"
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "deviceSerial"
        .end annotation
    .end param
    .param p6    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "custom"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/email/verify/initialize"
    .end annotation
.end method

.method public abstract emailVerifyRefresh(Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "email"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/email/verify/refresh"
    .end annotation
.end method

.method public abstract emailVerifyStatus(Ljava/lang/String;)Lcom/freedompop/acl/model/EmailVerificationResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "email"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/email/verify/status"
    .end annotation
.end method

.method public abstract getAvailableBundlePlans(Ljava/lang/String;)Ljava/util/List;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/freedompop/acl/model/BundlePlanInfo;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/GET;
        value = "/api/bundle/plan/available"
    .end annotation
.end method

.method public abstract getCurrentBundlePlan(Ljava/lang/String;)Lcom/freedompop/acl/model/BundlePlanInfo;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/api/bundle/plan/current"
    .end annotation
.end method

.method public abstract getEntitlements(Ljava/lang/String;)Ljava/util/Set;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Set",
            "<",
            "Lcom/freedompop/acl/model/Entitlement;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/GET;
        value = "/api/entitlements"
    .end annotation
.end method

.method public abstract getIncomingCallPref(Ljava/lang/String;)Lcom/freedompop/acl/model/IncomingCallPrefResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/getincomingcallpref"
    .end annotation
.end method

.method public abstract getLandingPage()Lcom/freedompop/acl/model/LandingPage;
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/offerLandingPage"
    .end annotation
.end method

.method public abstract getPhoneAccountInfo(Ljava/lang/String;)Lcom/freedompop/acl/model/AccountInfo;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/account/info"
    .end annotation
.end method

.method public abstract getPhoneNumbers(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Ljava/util/List;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/Integer;
        .annotation runtime Lretrofit/http/Path;
            value = "numToFetch"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "area_code"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/GET;
        value = "/phone/getnumbers/{numToFetch}"
    .end annotation
.end method

.method public abstract getPlayStoreVersion(Ljava/lang/String;)Lcom/freedompop/acl/model/PlayStoreVersion;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/market"
    .end annotation
.end method

.method public abstract getPromoOfferDefault(Ljava/lang/String;)Lcom/freedompop/acl/model/PromoOffer;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/offer/default"
    .end annotation
.end method

.method public abstract getPromoOfferItemsForGroup(Ljava/lang/String;Ljava/lang/String;I)Lcom/freedompop/acl/model/PromoOfferItems;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "group"
        .end annotation
    .end param
    .param p3    # I
        .annotation runtime Lretrofit/http/Path;
            value = "numberOfOffers"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/offer/{group}/{numberOfOffers}"
    .end annotation
.end method

.method public abstract getSupportedCountries()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/freedompop/acl/model/Country;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/GET;
        value = "/phone/supportedCountries"
    .end annotation
.end method

.method public abstract getUserIdentityConfirmation(Ljava/lang/String;)Lcom/freedompop/acl/model/UserIdentityConfirmationResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/userIdentity/confirmation"
    .end annotation
.end method

.method public abstract getUserInfo(Ljava/lang/String;)Lcom/freedompop/acl/model/User;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/user/info"
    .end annotation
.end method

.method public abstract getVoicemailUrls(Ljava/lang/String;)Lcom/freedompop/acl/model/VmListResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/api/phone/vm/summary"
    .end annotation
.end method

.method public abstract identify(Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/PhoneRadioType;)Lcom/freedompop/acl/model/PhoneIdentification;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "device_meid"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceSid"
        .end annotation
    .end param
    .param p3    # Lcom/freedompop/acl/model/PhoneRadioType;
        .annotation runtime Lretrofit/http/Query;
            value = "radioType"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/identification"
    .end annotation
.end method

.method public abstract identifySim(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/PhoneSimIdentification;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "iccid1"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "iccid2"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/sim/identification"
    .end annotation
.end method

.method public abstract identifySimSingle(Ljava/lang/String;)Lcom/freedompop/acl/model/PhoneSimIdentification;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "iccid1"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/sim/identification"
    .end annotation
.end method

.method public abstract initializeOttPlan(Ljava/lang/String;)Lcom/freedompop/acl/model/Product;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/plan/initialize-ott"
    .end annotation
.end method

.method public abstract listCalls(Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Long;ZZZZ)Lcom/freedompop/acl/model/ListCallsResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/Long;
        .annotation runtime Lretrofit/http/Query;
            value = "startDate"
        .end annotation
    .end param
    .param p3    # Ljava/lang/Long;
        .annotation runtime Lretrofit/http/Query;
            value = "endDate"
        .end annotation
    .end param
    .param p4    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeOutgoing"
        .end annotation
    .end param
    .param p5    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeIncoming"
        .end annotation
    .end param
    .param p6    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeDeleted"
        .end annotation
    .end param
    .param p7    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeRead"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/calls"
    .end annotation
.end method

.method public abstract listSms(Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Long;ZZZ)Lcom/freedompop/acl/model/ListSmsResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/Long;
        .annotation runtime Lretrofit/http/Query;
            value = "startDate"
        .end annotation
    .end param
    .param p3    # Ljava/lang/Long;
        .annotation runtime Lretrofit/http/Query;
            value = "endDate"
        .end annotation
    .end param
    .param p4    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeOutgoing"
        .end annotation
    .end param
    .param p5    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeDeleted"
        .end annotation
    .end param
    .param p6    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "includeRead"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/listsms"
    .end annotation
.end method

.method public abstract markCallAsRead(Ljava/lang/String;Ljava/lang/String;Z)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "callIds"
        .end annotation
    .end param
    .param p3    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "read"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/call/read"
    .end annotation
.end method

.method public abstract markSmsAsRead(Ljava/lang/String;Ljava/lang/String;Z)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "messageIds"
        .end annotation
    .end param
    .param p3    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "read"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/sms/read"
    .end annotation
.end method

.method public abstract orderNumber(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/Phone;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "area_code"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/ordernumber"
    .end annotation
.end method

.method public abstract orderPhoneNumber(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/Phone;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "phoneNumber"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/ordernumber/{phoneNumber}"
    .end annotation
.end method

.method public abstract reactivateDormantDevice(Ljava/lang/String;)Lcom/freedompop/acl/model/AccountDeviceActivationResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/account/reactivate"
    .end annotation
.end method

.method public abstract reactivateDormantDeviceOrderStatus(Ljava/lang/String;Ljava/util/Date;)Lcom/freedompop/acl/model/AccountDeviceActivationStatusResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/util/Date;
        .annotation runtime Lretrofit/http/Path;
            value = "timeCreated"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/account/reactivate/status/{timeCreated}"
    .end annotation
.end method

.method public abstract registerPushToken(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/PushDeviceType;Lcom/freedompop/acl/model/PhoneRadioType;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "pushToken"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceId"
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceSid"
        .end annotation
    .end param
    .param p5    # Lcom/freedompop/acl/model/PushDeviceType;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceType"
        .end annotation
    .end param
    .param p6    # Lcom/freedompop/acl/model/PhoneRadioType;
        .annotation runtime Lretrofit/http/Query;
            value = "radioType"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/push/register/token"
    .end annotation
.end method

.method public abstract replaceBundlePlan(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/SwitchBundleResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Path;
            value = "sku"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/POST;
        value = "/api/bundle/plan/replace/{sku}"
    .end annotation
.end method

.method public abstract resetPassword(Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Field;
            value = "email"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/FormUrlEncoded;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/user/password/reset"
    .end annotation
.end method

.method public abstract sendSms(Ljava/lang/String;Lretrofit/mime/TypedString;Lretrofit/mime/TypedString;Lretrofit/mime/TypedInput;)Lcom/freedompop/acl/model/SendSmsResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "to_numbers"
        .end annotation
    .end param
    .param p3    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "message_body"
        .end annotation
    .end param
    .param p4    # Lretrofit/mime/TypedInput;
        .annotation runtime Lretrofit/http/Part;
            value = "media_file"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/Multipart;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/sendsms"
    .end annotation
.end method

.method public abstract sendViralInvites(Ljava/lang/String;Lcom/freedompop/acl/model/Contacts;)Lcom/freedompop/acl/model/PlainJsonStatus;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Lcom/freedompop/acl/model/Contacts;
        .annotation runtime Lretrofit/http/Body;
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/POST;
        value = "/phone/friends/invites"
    .end annotation
.end method

.method public abstract setIncomingCallPreference(Ljava/lang/String;Z)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Z
        .annotation runtime Lretrofit/http/Query;
            value = "usePV"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/setincomingcallpref"
    .end annotation
.end method

.method public abstract sipConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/freedompop/acl/model/PhoneRadioType;)Lcom/freedompop/acl/model/SipConfig;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceId"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "deviceSid"
        .end annotation
    .end param
    .param p4    # Lcom/freedompop/acl/model/PhoneRadioType;
        .annotation runtime Lretrofit/http/Query;
            value = "radioType"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/GET;
        value = "/phone/device/config"
    .end annotation
.end method

.method public abstract storeUserIdentity(Ljava/lang/String;Lretrofit/mime/TypedString;Lretrofit/mime/TypedString;Lretrofit/mime/TypedString;Lretrofit/mime/TypedString;Lretrofit/mime/TypedString;Lretrofit/mime/TypedInput;Lretrofit/mime/TypedInput;)Lcom/freedompop/acl/model/UserIdentityResponse;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "firstName"
        .end annotation
    .end param
    .param p3    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "lastName"
        .end annotation
    .end param
    .param p4    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "identityType"
        .end annotation
    .end param
    .param p5    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "identityNumber"
        .end annotation
    .end param
    .param p6    # Lretrofit/mime/TypedString;
        .annotation runtime Lretrofit/http/Part;
            value = "country"
        .end annotation
    .end param
    .param p7    # Lretrofit/mime/TypedInput;
        .annotation runtime Lretrofit/http/Part;
            value = "file1"
        .end annotation
    .end param
    .param p8    # Lretrofit/mime/TypedInput;
        .annotation runtime Lretrofit/http/Part;
            value = "file2"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/Multipart;
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/userIdentity2"
    .end annotation
.end method

.method public abstract submitDiagnosticReport(Ljava/lang/String;Ljava/util/Map;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/util/Map;
        .annotation runtime Lretrofit/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lretrofit/client/Response;"
        }
    .end annotation

    .annotation runtime Lretrofit/http/POST;
        value = "/phone/report"
    .end annotation
.end method

.method public abstract switchAccount(Ljava/lang/String;Ljava/lang/String;)Lcom/freedompop/acl/model/BasicAccountInfo;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accountId"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/auth/account"
    .end annotation
.end method

.method public abstract undeleteCall(Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "callIds"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/call/undelete"
    .end annotation
.end method

.method public abstract undeleteSms(Ljava/lang/String;Ljava/lang/String;)Lretrofit/client/Response;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "accessToken"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit/http/Query;
            value = "messageIds"
        .end annotation
    .end param
    .annotation runtime Lretrofit/http/PUT;
        value = "/phone/sms/undelete"
    .end annotation
.end method
