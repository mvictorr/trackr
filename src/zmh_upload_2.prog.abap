*&---------------------------------------------------------------------*
*& Report ZMH_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmh_upload_2.
DATA: LV_filename TYPE string.
DATA: LV_ext TYPE string.
DATA: LV_exists            TYPE integer,
      lv_existing          TYPE i,
      lv_total_teams       TYPE i,
      lv_existing_teams    TYPE i,
      lv_total_members     TYPE i,
      lv_existing_members  TYPE i,
      lv_total_projects    TYPE i,
      lv_existing_projects TYPE i,
      lv_upload_toggle     TYPE i VALUE 0.
DATA: ls_member TYPE Ytrackr_Members.
DATA: Lv_count        TYPE Integer,
      lv_manager      TYPE string,
      lv_project      TYPE string,
      LV_days         TYPE p LENGTH 6 DECIMALS 3,
      Lv_user         TYPE string,
      Lv_Coverage     TYPE string,
      Lv_add          TYPE p LENGTH 6 DECIMALS 3,
      LV_total        TYPE p LENGTH 6 DECIMALS 3,
      lv_id           TYPE integer,
      Lv_last_user_id TYPE sysuuid_x16,
      Lv_last_proj_id TYPE sysuuid_x16,
      Lv_day_sum      TYPE Float,
      LS_Project      TYPE ytrackr_projects,
      LS_User         TYPE ytrackr_EMPLOYEE,
      ls_team         TYPE ytrackr_teams,
      Lv_New_User     TYPE integer,
      LV_procent      TYPE string,
      Lv_calc         TYPE p LENGTH 6 DECIMALS 3,
      LV_Fname        TYPE char100,
      lv_lname        TYPE char100,
      lv_check        TYPE p LENGTH 6 DECIMALS 3 VALUE '4.9',
      LV_jobtype      TYPE zjobtime_enum.
DATA ls_usr LIKE v_usr_name.
DATA: ls_lastemp TYPE Ytrackr_employee.
DATA: LT_Employee       TYPE TABLE OF ytrackr_EMPLOYEE,
      ls_Employee_check TYPE ytrackr_EMPLOYEE,
      LT_Employee_wid   TYPE TABLE OF ytrackr_EMPLOYEE WITH HEADER LINE.

DATA: LV_last_user TYPE String.

DATA: Lt_Data TYPE solix_tab.
DATA: xline TYPE x.
DATA : t_file LIKE TABLE OF xline.
DATA: lv_headerxstring TYPE xstring.
DATA: lv_filelength    TYPE i.

DATA: LT_Project        TYPE TABLE OF ytrackr_Projects,
      ls_projects       TYPE ytrackr_Projects,
      ls_projects_check TYPE ytrackr_Projects,
      LT_Project_wid    TYPE TABLE OF ytrackr_Projects WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1.
  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS: LV_File TYPE string.
    SELECTION-SCREEN PUSHBUTTON 50(10) TEXT-001 USER-COMMAND 100.
    SELECTION-SCREEN PUSHBUTTON 65(10) TEXT-002 USER-COMMAND 200.
    SELECTION-SCREEN PUSHBUTTON 80(10) TEXT-003 USER-COMMAND 300.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.
  lv_existing = 0.
  lv_total_teams     = 0.
  lv_existing_teams   = 0.
  lv_total_members   = 0.
  lv_existing_members = 0.
  lv_total_projects   = 0.
  lv_existing_projects = 0.
  lv_upload_toggle    = 0.
  CASE sy-Ucomm.
    WHEN '100'.
      CALL FUNCTION 'GUI_FILE_LOAD_DIALOG'
        EXPORTING
*         WINDOW_TITLE      =
          default_extension = '.xlsx'
*         DEFAULT_FILE_NAME =
*         WITH_ENCODING     =
*         FILE_FILTER       =
*         INITIAL_DIRECTORY =
        IMPORTING
          filename          = LV_filename
*         PATH              =
          fullpath          = LV_File
*         USER_ACTION       =
*         FILE_ENCODING     =
        .
    WHEN '200'.

*      DELETE FROM ytrackr_teams.
*      DELETE FROM ytrackr_EMPLOYEE.
*      DELETE FROM ytrackr_Projects.
*      DELETE FROM Ytrackr_emprj.
*      DELETE FROM ytrackr_members.

      lv_upload_toggle = 1.
      PERFORM run_upload.
    WHEN '300'.
      lv_upload_toggle = 0.
      PERFORM run_upload.
  ENDCASE.

