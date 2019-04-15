m=Map("pymultimonaprs", "pymulitmonaprs" , translate("pymultimonaprs is a python scripts to receive APRS packet using RTL-SDR, and send to APRS server on Inet, It's a IGate."))
m:chain("luci")

s = m:section(TypedSection, "pymultimonaprs", "")
s.addremove = false
s.anonymous = true

enable=s:option(Flag, "disabled", translate("Enabled"))
enable.enabled="0"
enable.disabled="1"
enable.default = "1"
enable.rmempty=false

callsign=s:option(Value, "callsign", translate("callsign"))
function callsign:validate(value)
    return value:match("[a-zA-Z0-9\-]+")
end
callsign.rmempty=false

passcode=s:option(Value, "passcode", translate("passcode for callsign"))
function passcode:validate(value)
    return value:match("[0-9]+")
end
passcode.rmempty=false

gateway=s:option(DynamicList, "gateway", translate("APRS server, </br>Format: server:port"))
gateway.rmempty=false

preferred_protocol=s:option(ListValue, "preferred_protocol", translate("APRS server connect protocol"))
preferred_protocol:value("Any")
preferred_protocol:value("UDP")
preferred_protocol:value("TCP")
preferred_protocol.default="Any"

append_callsign=s:option(Flag, "append_callsign", translate("Append you callsgin into aprs message"))
append_callsign.default=true

source=s:option(ListValue, "source", translate("recicve packet source"))
source:value("rtl")
source:value("alsa")
source.default="rtl"

rtl_freq=s:option(Value, "freq", translate("APRS receive frequency"))
rtl_freq.depends(source,"rtl")
rtl_freq.rmempty=false

rtl_ppm=s:option(Value, "ppm", translate("RTL device ppm"))
rtl_ppm.default=0
rtl_ppm.depends(source,"rtl")

rtl_gain=s:option(Value, "gain", translate("RTL device gain"))
rtl_gain.defualt=0
rtl_gain.depends(source,"rtl")

rtl_offset_tuning=s:option(Flag, "offset_tuning", translate("RTL device offset"))
rtl_offset_tuning.default=false
rtl_offset_tuning.depends(source,"rtl")

rtl_device_index=s:option(Value, "device_index", translate("RTL device index"))
rtl_device_index.default=0
rtl_device_index.depends(source,"rtl")

rtl_squelch_level=s:option(Value, "squelch_level", translate("RTL squelch level"))
rtl_squelch_level.default=1
rtl_squelch_level.depends(source,"rtl")

alsa_device=s:option(Value, "device", translate("Alsa device index"))
alsa_device.depends(source,"alsa")
alsa_device.default="default"

baacon_beacon=s:option(Flag, "beacon", translate("send beacon or not"))
beacon_beacon.default=1

beacon_lat=s:option(Value, "lat", translate("beacon lat"))
beacon_lat.rmempty=false

beacon_lng=s:option(Value, "lng", translate("beacon lng"))
beacon_lng.rmempty=false

beacon_table=s:option(Value, "table" ,translate("beacon table"))
beacon_table.default="R"

beacon_symbol=s:option(Value, "symbol", translate("beacon symboe"))
beacon_symbol.default="&"

beacon_comment=s:option(Value, "comment", translate("beacon comment"))
beacon_comment.default="PyMultimonAPRS iGate on Openwrt Router"

beacon_status_text=s:option(Value, "text", translate("beacon status text"))
beacon_status_text.default="Running on Openwrt with RTL dongle"

beacon_status_file=s:option(Flag, "file", translate("beacon status use file"))
beacon_status_file.default=false

beacon_weather=s:option(Flag, "weather", translate("beacon send weather info"))
beacon_weather.default=false

beacon_send_every=s:option(Value, "send_every", translate("beacon info send times"))
beacon_send_every.default=300

beacon_ambiguity=s:option(Value, "ambiguity", translate("beacon send ambiguity info"))
beacon_ambiguity.default=3

logging=s:option(Value, "logging", translate("pymultimonaprs logging to path/file"))
logging.default="/tmp/aprs.log"

debug=s:option(Flag, "debug", translate("pymultimonaprs running in debug mode"))
debug.default=false

return m
