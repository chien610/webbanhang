<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 class="text-center my-3">Đơn hàng đã mua</h2>
<table id="myTable">
    <thead>
    <tr>
        <th>Mã đơn hàng</th>
        <th>Ngày mua hàng</th>
        <th>Địa chỉ nhận hàng</th>
        <th>Khách hàng</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${oders}" var="o">
        <tr>
            <td>${o.id}</td>
            <td>${o.createdate}</td>
            <td>${o.address}</td>
            <td>${o.account.fullname}</td>
            <td>
                <a href="/purchase-details/${o.id}" class="btn btn-info">
                    <i class="fa-regular fa-eye fa-lg me-1"></i>
                    Xem chi tiết
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>