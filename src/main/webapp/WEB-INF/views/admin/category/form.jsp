<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="col-8 mx-auto border rounded-3 p-5">
    <h2 class="text-center mb-4">Cập nhật nhóm sản phẩm</h2>
    <form:form method="post" modelAttribute="category">
        <div class="mb-3 ${status.equals("edit") ? 'd-none' : ''}">
            <label for="recipient-name" class="col-form-label">Mã:</label>
            <form:input path="id" class="form-control" id="recipient"/>
            <span><form:errors path="id" cssStyle="color: #e81414"/></span>
        </div>

        <div class="mb-5">
            <label for="recipient-name" class="col-form-label">Tên danh mục:</label>
            <form:input path="name" class="form-control" id="recipient-name"/>
            <span><form:errors path="name" cssStyle="color: #e81414"/></span>
        </div>

        <hr>
        <div class="mt-3 text-center">
            <button formaction="/admin/category/${status.equals("edit") ? 'update/'.concat(category.id) : 'store'}"
                    class="btn btn-success me-2">
                <i class="fa-light fa-floppy-disk fa-lg me-2"></i>
                Lưu lại
            </button>

            <a href="/admin/category" class="btn btn-dark">
                <i class="fa-regular fa-arrow-turn-left fa-lg me-2"></i>
                Quay lại
            </a>
        </div>
    </form:form>
</div>
<script src="https://kit.fontawesome.com/9f7cfb03fb.js" crossorigin="anonymous"></script>
