"! AAP static check exception base class
"! <p>
"! Exceptions of this type should be expected and either be <strong>handled or propagated</strong>
"! by the caller.
"! </p>
CLASS zcx_aap_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS:
      BEGIN OF gc_error,
        msgid TYPE symsgid VALUE 'ZAAP',
        msgno TYPE symsgno VALUE '023',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_error.
    INTERFACES:
      if_t100_message.
    METHODS:
      "! @parameter is_textid | Textid
      "! @parameter ix_previous | Previous exception
      constructor IMPORTING is_textid   LIKE if_t100_message=>t100key OPTIONAL
                            ix_previous LIKE previous OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_aap_error IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = ix_previous ).

    CLEAR me->textid.
    IF is_textid IS INITIAL.
      if_t100_message~t100key = gc_error.
    ELSE.
      if_t100_message~t100key = is_textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
