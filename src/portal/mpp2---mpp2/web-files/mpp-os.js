(function(){
"use strict";

// ── DATA ──────────────────────────────────────────
var D = {
  rings: [
    { key: "center", label: "One Record", color: "#002B5C", radius: 0,
      desc: "Every contact, property, program, and dollar lives in one shared database. Your staff and our Copilot agents work from the same record." },
    { key: "backoffice", label: "Your Back Office", color: "#3B6B94", radius: 150,
      desc: "AP, procurement, grants, fundraising, volunteers, and HR. Everything that keeps the doors open and the auditors happy." },
    { key: "programs", label: "Your Programs", color: "#B85C38", radius: 280,
      desc: "Homebuyer education, down payment assistance, construction management, property management, and learning management." },
    { key: "constituents", label: "Your Constituents", color: "#6B7B8D", radius: 390,
      desc: "Portals, website, email, Copilot agents, and managed Microsoft 365. Every surface your homebuyers, tenants, donors, and vendors see." },
    { key: "quickbooks", label: "Your ERP (QuickBooks)", color: "#C8C8C8", radius: 460,
      desc: "We don't replace your general ledger. Our AP and procurement modules feed your QuickBooks." }
  ],
  nodes: [
    { ring: "center", label: "Shared Dataverse", angle: 0 },
    { ring: "backoffice", label: "AP", angle: 0 },
    { ring: "backoffice", label: "Procurement", angle: 60 },
    { ring: "backoffice", label: "Grants", angle: 120 },
    { ring: "backoffice", label: "Fundraising", angle: 180 },
    { ring: "backoffice", label: "Volunteers", angle: 240 },
    { ring: "backoffice", label: "HR", angle: 300 },
    { ring: "programs", label: "HBE", angle: 0 },
    { ring: "programs", label: "DPA", angle: 51 },
    { ring: "programs", label: "Construction", angle: 103 },
    { ring: "programs", label: "Property Mgmt", angle: 154 },
    { ring: "programs", label: "LMS", angle: 206 },
    { ring: "programs", label: "Prop Analyzer", angle: 257 },
    { ring: "programs", label: "Plan Manager", angle: 309 },
    { ring: "constituents", label: "Portals", angle: 0 },
    { ring: "constituents", label: "Website", angle: 45 },
    { ring: "constituents", label: "Email", angle: 90 },
    { ring: "constituents", label: "Copilot Agents", angle: 135 },
    { ring: "constituents", label: "M365", angle: 180 },
    { ring: "constituents", label: "Classes", angle: 225 },
    { ring: "constituents", label: "Donations", angle: 270 },
    { ring: "constituents", label: "Rent Payments", angle: 315 }
  ],
  modules: [
    { name: "Accounts Payable", ring: "backoffice", icon: "\uD83D\uDCC4", slug: "accounts-payable",
      summary: "Invoice intake, approval workflows, vendor payments, and 1099s. AI reads the invoices." },
    { name: "Procurement", ring: "backoffice", icon: "\uD83D\uDCCB", slug: "procurement",
      summary: "Purchase orders, vendor management, contract compliance, and bid tracking." },
    { name: "Grants Management", ring: "backoffice", icon: "\uD83C\uDFDB", slug: "grants",
      summary: "Grant tracking, reporting, drawdowns, and compliance calendars." },
    { name: "Fundraising & Engagement", ring: "backoffice", icon: "\u2764\uFE0F", slug: "fundraising",
      summary: "Donor CRM, campaigns, receipts, newsletters, and board dashboards." },
    { name: "Volunteer Management", ring: "backoffice", icon: "\uD83E\uDD1D", slug: "volunteers",
      summary: "Recruitment, scheduling, hour tracking, and impact reporting." },
    { name: "Human Resources", ring: "backoffice", icon: "\uD83D\uDC65", slug: "hr",
      summary: "Employee records, onboarding, time-off, and compliance." },
    { name: "Homebuyer Education", ring: "programs", icon: "\uD83C\uDF93", slug: "hbe",
      summary: "Class scheduling, attendance, certificates, and HUD 9902 reporting." },
    { name: "Down Payment Assistance", ring: "programs", icon: "\uD83D\uDD11", slug: "dpa",
      summary: "Application intake, income verification, underwriting, closing, and liens." },
    { name: "Construction Management", ring: "programs", icon: "\uD83C\uDFD7", slug: "cms",
      summary: "Project tracking, draws, RFIs, submittals, and vendor portals." },
    { name: "Property Management", ring: "programs", icon: "\uD83C\uDFE2", slug: "property-management",
      summary: "Tenant ledger, rent collection, maintenance, and unit turns." },
    { name: "Learning Management", ring: "programs", icon: "\uD83D\uDCDA", slug: "lms",
      summary: "Online courses, certifications, and compliance training." },
    { name: "Property Analyzer", ring: "programs", icon: "\uD83D\uDCCD", slug: "find-jurisdiction",
      summary: "Jurisdiction lookup, appraisal data, and property research." },
    { name: "Plan Manager", ring: "programs", icon: "\uD83D\uDCD0", slug: "plan-manager",
      summary: "Architectural plan and drawing version control for construction." },
    { name: "Website & Portals", ring: "constituents", icon: "\uD83C\uDF10", slug: "hbe",
      summary: "Power Pages portals for homebuyers, tenants, donors, and vendors. One login." },
    { name: "Email Campaigns", ring: "constituents", icon: "\u2709\uFE0F", slug: "fundraising",
      summary: "Newsletters, announcements, and automated journeys. Built into the CRM." },
    { name: "Copilot Studio Agents", ring: "constituents", icon: "\uD83E\uDD16", slug: "hbe",
      summary: "AI agents that answer questions, schedule classes, and check status \u2014 24/7." },
    { name: "Managed Microsoft 365", ring: "constituents", icon: "\uD83D\uDEE1", slug: "m365",
      summary: "Business email, Teams, security, and Copilot \u2014 one vendor, one bill." }
  ],
  txns: {
    homebuyer: { label: "A family buys a home", steps: [
      { ring: "constituents", label: "Registers on portal", desc: "Prospective homebuyer finds a class and registers online." },
      { ring: "programs", label: "Attends HBE class", desc: "Class roster tracked, certificate issued after completion." },
      { ring: "programs", label: "Applies for DPA", desc: "Uploads documents. Income verified against AMI." },
      { ring: "backoffice", label: "Compliance check", desc: "Funding-source rules validated. Audit trail created." },
      { ring: "programs", label: "Closes on home", desc: "Award, closing package, lien recorded." },
      { ring: "backoffice", label: "AP disburses funds", desc: "Funds wired. Invoice recorded. GL entry created." },
      { ring: "center", label: "One record updated", desc: "Contact, property, loan, and program history \u2014 all in one place." }
    ]},
    tenant: { label: "A tenant pays rent", steps: [
      { ring: "constituents", label: "Pays on portal", desc: "Tenant pays rent through the self-service portal." },
      { ring: "programs", label: "Rent posted", desc: "Rent roll updated. Late notices sent automatically." },
      { ring: "backoffice", label: "AR updated", desc: "Accounts receivable and cash flow reflect the payment." },
      { ring: "programs", label: "Maintenance work order", desc: "Tenant submits request. Vendor dispatched." },
      { ring: "backoffice", label: "Vendor paid", desc: "Invoice matched to work order, approved, and paid." },
      { ring: "center", label: "Ledger current", desc: "Tenant ledger and unit financials are up to date." }
    ]},
    donor: { label: "A donor gives", steps: [
      { ring: "constituents", label: "Gives online", desc: "One-time or recurring gift on your website." },
      { ring: "programs", label: "Gift recorded", desc: "Donation recorded, receipt issued, thank-you queued." },
      { ring: "backoffice", label: "Tax receipt sent", desc: "GL entry and tax receipt generated automatically." },
      { ring: "constituents", label: "Newsletter journey", desc: "Donor segmented into the right stewardship track." },
      { ring: "backoffice", label: "Board dashboard", desc: "Campaign P&L and giving trends updated." },
      { ring: "center", label: "Donor history complete", desc: "Every gift, every interaction, in one donor record." }
    ]},
    contractor: { label: "A contractor gets paid", steps: [
      { ring: "constituents", label: "Submits draw", desc: "Contractor submits draw request with lien release." },
      { ring: "programs", label: "CMS reviews", desc: "Budget check, approval workflow, inspection evidence." },
      { ring: "backoffice", label: "Procurement validates", desc: "Vendor compliance, PO matching, contract terms." },
      { ring: "backoffice", label: "AP pays", desc: "Approved draw becomes payment with audit trail." },
      { ring: "backoffice", label: "Grant reported", desc: "Draw coded to funding source. Funder report updated." },
      { ring: "center", label: "Project current", desc: "Budget, cash flow, and compliance all reflect the draw." }
    ]}
  },
  ringLabels: {
    backoffice: "AP \u00B7 Procurement \u00B7 Grants \u00B7 Fundraising \u00B7 Volunteers \u00B7 HR",
    programs: "HBE \u00B7 DPA \u00B7 Construction \u00B7 Property \u00B7 LMS",
    constituents: "Portals \u00B7 Website \u00B7 Email \u00B7 Copilot \u00B7 M365"
  }
};

// ── SVG CONSTANTS ─────────────────────────────────
var V = 1000, CX = V/2, CY = V/2, NR = 8, CR = 50;
var R = {};
D.rings.forEach(function(r) { R[r.key] = r; });
var ringsVis = D.rings.filter(function(r) { return r.key !== "quickbooks"; });
var qr = R.quickbooks;
var activeRing = null, timer = null, activeStep = -1, selectedTxn = "", playing = false;

// ── SVG HELPERS ───────────────────────────────────
function svgEl(tag, attrs) {
  var e = document.createElementNS("http://www.w3.org/2000/svg", tag);
  if (attrs) for (var k in attrs) e.setAttribute(k, attrs[k]);
  return e;
}
function svgT(tag, attrs, text) {
  var e = svgEl(tag, attrs);
  if (text) e.textContent = text;
  return e;
}
function hEl(tag, attrs, children) {
  var e = document.createElement(tag);
  if (attrs) for (var k in attrs) {
    if (k === "style" && typeof attrs[k] === "object") {
      for (var sk in attrs[k]) e.style[sk] = attrs[k][sk];
    } else if (k === "className") { e.className = attrs[k]; }
    else { e.setAttribute(k, attrs[k]); }
  }
  if (children) for (var i = 0; i < children.length; i++) {
    var c = children[i];
    if (typeof c === "string" || typeof c === "number") e.appendChild(document.createTextNode(String(c)));
    else if (c) e.appendChild(c);
  }
  return e;
}
function degRad(d) { return d * Math.PI / 180; }
function polar(r, a) {
  var rd = degRad(a - 90);
  return { x: CX + r * Math.cos(rd), y: CY + r * Math.sin(rd) };
}

// ── STATE ─────────────────────────────────────────
function setActive(key) {
  activeRing = key;
  // Update step info panel
  var infoDiv = document.querySelector(".mpp-os-step-info");
  if (infoDiv && D.txns[selectedTxn] && activeStep >= 0) {
    var s = D.txns[selectedTxn].steps[activeStep];
    infoDiv.style.display = "inline-block";
    infoDiv.innerHTML = "<h3 style=\"color:" + R[s.ring].color + "\">" + s.label + "</h3><p>" + s.desc + "</p>";
  } else if (infoDiv) {
    infoDiv.style.display = "none";
  }
  updateVis();
}
function updateVis() {
  // Ring bands
  var bands = document.querySelectorAll(".mpp-os-ring-band");
  for (var i = 0; i < bands.length; i++) {
    var b = bands[i], bk = b.getAttribute("data-ring");
    b.setAttribute("stroke-width", activeRing === bk ? "3" : "1.5");
    b.setAttribute("opacity", activeRing === bk ? "1" : "0.85");
  }
  // Nodes
  var ng = document.querySelectorAll(".mpp-os-node-g");
  for (var i = 0; i < ng.length; i++) {
    var g = ng[i], rk = g.getAttribute("data-ring");
    var cir = g.querySelector("circle"), txt = g.querySelector("text");
    if (cir) {
      cir.setAttribute("r", activeRing === rk ? String(NR + 3) : String(NR));
      cir.setAttribute("stroke-width", activeRing === rk ? "2.5" : "1.5");
      cir.setAttribute("opacity", activeRing === rk ? "1" : "0.9");
    }
    if (txt) txt.setAttribute("font-weight", activeRing === rk ? "700" : "500");
  }
  // Step glow
  var glow = document.getElementById("mpp-os-step-glow");
  if (glow && activeRing && R[activeRing] && R[activeRing].radius > 0) {
    glow.setAttribute("r", String(R[activeRing].radius));
    glow.setAttribute("stroke", R[activeRing].color);
    glow.setAttribute("opacity", "0.45");
    glow.style.display = "";
  } else if (glow) {
    glow.style.display = "none";
  }
  // Cards
  var cards = document.querySelectorAll(".mpp-os-card");
  for (var i = 0; i < cards.length; i++) {
    var cd = cards[i], ck = cd.getAttribute("data-ring");
    cd.style.borderLeftColor = R[ck] ? R[ck].color : "#E5E7EB";
    cd.style.borderLeftWidth = activeRing === ck ? "5px" : "4px";
    cd.style.background = activeRing === ck ? "#F0F4FA" : "#fff";
  }
}

function play() {
  if (!selectedTxn || !D.txns[selectedTxn]) return;
  stop();
  playing = true;
  activeStep = 0;
  var steps = D.txns[selectedTxn].steps;
  setActive(steps[0].ring);
  timer = setInterval(function() {
    activeStep++;
    if (activeStep >= steps.length) { stop(); return; }
    setActive(steps[activeStep].ring);
  }, 1300);
}
function stop() {
  playing = false;
  activeStep = -1;
  activeRing = null;
  if (timer) { clearInterval(timer); timer = null; }
  updateVis();
  var infoDiv = document.querySelector(".mpp-os-step-info");
  if (infoDiv) infoDiv.style.display = "none";
}

// ── BUILD SVG ─────────────────────────────────────
function buildSvg() {
  var svg = svgEl("svg", { viewBox: "0 0 " + V + " " + V, width: "100%", height: "100%", "aria-label": "Operating system concentric rings" });

  // Gradients + glow filter
  var defs = svgEl("defs", {});
  D.rings.forEach(function(r) {
    var g = svgEl("radialGradient", { id: "g-" + r.key, cx: "50%", cy: "50%" });
    g.appendChild(svgEl("stop", { offset: "0%", "stop-color": r.color, "stop-opacity": "0.06" }));
    g.appendChild(svgEl("stop", { offset: "100%", "stop-color": r.color, "stop-opacity": "0.16" }));
    defs.appendChild(g);
  });
  var f = svgEl("filter", { id: "glow" });
  f.appendChild(svgEl("feGaussianBlur", { stdDeviation: "4", result: "blur" }));
  var fm = svgEl("feMerge", {});
  fm.appendChild(svgEl("feMergeNode", { "in": "blur" }));
  fm.appendChild(svgEl("feMergeNode", { "in": "SourceGraphic" }));
  f.appendChild(fm);
  defs.appendChild(f);
  svg.appendChild(defs);

  // Ring bands (donut paths)
  ringsVis.filter(function(r) { return r.key !== "center"; }).forEach(function(ring, i) {
    var ir = i === 0 ? CR : ringsVis[i].radius, or = ring.radius;
    var p = svgEl("path", {
      "class": "mpp-os-ring-band", "data-ring": ring.key,
      d: "M " + CX + " " + (CY - ir) +
         " A " + ir + " " + ir + " 0 0 1 " + CX + " " + (CY + ir) +
         " A " + ir + " " + ir + " 0 0 1 " + CX + " " + (CY - ir) +
         " M " + CX + " " + (CY - or) +
         " A " + or + " " + or + " 0 0 0 " + CX + " " + (CY + or) +
         " A " + or + " " + or + " 0 0 0 " + CX + " " + (CY - or),
      fill: "url(#g-" + ring.key + ")", stroke: ring.color, "stroke-width": "1.5",
      "stroke-dasharray": ring.key === "constituents" ? "10,5" : "none", opacity: "0.85"
    });
    p.addEventListener("mouseenter", function() { if (!playing) { activeRing = ring.key; updateVis(); } });
    p.addEventListener("mouseleave", function() { if (!playing) { activeRing = null; updateVis(); } });
    svg.appendChild(p);
  });

  // QuickBooks outer ring
  if (qr) {
    svg.appendChild(svgEl("circle", { cx: CX, cy: CY, r: qr.radius, fill: "none", stroke: qr.color, "stroke-width": "1.5", "stroke-dasharray": "8,6", opacity: "0.65" }));
    svg.appendChild(svgT("text", { x: CX, y: CY - qr.radius - 10, "text-anchor": "middle", "font-size": "13", "font-weight": "600", fill: qr.color, "font-family": "inherit" }, qr.label));
    svg.appendChild(svgT("text", { x: CX, y: CY - qr.radius + 14, "text-anchor": "middle", "font-size": "11", fill: "#999", "font-family": "inherit", "font-style": "italic" }, "(We integrate, we don\u2019t replace)"));
  }

  // Ring labels
  ringsVis.forEach(function(ring, i) {
    if (ring.key === "center") return;
    var pr = i === 0 ? CR : ringsVis[i - 1].radius, lr = (pr + ring.radius) / 2, pp = polar(lr, 225);
    svg.appendChild(svgT("text", { x: pp.x, y: pp.y - 4, "text-anchor": "middle", "font-size": "14", "font-weight": "700", fill: ring.color, "font-family": "inherit", "letter-spacing": "0.3" }, ring.label));
    svg.appendChild(svgT("text", { x: pp.x, y: pp.y + 14, "text-anchor": "middle", "font-size": "10", fill: "#777", "font-family": "inherit" }, D.ringLabels[ring.key] || ""));
  });

  // Center
  var cg = svgEl("g", {});
  cg.appendChild(svgEl("circle", { cx: CX, cy: CY, r: CR, fill: "#002B5C", opacity: "0.12" }));
  cg.appendChild(svgEl("circle", { cx: CX, cy: CY, r: CR, fill: "none", stroke: "#002B5C", "stroke-width": "2" }));
  cg.appendChild(svgT("text", { x: CX, y: CY - 6, "text-anchor": "middle", "font-size": "15", "font-weight": "700", fill: "#002B5C", "font-family": "inherit" }, "One Record"));
  cg.appendChild(svgT("text", { x: CX, y: CY + 14, "text-anchor": "middle", "font-size": "11", fill: "#5E6F7D", "font-family": "inherit" }, "Shared Dataverse"));
  svg.appendChild(cg);

  // Nodes
  D.nodes.forEach(function(n) {
    var rv = R[n.ring].radius;
    if (rv === 0) return;
    var pos = polar(rv, n.angle);
    var g = svgEl("g", { "class": "mpp-os-node-g", "data-ring": n.ring });
    g.appendChild(svgEl("circle", { cx: pos.x, cy: pos.y, r: NR, fill: "#fff", stroke: R[n.ring].color, "stroke-width": "1.5", opacity: "0.9", "class": "mpp-os-node-circle" }));
    g.appendChild(svgT("text", { x: pos.x, y: pos.y + NR + 13, "text-anchor": "middle", "font-size": "10", "font-weight": "500", fill: "#555", "font-family": "inherit" }, n.label));
    svg.appendChild(g);
  });

  // Step glow indicator
  var glow = svgEl("circle", { id: "mpp-os-step-glow", cx: CX, cy: CY, r: "0", fill: "none", stroke: "#002B5C", "stroke-width": "3", opacity: "0", "class": "mpp-os-step-glow", style: "display:none" });
  svg.appendChild(glow);

  return svg;
}

// ── BUILD HTML SECTIONS ───────────────────────────
function buildHeader() {
  return hEl("div", { className: "mpp-os-header" }, [
    hEl("h1", {}, "How Max Power Platform runs the whole nonprofit"),
    hEl("p", {}, "Everything your housing nonprofit runs \u2014 from the back office to your constituents \u2014 on one platform. The one gap? Your general ledger. We don\u2019t replace QuickBooks. We integrate with it.")
  ]);
}

function buildControls() {
  var d = hEl("div", { className: "mpp-os-controls" }, [
    hEl("p", { style: { color: "#002B5C", fontWeight: "600", marginBottom: "10px", fontSize: "15px" } }, "See how one person\u2019s journey crosses every ring")
  ]);

  var row = hEl("div", { style: { display: "flex", flexWrap: "wrap", justifyContent: "center", gap: "10px" } });

  var sel = hEl("select", {}, [hEl("option", { value: "" }, "\u2014 Choose a story \u2014")]);
  Object.keys(D.txns).forEach(function(k) {
    sel.appendChild(hEl("option", { value: k }, D.txns[k].label));
  });

  var playBtn = hEl("button", { className: "mpp-os-btn mpp-os-btn-play", disabled: "true" }, "Play");
  var pauseBtn = hEl("button", { className: "mpp-os-btn mpp-os-btn-pause", disabled: "true" }, "Pause");
  var resetBtn = hEl("button", { className: "mpp-os-btn mpp-os-btn-reset" }, "Reset");

  sel.onchange = function() {
    selectedTxn = sel.value;
    stop();
    playBtn.disabled = !selectedTxn;
    pauseBtn.disabled = true;
  };
  playBtn.onclick = function() { if (selectedTxn) { play(); playBtn.disabled = true; pauseBtn.disabled = false; } };
  pauseBtn.onclick = function() { stop(); playBtn.disabled = !selectedTxn; pauseBtn.disabled = true; };
  resetBtn.onclick = function() {
    stop();
    selectedTxn = "";
    sel.value = "";
    playBtn.disabled = true;
    pauseBtn.disabled = true;
  };

  row.appendChild(sel);
  row.appendChild(playBtn);
  row.appendChild(pauseBtn);
  row.appendChild(resetBtn);
  d.appendChild(row);

  var infoDiv = hEl("div", { className: "mpp-os-step-info", style: { display: "none" } });
  d.appendChild(infoDiv);

  return d;
}

function buildCards() {
  var d = hEl("div", { className: "mpp-os-cards" });
  ringsVis.forEach(function(r) {
    d.appendChild(hEl("div", { className: "mpp-os-card", "data-ring": r.key, style: { borderLeftColor: r.color } }, [
      hEl("h3", { style: { color: r.color } }, r.label),
      hEl("p", {}, r.desc)
    ]));
  });
  return d;
}

function buildModules() {
  var d = hEl("div", { className: "mpp-os-modules" });
  var inner = hEl("div", { className: "mpp-os-modules-inner" }, [
    hEl("h2", {}, "Every module, one platform"),
    hEl("p", {}, "Each module connects through Shared Dataverse. No silos. No duplicate data entry.")
  ]);

  ["backoffice", "programs", "constituents"].forEach(function(key) {
    var mods = D.modules.filter(function(m) { return m.ring === key; });
    if (!mods.length) return;
    var group = hEl("div", { className: "mpp-os-module-group" }, [
      hEl("h3", { style: { color: R[key].color } }, R[key].label)
    ]);
    var grid = hEl("div", { className: "mpp-os-module-grid" });
    mods.forEach(function(m) {
      grid.appendChild(hEl("a", { className: "mpp-os-module-tile", href: "/" + m.slug + "/" }, [
        hEl("div", { className: "icon" }, m.icon),
        hEl("h4", {}, m.name),
        hEl("p", {}, m.summary)
      ]));
    });
    group.appendChild(grid);
    inner.appendChild(group);
  });

  // QuickBooks note
  inner.appendChild(hEl("div", { className: "mpp-os-qb-note" }, [
    hEl("strong", {}, "\uD83D\uDCCA Your ERP (QuickBooks)"),
    hEl("p", {}, "We don\u2019t replace your general ledger. Our AP and procurement modules feed QuickBooks \u2014 one integration, no double entry.")
  ]));

  d.appendChild(inner);
  return d;
}

function buildBacklink() {
  return hEl("div", { className: "mpp-os-backlink" }, [
    hEl("a", { href: "/" }, "\u2190 Back to Max Power Platform")
  ]);
}

// ── RENDER ────────────────────────────────────────
window.MPPOperatingSystem = {
  render: function(mountId) {
    var root = document.getElementById(mountId);
    if (!root) return;
    root.innerHTML = "";

    root.appendChild(buildHeader());

    var svgWrap = hEl("div", { className: "mpp-os-svg-wrap" });
    svgWrap.appendChild(buildSvg());
    root.appendChild(svgWrap);

    root.appendChild(buildControls());
    root.appendChild(buildCards());
    root.appendChild(buildModules());
    root.appendChild(buildBacklink());
  }
};

// Auto-mount if root exists
var auto = document.getElementById("mpp-os-root");
if (auto) window.MPPOperatingSystem.render("mpp-os-root");

})();
