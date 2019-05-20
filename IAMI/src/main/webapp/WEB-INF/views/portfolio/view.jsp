<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";
var commentCount = 0;
$(document).ready(function() {
	$("oembed[url]").each(function() {
		 const anchor = document.createElement("a");
		 anchor.setAttribute('href', $(this).attr("url"));
		 anchor.className = 'embedly-card';
		 $(this).css("width", "100%");
		 
		 $(this).append(anchor);
	});

	dateFormat();
	commentList();
	$("#summary").html($("#summary").html().trim().replace(/\n/g, "<br>"));
});
function dateFormat() {
	var dates = new Date($("#start-date").html().replace(/-/g, "/").replace(".0", ""));
	var year = dates.getFullYear();
	var month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	var day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	
	$("#start-date").html(year + "-" + month + "-" + day);
	
	dates = new Date($("#end-date").html().replace(/-/g, "/").replace(".0", ""));
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	
	$("#end-date").html(year + "-" + month + "-" + day);
	
	dates = new Date($("#regdate").html().replace(/-/g, "/").replace(".0", ""));
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	var hour = dates.getHours();
	hour = (hour + "").length == 1? ("0" + hour):hour;
	var minute = dates.getMinutes();
	minute = (minute + "").length == 1? ("0" + minute):minute;
	
	$("#regdate").html(year + "-" + month + "-" + day + " " + hour + ":" + minute);
}
function commentDateFormat(date) {
	dates = new Date(date);
	year = dates.getFullYear();
	month = dates.getMonth()+1;
	month = (month + "").length == 1? ("0" + month):month;
	day = dates.getDate();
	day = (day + "").length == 1? ("0" + day):day;
	var hour = dates.getHours();
	hour = (hour + "").length == 1? ("0" + hour):hour;
	var minute = dates.getMinutes();
	minute = (minute + "").length == 1? ("0" + minute):minute;
	
	return year + "-" + month + "-" + day + " " + hour + ":" + minute;
}
function openRecomment(no) {
	$("#recomment-write-" + no).toggle();
	$("#recomment-list-" + no).toggle();
}
function openCommentDropdown(no) {
	$("#comment-dropdown-" + no).toggle();
}
function openReCommentDropdown(no) {
	$("#recomment-dropdown-" + no).toggle();
}
function openCommentUpdateForm(no) {
	$("#comment-update-" + no).toggle();
}
function commentList(page) {
	var pot_no = "${portfolio.pot_no}";
	
	if(page == null) {
		page = 1;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/comment/list",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no,
			"page" : page
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		complete: function(data) {
			recommentList();
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					$("#comment-count-all").html(data.count);
					var tempHTML = "";
					for(var i=0; i<data.count; i++) {
						tempHTML += "<ul class='comment-list'>";
						tempHTML += "<li class='comment'>";
							if(data.list[i].com_status != 0) {
								tempHTML += "<div class='comment-profile'>";
								if(data.list[i].com_type == 2) {
									if(data.list[i].mem_profile != null) {
										if(parseInt("${portfolio.mem_no}") == data.list[i].mem_no) {
											tempHTML += "<span class='badge writer'>작성자</span>";
										}
										tempHTML += "<img class='profile' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].mem_profile + "'/>";
									} else {
										tempHTML += "<img class='profile-none' src='${pageContext.request.contextPath}/resources/image/main/user.png'/>";
									}
								} else {
									tempHTML += "<span class='badge'>비회원</span>";
									tempHTML += "<img class='profile-none' src='${pageContext.request.contextPath}/resources/image/main/user.png'/>";							
								}
							}
							tempHTML += "</div>";
							tempHTML += "<div class='comment-content'>";
								if(data.list[i].com_status != 0) {
									if(data.list[i].com_type == 2) {				
										tempHTML += "<span class='nickname'>" + data.list[i].mem_nickname + "</span>";
										tempHTML += "<span class='id'>(" + data.list[i].mem_id + ")</span>";
										tempHTML += "<span class='regdate'>" + commentDateFormat(data.list[i].com_regdate) + "</span>";
									} else {
										tempHTML += "<span class='nickname'>" + data.list[i].com_nickname + "</span> ";
										tempHTML += "<span class='regdate'>" + commentDateFormat(data.list[i].com_regdate) + "</span>";
									}
									tempHTML += "<div class='regdate-m'>";
										tempHTML += "<span class='regdate m'>" + commentDateFormat(data.list[i].com_regdate) + "</span>";
									tempHTML += "</div>";
									tempHTML += "<div class='content'>";
										tempHTML += data.list[i].com_content.replace(/\n/g, "<br>");
									tempHTML += "</div>";
								} else {
									/* $("#comment-count-all").html(parseInt($("#comment-count-all").html()) - 1); */
									tempHTML += "<div class='content'>";
										tempHTML += "사용자의 요청으로 삭제된 댓글입니다.";
									tempHTML += "</div>";
								}
								if(data.list[i].com_type == 2) {
									tempHTML += "<div id='comment-update-" + data.list[i].com_no + "' class='update row'>";
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<textarea type='text' id='comment-update-content-" + data.list[i].com_no + "' class='update-input'>" + data.list[i].com_content + "</textarea>";
										tempHTML += "</div>"
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<button class='w3-button' onclick='memberCommentUpdate(" + data.list[i].com_no + ");'>수정</button>";
										tempHTML += "</div>"
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<button class='w3-button' onclick='openCommentUpdateForm(" + data.list[i].com_no + ");'>닫기</button>";
										tempHTML += "</div>"
									tempHTML += "</div>";
								} else {
									tempHTML += "<div id='comment-update-" + data.list[i].com_no + "' class='update row'>";
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<textarea type='text' id='comment-update-content-" + data.list[i].com_no + "' class='update-input'>" + data.list[i].com_content + "</textarea>";
										tempHTML += "</div>"
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<input type='password' id='comment-update-password-" + data.list[i].com_no + "' class='update-input' placeholder='비밀번호'/>";
										tempHTML += "</div>"
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<button class='w3-button' onclick='nonmemberCommentUpdate(" + data.list[i].com_no + ");'>수정</button>";
										tempHTML += "</div>"
										tempHTML += "<div class='col-md-4'>"
											tempHTML += "<button class='w3-button' onclick='openCommentUpdateForm(" + data.list[i].com_no + ");'>닫기</button>";
										tempHTML += "</div>"
									tempHTML += "</div>";
								}
								tempHTML += "<div class='function'>";
									tempHTML += "<button id='recomment-btn-" + data.list[i].com_no + "' class='w3-button w3-white w3-border recomment-btn' onclick='openRecomment(" + data.list[i].com_no + ");'>답글 (<span id='recomment-count-" + data.list[i].com_no + "'>0</span>)";
									if(data.list[i].com_status != 0) {
										tempHTML += "<input type='hidden' value='1'>";
									}
									tempHTML += "</button>";
									tempHTML += "<div id='recomment-write-" + data.list[i].com_no + "' class='recomment-write'>";
									if(${not empty sessionScope.mem_no}) {
										if(data.list[i].com_status != 0) {
											tempHTML += "<div class='recomment-write-input'>";
												tempHTML += "<textarea id='recomment-content-" + data.list[i].com_no + "' placeholder='내용을 입력해주세요.'></textarea>";
											tempHTML += "</div>";
											tempHTML += "<div class='recomment-write-button'>";
												tempHTML += "<button class='w3-button' onclick='openRecomment(" + data.list[i].com_no + ");'>닫기</button>";
												tempHTML += "<button id='btn-recomment-write' class='w3-button' onclick='memberReCommentWrite(" + data.list[i].com_no + ");'>작성</button>";
											tempHTML += "</div>";
										}
									} else {
										if(data.list[i].com_status != 0) {
											tempHTML += "<div class='recomment-write-nonmember'>";
											tempHTML += "<div class='row'>";
												tempHTML += "<div class='nonmember-nickname col-md-6'>";
													tempHTML += "<div class='wrapper'>";
														tempHTML += "<div>닉네임</div>";
														tempHTML += "<input type='text' id='recomment-nickname-" + data.list[i].com_no + "' placeholder='닉네임을 입력해주세요.'/>";
													tempHTML += "</div>";
												tempHTML += "</div>";
												tempHTML += "<div class='nonmember-password col-md-6'>";
													tempHTML += "<div class='wrapper'>";
														tempHTML += "<div>비밀번호</div>";
														tempHTML += "<input type='password' id='recomment-password-" + data.list[i].com_no + "' placeholder='비밀번호를 입력해주세요.'/>";
													tempHTML += "</div>";
												tempHTML += "</div>";
											tempHTML += "</div>";
											tempHTML += "</div>";
											tempHTML += "<div class='recomment-write-input'>";
												tempHTML += "<textarea id='recomment-content-" + data.list[i].com_no + "' placeholder='내용을 입력해주세요.'></textarea>";
											tempHTML += "</div>";
											tempHTML += "<div class='recomment-write-button'>";
												tempHTML += "<button class='w3-button' onclick='openRecomment(" + data.list[i].com_no + ");'>닫기</button>";
												tempHTML += "<button id='btn-recomment-write' class='w3-button' onclick='nonmemberReCommentWrite(" + data.list[i].com_no + ");'>작성</button>";
											tempHTML += "</div>";		
										}
									}
									tempHTML += "</div>";
								tempHTML += "</div>";
							tempHTML += "</div>";
							if(data.list[i].com_status != 0) {
								if(data.list[i].com_type == 2) {
									var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
									if(mem_no == data.list[i].mem_no) {
										tempHTML += "<div class='comment-ellipsis'>";
											tempHTML += "<i class='fas fa-ellipsis-v' onclick='openCommentDropdown(" + data.list[i].com_no + ");'></i>";
											tempHTML += "<ul id='comment-dropdown-" + data.list[i].com_no + "' class='dropdown'>";
												tempHTML += "<li><i class='fas fa-pen' onclick='openCommentUpdateForm(" + data.list[i].com_no + ");'></i></li>";
												tempHTML += "<li><i class='fas fa-trash-alt' onclick='memberCommentDelete(" + data.list[i].com_no + ")'></i></li>";
											tempHTML += "</ul>";
										tempHTML += "</div>";
									}
								} else {
									tempHTML += "<div class='comment-ellipsis'>";
										tempHTML += "<i class='fas fa-ellipsis-v' onclick='openCommentDropdown(" + data.list[i].com_no + ");'></i>";
										tempHTML += "<ul id='comment-dropdown-" + data.list[i].com_no + "' class='dropdown'>";
											tempHTML += "<li><i class='fas fa-pen' onclick='openCommentUpdateForm(" + data.list[i].com_no + ");'></i></li>";
											tempHTML += "<li><i class='fas fa-trash-alt' onclick='nonmemberCommentDelete(" + data.list[i].com_no + ")'></i></li>";
										tempHTML += "</ul>";
									tempHTML += "</div>";								
								}
							}
						tempHTML += "</li>";
						tempHTML += "<li id='recomment-list-" + data.list[i].com_no + "' class='recomment-lists'>";
						tempHTML += "</li>";
						tempHTML += "</ul>";
					}
					$(".comment-list-box").html(tempHTML);
					tempHTML = "";
					// 댓글 페이징
					if(data.startPage > data.pageBlock) {
						tempHTML += "<li class='prev" + (data.page==i? "active":"") + "' onclick='" + (data.page!=i? "commentList(" + parseInt(data.startPage - data.pageBlock) + ")":"") + "'>";
							tempHTML += "이전";
						tempHTML += "</li>";
					}
					for(var i=data.startPage; i<=data.endPage; i++) {
						if(i == (data.endPage)) {
							tempHTML += "<li class='pagination-last " + (data.page==i? "active":"") + "' onclick='" + (data.page!=i? "commentList(" + i + ")":"") + "'>";
								tempHTML += i;
							tempHTML += "</li>";						
						} else {
							tempHTML += "<li class='" + (data.page==i? "active":"") + "' onclick='" + (data.page!=i? "commentList(" + i + ")":"") + "'>";
								tempHTML += i;
							tempHTML += "</li>";					
						}
					}
					if(data.endPage < data.pageCount) {
						tempHTML += "<li class='next pagination-last " + (data.page==i? "active":"") + "' onclick='" + (data.page!=i? "commentList(" + parseInt(data.startPage + data.pageBlock) + ")":"") + "'>";
							tempHTML += "다음";
						tempHTML += "</li>";
					}
					commentCount = data.commentCount;
					$("#comment-count-all").html(commentCount);
					$(".pagination-box").html(tempHTML);
				}
			}
		}
	});
}
/* <ul class="pagination-box">
<li>이전</li>
<li>1</li>
<li>2</li>
<li>3</li>
<li>4</li>
<li>5</li>
<li class="active">6</li>
<li>7</li>
<li>8</li>
<li>9</li>
<li>10</li>
<li class="pagination-last">다음</li>
</ul> */
function recommentList() {
	var pot_no = "${portfolio.pot_no}";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/recomment/list",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		complete: function(data) {
			removeRecommentDiv();
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var tempHTML = "";
					for(var i=0; i<data.count; i++) { // 답글 및 카운트 초기화
						$("#recomment-count-" + data.list[i].com_no).html("0");
						$("#recomment-list-" + data.list[i].com_no).html("");
					}
					$("#comment-count-all").html(commentCount); // 댓글 카운트 초기화
					for(var i=0; i<data.count; i++) {
						$("#comment-count-all").html(parseInt($("#comment-count-all").html()) + 1);
						tempHTML = "";
						tempHTML += "<ul class='recomment-list'>";
							tempHTML += "<li class='recomment'>";
								tempHTML += "<div class='recomment-arrow'>";
									tempHTML += "<i class='fas fa-location-arrow fa-2x'></i>";
								tempHTML += "</div>";
								tempHTML += "<div class='recomment-box'>";
									tempHTML += "<div class='recomment-profile'>";
										if(data.list[i].rcom_type == 2) {
											if(data.list[i].mem_profile != null) {
												if(parseInt("${portfolio.mem_no}") == data.list[i].mem_no) {
													tempHTML += "<span class='badge writer'>작성자</span>";
												}
												tempHTML += "<img class='profile' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].mem_profile + "'/>"
											} else {
												tempHTML += "<img class='profile-none' src='${pageContext.request.contextPath}/resources/image/main/user.png'/>"
											}
										} else {
											tempHTML += "<span class='badge'>비회원</span>";
											tempHTML += "<img class='profile-none' src='${pageContext.request.contextPath}/resources/image/main/user.png'/>"
										}
									tempHTML += "</div>";
									tempHTML += "<div class='recomment-content'>";
 										if(data.list[i].rcom_type == 2) {
											tempHTML += "<span class='nickname'>" + data.list[i].mem_nickname + "</span><span class='id'>(" + data.list[i].mem_id + ")</span><span class='regdate'>" + commentDateFormat(data.list[i].rcom_regdate) + "</span>";
										} else {
											tempHTML += "<span class='nickname'>" + data.list[i].rcom_nickname + "</span> <span class='regdate'>2019-05-16 02:36</span>";
										}
										tempHTML += "<div class='regdate-m'>";
											tempHTML += "<span class='regdate m'>" + commentDateFormat(data.list[i].rcom_regdate) + "</span>";
										tempHTML += "</div>";
										tempHTML += "<div class='content'>";
											tempHTML += data.list[i].rcom_content.replace(/\n/g, "<br>");
										tempHTML += "</div>";
									tempHTML += "</div>";
									if(data.list[i].rcom_type == 2) {
										if(${not empty sessionScope.mem_no}) {
											tempHTML += "<div class='recomment-ellipsis'>";
												tempHTML += "<i class='fas fa-ellipsis-v' onclick='openReCommentDropdown(" + data.list[i].rcom_no + ");'></i>";
												tempHTML += "<ul id='recomment-dropdown-" + data.list[i].rcom_no + "' class='dropdown'>";
													tempHTML += "<li><i class='fas fa-trash-alt' onclick='memberReCommentDelete(" + data.list[i].rcom_no + ");'></i></li>";												
												tempHTML += "</ul>";
											tempHTML += "</div>";
										}
									} else {
										tempHTML += "<div class='recomment-ellipsis'>";
											tempHTML += "<i class='fas fa-ellipsis-v' onclick='openReCommentDropdown(" + data.list[i].rcom_no + ");'></i>";
											tempHTML += "<ul id='recomment-dropdown-" + data.list[i].rcom_no + "' class='dropdown'>";
												tempHTML += "<li><i class='fas fa-trash-alt' onclick='nonmemberReCommentDelete(" + data.list[i].rcom_no + ");'></i></li>";												
											tempHTML += "</ul>";
										tempHTML += "</div>";										
									}
								tempHTML += "</div>";
							tempHTML += "</li>";
						tempHTML += "</ul>";
						$("#recomment-count-" + data.list[i].com_no).html(parseInt($("#recomment-count-" + data.list[i].com_no).html()) + 1);
						$("#recomment-list-" + data.list[i].com_no).append(tempHTML);
					}
				}
			}
		}
	});
}
function removeRecommentDiv() {
	$(".comment-list-box").find(".recomment-btn").each(function() {
		if($(this).find("span").html() == "0" && $(this).find("input[type='hidden']").val() == null) {
			$(this).parent(".function").parent(".comment-content").parent(".comment").parent(".comment-list").remove();
			/* $(this).remove(); */
		}
	});
}
function nonmemberCommentWrite() {
	var nickname = $("#comment-nickname").val();
	var password = $("#comment-password").val();
	var content = $("#comment-content").val();
	var pot_no = "${portfolio.pot_no}";
	
	if(nickname == null || nickname.length < 3 || nickname.length > 7) {
		alert("닉네임은 3자 이상 7자 이하로 입력해주세요.");
		return false;
	}
	if(password == null || password.length < 4 || password.length > 20) {
		alert("비밀번호는 4자 이상 20자 이하로 입력해주세요.");
		return false;
	}
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/comment/write",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no,
			"com_nickname" : nickname,
			"com_pw" : password,
			"com_content" : content,
			"com_type" : 1
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#comment-nickname").val("");
					$("#comment-password").val("");
					$("#comment-content").val("");
					commentList();
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function nonmemberCommentUpdate(no) {
	var content = $("#comment-update-content-" + no).val();
	var password = $("#comment-update-password-" + no).val();
	
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	if(password == null || password.length == 0) {
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/comment/update",
		type: "POST",
		cache: false,
		data: {
			"com_no" : no,
			"com_pw" : password,
			"com_content" : content,
			"com_type" : 1
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					alert("수정되었습니다.");
					commentList();
				} else if(data == "Wrong") {
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function memberCommentUpdate(no) {
	var content = $("#comment-update-content-" + no).val();
	
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/comment/update",
		type: "POST",
		cache: false,
		data: {
			"com_no" : no,
			"com_content" : content,
			"com_type" : 2
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					alert("수정되었습니다.");
					commentList();
				} else if(data == "Wrong") {
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function memberCommentWrite() {
	var content = $("#comment-content").val();
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var pot_no = "${portfolio.pot_no}";
	
	
	if(mem_no == 0) {
		alert("로그인이 필요합니다.");
		return false;
	}
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/comment/write",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no,
			"mem_no" : mem_no,
			"com_content" : content,
			"com_type" : 2
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#comment-content").val("");
					commentList();
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function nonmemberCommentDelete(no) {
	var pop = window.open("${pageContext.request.contextPath}/portfolio/delete?no=" + no + "&type=1","pop","width=500,height=500, scrollbars=yes, resizable=yes");
}
function nonmemberReCommentDelete(no) {
	var pop = window.open("${pageContext.request.contextPath}/portfolio/delete?no=" + no + "&type=2","pop","width=500,height=500, scrollbars=yes, resizable=yes");
}
function memberCommentDelete(no) {
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	
	if(mem_no == 0) {
		alert("로그인이 필요합니다.");
		return false;
	}
	
	var confirms = confirm("정말로 삭제하시겠습니까?");
	
	if(confirms) {
		$.ajax({
			url: "${pageContext.request.contextPath}/portfolio/comment/delete",
			type: "POST",
			cache: false,
			data: {
				"com_no" : no,
				"com_type" : 2
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						alert("삭제되었습니다.");
						commentList();
					} else {
						alert("알 수 없는 오류입니다.");
					}
				}
			}
		});
	}
}
function memberReCommentDelete(no) {
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";

	if(mem_no == 0) {
		alert("로그인이 필요합니다.");
		return false;
	}
	
	var confirms = confirm("정말로 삭제하시겠습니까?");
	
	if(confirms) {
		$.ajax({
			url: "${pageContext.request.contextPath}/portfolio/recomment/delete",
			type: "POST",
			cache: false,
			data: {
				"rcom_no" : no,
				"rcom_type" : 2
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						alert("삭제되었습니다.");
						commentList();
					} else {
						alert("알 수 없는 오류입니다.");
					}
				}
			}
		});
	}
}
function deleteCommentOk(status) {
	if(status == "Ok") {
		commentList();
	}
}
function nonmemberReCommentWrite(no) {
	var nickname = $("#recomment-nickname-" + no).val();
	var password = $("#recomment-password-" + no).val();
	var content = $("#recomment-content-" + no).val();
	var pot_no = "${portfolio.pot_no}";
	
	if(nickname == null || nickname.length < 3 || nickname.length > 7) {
		alert("닉네임은 3자 이상 7자 이하로 입력해주세요.");
		return false;
	}
	if(password == null || password.length < 4 || password.length > 20) {
		alert("비밀번호는 4자 이상 20자 이하로 입력해주세요.");
		return false;
	}
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/recomment/write",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no,
			"com_no" : no,
			"rcom_nickname" : nickname,
			"rcom_pw" : password,
			"rcom_content" : content,
			"rcom_type" : 1
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#recomment-nickname-" + no).val("");
					$("#recomment-password-" + no).val("");
					$("#recomment-content-" + no).val("");
					recommentList();
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function memberReCommentWrite(no) {
	var mem_no = "${empty sessionScope.mem_no? 0:sessionScope.mem_no}";
	var content = $("#recomment-content-" + no).val();
	var pot_no = "${portfolio.pot_no}";
	
	if(mem_no == 0) {
		alert("로그인이 필요합니다.");
		return false;
	}
	if(content == null || content.length == 0) {
		alert("내용을 입력해주세요.");
		return false;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/portfolio/recomment/write",
		type: "POST",
		cache: false,
		data: {
			"pot_no" : pot_no,
			"mem_no" : mem_no,
			"com_no" : no,
			"rcom_content" : content,
			"rcom_type" : 2
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success:function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#recomment-content-" + no).val("");
					recommentList();
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
</script>
<style>
.viewWrapper {
	margin: 0 10px;
}
hr {
	margin: 16px 0;
}
.subject {
	margin-top: 10px;
}
.dev-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.dev-list h5 {
	font-weight: normal;
}
.dev-list .dev-list-content {
	list-style-type: none;
	margin: 0;
	overflow: hidden;	
}
.dev-list .dev-list-content .start, .end {
	position: relative;
}
.dev-list .dev-list-content .date-badge {
	position: absolute;
	top: 0;
	left: -27px;
	font-size: 8pt;
}
.dev-list .dev-list-content .date-badge.start {
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.dev-list .dev-list-content .date-badge.end {
	padding: 1px;
	border: 1px solid rgba(204, 61, 61, 0.4);
	border-radius: 5px;
	background-color: rgba(204, 61, 61, 0.4);
	color: white;
}
.dev-list .dev-list-content .start, .end #start-date, #end-date {
	padding-left: 3px;
}
.dev-list .row {
	margin: 0;
	margin-bottom: 10px;
	box-sizing: border-box;
	list-style-type: none;
	overflow: hidden;
}
.dev-list .row li {
	width: 100%;
}
.margin-title {
	margin-top: 5px;
}
.environment-title div {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
.environment-title .btn-add {
	display: none;
	width: 25px;
	margin-left: 5px;
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	background-color: rgba(17, 135, 207, 0.4) !important;
	color: white !important;
	cursor: pointer;
}
.environment-input {
	margin-top: 7.5px;
}
.environment-input .container {
	max-width: 100% !important;
	padding: 0 !important;
}
.environment-input .container .row {
	margin: 0 !important;
}
.environment-input .container .row .empty {
	padding: 30px;
	text-align: center;
	border: 1px solid #D5D5D5;
}
.environment-input .container .row .margin-card {
	margin-right: 5px;
}
.environment-input .container .row .dev-card {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
#dem_environment, #git_environment .dev-card {
	cursor: pointer;
}
.container .dev-card {
	position: relative;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.container .card-box.select .dev-card {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card:hover {
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.container .dev-card div {
	display: inline-block;
	vertical-align: middle;
}
.container .dev-card div.api {
	display: block;
	vertical-align: inherit;
	text-align: center;
}
.container .dev-card .dev-card-img {
	width: 50px;
	height: 50px;
}
.container .dev-card .dev-card-img img {
	width: 100%;
	height: 100%;
}
.container .dev-card .dev-card-text {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.container .dev-card .fa-check {
	display: none;
	position: absolute;
	top: 0;
	right: 0;
	padding: 0;
	color: rgba(17, 135, 207, 0.4);
}
.container .dev-card .fa-link, .fa-github-square {
	color: rgba(17, 135, 207, 0.4);
}
.recommend-box {
	text-align: center;
	margin-bottom: 10px;
}
.recommend-box button {
	border: 1px solid rgba(17, 135, 207, 0.4) !important;
	color: rgba(17, 135, 207, 0.4) !important;
}
.profile-box {
	margin-bottom: 10px;
}
.profile-box .profile-inner {
	display: flex;
	align-items: center;
	margin: 0 10px;
	padding: 10px;
	border: 1px solid #D5D5D5;
	background-color: rgba(246, 246, 246, 0.4);
}
.profile-box .profile-inner .profile-image {
	position: relative;
}
.profile-box .profile-inner .profile-image .badge {
	position: absolute;
	top: 0;
	left: 0;
	padding: 1px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.profile-box .profile-inner .profile-image .profile {
	width: 70px;
	height: 70px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 50%;
}
.profile-box .profile-inner .profile-image .profile-none {
	width: 70px;
	height: 70px;
}
.profile-box .profile-inner .profile-content {
	padding-left: 10px;
}
.profile-box .profile-inner .profile-content i {
	color: rgba(17, 135, 207, 0.4);
}
.profile-box .profile-inner .profile-content .content-1 .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.profile-box .profile-inner .profile-content .content-1 .id {
	color: gray;
}
.profile-box .profile-inner .profile-content .content-2 .email {
	/* color: rgba(17, 135, 207, 0.5); */
	color: gray;
/* 	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white; */
}
.profile-box .profile-inner .profile-content .content-3 .regdate {
	/* color: rgba(17, 135, 207, 0.5); */
	color: gray;
/*  	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 5px;
	background-color: rgba(17, 135, 207, 0.4);
	color: white; */
}
.comment-title {
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 5px;
}
.comment-title i {
	color: rgba(17, 135, 207, 0.4); 
}
.comment-title .w3-badge {
	background-color: rgba(17, 135, 207, 0.4); 
}
.comment-write {
	margin-left: 10px;
	margin-bottom: 10px;
}
.comment-write .row {
	margin: 0;
}
.comment-write .row input {
	width: 100%;
	height: 35px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.comment-write .row .nonmember-nickname {
	padding: 0;
}
.comment-write .row .nonmember-password {
	padding: 0;
}
.comment-write .row .wrapper {
	margin-right: 10px;
}
.comment-write .comment-write-input {
	display: flex;
	margin-top: 5px;
	margin-right: 10px;
}
.comment-write .comment-write-input textarea {
	flex-grow: 1;
	padding: 5px;
	height: 80px;
	border: 1px solid #D5D5D5;
}
.comment-write .comment-write-input button {
	width: 100px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.comment-write .comment-write-input-m {
	display: none;
	margin-top: 5px;
	margin-right: 10px;
}
.comment-write .comment-write-input-m #btn-comment-write-m {
	width: 100%;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.recomment-write {
	display: none;
	margin-top: 5px;
}
.recomment-write .row {
	margin: 0;
}
.recomment-write .row input {
	width: 100%;
	height: 35px;
	padding: 5px;
	border: 1px solid #D5D5D5;
}
.recomment-write .row .nonmember-nickname {
	padding: 0;
}
.recomment-write .row .nonmember-password {
	padding: 0;
}
.recomment-write .row .nonmember-nickname .wrapper {
	margin-right: 5px;
}
.recomment-write .row .nonmember-password .wrapper {
	margin-left: 5px;
}
.recomment-write .recomment-write-input {
	margin-top: 5px;
}
.recomment-write .recomment-write-input textarea {
	width: 100%;
	padding: 5px;
	height: 80px;
	border: 1px solid #D5D5D5;
}
.recomment-write .recomment-write-button {
	display: flex;
	justify-content: space-between;
}
.recomment-write .recomment-write-button button {
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.comment-list {
	list-style-type: none;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
	padding: 0;
	overflow: hidden;
}
.comment-list .comment {
	display: flex;
	padding: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
}
.comment-list .comment .comment-profile {
	position: relative;
}
.comment-list .comment .comment-profile .profile {
	width: 50px;
	height: 50px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 50%;
}
.comment-list .comment .comment-profile .badge {
	position: absolute;
	top: 0;
	left: 0;
	padding: 1px;
	border: 1px solid rgba(242, 150, 97, 0.4);
	border-radius: 5px;
	background-color: rgba(242, 150, 97, 0.4);
	color: white;
}
.comment-list .comment .comment-profile .badge.writer {
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
}
.comment-list .comment .comment-profile .profile-none {
	width: 50px;
	height: 50px;
}
.comment-list .comment .comment-content {
	padding: 10px;
	flex-grow: 1;
}
.comment-list .comment .comment-content .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.comment-list .comment .comment-content .id {
	padding-right: 5px;
	color: gray;
}
.comment-list .comment .comment-content .regdate {
	color: gray;
	font-size: 10pt;
}
.comment-list .comment .comment-content .regdate-m {
	display: none;
}
.comment-list .comment .comment-content .content {
	margin-top: 5px;
	word-break: break-all;
	word-wrap: break-word;
	color: black;
}
.comment-list .comment .comment-content .update {
	display: none;
	margin: 0;
}
.comment-list .comment .comment-content .update div {
	margin-top: 5px;
	padding-left: 0;
}
.comment-list .comment .comment-content .update .update-input {
	width: 100%;
	height: 40px;
}
.comment-list .comment .comment-content .update .w3-button {
	width: 100%;
	height: 40px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
	color: white;
}
.comment-list .comment .comment-content .function {
	margin-top: 5px;
}
.comment-list .comment .comment-ellipsis {
	position: relative;
	padding: 10px;
}
.comment-list .comment .comment-ellipsis i {
	color: gray;
	text-align: center;
	cursor: pointer;
}
.comment-list .comment .comment-ellipsis .dropdown {
	display: none;
	list-style-type: none;
	position: absolute;
	left: -1px;
	margin: 0;
	padding: 0;
	border: 1px solid #D5D5D5;
	background-color: white;
}
.comment-list .comment .comment-ellipsis .dropdown li {
	padding: 5px;
}
.comment-list .comment .comment-ellipsis .dropdown li i:hover {
	color: rgba(17, 135, 207, 0.4);
}
.comment-list .comment .comment-content .function button {
	width: 70px;
	height: 30px;
	padding: 0;
}
.comment-list .recomment-lists {
	display: none;
}
.comment-list .recomment-list {
	list-style-type: none;
	margin: 0;
	margin-top: 5px;
	padding: 0;
	overflow: hidden;
}
.comment-list .recomment-list .recomment {
	display: flex;
	min-height: 100px;
}
.comment-list .recomment-list .recomment .recomment-arrow {
	padding: 10px;
}
.comment-list .recomment-list .recomment .recomment-arrow i {
	color: rgba(17, 135, 207, 0.4);
}
.comment-list .recomment-list .recomment .recomment-box {
	display: flex;
	flex-grow: 1;
	padding: 10px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(246, 246, 246, 0.3);
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile {
	position: relative;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile .profile {
	width: 50px;
	height: 50px;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-radius: 50%;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile .badge {
	position: absolute;
	top: 0;
	left: 0;
	padding: 1px;
	border: 1px solid rgba(242, 150, 97, 0.4);
	border-radius: 5px;
	background-color: rgba(242, 150, 97, 0.4);
	color: white;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile .badge.writer {
	border: 1px solid rgba(17, 135, 207, 0.4);
	background-color: rgba(17, 135, 207, 0.4);
}
.comment-list .recomment-list .recomment .recomment-box .recomment-profile .profile-none {
	width: 50px;
	height: 50px;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content {
	padding: 10px;
	flex-grow: 1;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .nickname {
	font-size: 13pt;
	font-weight: bold;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .id {
	padding-right: 5px;
	color: gray;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate {
	color: gray;
	font-size: 10pt;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m {
	display: none;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-content .content {
	margin-top: 5px;
	word-break: break-all;
	word-wrap: break-word;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis {
	position: relative;
	padding: 10px;
	text-align: center;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis i {
	color: gray;
	cursor: pointer;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown {
	display: none;
	list-style-type: none;
	position: absolute;
	left: 0;
	margin: 0;
	padding: 0;
	border: 1px solid #D5D5D5;
	background-color: white;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown li {
	padding: 5px;
}
.comment-list .recomment-list .recomment .recomment-box .recomment-ellipsis .dropdown li i:hover {
	color: rgba(17, 135, 207, 0.4);
}
.pagination-box {
	display: flex;
	justify-content: center;
	list-style-type: none;
	margin: 0;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
	padding: 0;
	overflow: hidden;
}
.pagination-box.m {
	display: none;
}
.pagination-box li {
	min-width: 30px;
	padding: 3px;
	text-align: center;
	border: 1px solid rgba(17, 135, 207, 0.4);
	border-right: none;
	background-color: white;
	color: rgba(17, 135, 207, 0.4);
	cursor: pointer;
}
.pagination-box li:hover {
	background-color: rgba(246, 246, 246, 0.5);
}
.pagination-box li.pagination-last {
	border-right: 1px solid rgba(17, 135, 207, 0.4);
}
.pagination-box li.active {
	border: 1px solid transparent;
	background-color: rgba(17, 135, 207, 0.4);
/* 	border: none;
	border-top: 1px solid rgba(17, 135, 207, 0.4);
	border-bottom: 1px solid rgba(17, 135, 207, 0.4); */
	color: white;
	cursor: default;
}
.pagination-box li.next {
	border-left: 1px solid transparent;
}
figure {
	margin-bottom: 0;
}
figure .embedly-card-hug {
	max-width: 1000px !important;
	margin: 0 !important;
}
figure .embedly-card-hug iframe {
	width: 100% !important;
}
@media (max-width:767px) {
	.margin-top {
		margin-top: 0 !important;
	}
	.margin-card {
		margin-right: 0 !important;
		margin-bottom: 5px !important;
	}
	.last {
		margin-bottom: 5px !important;
	}
	#btn-comment-write {
		display: none;
	}
	.comment-write .comment-write-input-m {
		display: block;
	}
	.recomment-write .row .nonmember-nickname .wrapper {
		margin-right: 0;
	}
	.recomment-write .row .nonmember-password .wrapper {
		margin-left: 0;
	}
}
@media (max-width:438px) {
	.comment-list .comment .comment-content .regdate {
		display: none;
	}
	.comment-list .comment .comment-content .regdate-m {
		display: block;
	}
	.comment-list .comment .comment-content .regdate-m .regdate.m {
		display: block;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate {
		display: none;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m {
		display: block;
	}
	.comment-list .recomment-list .recomment .recomment-box .recomment-content .regdate-m .regdate.m {
		display: block;
	}
}
@media (max-width:413px) {
	.pagination-box {
		display: none;
	}
	.pagination-box.m {
		display: flex;
	}
}
</style>
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
<div class="viewWrapper">
	<div class="subject">
		<h2>${portfolio.pot_subject}</h2>
	</div>
	<div class="description">
		${portfolio.pot_description}
	</div>
	<hr>
	<ul class="dev-list">
		<li><h5>개발기간</h5></li>
		<li>
			<ul class="dev-list-content">
				<li class="start">
					<span class="date-badge start">시작</span>
					<span id="start-date">${portfolio.pot_startdate}</span>
				</li>
				<li class="end">
					<span class="date-badge end">종료</span>
					<span id="end-date">${portfolio.pot_enddate}</span>
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요기능</h5></li>
		<li>
			<ul class="dev-list-content">
				<li id="summary">
					${portfolio.pot_summary}
				</li>
			</ul>
		</li>
	</ul>
	<ul class="dev-list w3-margin-top">
		<li><h5>주요환경</h5></li>
		<li>
			<ul class="row">
				<li>
					${portfolio.pot_environment}		
				</li>
			</ul>
		</li>
	</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>동영상</h5></li>
	<li>
		<ul class="dev-list-content">
			<li>
				${portfolio.pot_video}
			</li>
		</ul>
	</li>
</ul>
<ul class="dev-list w3-margin-top">
	<li><h5>Demo / GitHub</h5></li>
	<li>
		<ul class="row">
			<li>
				${portfolio.pot_source}
			</li>
		</ul>
	</li>
</ul>
</div>
<div class="recommend-box">
	<button id="btn-next" class="w3-button w3-white w3-border"><i class="far fa-thumbs-up"></i> <span>0</span></button>
</div>
<div class="profile-box">
	<div class="profile-inner">
		<div class="profile-image">
			<span class="badge">작성자</span>
			<c:choose>
				<c:when test="${not empty portfolio.mem_profile}">
					<img class="profile" src="${pageContext.request.contextPath}/resources/upload/${portfolio.mem_profile}"/>
				</c:when>
				<c:otherwise>
					<img class="profile-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="profile-content">
			<div class="content-1">
				<span class="nickname">${portfolio.mem_nickname}</span><span class="id">(${portfolio.mem_id})</span>
			</div>
			<div class="content-2">
				<i class="fas fa-envelope"></i> <span class="email">${portfolio.mem_email}</span>
			</div>
			<div class="content-3">
				<i class="fas fa-clock"></i> <span id="regdate" class="regdate">${portfolio.pot_regdate}</span>
			</div>
		</div>
	</div>
</div>
<div class="comment-title">
	<i class="far fa-comments"></i> 댓글 <span id="comment-count-all" class="w3-badge">0</span>
</div>
<div class="comment-write">
	<s:authorize access="!isAuthenticated()">
		<div class="comment-write-nonmember">
			<div class="row">
				<div class="nonmember-nickname col-md-6">
					<div class="wrapper">
						<div>닉네임</div>
						<input id="comment-nickname" type="text" placeholder="닉네임을 입력해주세요."/>
					</div>
				</div>
				<div class="nonmember-password col-md-6">
					<div class="wrapper">
						<div>비밀번호</div>
						<input id="comment-password" type="password" placeholder="비밀번호를 입력해주세요."/>
					</div>
				</div>
			</div>
		</div>
		<div class="comment-write-input">
			<textarea id="comment-content" placeholder="내용을 입력해주세요."></textarea>
			<button id="btn-comment-write" class="w3-button" onclick="nonmemberCommentWrite();">작성</button>
		</div>
		<div class="comment-write-input-m">
			<button id="btn-comment-write-m" class="w3-button" onclick="nonmemberCommentWrite();">작성</button>
		</div>
	</s:authorize>
	<s:authorize access="isAuthenticated()">
		<div class="comment-write-input">
			<textarea id="comment-content" placeholder="내용을 입력해주세요."></textarea>
			<button id="btn-comment-write" class="w3-button" onclick="memberCommentWrite();">작성</button>
		</div>
		<div class="comment-write-input-m">
			<button id="btn-comment-write-m" class="w3-button" onclick="memberCommentWrite();">작성</button>
		</div>
	</s:authorize>
</div>
<div class="comment-list-box">
<ul id="comment-list" class="comment-list">
	<li class="comment">
		<div class="comment-profile">
			<span class="badge">비회원</span>
			<img class="profile-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
		</div>
		<div class="comment-content">
			<span class="nickname">테스트</span><span class="id">(test13585)</span><span class="regdate">2019-05-16 02:36</span>
			<div class="regdate-m">
				<span class="regdate m">2019-05-16 02:36</span>
			</div>
			<div class="content">
				테스트입니다.
			</div>
			<div class="function">
				<button class="w3-button w3-white w3-border" onclick="openRecomment(1);">답글 (<span>0</span>)</button>
				<div id="recomment-write-1" class="recomment-write">
					<div class="recomment-write-nonmember">
						<div class="row">
							<div class="nonmember-nickname col-md-6">
								<div class="wrapper">
									<div>닉네임</div>
									<input type="text" placeholder="닉네임을 입력해주세요."/>
								</div>
							</div>
							<div class="nonmember-password col-md-6">
								<div class="wrapper">
									<div>비밀번호</div>
									<input type="text" placeholder="비밀번호를 입력해주세요."/>
								</div>
							</div>
						</div>
					</div>
					<div class="recomment-write-input">
						<textarea placeholder="내용을 입력해주세요."></textarea>
					</div>
					<div class="recomment-write-button">
						<button class="w3-button">닫기</button>
						<button id="btn-recomment-write" class="w3-button">작성</button>
					</div>
				</div>
			</div>
		</div>
		<div class="comment-ellipsis">
			<i class="fas fa-ellipsis-v" onclick="openCommentDropdown(1);"></i>
			<ul id="comment-dropdown-1" class="dropdown">
				<li><i class="fas fa-pen"></i></li>
				<li><i class="fas fa-trash-alt"></i></li>
			</ul>
		</div>
	</li>
	<li id="recomment-list-1" class="recomment-lists">
		<ul class="recomment-list">
			<li class="recomment">
				<div class="recomment-arrow">
					<i class="fas fa-location-arrow fa-2x"></i>
				</div>
				<div class="recomment-box">
					<div class="recomment-profile">
						<span class="badge">비회원</span>
						<img class="profile-none" src="${pageContext.request.contextPath}/resources/image/main/user.png"/>
					</div>
					<div class="recomment-content">
						<span class="nickname">테스트</span><span class="id">(test13585)</span><span class="regdate">2019-05-16 02:36</span>
						<div class="regdate-m">
							<span class="regdate m">2019-05-16 02:36</span>
						</div>
						<div class="content">
							안녕입니다.
						</div>
					</div>
					<div class="recomment-ellipsis">
						<i class="fas fa-ellipsis-v" onclick="openReCommentDropdown(1);"></i>
						<ul id="recomment-dropdown-1" class="dropdown">
							<li><i class="fas fa-trash-alt"></i></li>
						</ul>
					</div>
				</div>
			</li>
		</ul>
	</li>
</ul>
</div>
<ul class="pagination-box">
</ul>
<ul class="pagination-box m">
	<li>이전</li>
	<li class="pagination-last">다음</li>
</ul>