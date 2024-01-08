@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gets the list of roles'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity YTRACKR_C_GET_ROLE as select from dd07t {
      @ObjectModel.text.element: ['Text']
  key domvalue_l as RoleKey,

      @Semantics.text: true
      ddtext                                   as Text }
where
      domname    = 'ZROLE_ENUM'
  and ddlanguage = $session.system_language