FORM run_upload.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename   = LV_File
      filetype   = 'BIN'
    IMPORTING
      filelength = lv_filelength
      header     = lv_headerxstring
    TABLES
      data_tab   = lt_data.

  IF sy-subrc <> 0.
*       Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = lv_filelength
    IMPORTING
      buffer       = lv_headerxstring
    TABLES
      binary_tab   = lt_data
    EXCEPTIONS
      failed       = 1
      OTHERS       = 2.

  IF sy-subrc <> 0.
    "Implement suitable error handling here
  ENDIF.

  DATA : lo_excel_ref TYPE REF TO cl_fdt_xl_spreadsheet .

  TRY .
      lo_excel_ref = NEW cl_fdt_xl_spreadsheet(
                              document_name = lv_file
                              xdocument     = lv_headerxstring ) .
    CATCH cx_fdt_excel_core.
      "Implement suitable error handling here
  ENDTRY .

  lo_excel_ref->if_fdt_doc_spreadsheet~get_worksheet_names(
IMPORTING
  worksheet_names = DATA(lt_worksheets) ).

  IF NOT lt_worksheets IS INITIAL.
    READ TABLE lt_worksheets INTO DATA(lv_woksheetname) INDEX 1.

    DATA(lo_data_ref) = lo_excel_ref->if_fdt_doc_spreadsheet~get_itab_from_worksheet(
                                             lv_woksheetname ).
    "now you have excel work sheet data in dyanmic internal table

    FIELD-SYMBOLS : <gt_data>       TYPE STANDARD TABLE .

    ASSIGN lo_data_ref->* TO <gt_data>.
  ENDIF.

  LOOP AT <gt_data> ASSIGNING FIELD-SYMBOL(<gl_line>).
    IF Lv_count <> 0.

      ASSIGN COMPONENT 1 OF STRUCTURE <gl_line> TO FIELD-SYMBOL(<gl_data>).
      IF <gl_data> <> ''.
        SPLIT LV_filename AT '.' INTO LV_filename lv_lname.
        CLEAR lv_lname.
        SPLIT <gl_data> AT ' ' INTO lv_fname lv_lname.
        SELECT SINGLE * FROM v_usr_name INTO @ls_usr WHERE name_first = @lv_fname AND name_last = @lv_lname.
        CLEAR ls_Employee_check.
        SELECT SINGLE * FROM ytrackr_EMPLOYEE AS emp WHERE emp~first_name = @lv_fname AND emp~last_name = @lv_lname INTO @ls_Employee_check.
        IF ls_Employee_check IS INITIAL.

          LS_User-emp_uuid = cl_system_uuid=>create_uuid_x16_static( ).
          LS_User-first_name = lv_fname.
          ls_user-last_name = lv_lname.
          ls_user-username = ls_usr-bname.
          INSERT INTO ytrackr_EMPLOYEE VALUES ls_user.

        ELSE.
          MOVE-CORRESPONDING ls_Employee_check TO LS_User.
        ENDIF.
        ls_team-team_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        ls_team-team_name = LV_filename.
        ls_team-people_counselor  = LS_User-emp_uuid.
        ls_team-manager = LS_User-emp_uuid.

        INSERT INTO ytrackr_Teams VALUES ls_team.

        CLEAR LS_USer.
      ENDIF.

      ASSIGN COMPONENT 2 OF STRUCTURE <gl_line> TO <gl_data>.
      IF <gl_data> <> ''.
        PERFORM make_employee.
        Lv_user = <gl_data>.
        ASSIGN COMPONENT 3 OF STRUCTURE <gl_line> TO <gl_data>.
        Lv_Coverage = <gl_data>.
      ELSE.
        lv_new_user = 1.
      ENDIF.

      ASSIGN COMPONENT 5 OF STRUCTURE <gl_line> TO <gl_data>.
      IF <gl_data> <> ''.
        lv_project  = <gl_data>.
        ASSIGN COMPONENT 7 OF STRUCTURE <gl_line> TO <gl_data>.
        MOVE <gl_data> TO lv_add.
        lv_total = lv_total + lv_add.
      ENDIF.

    ELSE.
      Lv_count = Lv_count + 1.
    ENDIF.
  ENDLOOP.

  PERFORM make_employee.

  CLEAR Lv_count.
  LOOP AT <gt_data> ASSIGNING <gl_line>.
    IF Lv_count <> 0.
      ASSIGN COMPONENT 2 OF STRUCTURE <gl_line> TO <gl_data>.
      IF <gl_data> <> ''.

        SPLIT <gl_data> AT ' ' INTO lv_fname lv_lname.
        LOOP AT LT_Employee INTO ls_lastemp WHERE first_name = lv_fname AND last_name = lv_lname.
        ENDLOOP.

      ENDIF.
      ASSIGN COMPONENT 5 OF STRUCTURE <gl_line> TO <gl_data>.
      IF <gl_data> <> ''.
        lv_project  = <gl_data>.
        ASSIGN COMPONENT 8 OF STRUCTURE <gl_line> TO <gl_data>.


        CLEAR ls_projects_check.
        SELECT * FROM ytrackr_Projects AS prj WHERE prj~proj_name = @lv_project
                                            AND prj~proj_manager = @<gl_data>
                  INTO @ls_projects_check.
        ENDSELECT.

        IF ls_projects_check IS INITIAL.
          ls_projects-proj_uuid = cl_system_uuid=>create_uuid_x16_static( ).
          ls_projects-proj_name = lv_project.
          ls_projects-stream = lv_project.
          ls_projects-proj_manager = <gl_data>.
          ls_projects-delievery_manager = <gl_data>.
          IF lv_upload_toggle = 1.
            INSERT INTO ytrackr_Projects VALUES ls_projects.
          ENDIF.
        ELSE.
          lv_existing_projects = lv_existing_projects + 1.
          MOVE ls_projects_check TO Ls_Projects .
        ENDIF.

        lv_total_projects = lv_total_projects + 1.

        APPEND Ls_Projects TO LT_Project.

        DATA:lS_emp_prj TYPE Ytrackr_emprj.
        lS_emp_prj-emp_uuid = ls_lastemp-emp_uuid.
        lS_emp_prj-proj_uuid = ls_projects-proj_uuid.
        ASSIGN COMPONENT 6 OF STRUCTURE <gl_line> TO <gl_data>.
        CASE <gl_data>.
          WHEN 'planned'.
            lS_emp_prj-status = 1.
          WHEN 'ongoing'.
            lS_emp_prj-status = 2.
          WHEN 'ended'.
            lS_emp_prj-status = 3.
        ENDCASE.
        ASSIGN COMPONENT 7 OF STRUCTURE <gl_line> TO <gl_data>.
        lS_emp_prj-proj_days_per_week = <gl_data>.
        IF lv_upload_toggle = 1.
          INSERT INTO Ytrackr_emprj VALUES lS_emp_prj.
        ENDIF.
      ENDIF.
    ELSE.
      Lv_count = Lv_count + 1.
    ENDIF.
  ENDLOOP.
  MESSAGE w000(zmh_message) WITH lv_total_members lv_existing_members.
  MESSAGE w001(zmh_message) WITH lv_total_projects lv_existing_projects.
