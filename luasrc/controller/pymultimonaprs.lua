module("luci.controller.pymultimonaprs", package.seeall)

function index()
        if not nixio.fs.access("/etc/config/pymultimonaprs") then
                nixio.fs.writefile("/etc/config/pymultimonaprs","config pymultimonaprs main\n")
        end

        local page=entry({"admin", "services", "pymultimonaprs"}, cbi("pymultimonaprs"), _("pymultimonaprs"))
        page.dependent = true

end
