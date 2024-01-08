CLASS lhc_ytrackr_i_emp_prj DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ytrackr_i_emp_prj RESULT result.
    METHODS checkprojdays FOR VALIDATE ON SAVE
      IMPORTING keys FOR ytrackr_i_emp_prj~checkprojdays.

ENDCLASS.

CLASS lhc_ytrackr_i_emp_prj IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD checkProjDays.

    READ ENTITIES OF ytrackr_i_emp_prj IN LOCAL MODE
    ENTITY ytrackr_i_emp_prj
    FIELDS ( ProjDaysPerWeek ) WITH CORRESPONDING #( keys )
    RESULT DATA(EmpProjDays).

    LOOP AT empprojdays INTO DATA(projDays).

      IF projdays-ProjDaysPerWeek > 6 OR projdays-ProjDaysPerWeek < 0.

        APPEND VALUE #( %tky = projdays-%tky ) TO failed-ytrackr_i_emp_prj.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = 'Cannot have more than 5 project days per week') )
        TO reported-ytrackr_i_emp_prj.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
