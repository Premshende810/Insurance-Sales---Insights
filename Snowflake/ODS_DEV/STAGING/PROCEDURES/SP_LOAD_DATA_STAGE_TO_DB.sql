CREATE OR REPLACE PROCEDURE ODS_DEV.STAGING.SP_AUTOMATE_DATA_COPY()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS CALLER
AS 'DECLARE
    curs CURSOR FOR SELECT * FROM ods_dev.control.copy_ctrl WHERE is_active = TRUE;

    tbl STRING;
    sch STRING;
    db STRING;
    file_typ STRING;
    file_pat STRING;
    fld_dlm STRING;
    skp_hdr STRING;
    forc STRING;
    on_err STRING;
    trun_col STRING;
    cnt INTEGER;
    ret STRING;
    file_format1 STRING;
    copy_stmt STRING;

BEGIN
    ret := '''';

    FOR rec IN curs DO
        tbl := rec.stage_table_name;
        sch := rec.schema_name;
        db := rec.database_name;
        file_typ := rec.files_typ;
        file_pat := rec.files_pattern;
        fld_dlm := rec.field_delim;
        skp_hdr := rec.skip_header;
        forc := rec.force;
        on_err := rec.on_error;
        trun_col := rec.truncate_cols;

        IF (:file_typ = ''csv'') THEN
            file_format1 := ''(type='' || :file_typ || '' skip_header='' || :skp_hdr || '' field_delimiter='''''' || :fld_dlm || '''''' empty_field_as_null = TRUE)'';
        ELSE
            file_format1 := ''(type='' || :file_typ || '')'';
        END IF;

        -- Removed the CREATE STAGE statement, as you already have ODS_STAGE
        -- You can directly use ODS_STAGE in your COPY command

        SELECT COUNT(1) INTO cnt FROM table(result_scan(last_query_id()));

        -- Check for the files in the stage
        LIST @ods_dev.staging.ODS_STAGE;

        SELECT COUNT(1) INTO cnt FROM table(result_scan(last_query_id()));

        IF (:cnt > 0) THEN
            copy_stmt := ''COPY INTO '' || :db || ''.'' || :sch || ''.'' || :tbl || ''
            FROM @ods_dev.staging.ODS_STAGE
            PATTERN = '''''' || :file_pat || '''''' 
            ON_ERROR = '' || :on_err || ''
            FORCE = '' || :forc || ''
            TRUNCATECOLUMNS = '' || :trun_col;

            EXECUTE IMMEDIATE copy_stmt;

            ret := :ret || :file_pat || '' Format files completed successfully. \\n'';
        ELSE
            ret := :ret || :file_pat || '' Format files not present in the external stage. \\n'';
        END IF;

    END FOR;

    RETURN :ret;

END';
