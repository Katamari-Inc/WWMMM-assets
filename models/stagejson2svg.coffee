fs = require 'fs'
data = JSON.parse(fs.readFileSync("http-aid-dcc.json"))

# 1024px * 0.3 / 25.4 * 72
# 1024px -> 307.2mm -> 12.094488189in -> 870.803149608px
# 1122.755905512

toMm = .850393701
toPx = 1 / toMm / 25.4 * 72
# console.error toPx
# console.error toPx * toMm

svg = """
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
   width="870.803149606" height="1154.834645669" viewBox="0 0 870.803149606 1154.834645669" enable-background="new 0 0 870.803149606 1154.834645669"
   xml:space="preserve">
   <rect x="0" y="0" fill="#FFFFFF" stroke="none" width="870.803149606" height="1154.834645669"/>
   <g transform="matrix(#{toMm} 0 0 #{toMm} 0 0)">
"""

# console.log data.islands[0]

labels = ""
guardrails = ""
svg += "<g id=\"Floor\">"
for island in data.islands
  for contour in island.contours
    svg += """
    <polygon fill="#1CB8E8" stroke="none" stroke-miterlimit="10" points="#{contour.join(',')}"/>
    """
    minX = minY = Number.MAX_VALUE
    maxX = maxY = Number.MIN_VALUE
    for i in [0...contour.length] by 2
      x = contour[i]
      y = contour[i + 1]
      if x < minX then minX = x
      if maxX < x then maxX = x
      if y < minY then minY = y
      if maxY < y then maxY = y
    labels += """
    <text x="#{(minX + maxX) / 2}" y="#{(minY + maxY) / 2 + 4}" fill="#BF5AA2" font-family="Verdana" font-size="12" text-anchor="middle">#{island.level}</text>
    """
  for guardrail in island.guardrails
    guardrails += """
    <polyline fill="none" stroke="#514ED1" stroke-width="0.4mm" stroke-linejoin="round" points="#{guardrail.join(',')}"/>
    """
svg += "</g>"

svg += "<g id=\"Floor level\">" + labels + "</g>"
svg += "<g id=\"Guardrails\">" + guardrails + "</g>"

labels = ""
svg += "<g id=\"Bridges\">"
for bridge in data.bridges
  a = -bridge.angle / 180 * Math.PI
  s = Math.sin(a)
  c = Math.cos(a)
  if bridge.type is 0
    color = "#4CB73D"
    x = 0
    d = bridge.distance
  else
    color = "#EF305E"
    d = Math.max(bridge.distance, 15)
    if bridge.level[1] > bridge.level[0]
      x = bridge.distance - d
  # x -= 0.2 * toPx
  # d += 0.2 * 2 * toPx
  svg += """
  <g transform="matrix(#{c} #{-s} #{s} #{c} #{bridge.start[0]} #{bridge.start[1]})">
    <circle fill="#{color}" opacity="0.5" cx="#{x - 4 * toPx}" cy="" r="#{3.3 / 2 * toPx}"/>
    <circle fill="#{color}" opacity="0.5" cx="#{x + d + 4 * toPx}" cy="" r="#{3.3 / 2 * toPx}"/>
    <rect x="#{x - 0.3 / 2 * toPx}" y="#{-(bridge.width + 0.3 * toPx) / 2}" fill="#{color}" opacity="0.5" stroke="none" width="#{d + 0.3 * toPx}" height="#{bridge.width + 0.3 * toPx}"/>
    <rect x="#{x + d}" y="#{-(2 + .3) / 2 * toPx}" width="#{4 * toPx}" height="#{(2 + .3) * toPx}" fill="#{color}" opacity="0.5" stroke="none"/>
    <rect x="#{x - 4 * toPx}" y="#{-(2 + .3) / 2 * toPx}" width="#{4 * toPx}" height="#{(2 + .3) * toPx}" fill="#{color}" opacity="0.5" stroke="none"/>
    <rect x="#{x}" y="#{-bridge.width / 2}" fill="#FFC90A" opacity="0.5" stroke="none" width="#{d}" height="#{bridge.width}"/>

    <!--
    <circle fill="#ff0000" opacity="0.3" cx="#{x - 4 * toPx}" cy="" r="#{3 / 2 * toPx}"/>
    <circle fill="#ff0000" opacity="0.3" cx="#{d + 4 * toPx}" cy="" r="#{3 / 2 * toPx}"/>
    <rect x="#{x}" y="#{-bridge.width / 2}" fill="#{color}" opacity="0.5" stroke="none" width="#{d}" height="#{bridge.width}"/>
    <rect x="#{x + d}" y="#{-2 / 2 * toPx}" width="#{4 * toPx}" height="#{2 * toPx}" fill="#{color}" opacity="0.5" stroke="none"/>
    <rect x="#{x - 4 * toPx}" y="#{-2 / 2 * toPx}" width="#{4 * toPx}" height="#{2 * toPx}" fill="#{color}" opacity="0.5" stroke="none"/>
    -->
  </g>
  """
  labels += """
  <text x="#{bridge.start[0]}" y="#{bridge.start[1]}" fill="#4F4AAF" font-family="Verdana" font-size="12">W#{bridge.width}, D#{d}</text>
  """
svg += "</g>"

svg += "<g id=\"Bridge size\">" + labels + "</g>"

svg += "</g></svg>"

# console.log svg
fs.writeFileSync("stage.svg", svg)
