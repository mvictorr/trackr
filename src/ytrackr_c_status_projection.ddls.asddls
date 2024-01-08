@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'status projection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ytrackr_c_status_projection as select from ytrackr_emprj as _statc
{
       key emp_uuid as EmpUUID,
       sum(proj_days_per_week) as ProjDays
}
where status = '2' or status = '1'
group by emp_uuid
