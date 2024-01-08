@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gets the list of statuses'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity YTRACKR_C_GET_STATUS as select from dd07t {
      @ObjectModel.text.element: ['Text']
  key domvalue_l as StatKey,

      @Semantics.text: true
      ddtext                                   as Text }
where
      domname    = 'ZSTAT_ENUM'
  and ddlanguage = $session.system_language
