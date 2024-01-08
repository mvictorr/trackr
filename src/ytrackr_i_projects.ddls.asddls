@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projects interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ytrackr_i_projects as select from ytrackr_projects {
    key proj_uuid as ProjUuid,
    proj_manager as ProjManager,
    proj_name as ProjName,
    stream as Stream,
    delievery_manager as DeliveryManager
}