ENDFORM.

FORM make_project.

ENDFORM.





FORM make_employee.
  IF lv_new_user = 1.

    MOVE lv_coverage TO lv_calc.
    IF lv_calc <> 0.

      lv_calc = lv_total / lv_calc .
      IF lv_calc >= lv_check .
        LV_jobtype = '8'.
      ELSE.
        LV_jobtype = '6'.
      ENDIF.
      ls_user-jobtime = LV_jobtype.
    ENDIF.

    SPLIT Lv_user AT ' ' INTO lv_fname lv_lname.

    CLEAR ls_Employee_check.
    SELECT * FROM ytrackr_EMPLOYEE AS emp WHERE emp~first_name = @lv_fname AND emp~last_name = @lv_lname INTO @ls_Employee_check.
    ENDSELECT.

    IF ls_Employee_check IS INITIAL.
      ls_User-emp_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      LS_User-first_name = lv_fname.
      ls_user-last_name = lv_lname.
      IF lv_upload_toggle = 1.
        INSERT INTO ytrackr_employee VALUES ls_user.
      ENDIF.

      lv_total_members = lv_total_members + 1.
      CLEAR ls_member.

      ls_member-tmember_uuid = ls_User-emp_uuid.
      ls_member-team_uuid = ls_team-team_uuid.
      IF lv_upload_toggle = 1.
        INSERT INTO Ytrackr_Members VALUES ls_member.
      ENDIF.
    ELSE.
      lv_existing_members = lv_existing_members + 1.
      MOVE ls_Employee_check TO ls_user .
    ENDIF.
    APPEND ls_user TO LT_Employee .

    lv_new_user = 0.
    lv_calc = 0.
    lv_total = 0.
    lv_add = 0.
  ENDIF.
ENDFORM.
