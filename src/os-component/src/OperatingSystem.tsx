import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Dropdown,
  PrimaryButton,
  DefaultButton,
  Text,
  Stack,
  Label,
  type IStackTokens,
  type IDropdownOption,
} from '@fluentui/react';
import { nodes, rings, transactions } from './data';

const VIEWBOX = 840;
const CX = VIEWBOX / 2;
const CY = VIEWBOX / 2;
const NODE_RADIUS = 10;
const CENTER_RADIUS = 46;

function degToRad(deg: number) {
  return (deg * Math.PI) / 180;
}

function polarToCartesian(radius: number, angleDeg: number) {
  return {
    x: CX + radius * Math.cos(degToRad(angleDeg)),
    y: CY + radius * Math.sin(degToRad(angleDeg)),
  };
}

const transactionOptions: IDropdownOption[] = [
  { key: '', text: '— Select a transaction to trace —' },
  ...Object.keys(transactions).map((key) => ({
    key,
    text: transactions[key].label,
  })),
];

const stackTokens: IStackTokens = { childrenGap: 16 };

export default function OperatingSystem() {
  const [hoveredRing, setHoveredRing] = useState<string | null>(null);
  const [activeRing, setActiveRing] = useState<string | null>(null);
  const [selectedTransaction, setSelectedTransaction] = useState<string>('');
  const [txnStep, setTxnStep] = useState<number>(-1);
  const [isPlaying, setIsPlaying] = useState(false);
  const [time, setTime] = useState(0);
  const rafRef = useRef<number | null>(null);
  const txnTimerRef = useRef<number | null>(null);

  // Continuous planetary motion
  useEffect(() => {
    let last = performance.now();
    const tick = (now: number) => {
      const dt = (now - last) / 1000;
      last = now;
      setTime((t) => t + dt);
      rafRef.current = requestAnimationFrame(tick);
    };
    rafRef.current = requestAnimationFrame(tick);
    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
    };
  }, []);

  // Transaction playback
  useEffect(() => {
    if (isPlaying && selectedTransaction) {
      setTxnStep(0);
      txnTimerRef.current = window.setInterval(() => {
        setTxnStep((s) => {
          const steps = transactions[selectedTransaction].steps;
          if (s >= steps.length - 1) {
            setIsPlaying(false);
            return s;
          }
          return s + 1;
        });
      }, 1600);
    } else {
      setTxnStep(-1);
    }
    return () => {
      if (txnTimerRef.current) clearInterval(txnTimerRef.current);
    };
  }, [isPlaying, selectedTransaction]);

  const handlePlay = () => {
    if (!selectedTransaction) return;
    setIsPlaying(true);
  };

  const handlePause = () => {
    setIsPlaying(false);
    setTxnStep(-1);
  };

  const info = useMemo(() => {
    if (txnStep >= 0 && selectedTransaction) {
      const step = transactions[selectedTransaction].steps[txnStep];
      const ring = rings.find((r) => r.key === step.ring);
      return {
        title: step.label,
        subtitle: ring?.label ?? '',
        body: step.desc,
        color: ring?.color ?? '#002B5C',
      };
    }
    const key = activeRing || hoveredRing;
    if (!key) {
      return {
        title: 'How Max Power Platform runs the whole nonprofit',
        subtitle: 'Exhibit 1 — Operating system model',
        body:
          'Hover any ring or node to see what it does. Select a transaction and press Play to trace how a single constituent action flows through public-facing work, mission operations, and the back-office engine — all anchored to the shared Dataverse core.',
        color: '#002B5C',
      };
    }
    const ring = rings.find((r) => r.key === key);
    return {
      title: ring?.label ?? '',
      subtitle: ring?.shortLabel ?? '',
      body: ring?.desc ?? '',
      color: ring?.color ?? '#002B5C',
    };
  }, [txnStep, selectedTransaction, activeRing, hoveredRing]);

  const nodePositions = useMemo(() => {
    return nodes.map((n) => {
      const ring = rings.find((r) => r.key === n.ring)!;
      const speed = ring.orbitDuration ? 360 / ring.orbitDuration : 0;
      const angle = n.angle + time * speed;
      const pos = polarToCartesian(ring.radius, angle);
      return {
        key: n.ring,
        label: n.label,
        ring,
        angle,
        x: pos.x,
        y: pos.y,
      };
    });
  }, [time]);

  const isHighlighted = (key: string) => {
    if (txnStep >= 0 && selectedTransaction) {
      return transactions[selectedTransaction].steps[txnStep].ring === key;
    }
    return hoveredRing === key || activeRing === key;
  };

  const pulseRing = useMemo(() => {
    if (txnStep < 0 || !selectedTransaction) return null;
    const step = transactions[selectedTransaction].steps[txnStep];
    const ring = rings.find((r) => r.key === step.ring);
    if (!ring || ring.radius === 0) return null;
    return (
      <circle
        cx={CX}
        cy={CY}
        r={ring.radius}
        fill="none"
        stroke={ring.color}
        strokeWidth={6}
        opacity={0.35}
        className="mpp-os-pulse"
      />
    );
  }, [txnStep, selectedTransaction]);

  return (
    <div className="mpp-os">
      <Stack horizontal wrap tokens={stackTokens} className="mpp-os-layout">
        <Stack.Item grow={2} className="mpp-os-diagram">
          <svg
            viewBox={`0 0 ${VIEWBOX} ${VIEWBOX}`}
            role="img"
            aria-label="Planetary operating system diagram"
            className="mpp-os-svg"
          >
            <defs>
              <radialGradient id="coreGradient" cx="50%" cy="50%" r="50%">
                <stop offset="0%" stopColor="#003D7A" />
                <stop offset="100%" stopColor="#002B5C" />
              </radialGradient>
              <filter id="softShadow" x="-50%" y="-50%" width="200%" height="200%">
                <feDropShadow dx="0" dy="1" stdDeviation="2" floodColor="#000000" floodOpacity="0.15" />
              </filter>
            </defs>

            {/* Background rings */}
            {rings
              .filter((r) => r.radius > 0)
              .map((r) => (
                <g key={r.key}>
                  <circle
                    cx={CX}
                    cy={CY}
                    r={r.radius}
                    fill="none"
                    stroke={isHighlighted(r.key) ? r.color : '#D9D9D9'}
                    strokeWidth={isHighlighted(r.key) ? 3 : 1.5}
                    strokeDasharray={isHighlighted(r.key) ? undefined : '4 6'}
                    opacity={isHighlighted(r.key) ? 1 : 0.8}
                  />
                  {/* Ring label positioned at top */}
                  <text
                    x={CX}
                    y={CY - r.radius - 12}
                    textAnchor="middle"
                    fill={r.color}
                    fontSize={13}
                    fontWeight={600}
                    fontFamily="'Segoe UI', Arial, sans-serif"
                  >
                    {r.label}
                  </text>
                </g>
              ))}

            {/* Transaction pulse ring */}
            {pulseRing}

            {/* Core */}
            <g
              onMouseEnter={() => setHoveredRing('center')}
              onMouseLeave={() => setHoveredRing(null)}
              onClick={() => setActiveRing('center')}
              className="mpp-os-core"
              role="button"
              tabIndex={0}
              aria-label="Shared Dataverse core"
            >
              <circle
                cx={CX}
                cy={CY}
                r={CENTER_RADIUS}
                fill="url(#coreGradient)"
                filter="url(#softShadow)"
              />
              <text
                x={CX}
                y={CY - 6}
                textAnchor="middle"
                fill="#ffffff"
                fontSize={11}
                fontWeight={600}
                fontFamily="'Segoe UI', Arial, sans-serif"
              >
                Shared
              </text>
              <text
                x={CX}
                y={CY + 10}
                textAnchor="middle"
                fill="#ffffff"
                fontSize={11}
                fontWeight={600}
                fontFamily="'Segoe UI', Arial, sans-serif"
              >
                Dataverse
              </text>
            </g>

            {/* Nodes */}
            {nodePositions.map((n, idx) => {
              const highlighted = isHighlighted(n.key);
              return (
                <g
                  key={idx}
                  transform={`translate(${n.x}, ${n.y})`}
                  onMouseEnter={() => setHoveredRing(n.key)}
                  onMouseLeave={() => setHoveredRing(null)}
                  onClick={() => setActiveRing(n.key)}
                  className="mpp-os-node"
                  role="button"
                  tabIndex={0}
                  aria-label={`${n.label}, ${n.ring.label}`}
                >
                  <circle
                    r={NODE_RADIUS}
                    fill="#ffffff"
                    stroke={n.ring.color}
                    strokeWidth={highlighted ? 4 : 2}
                    filter="url(#softShadow)"
                    className={highlighted ? 'mpp-os-node-active' : ''}
                  />
                  {/* Label line */}
                  <line
                    x1={0}
                    y1={0}
                    x2={n.x > CX ? 22 : -22}
                    y2={0}
                    stroke={n.ring.color}
                    strokeWidth={1}
                    opacity={0.5}
                  />
                  <text
                    x={n.x > CX ? 28 : -28}
                    y={4}
                    textAnchor={n.x > CX ? 'start' : 'end'}
                    fill={highlighted ? '#1a1a1a' : '#4a4a4a'}
                    fontSize={12}
                    fontWeight={highlighted ? 600 : 400}
                    fontFamily="'Segoe UI', Arial, sans-serif"
                  >
                    {n.label}
                  </text>
                </g>
              );
            })}
          </svg>
        </Stack.Item>

        <Stack.Item grow={1} className="mpp-os-panel">
          <div className="mpp-os-info" style={{ borderLeftColor: info.color }}>
            <Text
              variant="large"
              className="mpp-os-info-title"
              style={{ color: info.color }}
            >
              {info.title}
            </Text>
            <Text variant="small" className="mpp-os-info-subtitle">
              {info.subtitle}
            </Text>
            <Text variant="medium" className="mpp-os-info-body">
              {info.body}
            </Text>
          </div>

          <Label>Trace a transaction</Label>
          <Dropdown
            selectedKey={selectedTransaction}
            options={transactionOptions}
            onChange={(_, option) => {
              setSelectedTransaction(option?.key as string);
              setIsPlaying(false);
              setTxnStep(-1);
            }}
            className="mpp-os-dropdown"
          />

          <Stack horizontal tokens={{ childrenGap: 10 }} className="mpp-os-controls">
            <PrimaryButton text="Play" onClick={handlePlay} disabled={!selectedTransaction || isPlaying} />
            <DefaultButton text="Pause" onClick={handlePause} disabled={!isPlaying} />
          </Stack>

          <div className="mpp-os-legend">
            {rings.map((r) => (
              <div
                key={r.key}
                className={`mpp-os-legend-item ${isHighlighted(r.key) ? 'active' : ''}`}
                onMouseEnter={() => setHoveredRing(r.key)}
                onMouseLeave={() => setHoveredRing(null)}
                onClick={() => setActiveRing(r.key)}
              >
                <span className="mpp-os-legend-dot" style={{ backgroundColor: r.color }} />
                <span className="mpp-os-legend-label">{r.label}</span>
              </div>
            ))}
          </div>
        </Stack.Item>
      </Stack>
    </div>
  );
}
