{ sumiFont }:
/* Tokyo Night Storm */
''
  * {
    font-family: "${sumiFont.name}";
    font-size: ${toString sumiFont.size}px;
    margin: 0;
    padding: 0;
    border: none;
    border-radius: 0;
  }

  window#waybar {
    background: #1f2335;
    color: #c0caf5;
    border-bottom: 1px solid #3b4261;
  }

  /* ── workspaces ───────────────────────────────────────────── */
  #workspaces button {
    padding: 0 8px;
    color: #3b4261;
  }

  #workspaces button.focused {
    color: #c0caf5;
    border-bottom: 2px solid #7aa2f7;
  }

  #workspaces button.visible {
    color: #565f89;
  }

  #workspaces button.urgent {
    color: #f7768e;
  }

  /* ── modules ──────────────────────────────────────────────── */
  #clock,
  #pulseaudio,
  #battery {
    padding: 0 12px;
    color: #a9b1d6;
  }

  #clock {
    color: #c0caf5;
  }

  #battery.warning {
    color: #e0af68;
  }

  #battery.critical {
    color: #f7768e;
  }
''
