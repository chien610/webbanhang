<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="/static/css/main.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary p-0">
    <div class="navbar-nav collapse navbar-collapse ms-1">
        <a class="nav-item nav-link active" href="/">
            <i class="fa-light fa-house-chimney fa-lg me-1"></i>
            Sản phẩm
        </a>
        <a class="nav-item nav-link active ms-2" href="/about">
            <i class="fa-light fa-circle-info fa-lg me-1"></i>
            Giới thiệu
        </a>
    </div>

    <ul class="navbar-nav ml-auto">
        <li class="nav-item no-arrow me-3">
            <c:if test="${cart.total > 0}">
                <a href="/cart" class="nav-link mt-2 text-light position-relative me-2">
                    <img src="/static/images/cart.png" alt="IMG" style="width:40px"/>
                    <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill bg-danger">
                         ${carts}
                        <span class="visually-hidden">unread messages</span>
                      </span>
                </a>
            </c:if>
        </li>
        <li class="nav-item no-arrow me-3">
            <a class="nav-link dropdown-toggle p-1" data-bs-toggle="dropdown" href="#">
                <img alt="" class="rounded-circle" style="width:60px"
                     src="${sessionScope.account.photo}"
                     onerror="this.onerror = null; this.src = `/static/images/user.svg`;"
                />
            </a>
            <div class="dropdown-menu dropdown-menu-end">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <div class="text-center">
                            <i class="fa-light fa-user-secret fa-xl me-2"></i>
                            <span class="fs-5">${sessionScope.account.username}</span>
                        </div>
                        <hr>

                        <a class="dropdown-item" href="/purchase-history">
                            <i class="fa-regular fa-rectangle-history fa-lg me-1"></i>
                            Lịch sử mua hàng
                        </a>

                        <button class="dropdown-item"
                                onclick="return window.confirm('Bạn có muốn đăng xuất?') ? window.location.href=`/logout`: ''">
                            <i class="fa-regular fa-right-from-bracket fa-lg me-1"></i>
                            Đăng xuất
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a class="dropdown-item" href="/login">
                            <i class="fa-regular fa-key-skeleton fa-lg me-1"></i>
                            Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </li>
    </ul>
</nav>
<script src="https://kit.fontawesome.com/9f7cfb03fb.js" crossorigin="anonymous"></script>