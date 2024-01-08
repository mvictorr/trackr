@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gets the total team planned capacity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YTRACKR_C_GET_TOTALCAP as select from YTRACKR_C_STATUS
{
    key avg(YTRACKR_C_STATUS.TotalCap as abap.fltp) as TotalCap
}
