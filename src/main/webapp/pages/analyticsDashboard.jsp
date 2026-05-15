<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Analytics Dashboard - KhelPoshak</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: #f3f4f6;
            }
            
            .dashboardContainer {
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px;
            }
            
            /* Stats Grid */
            .statsGrid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .statCard {
                background: white;
                border-radius: 16px;
                padding: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                transition: transform 0.2s;
            }
            
            .statCard:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .statCard h3 {
                font-size: 14px;
                color: #6b7280;
                margin-bottom: 10px;
                font-weight: 500;
            }
            
            .statNumber {
                font-size: 32px;
                font-weight: bold;
                color: #1f2937;
            }
            
            .statNumber.warning {
                color: #ef4444;
            }
            
            .statSmall {
                font-size: 12px;
                color: #6b7280;
                margin-top: 8px;
            }
            
            /* Charts Row */
            .chartsRow {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .chartCard {
                background: white;
                border-radius: 16px;
                padding: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            
            .chartCard h3 {
                font-size: 16px;
                color: #374151;
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e5e7eb;
            }
            
            .chartContainer {
                height: 320px;
                position: relative;
            }
            
            /* Data Row */
            .dataRow {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
                gap: 20px;
            }
            
            .dataCard {
                background: white;
                border-radius: 16px;
                padding: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            
            .dataCard h3 {
                font-size: 16px;
                color: #374151;
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e5e7eb;
            }
            
            /* Tables */
            .dataTable {
                width: 100%;
                border-collapse: collapse;
            }
            
            .dataTable th {
                text-align: left;
                padding: 10px 8px;
                background: #f9fafb;
                font-size: 13px;
                font-weight: 600;
                color: #4b5563;
                border-bottom: 1px solid #e5e7eb;
            }
            
            .dataTable td {
                padding: 10px 8px;
                font-size: 13px;
                color: #374151;
                border-bottom: 1px solid #f3f4f6;
            }
            
            .dataTable tr:hover {
                background: #f9fafb;
            }
            
            /* Status Badges */
            .status {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 600;
            }
            
            .status.Pending {
                background: #fef3c7;
                color: #d97706;
            }
            
            .status.Processing {
                background: #dbeafe;
                color: #2563eb;
            }
            
            .status.Shipped {
                background: #e0e7ff;
                color: #4f46e5;
            }
            
            .status.Delivered {
                background: #d1fae5;
                color: #059669;
            }
            
            .status.Cancelled {
                background: #fee2e2;
                color: #dc2626;
            }
            
            /* Low Stock */
            .lowStock {
                background: #fee2e2;
                color: #dc2626;
                font-weight: bold;
                padding: 2px 6px;
                border-radius: 12px;
                font-size: 12px;
                display: inline-block;
            }
            
            .emptyMsg {
                text-align: center;
                padding: 30px;
                color: #9ca3af;
            }
            
            .pageHeader {
                margin-bottom: 25px;
            }
            
            .pageHeader h1 {
                font-size: 28px;
                color: #1f2937;
            }
            
            .pageHeader p {
                color: #6b7280;
                margin-top: 5px;
            }
            
            hr {
                margin: 15px 0;
                border: none;
                border-top: 1px solid #e5e7eb;
            }
            
            @media (max-width: 768px) {
                .statsGrid {
                    grid-template-columns: 1fr;
                }
                .chartsRow {
                    grid-template-columns: 1fr;
                }
                .dataRow {
                    grid-template-columns: 1fr;
                }
                .chartContainer {
                    height: 250px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Use your existing admin navbar -->
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="analytics"/>
        </jsp:include>
        
        <div class="dashboardContainer">
            <!-- Page Header -->
            <div class="pageHeader">
                <h1>Analytics Dashboard</h1>
                <p>View sales performance and business insights</p>
                <hr>
            </div>
            
            <!-- Stats Cards -->
            <div class="statsGrid">
                <div class="statCard">
                    <h3>Total Products</h3>
                    <div class="statNumber">${totalProducts}</div>
                </div>
                
                <div class="statCard">
                    <h3>Total Orders</h3>
                    <div class="statNumber">${totalOrders}</div>
                </div>
                
                <div class="statCard">
                    <h3>Total Users</h3>
                    <div class="statNumber">${totalUsers}</div>
                </div>
                
                <div class="statCard">
                    <h3>Total Revenue</h3>
                    <div class="statNumber">Rs. <fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/></div>
                </div>
                
                <div class="statCard">
                    <h3>Pending Orders</h3>
                    <div class="statNumber ${pendingOrders > 0 ? 'warning' : ''}">${pendingOrders}</div>
                    <div class="statSmall">Completed: ${completedOrders}</div>
                </div>
                
                <div class="statCard">
                    <h3>Today's Activity</h3>
                    <div class="statNumber">${ordersToday} Orders</div>
                    <div class="statSmall">Revenue: Rs. <fmt:formatNumber value="${revenueToday}" type="number" maxFractionDigits="0"/></div>
                </div>
            </div>
            
            <!-- Charts Section -->
            <div class="chartsRow">
                <div class="chartCard">
                    <h3> Weekly Orders Trend</h3>
                    <div class="chartContainer">
                        <canvas id="ordersChart"></canvas>
                    </div>
                </div>
                
                <div class="chartCard">
                    <h3> Weekly Revenue Trend</h3>
                    <div class="chartContainer">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Recent Orders & Low Stock -->
            <div class="dataRow">
                <div class="dataCard">
                    <h3> Recent Orders</h3>
                    <c:choose>
                        <c:when test="${empty recentOrders}">
                            <div class="emptyMsg">No orders yet</div>
                        </c:when>
                        <c:otherwise>
                            <table class="dataTable">
                                <thead>
                                    <tr>
                                        <th>Order #</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${recentOrders}">
                                        <tr>
                                            <td>${order.orderNumber}</td>
                                            <td>${order.customerName}</td>
                                            <td>Rs. <fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="0"/></td>
                                            <td><span class="status ${order.status}">${order.status}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="dataCard">
                    <h3>⚠️ Low Stock Alert</h3>
                    <c:choose>
                        <c:when test="${empty lowStockProducts}">
                            <div class="emptyMsg">✓ All products have sufficient stock</div>
                        </c:when>
                        <c:otherwise>
                            <table class="dataTable">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Team</th>
                                        <th>S</th>
                                        <th>M</th>
                                        <th>L</th>
                                        <th>XL</th>
                                        <th>XXL</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${lowStockProducts}">
                                        <tr>
                                            <td>${product.name}</td>
                                            <td>${product.team}</td>
                                            <td class="${product.stockS < 5 ? 'lowStock' : ''}">${product.stockS}</td>
                                            <td class="${product.stockM < 5 ? 'lowStock' : ''}">${product.stockM}</td>
                                            <td class="${product.stockL < 5 ? 'lowStock' : ''}">${product.stockL}</td>
                                            <td class="${product.stockXl < 5 ? 'lowStock' : ''}">${product.stockXl}</td>
                                            <td class="${product.stockXxl < 5 ? 'lowStock' : ''}">${product.stockXxl}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Weekly Orders Chart
            const weeklyOrdersData = ${weeklyOrders != null ? weeklyOrders : '[0,0,0,0,0,0,0]'};
            new Chart(document.getElementById("ordersChart"), {
                type: "line",
                data: {
                    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                    datasets: [{
                        label: "Orders",
                        data: weeklyOrdersData,
                        borderColor: "#4F46E5",
                        backgroundColor: "rgba(79, 70, 229, 0.1)",
                        borderWidth: 2,
                        tension: 0.3,
                        fill: true,
                        pointBackgroundColor: "#4F46E5",
                        pointRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { position: "top" } },
                    scales: { y: { beginAtZero: true, title: { display: true, text: "Number of Orders" } } }
                }
            });
            
            // Weekly Revenue Chart
            const weeklyRevenueData = ${weeklyRevenue != null ? weeklyRevenue : '[0,0,0,0,0,0,0]'};
            new Chart(document.getElementById("revenueChart"), {
                type: "bar",
                data: {
                    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                    datasets: [{
                        label: "Revenue (Rs.)",
                        data: weeklyRevenueData,
                        backgroundColor: "#22C55E",
                        borderRadius: 6,
                        borderColor: "#16A34A",
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: "top" },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return "Rs. " + context.parsed.y.toLocaleString();
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: "Revenue (Rs.)" },
                            ticks: {
                                callback: function(value) {
                                    return "Rs. " + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
        </script>
    </body>
</html>