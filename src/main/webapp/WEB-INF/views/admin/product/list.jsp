<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="text-center my-4">Danh sách sản phẩm</h2>
<div class="d-flex justify-content-between">
    <div class="mb-3">
        <a href="/admin/product/create" class="btn btn-success">
            <i class="fa-light fa-cart-plus fa-lg me-1"></i>
            Thêm mới
        </a>
    </div>

    <form method="get" action="/admin/product-search">
        <div class="col-12 d-flex p-0">
            <input type="text" name="keyword" class="form-control"
                   placeholder="Tìm kiếm" title="Tìm kiếm theo tên hoặc nhóm sản phẩm"/>
            <button type="submit" class="btn">
                <i class="fa-sharp fa-regular fa-magnifying-glass fa-lg"></i>
            </button>
        </div>
    </form>
</div>

<table class="table table-hover">
    <thead class="bg-light">
    <tr>
        <th>#</th>
        <th>Hình ảnh</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Nhóm sản phẩm</th>
        <th>Thời gian tạo</th>
        <th>Có sẵn</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${products.content}" var="product">
        <tr>
            <td>${product.id}</td>
            <td>
                <img src="${product.image}" alt="IMG" width="150px" class="rounded">
            </td>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.category.name}</td>
            <td>${product.createdate}</td>
            <td>
                <span class="badge rounded-pill ${product.available ? 'bg-success' : 'bg-danger'}">
                        ${product.available ? 'Yes' : 'No'}
                </span>
            </td>
            <td>
                <a href="/admin/product/update/${product.id}" class="btn btn-warning me-2 mb-2">
                    <i class="fa-light fa-pen-to-square fa-lg me-1"></i>
                    Sửa
                </a>
                <button onclick="remove('${product.id}');" class="btn btn-danger me-2 mb-2">
                    <i class="fa-light fa-trash fa-lg me-1"></i>
                    Xoá
                </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="col btn-group me-2" role="group" aria-label="First group">
    <a href="/admin/product${pageSearch.equals("product-search")
            ? '-search?keyword='.concat(sessionScope.kw).concat('&page=0')
            : '?page=0'}"
       class="btn btn-outline-secondary">Start</a>

    <a href="/admin/product${pageSearch.equals("product-search")
            ? '-search?keyword='.concat(sessionScope.kw).concat('&page='.concat(page > 0 ? page - 1 : 0))
            : '?page='.concat(page > 0 ? page - 1 : 0)}"
       class="btn btn-outline-secondary">Previous</a>

    <span class="mx-3">Hiển thị ${currentPage+1}-${totalPage} trên tổng số ${totalProducts} sản phẩm</span>

    <a href="/admin/product${pageSearch.equals("product-search")
            ? '-search?keyword='.concat(sessionScope.kw).concat('&page='.concat(page < totalPage-1 ? page + 1 : totalPage-1))
            : '?page='.concat(page < totalPage-1 ? page + 1 : totalPage-1)}"
       class="btn btn-outline-secondary">Next</a>

    <a href="/admin/product${pageSearch.equals("product-search")
            ? '-search?keyword='.concat(sessionScope.kw).concat('&page='.concat(totalPage-1))
            : '?page='.concat(totalPage-1)}"
       class="btn btn-outline-secondary">End</a>
</div>