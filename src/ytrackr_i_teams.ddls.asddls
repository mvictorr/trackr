@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teams interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ytrackr_i_teams
  as select from    ytrackr_teams as Team

    left outer join YTRACKR_C_TEAM_CAP on Team.team_uuid = YTRACKR_C_TEAM_CAP.TeamUUID

  association [1] to ytrackr_i_employee as _PeopleCounselor on Team.people_counselor = _PeopleCounselor.EmpUuid

  association [1] to ytrackr_i_employee as _Manager         on Team.manager = _Manager.EmpUuid

  association [1..*] to ytrackr_member_del as _Members         on Team.team_uuid = _Members.TeamUuid

{
  key Team.team_uuid                     as TeamUuid,
      Team.people_counselor              as PeopleCounselor,
      Team.manager                       as Manager,
      Team.team_name                     as TeamName,
      //    available_capacity as AvaCap,

      YTRACKR_C_TEAM_CAP.TeamUtilization as TeamUtilization,
      YTRACKR_C_TEAM_CAP.TotalCap        as TotalCap,

      _PeopleCounselor,
      _Manager,
      _Members
}
where
     _PeopleCounselor.Username = $session.user
  or _Manager.Username         = $session.user
