<%@ Page Language="C#" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        // You could add session checks here to ensure the user is logged in
    }
</script>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | APB Broadband</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #f0f2f5;
            --sidebar-color: #1a2a3a;
            --accent-blue: #00d4ff;
            --card-white: #ffffff;
            --text-dark: #333;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: var(--bg-color); display: flex; height: 100vh; }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: var(--sidebar-color);
            color: white;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }
        .user-profile { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #34495e; }
        .user-profile i { font-size: 50px; color: var(--accent-blue); margin-bottom: 10px; }
        .user-profile h3 { font-size: 1.1em; letter-spacing: 1px; }
        .user-profile p { font-size: 0.8em; opacity: 0.6; }

        .menu-item {
            padding: 15px;
            color: #bdc3c7;
            text-decoration: none;
            display: flex;
            align-items: center;
            border-radius: 8px;
            margin-bottom: 5px;
            transition: 0.3s;
        }
        .menu-item:hover, .active { background-color: #2c3e50; color: var(--accent-blue); }
        .menu-item i { width: 30px; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        
        /* Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card {
            background: var(--card-white);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .stat-card.dark { background-color: var(--sidebar-color); color: white; }
        .stat-info h2 { font-size: 1.8em; }
        .stat-info p { font-size: 0.9em; opacity: 0.8; }
        .stat-icon { font-size: 1.5em; color: var(--accent-blue); }

        /* Bottom Grid */
        .bottom-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        .large-card {
            background: var(--card-white);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            min-height: 300px;
        }
        .card-title { margin-bottom: 20px; color: var(--text-dark); border-bottom: 1px solid #eee; padding-bottom: 10px; }
        
        .quick-links { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .ql-btn { 
            padding: 10px; border: 1px solid #ddd; border-radius: 5px; 
            text-align: center; text-decoration: none; color: var(--text-dark); font-size: 0.9em;
        }
        .ql-btn:hover { background: var(--bg-color); }
    </style>
</head>
<body>

    <!-- Left Menu Sidebar -->
    <div class="sidebar">
        <div class="user-profile">
            <i class="fas fa-user-circle"></i>
            <h3>SUPER ADMIN</h3>
            <p>APB Broadband Admin</p>
        </div>
        <nav>
            <a href="#" class="menu-item active"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="#" class="menu-item"><i class="fas fa-users-cog"></i> Operator Management</a>
            <a href="#" class="menu-item"><i class="fas fa-user-friends"></i> Customer Management</a>
            <a href="#" class="menu-item"><i class="fas fa-box-open"></i> Packages</a>
            <a href="#" class="menu-item"><i class="fas fa-file-invoice-dollar"></i> Billing</a>
            <a href="#" class="menu-item"><i class="fas fa-book"></i> Ledger</a>
            <a href="index.html" class="menu-item" style="margin-top: 50px; color: #e74c3c;"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </nav>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="header">
            <h1>Dashboard Overview</h1>
            <div class="search"><input type="text" placeholder="Search..." style="padding: 8px; border-radius: 5px; border: 1px solid #ccc;"></div>
        </div>

        <!-- Top Row Stats -->
        <div class="stats-grid">
            <div class="stat-card dark">
                <div class="stat-info">
                    <p>Monthly Revenue</p>
                    <h2>₹ 45,628</h2>
                </div>
                <i class="fas fa-wallet stat-icon"></i>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <p>Total Customers</p>
                    <h2>1,259</h2>
                </div>
                <i class="fas fa-users stat-icon"></i>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <p>Active Nodes</p>
                    <h2>84</h2>
                </div>
                <i class="fas fa-network-wired stat-icon"></i>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <p>Network Rating</p>
                    <h2>4.8 / 5</h2>
                </div>
                <i class="fas fa-star stat-icon" style="color: #f1c40f;"></i>
            </div>
        </div>

        <!-- Middle & Bottom Section -->
        <div class="bottom-grid">
            <!-- Left Side: Data Analysis -->
            <div class="large-card">
                <h3 class="card-title">Customer Connectivity Status</h3>
                <div style="height: 200px; display: flex; align-items: flex-end; justify-content: space-around; padding: 20px;">
                    <!-- Placeholder for Chart visuals -->
                    <div style="width: 40px; height: 60%; background: #3498db; border-radius: 5px 5px 0 0;"></div>
                    <div style="width: 40px; height: 80%; background: #2ecc71; border-radius: 5px 5px 0 0;"></div>
                    <div style="width: 40px; height: 40%; background: #3498db; border-radius: 5px 5px 0 0;"></div>
                    <div style="width: 40px; height: 90%; background: #2ecc71; border-radius: 5px 5px 0 0;"></div>
                    <div style="width: 40px; height: 70%; background: #3498db; border-radius: 5px 5px 0 0;"></div>
                </div>
                <p style="font-size: 0.9em; color: #7f8c8d; text-align: center;">Daily Active Users Trend</p>
            </div>

            <!-- Right Side: Quick Links & Tools -->
            <div class="large-card">
                <h3 class="card-title">Quick Actions</h3>
                <div class="quick-links">
                    <a href="#" class="ql-btn"><i class="fas fa-plus"></i> Add User</a>
                    <a href="#" class="ql-btn"><i class="fas fa-search"></i> Find Bill</a>
                    <a href="#" class="ql-btn"><i class="fas fa-cog"></i> Master Pkg</a>
                    <a href="#" class="ql-btn"><i class="fas fa-exclamation-triangle"></i> Alerts</a>
                </div>
                
                <h3 class="card-title" style="margin-top: 30px;">System Notifications</h3>
                <div style="font-size: 0.85em;">
                    <p style="padding: 5px; border-left: 3px solid #e67e22; margin-bottom: 10px; background: #fff5e6;">- Backup completed successfully.</p>
                    <p style="padding: 5px; border-left: 3px solid #e74c3c; background: #fee;">- Node 14 reported high latency.</p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>