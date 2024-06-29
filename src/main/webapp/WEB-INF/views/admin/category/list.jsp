<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h2 class="text-center my-4">Nhóm sản phẩm</h2>
<div class="mb-3">
    <a class="btn btn-success" href="/admin/category/create">
        <i class="fa-sharp fa-solid fa-plus fa-lg me-1"></i>
        Thêm mới
    </a>
</div>
<table class="table table-hover ">
    <thead class="bg-light">
    <tr>
        <th>#</th>
        <th>Tên danh mục</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${categories}" var="categorie">
        <tr>
            <td>${categorie.id}</td>
            <td>${categorie.name}</td>
            <td>
                <a href="/admin/category/update/${categorie.id}" class="btn btn-warning me-2 mb-2">
                    <i class="fa-light fa-pen-to-square fa-lg me-1"></i>
                    Sửa
                </a>
                <button onclick="remove('${categorie.id}');"
                        class="btn btn-danger me-2 mb-2">
                    <i class="fa-light fa-trash fa-lg me-1"></i>
                    Xoá
                </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

