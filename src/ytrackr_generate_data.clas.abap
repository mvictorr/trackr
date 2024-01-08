CLASS ytrackr_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ytrackr_generate_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  data itab1 type table of ytrackr_employee.

  DATA(lvemp1) = cl_system_uuid=>create_uuid_x16_static( ).

   write:/ lvemp1.


*    DATA itab3 TYPE TABLE OF ytrackr_employee.
*
*    DATA(lvemp1) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp2) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp3) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp4) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp5) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp6) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp7) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp8) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvemp9) = cl_system_uuid=>create_uuid_x16_static( ).
*
*
*
*    itab3 = VALUE #(
*    ( emp_uuid = lvemp1 date_of_empl = '01.10.2022' department = 'ABAP' email = 'victor.mihoc@mhp.com' first_name = 'Victor'
*    jobtime = '6' last_name = 'Mihoc' location = 'Cluj-Napoca' role = 'PC' utilization = '50' username = 'VMIHOC')
*    ( emp_uuid = lvemp2 date_of_empl = '01.10.2022' department = 'UI' email = 'ruben.bonte@mhp.com' first_name = 'Ruben'
*    jobtime = '6' last_name = 'Bonte' location = 'Cluj-Napoca' role = 'JC' utilization = '50' username = 'RBONTE')
*    ( emp_uuid = lvemp3 date_of_empl = '01.10.2022' department = 'UI' email = 'akan.ali@mhp.com' first_name = 'Akan'
*    jobtime = '6' last_name = 'Narcis' location = 'Cluj-Napoca' role = 'PC' utilization = '50' username = 'AAKAN')
*    ( emp_uuid = lvemp4 date_of_empl = '01.10.2022' department = 'UI' email = 'alexandru.vandici@mhp.com' first_name = 'Alexandru'
*    jobtime = '8' last_name = 'Vandici' location = 'Cluj-Napoca' role = 'JC' utilization = '50' username = 'AVANDICI')
*    ( emp_uuid = lvemp5 date_of_empl = '01.10.2022' department = 'UI' email = 'ariana.horvath@mhp.com' first_name = 'Ariana'
*    jobtime = '6' last_name = 'Horvath' location = 'Cluj-Napoca' role = 'JC' utilization = '50' username = 'AHORVATH')
*    ( emp_uuid = lvemp6 date_of_empl = '01.10.2022' department = 'UI' email = 'mihnea.harsan@mhp.com' first_name = 'Mihnea'
*    jobtime = '6' last_name = 'Harsan' location = 'Cluj-Napoca' role = 'JC' utilization = '50' username = 'MHARSAN')
*     ( emp_uuid = lvemp7 date_of_empl = '01.10.2022' department = 'ABAP' email = 'dragos.idk@mhp.com' first_name = 'Dragos'
*    jobtime = '6' last_name = '' location = 'Timisoara' role = 'JC' utilization = '50')
*         ( emp_uuid = lvemp8 date_of_empl = '01.10.2022' department = 'ABAP' email = 'mara.deac-petrusel@mhp.com' first_name = 'Mara'
*    jobtime = '8' last_name = 'Deac-Petrusel' location = 'Cluj-Napoca' role = 'M' username = 'MDEAC-PETRUS')
*         ( emp_uuid = lvemp9 date_of_empl = '01.10.2022' department = 'ABAP' email = 'dragos.idk@mhp.com' first_name = 'Radu'
*    jobtime = '8' last_name = 'Fugaciu' location = 'Cluj-Napoca' role = 'M' username = 'RFUGACIU')
*
*
*    ).
*
*
*
*    DATA itab4 TYPE TABLE OF ytrackr_projects.
*
*    DATA(lvproj1) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvproj2) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvproj3) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvproj4) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvproj5) = cl_system_uuid=>create_uuid_x16_static( ).
*
*
*
*    itab4 = VALUE #(
*       ( proj_uuid = lvproj1 proj_name = 'Porsche' proj_manager = 'Lea Müller' stream = 'Motorsport' delievery_manager = 'Lea Müller')
*       ( proj_uuid = lvproj2 proj_name = 'Boeing' proj_manager = 'Nico Bauer' stream = 'Design' delievery_manager = 'Nico Bauer')
*       ( proj_uuid = lvproj3 proj_name = 'Bose' proj_manager = 'Hannah Schmidt' stream = 'Audio' delievery_manager = 'Hannah Schmidt')
*       ( proj_uuid = lvproj4 proj_name = 'Mercedes' proj_manager = 'Felix Klein' stream = 'Migration' delievery_manager = 'Felix Klein')
*       ( proj_uuid = lvproj5 proj_name = 'Aerostar' proj_manager = 'Maximilian Weber' stream = 'Maintenance' delievery_manager = 'Maximilian Weber')
*
*
*
*     ).
*
*
*    DATA itab TYPE TABLE OF ytrackr_teams.
*
*
*    DATA(lvteam1) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvteam2) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvteam3) = cl_system_uuid=>create_uuid_x16_static( ).
*    DATA(lvteam4) = cl_system_uuid=>create_uuid_x16_static( ).
*
*
*
*    itab = VALUE #(
*
*
*  (  team_uuid = lvteam1 people_counselor = lvemp1 manager = lvemp1 team_name = 'MHP VM' )
*  (  team_uuid = lvteam2 people_counselor = lvemp3 manager = lvemp3 team_name = 'MHP AA' )
*    (  team_uuid = lvteam3 people_counselor = lvemp2 manager = lvemp2 team_name = 'MHP RB' )
*
*
*    ).
*
*
*
*
*    DATA itab2 TYPE TABLE OF ytrackr_members.
*
*
*    itab2 = VALUE #(
*    ( team_uuid = lvteam1 tmember_uuid = lvemp6  )
*    ( team_uuid = lvteam1 tmember_uuid = lvemp8  )
*    ( team_uuid = lvteam2 tmember_uuid = lvemp4  )
*    ( team_uuid = lvteam2 tmember_uuid = lvemp9  )
*    ( team_uuid = lvteam3 tmember_uuid = lvemp5  )
*    ( team_uuid = lvteam3 tmember_uuid = lvemp7  )
*
*      ).
*
*
*    DATA itab5 TYPE TABLE OF ytrackr_emprj.
*
*    itab5 = VALUE #(
*
*    ( emp_uuid = lvemp4 proj_uuid = lvproj3 status = '2' comments = 'Making good progress' proj_days_per_week = '1')
* ( emp_uuid = lvemp2 proj_uuid = lvproj4 status = '2' comments = 'Waiting for client feedback' proj_days_per_week = '1')
*( emp_uuid = lvemp5 proj_uuid = lvproj2 status = '1' comments = 'Delivered ahead of schedule' proj_days_per_week = '1')
*( emp_uuid = lvemp3 proj_uuid = lvproj5 status = '3' comments = 'Needs more resources' proj_days_per_week = '1')
*( emp_uuid = lvemp1 proj_uuid = lvproj1 status = '4' comments = 'Great teamwork' proj_days_per_week = '1')
*( emp_uuid = lvemp6 proj_uuid = lvproj2 status = '2' comments = 'Waiting for materials' proj_days_per_week = '1')
*( emp_uuid = lvemp2 proj_uuid = lvproj3 status = '2' comments = 'Facing technical challenges' proj_days_per_week = '1')
*( emp_uuid = lvemp3 proj_uuid = lvproj1 status = '2' comments = 'Excellent work!' proj_days_per_week = '1')
*( emp_uuid = lvemp5 proj_uuid = lvproj4 status = '3' comments = 'Need to improve communication' proj_days_per_week = '1')
*( emp_uuid = lvemp1 proj_uuid = lvproj5 status = '2' comments = 'Facing tight deadlines' proj_days_per_week = '1')
*    ).
*
*
*
*    DELETE FROM ytrackr_teams.
*    DELETE FROM ytrackr_members.
*    DELETE FROM ytrackr_employee.
*    DELETE FROM ytrackr_projects.
*    DELETE FROM ytrackr_emprj.
*
*    INSERT ytrackr_teams FROM TABLE @itab.
**
*    INSERT ytrackr_members FROM TABLE @itab2.
*    INSERT ytrackr_employee FROM TABLE @itab3.
*
*    INSERT ytrackr_projects FROM TABLE @itab4.
*    INSERT ytrackr_emprj FROM TABLE @itab5.
*
*
*

  ENDMETHOD.

ENDCLASS.
