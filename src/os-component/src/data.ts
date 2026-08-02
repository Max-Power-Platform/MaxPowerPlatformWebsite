export interface Ring {
  key: 'center' | 'inner' | 'middle' | 'outer';
  label: string;
  shortLabel: string;
  color: string;
  desc: string;
  radius: number;
  orbitDuration: number; // seconds for one full revolution
}

export interface Node {
  ring: Ring['key'];
  label: string;
  angle: number; // base angle in degrees, 0 = right (3 o'clock)
}

export interface TransactionStep {
  ring: Ring['key'];
  label: string;
  desc: string;
}

export const rings: Ring[] = [
  {
    key: 'center',
    label: 'Shared Dataverse',
    shortLabel: 'Core',
    color: '#002B5C',
    desc: 'One mission, one record. Every contact, property, program, funding source, and outcome lives in a single shared Dataverse.',
    radius: 0,
    orbitDuration: 0,
  },
  {
    key: 'inner',
    label: 'Back-office engine',
    shortLabel: 'Engine',
    color: '#5B7C99',
    desc: 'Finance, payroll, HR, compliance, grants, legal, IT, governance, and audit — the engine that makes the mission accountable and sustainable.',
    radius: 140,
    orbitDuration: 120,
  },
  {
    key: 'middle',
    label: 'Mission operations',
    shortLabel: 'Mission',
    color: '#B85C38',
    desc: 'The programs and workflows that deliver the mission: intake, education, counseling, lending, construction, property management, fundraising, and grants.',
    radius: 260,
    orbitDuration: 180,
  },
  {
    key: 'outer',
    label: 'Public-facing work',
    shortLabel: 'Public',
    color: '#8C8C8C',
    desc: 'What the world sees and touches: website, Power Pages portals, classes, closings, donations, rent payments, bids, and reports.',
    radius: 380,
    orbitDuration: 240,
  },
];

export const nodes: Node[] = [
  // Center
  { ring: 'center', label: 'Shared Dataverse', angle: 0 },
  // Inner ring — 8 nodes
  { ring: 'inner', label: 'Finance', angle: 0 },
  { ring: 'inner', label: 'Payroll', angle: 45 },
  { ring: 'inner', label: 'HR', angle: 90 },
  { ring: 'inner', label: 'Compliance', angle: 135 },
  { ring: 'inner', label: 'Grants', angle: 180 },
  { ring: 'inner', label: 'Legal', angle: 225 },
  { ring: 'inner', label: 'IT/Security', angle: 270 },
  { ring: 'inner', label: 'Governance', angle: 315 },
  // Middle ring — 12 nodes
  { ring: 'middle', label: 'Outreach', angle: 0 },
  { ring: 'middle', label: 'Education', angle: 30 },
  { ring: 'middle', label: 'DPA', angle: 60 },
  { ring: 'middle', label: 'Construction', angle: 90 },
  { ring: 'middle', label: 'Property', angle: 120 },
  { ring: 'middle', label: 'Fundraising', angle: 150 },
  { ring: 'middle', label: 'Volunteers', angle: 180 },
  { ring: 'middle', label: 'Procurement', angle: 210 },
  { ring: 'middle', label: 'AP', angle: 240 },
  { ring: 'middle', label: 'LMS', angle: 270 },
  { ring: 'middle', label: 'HR', angle: 300 },
  { ring: 'middle', label: 'Plans', angle: 330 },
  // Outer ring — 12 nodes
  { ring: 'outer', label: 'Website', angle: 0 },
  { ring: 'outer', label: 'Portal', angle: 30 },
  { ring: 'outer', label: 'Classes', angle: 60 },
  { ring: 'outer', label: 'Closings', angle: 90 },
  { ring: 'outer', label: 'Donations', angle: 120 },
  { ring: 'outer', label: 'Rent', angle: 150 },
  { ring: 'outer', label: 'Bids', angle: 180 },
  { ring: 'outer', label: 'Reports', angle: 210 },
  { ring: 'outer', label: 'Events', angle: 240 },
  { ring: 'outer', label: 'Email', angle: 270 },
  { ring: 'outer', label: 'Support', angle: 300 },
  { ring: 'outer', label: 'Mobile', angle: 330 },
];

