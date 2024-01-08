@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gets the list of employees with avacapa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ytrackr_c_get_export as select from ytrackr_employee 
    left outer join ytrackr_c_status_projection on ytrackr_employee.emp_uuid = ytrackr_c_status_projection.EmpUUID
{
    key ytrackr_employee.emp_uuid as EmpUuid,
    ytrackr_employee.first_name as FirstName,
    ytrackr_employee.last_name as LastName,
    ytrackr_employee.role as Role,
    ytrackr_employee.jobtime as Jobtime,
    ytrackr_employee.skillset as Skillset,
    case when ytrackr_employee.emp_uuid = ytrackr_c_status_projection.EmpUUID then 1 else 0 end as isAssigned,
    ytrackr_c_status_projection.ProjDays /
        ( case when ytrackr_employee.jobtime = '4' then cast(2.5 as abap.fltp) when ytrackr_employee.jobtime = '6' then cast(3.75 as abap.fltp)
            when ytrackr_employee.jobtime = '8' then cast(5 as abap.fltp) else 1 end ) * cast( 100 as abap.fltp ) as Utilization
}
