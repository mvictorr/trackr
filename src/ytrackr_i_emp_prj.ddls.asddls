@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project status interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ytrackr_i_emp_prj as select from ytrackr_emprj as _EmpProj
association[1] to ytrackr_i_employee as _Employee
on _EmpProj.emp_uuid = _Employee.EmpUuid
association[1] to ytrackr_i_projects as _Project
on _EmpProj.proj_uuid = _Project.ProjUuid
 {
    key emp_uuid as EmpUuid,
    key proj_uuid as ProjUuid,
    proj_days_per_week as ProjDaysPerWeek,
    status as Status,
    comments as Comments,
    
    _Employee,
    _Project
}
