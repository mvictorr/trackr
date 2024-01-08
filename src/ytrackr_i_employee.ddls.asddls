@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employees interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ytrackr_i_employee as select from ytrackr_employee 
    left outer join ytrackr_c_status_projection on ytrackr_employee.emp_uuid = ytrackr_c_status_projection.EmpUUID
{
    key ytrackr_employee.emp_uuid as EmpUuid,
    ytrackr_employee.first_name as FirstName,
    ytrackr_employee.last_name as LastName,
    ytrackr_employee.role as Role,
    ytrackr_employee.jobtime as Jobtime,
    ytrackr_employee.email as Email,
    ytrackr_employee.location as Location,
    ytrackr_employee.date_of_empl as DateOfEmpl,
    ytrackr_employee.department as Department,
    ytrackr_employee.utilization as Utilization,
    ytrackr_employee.username as Username,
    ytrackr_employee.skillset as Skillset,
    case
    when ytrackr_employee.jobtime is null then 0
    when ytrackr_c_status_projection.ProjDays is null then 0
    when ytrackr_employee.jobtime = '4' then ytrackr_c_status_projection.ProjDays / cast(2.5 as abap.fltp) * cast(100 as abap.fltp)
    when ytrackr_employee.jobtime = '6' then ytrackr_c_status_projection.ProjDays / cast(3.75 as abap.fltp) * cast(100 as abap.fltp)
    when ytrackr_employee.jobtime = '8' then ytrackr_c_status_projection.ProjDays / cast(5 as abap.fltp) * cast(100 as abap.fltp)
    else 0
end as Utilizationn

}

