@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Team members interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ytrackr_member_del as select from ytrackr_members as Member

 association[1] to ytrackr_i_teams as _Team
 on Member.team_uuid = _Team.TeamUuid
  
 association[1] to ytrackr_i_employee as _Employee
 on Member.tmember_uuid = _Employee.EmpUuid

{
  key tmember_uuid          as TmemberUuid,
  key team_uuid             as TeamUuid,
  
  _Team,
  _Employee
}where _Team._PeopleCounselor.Username = $session.user or _Team._Manager.Username = $session.user
