import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodorderapp.model.Order;


@WebServlet("/view-orders")
public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        HttpSession session = request.getSession();
        int restaurantId = (int) session.getAttribute("resID");

        try {
            conn = DBConnection.getCon();
            String sql = "select od.order_id, o.user_id, od.res_id, f.food, od.quantity, od.price,o.order_status, o.order_date from order_details od join orders o on \r\n"
            		+ "od.order_id=o.order_id join food f on f.foodId=od.food_id where od.res_id=? ORDER BY order_date DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, restaurantId);
            rs = pstmt.executeQuery();

            List<Order> pendingOrders = new ArrayList<>();
            List<Order> dispatchedOrders = new ArrayList<>();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setRestaurantId(rs.getInt("res_id"));
                order.setFoodName(rs.getString("food"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotal(rs.getDouble("price"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));

                if ("pending".equals(order.getOrderStatus())) {
                    pendingOrders.add(order);
                } else if ("Dispatched".equals(order.getOrderStatus())) {
                    dispatchedOrders.add(order);
                }
            }

            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("dispatchedOrders", dispatchedOrders);
            request.getRequestDispatcher("view-orders.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
