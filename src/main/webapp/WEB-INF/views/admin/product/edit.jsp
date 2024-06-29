<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-8 mx-auto border rounded-3 p-5">
    <h2 class="text-center mb-4">Cập nhật sản phẩm</h2>
    <form:form modelAttribute="product" method="post" enctype="multipart/form-data">
        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="name">Tên sản phẩm:</label>
            <form:input path="name" id="name" cssClass="form-control"/>
            <span><form:errors path="name" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="price">Giá bán:</label>
            <form:input path="price" type="number" min="0" id="price" cssClass="form-control"/>
            <span><form:errors path="price" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label">Nhóm sản phẩm:</label>
            <form:select path="category.id" cssClass="form-select">
                <form:options items="${categories}" itemLabel="name" itemValue="id"/>
            </form:select>
            <span><form:errors path="category" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="time">Thời gian tạo:</label>
            <form:input path="createdate" type="text" id="time" cssClass="form-control"/>
        </div>
        <br>

        <div class="mb-3">
            <label for="formFile" class="form-label">Hình ảnh:</label>
            <br>
            <img src="${product.image}" alt="IMG" width="150px" class="rounded my-3">
            <input class="form-control" type="file" id="formFile" name="attach">
            <span><form:errors path="image" cssStyle="color: #e81414"/></span>
        </div>
        <br>

        <div class="form-outline" data-mdb-input-init>
            <label class="form-label" for="av">Có sẵn:</label>
            <form:checkbox path="available" cssClass="form-check-input ms-3" id="av"/>
        </div>

        <hr>
        <div class="mt-3 text-center">
            <button formaction="/admin/product/update/${product.id}" class="btn btn-success mx-2">
                <i class="fa-light fa-floppy-disk fa-lg me-2"></i>
                Lưu lại
            </button>

            <a href="/admin/product" class="btn btn-dark">
                <i class="fa-regular fa-arrow-turn-left fa-lg me-2"></i>
                Quay lại
            </a>
        </div>
    </form:form>
</div>