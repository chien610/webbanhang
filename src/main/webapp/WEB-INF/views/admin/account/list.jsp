<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="text-center my-4">Danh sách người dùng</h2>
<div>
    <a href="/admin/account/create" class="btn btn-success">
        <i class="fa-light fa-file-user fa-lg me-1"></i>
        Thêm mới
    </a>
</div>

<table class="table table-hover mt-3">
    <thead class="bg-light">
    <tr>
        <th>Tên đăng nhập</th>
        <th>Mật khẩu</th>
        <th>Họ & tên</th>
        <th>Email</th>
        <th>Hình ảnh</th>
        <th>Trạng thái</th>
        <th>Admin</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${accounts.content}" var="account">
        <tr>
            <td>${account.username}</td>
            <td>${account.password}</td>
            <td>${account.fullname}</td>
            <td>${account.email}</td>
            <td>
                <img src="${account.photo}" alt="Không có ảnh" width="150px" class="rounded">
            </td>
            <td>
                <span class="badge rounded-pill ${account.activated ? 'bg-success' : 'bg-danger'}">
                        ${account.activated ? 'Yes' : 'No'}
                </span>
            </td>
            <td>
                   <span class="badge rounded-pill ${account.admin ? 'bg-success' : 'bg-danger'}">
                           ${account.admin ? 'Yes' : 'No'}
                   </span>
            </td>
            <td>
                <a href="/admin/account/update/${account.username}" class="btn btn-warning me-2 mb-2">
                    <i class="fa-light fa-pen-to-square fa-lg me-1"></i>
                    Sửa
                </a>
                <button onclick="return window.confirm('Bạn có muốn xoá?') ? window.location.href=`/admin/account/delete/` + '${account.username}' : ''"
                        class="btn btn-danger me-2 mb-2">
                    <i class="fa-light fa-trash fa-lg me-1"></i>
                    Xoá
                </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="btn-group me-2" role="group" aria-label="First group">
    <a href="/admin/account?page=0" class="btn btn-outline-secondary">Start</a>
    <a href="/admin/account?page=${pageNumber <= 0 ? 0 : pageNumber - 1}" class="btn btn-outline-secondary">Previous</a>
    <span class="mx-3">Hiển thị ${currentPage+1}-${totalPage} trên tổng số ${totalAccounts} người dùng</span>
    <a href="/admin/account?page=${pageNumber < totalPage-1 ? pageNumber + 1 : totalPage-1}"
       class="btn btn-outline-secondary">Next</a>
    <a href="/admin/account?page=${totalPage-1}" class="btn btn-outline-secondary">End</a>
</div>