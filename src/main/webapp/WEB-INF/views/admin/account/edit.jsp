<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-8 mx-auto border rounded-3 p-5">
    <h2 class="text-center mb-4">Cập nhật tài khoản</h2>
    <form:form modelAttribute="account" method="POST" enctype="multipart/form-data">
        <div class="d-none">
                <%--Tên đăng nhập--%>
            <form:input path="username" id="user" cssClass="form-control"/>
        </div>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="name">Họ & tên:</label>
            <form:input path="fullname" id="name" cssClass="form-control"/>
            <span><form:errors path="fullname" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="pass">Mật khẩu:</label>
            <div class="d-flex">
                <form:input path="password" type="password" id="pass" cssClass="form-control"/>
                <button type="button" class="input-group-text ms-1" onclick="showAndHidePassword();">
                    <i class="fa-solid fa-eye fa-lg"></i>
                </button>
            </div>
            <span><form:errors path="password" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="mail">Email:</label>
            <form:input path="email" type="email" id="mail" cssClass="form-control"/>
            <span><form:errors path="email" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="mb-3">
            <label for="formFile" class="form-label">Hình ảnh:</label>
            <br>
            <img src="${account.photo}" alt="IMG" width="150px" class="rounded my-2">
            <input class="form-control" type="file" id="formFile" name="attach">
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="active">Trạng thái:</label>
            <form:checkbox path="activated" cssClass="form-check-input ms-3" id="active"/>
            <span><form:errors path="activated" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="admin">Admin:</label>
            <form:checkbox path="admin" cssClass="form-check-input ms-3" id="admin"/>
        </div>

        <hr>
        <div class="mt-3 text-center">
            <button formaction="/admin/account/update/${account.username}" class="btn btn-success me-2">
                <i class="fa-light fa-floppy-disk fa-lg me-2"></i>
                Cập nhật
            </button>

            <a href="/admin/account" class="btn btn-dark">
                <i class="fa-regular fa-arrow-turn-left fa-lg me-2"></i>
                Quay lại
            </a>
        </div>
    </form:form>
</div>