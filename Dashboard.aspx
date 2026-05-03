<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>APB Broadband | Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --bg: #f0f2f5; --side: #1a2a3a; --blue: #00d4ff; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: var(--bg); display: flex; height: 100vh; }

        /* Sidebar */
        .sidebar { width: 260px; background: var(--side); color: white; padding: 20px; }
        .profile { text-align: center; padding: 20px 0; border-bottom: 1px solid #34495e; }
        .profile i { font-size: 50px; color: var(--blue); }
        .menu-item { display: block; padding: 15px; color: #bdc3c7; text-decoration: none; border-radius: 8px; margin-top: 5px; }
        .menu-item:hover, .active { background: #2c3e50; color: var(--blue); }
        .menu-item i { margin-right: 10px; width: 20px; }

        /* Content */
        .main { flex: 1; padding: 30px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; margin-bottom: 30px; }
        
        .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .card.dark { background: var(--side); color: white; }

        .grid-layout { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        .panel { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .panel-h { font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; }

        .links { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .link-btn { padding: 10px; border: 1px solid #ddd; text-align: center; text-decoration: none; color: #333; border-radius: 5px; font-size: 0.9em; }
        .link-btn:hover { background: var(--bg); border-color: var(--blue); }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <i class="fas fa-user-circle"></i>
            <h3>SUPER ADMIN</h3>
            <p>APB Broadband</p>
        </div>
        <nav style="margin-top:20px;">
            <a href="#" class="menu-item active"><i class="fas fa-home"></i> Dashboard</a>
            <a href="#" class="menu-item"><i class="fas fa-users-cog"></i> Operator Mgmt</a>
            <a href="#" class="menu-item"><i class="fas fa-user-friends"></i> Customer Mgmt</a>
            <a href="#" class="menu-item"><i class="fas fa-box"></i> Packages</a>
            <a href="#" class="menu-item"><i class="fas fa-file-invoice"></i> Billing</a>
            <a href="#" class="menu-item"><i class="fas fa-book"></i> Ledger</a>
            <a href="index.html" class="menu-item" style="margin-top:30px; color:#e74c3c;"><i class="fas fa-power-off"></i> Logout</a>
        </nav>
    </div>

    <div class="main">
        <div class="header">
            <h1>Dashboard User</h1>
            <i class="fas fa-bars" style="font-size: 20px; color: #666;"></i>
        </div>

        <div class="stats">
            <div class="card dark">
                <p>Earning</p>
                <h2 style="margin-top:10px;">₹ 45,628</h2>
            </div>
            <div class="card">
                <p>Share</p>
                <h2 style="margin-top:10px;">2434</h2>
            </div>
            <div class="card">
                <p>Active Users</p>
                <h2 style="margin-top:10px;">1259</h2>
            </div>
            <div class="card">
                <p>Rating</p>
                <h2 style="margin-top:10px;">4.8 / 5</h2>
            </div>
        </div>

        <div class="grid-layout">
            <div class="panel">
                <div class="panel-h">Customer Details & Master Packages</div>
                <div style="height:200px; background: #fafafa; border-radius: 8px; display:flex; align-items:center; justify-content:center; color:#999;">
                    [ Connectivity Trend Chart ]
                </div>
            </div>
            <div class="panel">
                <div class="panel-h">Quick Links</div>
                <div class="links">
                    <a href="#" class="link-btn">New Customer</a>
                    <a href="#" class="link-btn">Billing</a>
                    <a href="#" class="link-btn">Packages</a>
                    <a href="#" class="link-btn">Network</a>
                </div>
                <div class="panel-h" style="margin-top:20px;">Alerts</div>
                <div style="font-size:0.85em; color:#555;">
                    <p style="padding:5px; border-left:3px solid #f1c40f; background:#fff9e6; margin-bottom:5px;">- 5 Packages expiring today</p>
                    <p style="padding:5px; border-left:3px solid #e74c3c; background:#fdf2f2;">- Node 04 High Latency</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>