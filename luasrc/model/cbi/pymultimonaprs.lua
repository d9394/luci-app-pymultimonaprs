m=Map("pymultimonaprs", "pymulitmonaprs" , translate("pymultimonaprs is a python scripts to receive APRS packet using RTL-SDR, and send to APRS server on Inet, It's a IGate."))
m:chain("luci")

s = m:section(TypedSection, "pymultimonaprs", "")
s.addremove = false
s.anonymous = true

enable=s:option(Flag, "disabled", translate("Enabled"))
enable.enabled="0"
enable.disabled="1"
enable.default = "1"
enable.rmempty = false

callsign=s:option(Value, "callsign", translate("callsign"))
function callsign:validate(value)
    return value:match("[a-zA-Z0-9\-]+")
end

passcode=s:option(Value, "passcode", translate("passcode for callsign"))
function passcode:validate(value)
    return value:match("[0-9]+")
end

gateway=s:option(DynamicList, "gateway", translate("APRS server, </br>Format: server:port"))

preferred_protocol=s:option(ListValue, "preferred_protocol", translate("APRS server connect protocol"))
preferred_protocol:value("Any")
preferred_protocol:value("UDP")
preferred_protocol:value("TCP")

append_callsign=s:option(Flag, "append_callsign", translate("When transmit to APRS server ,Add you callsgin or not"))
append_callsign.default=true

source=s:option(ListValue, "append_callsign", translate("recicve packet source"))
source:value("rtl")
source:value("alsa")

p = m:section(TypedSection, "rtl", "")
p.addremove = false
p.anonymous = true

rtl_freq=p:option(Value, "frequency", translate("APRS receive frequency"))
rtl_freq.depends(source,"rtl")

rtl_ppm=p:option(Value, "ppm", translate("RTL device ppm"))
rtl_ppm.default=0
rtl_ppm.depends(source,"rtl")

rtl_gain=p:option(Value, "gain", translate("RTL device gain"))
rtl_gain.defualt=0
rtl_gain.depends(source,"rtl")

rtl_offset_tuning=p:option(Flag, "offset_tuning", translate("RTL device offset"))
rtl_offset_tuning.default=false
rtl_offset_tuning.depends(source,"rtl")

rtl_device_index=p:option(Value, "device_index", translate("RTL device index"))
rtl_device_index.default=0
rtl_device_index.depends(source,"rtl")

rtl_squelch_level=p:option(Value, "squelch_level", translate("RTL squelch level"))
rtl_squelch_level.default=1
rtl_squelch_level.depends(source,"rtl")

q = m:section(TypedSection, "pymultimonaprs", "")
q.addremove = false
q.anonymous = true

alsa_device=q:option(Value, "device", translate("Alsa device index"))
alsa_device.depends(source,"alsa")
alsa_device.default="default"

r = m:section(TypedSection, "beacon", "")
r.addremove = false
r.anonymous = true

beacon_lat=r:option(Value, "lat", translate("beacon lat"))

beacon_lng=r:option(Value, "lng", translate("beacon lng"))

beacon_table=r:option(Value, "table" ,translate("beacon table"))
beacon_table.default="R"

beacon_symbol=r:option(Value, "symbol", translate("beacon symboe"))
beacon_symbol.default="&"

beacon_comment=r:option(Value, "comment", translate("beacon comment"))
beacon_comment.default="PyMultimonAPRS iGate on Openwrt Router"

beacon_status_text=r:option(Value, "text", translate("beacon status text"))
beacon_status_text.default="Running on Openwrt with RTL dongle"

beacon_status_file=r:option(Flag, "file", translate("beacon status use file"))
beacon_status_file.default=false

beacon_weather=r:option(Flag, "weather", translate("beacon send weather info"))
beacon_weather.default=false

beacon_send_every=r:option(Value, "send_every", translate("beacon info send times"))
beacon_send_every.default=300

beacon_ambiguity=r:option(Value, "ambiguity", translate("beacon send ambiguity info"))
beacon_ambiguity.default=3

return m
