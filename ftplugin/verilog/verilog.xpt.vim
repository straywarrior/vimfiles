XPTemplate priority=lang


XPTvar $TRUE           1
XPTvar $FALSE          0
XPTvar $NULL           NULL

XPTvar $BRif           ' '
XPTvar $BRloop         ' '
XPTvar $BRstc          ' '
XPTvar $BRfun          \n

XPTvar $VOID_LINE      /* void */;
XPTvar $CURSOR_PH      /* cursor */

XPTinclude
      \ _common/common

XPTvar $CL  /*
XPTvar $CM   *
XPTvar $CR   */
XPTinclude
      \ _comment/c.like
      \ _comment/cpp.like

let s:f = g:XPTfuncs()

XPT begin    " begin ... end
begin
    `^
end

XPT always    " always @() begin ... end
always @(`^) begin
    `^
end

XPT if    " if () begin ... end
if (`^) begin
    `^
end

XPT else    " else begin ... end
else begin
    `^
end

XPT elif    " else if () begin ... end
else if (`^) begin
    `^
end
