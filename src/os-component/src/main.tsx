import { createRoot } from 'react-dom/client';
import OperatingSystem from './OperatingSystem';
import './index.css';

function render(mountId: string) {
  const el = document.getElementById(mountId);
  if (!el) {
    console.error(`MPPOperatingSystem: mount point #${mountId} not found`);
    return;
  }
  const root = createRoot(el);
  root.render(<OperatingSystem />);
}

(window as any).MPPOperatingSystem = { render };

if (typeof document !== 'undefined') {
  const autoMount = document.getElementById('mpp-os-root');
  if (autoMount) render('mpp-os-root');
}
