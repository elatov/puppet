# https://github.com/zmartzone/mod_auth_openidc/blob/master/auth_openidc.conf
type Apache::OIDCSettings = Struct[
  {
    Optional['RedirectURI']                             => Variant[Stdlib::HTTPSUrl,Stdlib::HttpUrl],
    Optional['CryptoPassphrase']                        => String,
    Optional['MetadataDir']                             => String,
    Optional['ProviderMetadataURL']                     => Stdlib::HTTPSUrl,
    Optional['ProviderIssuer']                          => String,
    Optional['ProviderAuthorizationEndpoint']           => Stdlib::HTTPSUrl,
    Optional['ProviderJwksUri']                         => Stdlib::HTTPSUrl,
    Optional['ProviderTokenEndpoint']                   => Stdlib::HTTPSUrl,
    Optional['ProviderTokenEndpointAuth']               => Enum['client_secret_basic','client_secret_post','client_secret_jwt','private_key_jwt','none'],
    Optional['ProviderTokenEndpointParams']             => Pattern[/^[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+(&[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+)*$/],
    Optional['ProviderUserInfoEndpoint']                => Stdlib::HTTPSUrl,
    Optional['ProviderCheckSessionIFrame']              => Stdlib::HTTPSUrl,
    Optional['ProviderEndSessionEndpoint']              => Stdlib::HTTPSUrl,
    Optional['ProviderRevocationEndpoint']              => Stdlib::HTTPSUrl,
    Optional['ProviderBackChannelLogoutSupported']      => Enum['On','Off'],
    Optional['ProviderRegistrationEndpointJson']        => String,
    Optional['Scope']                                   => Pattern[/^[A-Za-z0-9\-\._\s]+$/],
    Optional['AuthRequestParams']                       => Pattern[/^[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+(&[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+)*$/],
    Optional['SSLValidateServer']                       => Enum['On','Off'],
    Optional['UserInfoRefreshInterval']                 => Integer,
    Optional['JWKSRefreshInterval']                     => Integer,
    Optional['UserInfoTokenMethod']                     => Enum['authz_header','post_param'],
    Optional['ProviderAuthRequestMethod']               => Enum['GET','POST'],
    Optional['PublicKeyFiles']                          => String,
    Optional['ResponseType']                            => Enum['code','id_token','id_token token','code id_token','code token','code id_token token'],
    Optional['ResponseMode']                            => Enum['fragment','query','form_post'],
    Optional['ClientID']                                => String,
    Optional['ClientSecret']                            => String,
    Optional['ClientTokenEndpointCert']                 => String,
    Optional['ClientTokenEndpointKey']                  => String,
    Optional['ClientName']                              => String,
    Optional['ClientContact']                           => String,
    Optional['PKCDMethod']                              => Enum['plain','S256','referred_tb'],
    Optional['TokenBindingPolicy']                      => Enum['disabled','optional','required','enforced'],
    Optional['ClientJwksUri']                           => Stdlib::HTTPSUrl,
    Optional['IDTokenSignedResponseAlg']                => Enum['RS256','RS384','RS512','PS256','PS384','PS512','HS256','HS384','HS512','ES256','ES384','ES512'],
    Optional['IDTokenEncryptedResponseAlg']             => Enum['RSA1_5','A128KW','A256KW','RSA-OAEP'],
    Optional['IDTokenEncryptedResponseAlg']             => Enum['A128CBC-HS256','A256CBC-HS512','A256GCM'],
    Optional['UserInfoSignedResposeAlg']                => Enum['RS256','RS384','RS512','PS256','PS384','PS512','HS256','HS384','HS512','ES256','ES384','ES512'],
    Optional['UserInfoEncryptedResponseAlg']            => Enum['RSA1_5','A128KW','A256KW','RSA-OAEP'],
    Optional['UserInfoEncryptedResponseEnc']            => Enum['A128CBC-HS256','A256CBC-HS512','A256GCM'],
    Optional['OAuthServerMetadataURL']                  => Stdlib::HTTPSUrl,
    Optional['AuthIntrospectionEndpoint']               => Stdlib::HTTPSUrl,
    Optional['OAuthClientID']                           => String,
    Optional['OAuthClientSecret']                       => String,
    Optional['OAuthIntrospectionEndpointAuth']          => Enum['client_secret_basic','client_secret_post','client_secret_jwt','private_key_jwt','bearer_access_token','none'],
    Optional['OAuthIntrospectionClientAuthBearerToken'] => String,
    Optional['OAuthIntrospectionEndpointCert']          => String,
    Optional['OAuthIntrospectionEndpointKey']           => String,
    Optional['OAuthIntrospectionEndpointMethod']        => Enum['POST','GET'],
    Optional['OAuthIntrospectionEndpointParams']        => Pattern[/^[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+(&[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+)*$/],
    Optional['OAuthIntrospectionTokenParamName']        => String,
    Optional['OAuthTokenExpiryClaim']                   => Pattern[/^[A-Za-z0-9\-\._]+\s(absolute|relative)\s(mandatory|optional)$/],
    Optional['OAuthSSLValidateServer']                  => Enum['On','Off'],
    Optional['OAuthVerifySharedKeys']                   => String,
    Optional['OAuthVerifyCertFiles']                    => String,
    Optional['OAuthVerifyJwksUri']                      => Stdlib::HTTPSUrl,
    Optional['OAuthRemoteUserClaim']                    => String,
    Optional['OAuthAcceptTokenAs']                      => Pattern[/^((header|post|query|cookie\:[A-Za-z0-9\-\._]+|basic)\s?)+$/],
    Optional['OAuthAccessTokenBindingPolicy']           => Enum['disabled','optional','required','enforced'],
    Optional['Cookie']                                  => String,
    Optional['SessionCookieChunkSize']                  => Integer,
    Optional['CookieHTTPOnly']                          => Enum['On','Off'],
    Optional['CookieSameSite']                          => Enum['On','Off'],
    Optional['PassCookies']                             => String,
    Optional['StripCookies']                            => String,
    Optional['StateMaxNumberOfCookies']                 => Pattern[/^[0-9]+\s(false|true)$/],
    Optional['SessionInactivityTimeout']                => Integer,
    Optional['SessionMaxDuration']                      => Integer,
    Optional['SessionType']                             => Pattern[/^(server-cache(:persistent)?|client-cookie(:persistent)?)$/],
    Optional['SessionCacheFallbackToCookie']            => Enum['On','Off'],
    Optional['CacheType']                               => Enum['shm','memcache','file','redis'],
    Optional['CacheEncrypt']                            => Enum['On','Off'],
    Optional['CacheShmMax']                             => Integer,
    Optional['CacheShmEntrySizeMax']                    => Integer,
    Optional['CacheFileCleanInterval']                  => Integer,
    Optional['MemCacheServers']                         => String,
    Optional['RedisCacheServer']                        => String,
    Optional['RedisCachePassword']                      => String,
    Optional['DiscoverURL']                             => Variant[Stdlib::HTTPSUrl,Stdlib::HttpUrl],
    Optional['HTMLErrorTemplate']                       => String,
    Optional['DefaultURL']                              => Variant[Stdlib::HTTPSUrl,Stdlib::HttpUrl],
    Optional['PathScope']                               => Pattern[/^[A-Za-z0-9\-\._\s]+$/],
    Optional['PathAuthRequestParams']                   => Pattern[/^[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+(&[A-Za-z0-9\-\._%]+=[A-Za-z0-9\-\._%]+)*$/],
    Optional['IDTokenIatSlack']                         => Integer,
    Optional['ClaimPrefix']                             => String,
    Optional['ClaimDelimiter']                          => Pattern[/^.$/],
    Optional['RemoteUserClaim']                         => String,
    Optional['PassIDTokenAs']                           => Pattern[/^((claims|payload|serialized)\s?)+$/],
    Optional['PassUserInfoAs']                          => Pattern[/^((claims|json|jwt)\s?)+$/],
    Optional['PassClaimsAs']                            => Enum['none','headers','environment','both'],
    Optional['AuthNHeader']                             => String,
    Optional['HTTPTimeoutLong']                         => Integer,
    Optional['HTTPTimeoutShort']                        => Integer,
    Optional['StateTimeout']                            => Integer,
    Optional['ScrubRequestHeaders']                     => Enum['On','Off'],
    Optional['OutgoingProxy']                           => String,
    Optional['UnAuthAction']                            => Enum['auth','pass','401','410'],
    Optional['UnAuthzAction']                           => Enum['401','403','auth'],
    Optional['PreservePost']                            => Enum['On','Off'],
    Optional['PassRefreshToken']                        => Enum['On','Off'],
    Optional['RequestObject']                           => String,
    Optional['ProviderMetadataRefreshInterval']         => Integer,
    Optional['InfoHook']                                => Pattern[/^((iat|access_token|access_token_expires|id_token|userinfo|refresh_token|session)\s?)+$/],
    Optional['BlackListedClaims']                       => String,
    Optional['WhiteListedClaims']                       => String,
    Optional['RefreshAccessTokenBeforeExpiry']          => Pattern[/^[0-9]+(\slogout_on_error)?$/],
  }
]
