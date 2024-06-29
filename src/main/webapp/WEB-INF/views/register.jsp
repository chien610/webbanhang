<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="bg-login">
    <div class="login-form">
        <h3 class="text-center mb-5">Đăng ký tài khoản</h3>
        <form:form modelAttribute="account" method="POST" enctype="multipart/form-data">
            <div class="form-outline" data-mdb-input-init>
                <label class="form-label" for="user">Tên đăng nhập:</label>
                <form:input path="username" id="user" cssClass="form-control"/>
                <span><form:errors path="username" cssStyle="color: #e81414"/></span>
            </div>
            <br>

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
                <input class="form-control" type="file" id="formFile" name="attach">
            </div>
            <br>

            <hr>
            <div class="mt-3 text-center">
                <button formaction="/admin/account/create-account" class="btn btn-success me-2">
                    Đăng ký
                </button>

                <a href="/login" class="btn btn-dark">
                    Quay lại
                </a>
            </div>
        </form:form>
    </div>
</div>
