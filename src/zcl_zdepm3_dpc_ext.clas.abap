class ZCL_ZDEPM3_DPC_EXT definition
  public
  inheriting from ZCL_ZDEPM3_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZDEPM3_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
    DATA: ls_para    LIKE LINE OF it_parameter.

    CASE iv_action_name.
      WHEN 'FIcategory'.
        READ TABLE it_parameter INTO ls_para WITH KEY name = 'IPcategory'.
        IF sy-subrc EQ 0.
          SELECT product_id, type_code, category, name_guid, desc_guid, supplier_guid
            FROM snwd_pd
              INTO TABLE @DATA(lt_product)
                WHERE category EQ @ls_para-value.

          IF sy-subrc EQ 0.
            copy_data_to_ref(
              EXPORTING
                is_data = lt_product
              CHANGING
                cr_data = er_data
            ).
          ENDIF.
        ENDIF.
      WHEN OTHERS.
*        Do Nothing
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
