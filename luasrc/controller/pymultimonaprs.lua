module("luci.controller.pymultimonaprs", package.seeall)

function index()
        entry({"admin", "services", "pymultimonaprs"}, cbi("pymultimonaprs"), _("pymultimonaprs"))
end