export const transactions: Record<string, { label: string; steps: TransactionStep[] }> = {
  hbe: {
    label: 'Homebuyer class → DPA',
    steps: [
      { ring: 'outer', label: 'Signs up for class', desc: 'Prospective homebuyer registers on the portal.' },
      { ring: 'middle', label: 'HBE schedules', desc: 'Class roster, reminders, and attendance tracking.' },
      { ring: 'middle', label: 'Issues certificate', desc: 'Certificate generated automatically and emailed.' },
      { ring: 'inner', label: '9902 report line', desc: 'HUD 9902 attendance report is updated.' },
      { ring: 'center', label: 'Contact record updated', desc: 'Certificate and eligibility now live on the same contact record.' },
      { ring: 'outer', label: 'Prompted to apply', desc: 'Portal suggests the next step: Down Payment Assistance.' },
    ],
  },
  dpa: {
    label: 'Assistance application → closing',
    steps: [
      { ring: 'outer', label: 'Submits application', desc: 'Household applies online and uploads documents.' },
      { ring: 'middle', label: 'DPA verifies income', desc: 'Income verification, AMI calculation, and underwriting workflow.' },
      { ring: 'inner', label: 'Compliance check', desc: 'Eligibility, funding-source rules, and audit trail.' },
      { ring: 'middle', label: 'Closing & lien', desc: 'Award, closing, and lien recording.' },
      { ring: 'inner', label: 'Disbursement & AP', desc: 'Funds wired and recorded in Accounts Payable.' },
      { ring: 'center', label: 'Property + loan linked', desc: 'Property and loan records are tied to the contact for servicing.' },
    ],
  },
  rent: {
    label: 'Tenant rent → maintenance',
    steps: [
      { ring: 'outer', label: 'Tenant pays rent', desc: 'Tenant pays through the self-service portal.' },
      { ring: 'middle', label: 'Property posts payment', desc: 'Rent roll, late notices, and ledger updated.' },
      { ring: 'inner', label: 'AR + bank deposit', desc: 'Accounts receivable and cash flow updated.' },
      { ring: 'middle', label: 'Maintenance request', desc: 'Work order created, vendor dispatched, parts ordered.' },
      { ring: 'inner', label: 'Vendor invoice paid', desc: 'Invoice matched to work order, approved, and paid.' },
      { ring: 'center', label: 'Tenant + unit updated', desc: 'Tenant ledger and unit financials are current.' },
    ],
  },
  donate: {
    label: 'Donation → board report',
    steps: [
      { ring: 'outer', label: 'Donor gives online', desc: 'One-time or recurring gift on the website.' },
      { ring: 'middle', label: 'Fundraising records gift', desc: 'Gift recorded, receipt issued, acknowledgment queued.' },
      { ring: 'inner', label: 'GL + tax receipt', desc: 'General ledger entry and tax receipt generated.' },
      { ring: 'middle', label: 'Engagement journey', desc: 'Newsletter segmentation, stewardship, and next ask.' },
      { ring: 'inner', label: 'Board report', desc: 'Giving dashboards and campaign P&L updated.' },
      { ring: 'center', label: 'Donor record updated', desc: 'Gift history and engagement score in one place.' },
    ],
  },
  draw: {
    label: 'Construction draw → payment',
    steps: [
      { ring: 'outer', label: 'Contractor submits draw', desc: 'Draw request, lien release, and inspection evidence.' },
      { ring: 'middle', label: 'CMS reviews draw', desc: 'Budget check, approval workflow, and status update.' },
      { ring: 'middle', label: 'Procurement validates', desc: 'Vendor compliance, PO matching, and contract terms.' },
      { ring: 'inner', label: 'AP + payment', desc: 'Approved draw becomes a payment with full audit trail.' },
      { ring: 'inner', label: 'Grant reporting', desc: 'Draw coded to funding source and reported to funder.' },
      { ring: 'center', label: 'Project record updated', desc: 'Budget, cash flow, and compliance all reflect the draw.' },
    ],
  },
};
