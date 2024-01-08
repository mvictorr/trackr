@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project status projection view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity YTRACKR_C_STATUS
  as select from    ytrackr_employee
    left outer join ytrackr_emprj               on ytrackr_employee.emp_uuid = ytrackr_emprj.emp_uuid
    left outer join ytrackr_projects            on ytrackr_emprj.proj_uuid = ytrackr_projects.proj_uuid
    join            ytrackr_members             on ytrackr_employee.emp_uuid = ytrackr_members.tmember_uuid
    join            ytrackr_teams               on ytrackr_members.team_uuid = ytrackr_teams.team_uuid
    join            YTRACKR_C_TEAM_CAP          on ytrackr_teams.team_uuid = YTRACKR_C_TEAM_CAP.TeamUUID
    left outer join ytrackr_c_status_projection on ytrackr_employee.emp_uuid = ytrackr_c_status_projection.EmpUUID




{
  key ytrackr_employee.emp_uuid                                                                       as EmpUUID,
  key ytrackr_projects.proj_uuid                                                                      as ProjUUID,
      ytrackr_emprj.proj_days_per_week                                                                as ProjDaysPerWeek,
      ytrackr_emprj.status                                                                            as Status,
      ytrackr_emprj.comments                                                                          as Comments,
      concat_with_space(ytrackr_employee.first_name, ytrackr_employee.last_name, 1)                   as Fullname,
      ytrackr_projects.proj_manager                                                                   as ProjManager,
      ytrackr_projects.proj_name                                                                      as ProjName,
      ytrackr_projects.stream                                                                         as Stream,
      ytrackr_teams.team_name                                                                         as Team,

      ytrackr_c_status_projection.ProjDays /
      ( case when ytrackr_employee.jobtime = '4' then cast(2.5 as abap.fltp) when ytrackr_employee.jobtime = '6' then cast(3.75 as abap.fltp)
      when ytrackr_employee.jobtime = '8' then cast(5 as abap.fltp) end )  * cast( 100 as abap.fltp ) as Utilization,

      YTRACKR_C_TEAM_CAP.TeamUtilization                                                              as TeamUtilization,
      YTRACKR_C_TEAM_CAP.TotalCap                                                                     as TotalCap,


      ytrackr_projects.delievery_manager                                                              as DeliveryManager

}
