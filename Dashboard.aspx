<%@ Page Language="C#" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>APB Broadband | Management Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #f4f7f6;
            --sidebar-blue: #0e1a35;
            --active-blue: #00d4ff;
            --card-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: var(--bg-color); display: flex; height: 100vh; overflow: hidden; }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background-color: var(--sidebar-blue);
            color: white;
            display: flex;
            flex-direction: column;
            padding: 30px 20px;
        }
        .profile-section { text-align: center; margin-bottom: 40px; }
        .profile-section i { font-size: 60px; color: var(--active-blue); margin-bottom: 10px; }
        
        .nav-menu { flex-grow: 1; }
        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #a0acb9;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: 0.3s;
        }
        .nav-link i { margin-right: 15px; width: 20px; text-align: center; }
        .nav-link:hover, .nav-link.active { background: rgba(255,255,255,0.1); color: var(--active-blue); }

        /* Main Dashboard Content */
        .content { flex: 1; padding: 30px; overflow-y: auto; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        
        /* Stats Cards */
        .card-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card {
            background: white; padding: 25px; border-radius: 15px;
            box-shadow: var(--card-shadow); display: flex; justify-content: space-between;
        }
        .stat-card.dark { background: var(--sidebar-blue); color: white; }
        .stat-card h2 { font-size: 1.8em; margin: 5px 0; }
        .stat-card p { font-size: 0.85em; opacity: 0.7; }

        /* Main Grid Area */
        .dashboard-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 25px; }
        .panel { background: white; border-radius: 15px; padding: 25px; box-shadow: var(--card-shadow); }
        .panel-header { font-weight: bold; font-size: 1.1em; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; display: flex; justify-content: space-between; }

        /* Feature Lists */
        .quick-links { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .ql-item { 
            padding: 15px; border: 1px solid #edf2f7; border-radius: 10px; 
            text-align: center; text-decoration: none; color: #4a5568; font-size: 0.9em;
        }
        .ql-item:hover { background: #f8fafc; border-color: var(--active-blue); }
        
        .alert-item { padding: 10px; border-radius: 8px; margin-bottom: 10px; font-size: 0.85em; }
        .alert-warning { background: #fffaf0; border-left: 4px solid #ed8936; }
        .alert-danger { background: #fff5f5; border-left: 4px solid #f56565; }
    </style>
</head>
<body>

    <!-- Left Sidebar Menu -->
    <div class="sidebar">
        <div class="profile-section">
            <i class="fas fa-user-circle"></i>
            <h3>SUPER ADMIN</h3>
            <p>APB Broadband Studio</p>
        </div>
        <nav class="nav-menu">
            <a href="#" class="nav-link active"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="#" class="nav-link"><i class="fas fa-user-shield"></i> Operator Mgmt</a>
            <a href="#" class="nav-link"><i class="fas fa-users"></i> Customer Mgmt</a>
            <a href="#" class="nav-link"><i class="fas fa-cubes"></i> Packages</a>
            <a href="#" class="nav-link"><i class="fas fa-receipt"></i> Billing</a>
            <a href="#" class="nav-link"><i class="fas fa-book-open"></i> Ledger</a>
        </nav>
        <a href="index.html" class="nav-link" style="color: #ff5e5e;"><i class="fas fa-power-off"></i> Logout</a>
    </div>

    <!-- Right Side Content -->
    <div class="content">
        <div class="top-bar">
            <h1>Dashboard User</h1>
            <div style="color: #718096;"><i class="fas fa-bars"></i></div>
        </div>

        <!-- Horizontal Stats Cards -->
        <div class="card-row">
            <div class="stat-card dark">
                <div><p>Earning</p><h2>₹ 45,628</h2></div>
                <i class="fas fa-indian-rupee-sign" style="color: var(--active-blue);"></i>
            </div>
            <div class="stat-card">
                <div><p>Share</p><h2>2434</h2></div>
                <i class="fas fa-share-alt" style="color: #ed8936;"></i>
            </div>
            <div class="stat-card">
                <div><p>Active Users</p><h2>1259</h2></div>
                <i class="fas fa-thumbs-up" style="color: #48bb78;"></i>
            </div>
            <div class="stat-card">
                <div><p>Rating</p><h2>4.8</h2></div>
                <i class="fas fa-star" style="color: #ecc94b;"></i>
            </div>
        </div>

        <!-- Main Dashboard Layout -->
        <div class="dashboard-grid">
            <!-- Left Side Panels -->
            <div class="panel">
                <div class="panel-header">
                    Customer Details & Analytics
                    <span style="background: #edf2f7; padding: 4px 12px; border-radius: 20px; font-size: 0.7em;">Check Now</span>
                </div>
                <div style="height: 250px; display: flex; align-items: flex-end; justify-content: space-around; padding-top: 20px;">
                    <!-- Visual Chart Bars -->
                    <div style="width: 35px; height: 50%; background: #2d3748; border-radius: 4px;"></div>
                    <div style="width: 35px; height: 75%; background: #4a5568; border-radius: 4px;"></div>
                    <div style="width: 35px; height: 30%; background: #2d3748; border-radius: 4px;"></div>
                    <div style="width: 35px; height: 90%; background: #00d4ff; border-radius: 4px;"></div>
                    <div style="width: 35px; height: 65%; background: #2d3748; border-radius: 4px;"></div>
                </div>
            </div>

            <!-- Right Side Panels -->
            <div class="panel">
                <div class="panel-header">Quick Links</div>
                <div class="quick-links">
                    <a href="#" class="ql-item"><i class="fas fa-plus"></i><br>New Cust</a>
                    <a href="#" class="ql-item"><i class="fas fa-search"></i><br>Search</a>
                    <a href="#" class="ql-item"><i class="fas fa-tools"></i><br>Master Pkg</a>
                    <a href="#" class="ql-item"><i class="fas fa-file-pdf"></i><br>Reports</a>
                </div>

                <div class="panel-header" style="margin-top: 30px;">Notifications & Alerts</div>
                <div class="alert-item alert-warning">
                    <strong>Warning:</strong> Package 'Basic-30M' expiring for 5 users.
                </div>
                <div class="alert-item alert-danger">
                    <strong>Critical:</strong> Node-04 connectivity unstable.
                </div>
            </div>
        </div>
    </div>

</body>
</html>