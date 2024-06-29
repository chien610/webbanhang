<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="text-center my-3">Chi tiết đơn hàng</h2>
<table id="myTable">
    <thead>
    <tr>
        <th>Hình ảnh</th>
        <th>Tên sản phẩm</th>
        <th>Tổng giá tiền</th>
        <th>Số lượng</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${oders}" var="od">
        <tr>
            <td>
                <img src="${od.product.image}" alt="IMG" width="100px">
            </td>
            <td>${od.product.name}</td>
            <td>${od.price}</td>
            <td>${od.quantity}</td>
            <td><span class="badge bg-info text-dark p-2">Đã thanh toán</span></td>
            <td>
                <a href="/detail/${od.product.id}" class="btn btn-secondary">
                    <i class="fa-regular fa-cart-shopping fa-lg me-1"></i>
                    Xem sản phẩm
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
