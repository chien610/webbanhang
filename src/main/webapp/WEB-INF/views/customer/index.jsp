<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="my-4">
    <div class="row">
        <div class="col-3 p-3 card">
            <form method="GET">
                <div class="product-search-info mt-3">
                    <label class="mb-1"><b>Tên sản phẩm:</b></label>
                    <input name="keyword" value="${param.keyword}" class="form-control"
                           placeholder="Nhập tên sản phẩm để tìm"/>
                </div>

                <div class="brand-search-info mt-3">
                    <label><b>Loại sản phẩm:</b></label>
                    <div class="mt-2">
                        <input type="radio" name="categoryId" id="all" checked value=""/>
                        <label for="all">Tất cả</label>
                    </div>
                    <c:forEach var="c" items="${categoryList}">
                        <div class="mt-1">
                            <input name="categoryId" type="radio" value="${c.id}" id="${c.id}"
                                   <c:if test="${param.categoryId==c.id}">checked</c:if>
                            />
                            <label for="${c.id}">${c.name}</label>
                        </div>
                    </c:forEach>
                </div>

                <div class="price-search-info mt-3">
                    <label><b>Mức giá:</b></label>
                    <c:forEach items="${priceRangeList}" var="pr">
                        <div class="mt-1">
                            <input type="radio" name="priceRangeId" value="${pr.id}" id="${pr.id}"
                                ${pr.id == 0 ? 'checked' : ''}
                                   <c:if test="${param.priceRangeId==pr.id}">checked</c:if>
                            />
                            <label for="${pr.id}">${pr.display}</label>
                        </div>
                    </c:forEach>
                </div>
                <button type="submit" class="btn btn-primary mt-4 mb-4">Tìm kiếm</button>
            </form>
        </div>

        <div class="col-8 ms-5 p-2">
            <ul class="list-unstyled row">
                <c:forEach var="p" items="${productList.content}">
                    <li class="list-item col-sm-4 mb-5">
                        <div class="item-container">
                            <a href="/detail/${p.id}" class="product-item">
                                <img src="${p.image}" class="product-image"
                                     onerror="this.onerror = null; this.src = `/static/images/error-404.webp`;"/>
                                <div class="item-info">
                                    <div>
                                        <span class="product-name">${p.name}</span>
                                    </div>
                                    <div>
                                        <span class="price-title">Giá bán :</span>
                                        <span class="price">${p.price} ₫</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link"
                                             href="/${pagination!=1 ? '?page=0' : paginationForSearch.concat('&page=0')}">&laquo;</a>
                    </li>

                    <li class="page-item"><a class="page-link"
                                             href="/${pagination!=1 ? '?page='.concat(currentPage > 0 ? currentPage-1 : 0)
                        : paginationForSearch.concat('&page='.concat(currentPage > 0 ? currentPage-1 : 0))}">&lsaquo;</a>
                    </li>

                    <li class="page-item">
                        <button class="page-link" onclick="setPageForCustomer()">...</button>
                    </li>

                    <li class="page-item"><a class="page-link"
                                             href="/${pagination!=1 ? '?page='.concat(currentPage+1 < totalPage ? currentPage+1 : totalPage-1)
                        : paginationForSearch.concat('&page='.concat(currentPage+1 < totalPage ? currentPage+1 : totalPage-1))}">&rsaquo;</a>
                    </li>

                    <li class="page-item"><a class="page-link"
                                             href="/${pagination!=1 ? '?page='.concat(totalPage - 1)
                        : paginationForSearch.concat('&page='.concat(totalPage - 1))}">&raquo;</a></li>
                </ul>
                <span>Hiển thị ${currentPage+1}-${totalPage} trên tổng số ${totalProducts} sản phẩm</span>
            </nav>
        </div>
    </div>
</div>