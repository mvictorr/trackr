CLASS lhc_YTRACKR_C_STATUS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ytrackr_c_status RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE ytrackr_c_status.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ytrackr_c_status.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ytrackr_c_status.

    METHODS read FOR READ
      IMPORTING keys FOR READ ytrackr_c_status RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK ytrackr_c_status.

ENDCLASS.

CLASS lhc_YTRACKR_C_STATUS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  select * from ytrackr_c_status FOR ALL ENTRIES IN @keys where EmpUUID = @keys-EmpUUID into CORRESPONDING FIELDS OF
  table @result.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_YTRACKR_C_STATUS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_YTRACKR_C_STATUS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
