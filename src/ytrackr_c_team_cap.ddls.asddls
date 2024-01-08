@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Team utilization and availability'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YTRACKR_C_TEAM_CAP
  as select from ytrackr_employee
    join         ytrackr_members    on ytrackr_employee.emp_uuid = ytrackr_members.tmember_uuid
    join         ytrackr_teams      on ytrackr_members.team_uuid = ytrackr_teams.team_uuid
    join         ytrackr_i_employee on ytrackr_employee.emp_uuid = ytrackr_i_employee.EmpUuid
{
  key ytrackr_teams.team_uuid                                                    as TeamUUID,
      avg(ytrackr_i_employee.Utilizationn as abap.fltp)                          as TeamUtilization,
      cast(100 as abap.fltp) - avg(ytrackr_i_employee.Utilizationn as abap.fltp) as TotalCap
}
group by
  ytrackr_teams.team_uuid
