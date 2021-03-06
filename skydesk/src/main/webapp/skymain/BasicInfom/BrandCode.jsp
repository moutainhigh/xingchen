<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0"> 
<meta name="renderer" content="webkit|ie-comp|ie-stand" /> 
<meta http-equiv="X-UA-Compatible"  content="IE=edge,chrome=1">
<title>品牌编码</title>
<link rel="stylesheet" href="/skydesk/css/icon.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/skystyle.min.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/pagination.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/demo.min.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/msgbox.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<script type="text/javascript" src="/skydesk/js/msgbox.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="http://win.skydispark.com/skyasset/js/jquery.min.js"></script>
<script type="text/javascript" src="http://win.skydispark.com/skyasset/js/decimal.min.js"></script>
<script type="text/javascript" src="/skydesk/js/jquery.easyui.min.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/easyui-lang-zh_CN.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/jquery.fyutils.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/regexp.js?ver=<%=tools.DataBase.VERSION%>"></script>
</head>
<body class="easyui-layout layout panel-noscroll">
<!-- 工具栏 -->
<div id="toolbars" class="toolbar">
<div class="toolbar_box1">
<div class="fl">
	<input class="btn1" type="button" value="添加" onclick="addbrandd()">
	<input type="button" class="btn1" id="updatebtn" value="编辑" onclick="updatebrandd()">
	<input type="text" data-end="yes" placeholder="输入品牌名称或简称<回车搜索>" class="ipt1" id="qsbrandvalue" maxlength="20" data-enter="getbranddata()">
<!-- 	<input type="button" id="highsearch" class="btn2" value="高级搜索▼" onclick="toggle()"> -->
</div>
<div class="fl hide" id="searchbtn">
	<input type="button" class="btn2" type="button" value="搜索" onclick="searchbrand();toggle();"> 
	<input type="button" class="btn2" style="width: 100px;" value="清空搜索条件" onclick="resetsearch()">
</div>
<div class="fr">
	<input type="button" class="btn3"  value="导入" onclick="openimportd()"> 
	<span class="sepreate"></span>
	<input type="button" class="btn3" type="button" value="导出" id="odser" onclick="fyexportxls('#pp_total','#gg',currentdata,'api',0);">
</div>
</div>
<!-- 高级搜索栏 -->
<div class="searchbar" style="display: none" data-enter="searchbrand();toggle();">
	<input type="hidden" id="sbrandid">
	<div class="search-box">
	<div class="s-box">
		<div class="title">品牌名称</div>
		<div class="text"><input class="wid160 hig25" id="sbrandname" maxlength="20" type="text" placeholder="<输入>"></div>
	</div>
	<div class="s-box">
	<div class="title">状态</div>
		<div class="text">
		<label>
		<input type="radio" name="snouse" id="st1" value="0">在用
		</label>
		<label>
		<input type="radio" name="snouse" id="st2" value="1">禁用
		</label>
		<label>
		<input type="radio" name="snouse" id="st3" value="2" checked>所有
		</label>
		</div>
	</div>
	</div>
</div>
</div>
<table id="gg" style="overflow: hidden;"></table>
<!-- 分页 -->
<div class="page-bar">
	<div class="page-total">
	共有<span id="pp_total">0</span>条记录
</div>
<div id="pp" class="tcdPageCode page-code"></div>
</div>
<!-- 修改品牌窗 -->
<div id="ud" title="<span id='udtitle'>编辑品牌</span>" style="width: 350px; height: 200px;" class="easyui-dialog" closed=true>
	<div style="margin-top: 20px; text-align: center;">
	<table class="table1" cellspacing="10">
	<tr>
	<td class="header skyrequied" align="right">
	品牌名称
	</td>
	<td>
	<input type="hidden" id="ubrandid">
	<input type="hidden" id="uindex">
	<input class="hig25 wid160" type="text" placeholder="<输入>" name="ubrandname" id="ubrandname" maxlength="20" /> 
	</td>
	</tr>
	<tr>
	<td colspan="2" align="center">
	<label id="showqxkz"><input type="checkbox" id="ualluser" >授权所有职员</label>
	</td>
	</tr>
	</table>
	</div>
	<div class="dialog-footer textcenter">
		<label class="updateshow"><input type="checkbox" name="unoused" id="unoused">禁用</label>
		<input type="button" id="savebtn" class="btn1"  name="updatebrand" value="保存" onclick="savebrand()">
		<input type="button" class="btn2" name="close" value="取消" onclick="$('#ud').dialog('close')"> 
	</div>
</div>
<!-- 职员授权-->
<div id="epsqd" title="授权职员" style="width: 400px;text-align:center; height: 500px" class="easyui-dialog" closed=true>			
	<table id="epsqt" style="overflow:hidden"></table>
	<div class="dialog-footer textcenter">
	<div id="epsqpp" class="tcdPageCode fl"></div> 
	</div>
</div>
<script type="text/javascript" charset="UTF-8">
//权限设置
setqxpublic();
var pgid= "pg1001";
var _levelid= getValuebyName("GLEVELID");
//当浏览器窗口大小改变时，设置显示内容的高度  
window.onresize = function() {
	changeDivHeight();
}
function changeDivHeight() {
	var height = document.documentElement.clientHeight; //获取页面可见高度  
	$('#gg').datagrid('resize', {
		height: height - 50
	});
}
var searchb = false;
function toggle() {
	if (searchb) {
		$('#highsearch').val('高级搜索▼');
		searchb = false;
		$('#searchbtn').hide();
	} else {
		$('#highsearch').val('高级搜索▲');
		searchb = true;
		$('#searchbtn').show();
	}
	$('.searchbar').slideToggle('fast');
	$('#sbrandname').focus();

}
//清空搜索条件
function resetsearch() {
	$('#st3').prop('checked', true);
	var idstr = "#sbrandname";
	$(idstr).val('');
}
//添加框
function addbrandd() {
	$("#udtitle").html("添加品牌");
	$("#savebtn").val("保存并继续");
	$('#ud').dialog('open');
	$('#ubrandname,#ubrandid,#uindex').val("");
	$("#ualluser").removeProp("checked");
	$(".updateshow").hide();
	$('#ubrandname').focus();
}
//编辑框
function updatebrandd() {
	var row = $('#gg').datagrid('getSelected');
	if (!row) {
		alerttext("请选择一行数据，进行编辑!");
	} else {
		var noused = row.NOUSED;
		$("#udtitle").html("编辑品牌");
		$("#savebtn").val("保存");
		$(".updateshow").show();
		$('#ud').dialog('open');
		$('#ubrandname').focus();
		$('#ubrandname').val(row.BRANDNAME);
		$('#ubrandid').val(row.BRANDID);
		if (noused != 0) {
			$('#unoused').prop('checked', true);
		} else {
			$('#unoused').removeProp('checked');
		}
		$("#ualluser").removeProp("checked");
	}
}
$(function() {
	if(qxkz==0||(_levelid != 0 && _levelid != 5) ) $("#showqxkz").hide();
	
	$("#pp").createPage({
		pageCount: 1,
		current: 1,
		backFn: function(p) {
			getbrandlist(p);
		}
	});
	//加载数据
	$('#gg').datagrid({
		idField: 'BRANDID',
		height: $("body").height() - 50,
		fitColumns: true,
		striped: true,
		//隔行变色
		singleSelect: true,
// 		sortName: "BRANDNAME",
// 		sortOrder: "asc",
		columns: [[{
			field: 'BRANDID',
			title: '品牌ID',
			fieldtype: "G",
			width: 200,
			expable: true,
			hidden: true
		},{
			field: 'ROWNUMBER',
			title: '序号',
			width: 50,
			fixed: true,
			align: 'center',
			halign: 'center',
			formatter: function(value, row, index) {
				var p = $("#pp").getPage() - 1;
				return p * pagecount + index + 1;
			}
		},
		{
			field: 'BRANDNAME',
			title: '品牌',
			width: 200,
// 			sortable: true,
			fixed: true,
			halign: "center",
			align: 'center'
		},{
			field: 'NOUSED',
			title: '禁用',
			width: 80,
			fixed: true,
// 			sortable: true,
			fieldtype: "G",
			align: 'center',
			halign: 'center',
			formatter: function(value, row, index) {
				var nouse = Number(value);
				var checked = "";
				if (nouse == 1) checked = "checked";
				if (isNaN(nouse)) return "";
				return '<input type="checkbox" id="disabledcheckin_' + index + '" class="m-btn" onchange="disabledbrand(' + index + ')" ' + checked + '>';
			}
		},{
			field: 'ACTION',
			title: '操作',
			width: 150,
			fixed: true,
			align: 'center',
			halign: 'center',
			formatter: function(value, row, index) {
				var html = '<input type="button" class="m-btn" value="删除" onclick="delbrand(' + index + ')">';
				if(qxkz==1)
					html += '<input type="button" class="m-btn" value="授权职员" onclick="setepd(' + row.BRANDID + ')">';
				return html;
			}
		}]],
		onSortColumn: function(sort, order) {
			$('#pp').refreshPage();
		},
		onClickRow: function(index, row) {
			$('#uindex').val(index);
		},
		onDblClickRow: function(rowIndex, rowData) {
			updatebrandd();
		},
		pageSize: 20,
		toolbar: '#toolbars'
	}).datagrid("keyCtr", "updatebrandd()");
	setept();
	getbranddata();
	uploader_xls_options.uploadComplete = function(file){
		$('#pp').refreshPage();
	}
	uploader_xls = SkyUploadFiles(uploader_xls_options);
	setuploadserver({
		server: "/skydesk/fyimportservice?importser=appendbrand",
		xlsmobanname: "brandcode",
		channel: "brandcode"
	});
});

var currentdata = {};
var getbrandlist = function(page) {
	var $dg = $("#gg");
	var options = $dg.datagrid("options");
// 	var sort = options.sortName;
// 	var order = options.sortOrder;
	currentdata["erpser"] = "brandlist";
// 	currentdata["sort"] = sort;
// 	currentdata["order"] = order;
	currentdata["noused"] = 2;
	currentdata["rows"] = pagecount;
	currentdata["page"] = page;
	$dg.datagrid('loadData', nulldata);
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: currentdata,
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					$("#pp").setPage({
						pageCount: Math.ceil(data.total / pagecount),
						current: Number(page)
					});
					$dg.datagrid('loadData', data);
					$('#pp_total').html(data.total);
				}
			} catch(e) {
				// TODO: handle exception
				console.error(e);
				top.wrtiejsErrorLog(e);
			}
		}
	});
}
//搜索
function getbranddata() {
	var value = $('#qsbrandvalue').val();
	alertmsg(6);
	currentdata = {
		findbox: value
	};
	getbrandlist(1);
}
//搜索品牌
function searchbrand() {
	var brandname = $('#sbrandname').val();
	var noused = 0;
	if ($('#st1').prop('checked')) noused = "0";
	else if ($('#st2').prop('checked')) noused = "1";
	else noused = "2";
	alertmsg(6);
	currentdata = {
		brandname: brandname,
		noused: noused
	};
	getbrandlist(1);
}
//添加品牌
function savebrand() {
	var index = $("#uindex").val();
	var brandid = Number($("#ubrandid").val());
	var brandname = $('#ubrandname').val();
	if (brandname == "") {
		alerttext("品牌名不能为空");
		return;
	}
	var erpser = "addbrand";
	var noused = 0;
	if (brandid > 0){
		erpser = "updatebrandbyid";
		noused = $("#unoused").prop("checked") ? 1 : 0;
	}
	var alluser = 0;
	if($("#ualluser").prop("checked")&&(_levelid == 0 || _levelid == 5)) alluser = 1;
	alertmsg(2);
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: erpser,
			brandid: brandid,
			brandname: brandname,
			alluser: alluser,
			noused: noused
		},
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值
			try {
				if (valideData(data)) {
					var $dg = $("#gg");
					if (brandid == 0) {
						brandid = data.msg;
						$dg.datagrid('insertRow', {
							index: 0,
							row: {
								ROWNUMBER: 1,
								BRANDID: brandid,
								BRANDNAME: brandname,
								NOUSED: noused
							}
						}).datagrid('refresh');
						var total = Number($("#pp_total").html());
						if (!isNaN(total)) $("#pp_total").html(total + 1);
						$('#ubrandname').val("").focus();
					} else {
						$dg.datagrid('updateRow', {
							index: index,
							row: {
								BRANDID: brandid,
								BRANDNAME: brandname,
								NOUSED: noused
							}
						}).datagrid('refresh');
						$("#ud").dialog("close");
					}
				}
			} catch(e) {
				// TODO: handle exception
				console.error(e);top.wrtiejsErrorLog(e);
			}
		}
	});
}
function disabledbrand(index) {
	var $dg = $("#gg");
	var rows = $dg.datagrid("getRows");
	if (rows.length > 0) {
		var row = rows[index];
		var brandid = row.BRANDID;
		var $check = $('#disabledcheckin_' + index);
		var noused = 0;
		if ($check.prop('checked')) noused = 1;
		alertmsg(2);
		$.ajax({
			type: "POST",
			//访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp",
			//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "updatebrandbyid",
				brandid: brandid,
				noused: noused
			},
			//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				try {
					if (valideData(data)) {
						$dg.datagrid('updateRow', {
							index: index,
							row: {
								NOUSED: noused
							}
						});
					}
					$dg.datagrid('refresh');
				} catch(e) {
					// TODO: handle exception
					console.error(e);top.wrtiejsErrorLog(e);
				}
			}
		});
	}
}
//删除
function delbrand(index) {
	var $dg = $("#gg");
	var rows = $dg.datagrid("getRows");
	if (rows.length > 0) {
		var row = rows[index];
		var brandid = row.BRANDID;
		$.messager.confirm(dialog_title, '您确认要删除品牌' + row.BRANDNAME + '？',
		function(r) {
			if (r) {
				alertmsg(2);
				$.ajax({
					type: "POST",
					//访问WebService使用Post方式请求 
					url: "/skydesk/fyjerp",
					//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
					data: {
						erpser: "delbrandbyid",
						brandid: brandid
					},
					//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
					dataType: 'json',
					success: function(data) { //回调函数，result，返回值 
						try {
							if (valideData(data)) {
								$dg.datagrid("deleteRow", index).datagrid("refresh");
								var total = Number($("#pp_total").html());
								if (!isNaN(total)) $("#pp_total").html(total - 1);
							}
						} catch(e) {
							// TODO: handle exception
							console.error(e);top.wrtiejsErrorLog(e);
						}
					}
				});
			}
		});
	}
}
function getbrandep(page) {
	var brandid = $('#ubrandid').val();
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "brandemployelist",
			brandid: brandid,
			rows: pagecount,
			page: page
		},
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				var total = data.total;
				$('#epsqpp').setPage({
					pageCount: Math.ceil(total / pagecount),
					current: Number(page)
				});
				check = false;
				$('#epsqt').datagrid('loadData', data);
				check = true;

			}
		}
	});
}
function setepd(brandid) {
	$('#ubrandid').val(brandid);
	$('#epsqd').dialog('open');
	getbrandep('1');
}
function setbrandep(epid, value,index) {
	alertmsg(2);
	var row = $("#gg").datagrid("getSelected");
	var brandid = $('#ubrandid').val();
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "writeemployebrand",
			epid: epid,
			brandid: brandid,
			value: value
		},
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) {
			if (valideData(data)) {
				$("#epsqt").datagrid("updateRow",{
					index: index,
					row:{
						SELBJ: value
					}
				});
			}
			$("#epsqt").datagrid("refreshRow",index);
		}
	});
}
function setallep(value) {
	var brandid = $('#ubrandid').val();
	alertmsg(2);
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "writeallbrandemploye",
			brandid: brandid,
			value: value
		},
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) {
			if (valideData(data)) {
				$("#epsqpp").refreshPage();
			}
		}
	});
}
var check = false;
function setept() {
	$('#epsqpp').createPage({
		current: 1,
		backFn: function(p) {
			getbrandep(p);
		}
	});
	$('#epsqt').datagrid({
		idField: 'EPID',
		height: 410,
		fitColumns: true,
		striped: true,
		//隔行变色
		singleSelect: true,
		columns: [[{
			field: 'ROWNUMBER',
			title: '序号',
			width: 50,
			fixed: true,
			align: 'center',
			halign: 'center',
			formatter: function(value, row, index) {
				return index + 1;
			}
		},
		{
			field: 'EPNAME',
			title: '职员',
			width: 100,
			fixed: true,
			align: 'center',
			halign: 'center'
		},
		{
			field: 'CHECK',
			checkbox: true,
			fixed: true,
			width: 50
		}]],
		selectOnCheck: false,
		checkOnSelect: false,
		pageSize: 10,
		onCheck: function(index, row) {
			if (check) {
				setbrandep(row.EPID, '1',index);
			}
		},
		onUncheck: function(index, row) {
			if (check) {
				setbrandep(row.EPID, '0',index);
			}
		},
		onCheckAll: function(index, row) {
			if (check) {
				setallep('1');
			}
		},
		onUncheckAll: function(index, row) {
			if (check) {
				setallep('0');
			}
		},
		onLoadSuccess: function(data) {
			check = false;
			if (data) {
				$.each(data.rows,
				function(index, item) {
					if (item.SELBJ == '1') {
						$('#epsqt').datagrid('checkRow', index);
					} else $('#epsqt').datagrid('uncheckRow', index);
				});
				check = true;
				if (_levelid == '0' ||  _levelid == '5') {
					$('.datagrid-cell-check input[type=checkbox],.datagrid-header-check input[type=checkbox]').removeAttr('disabled');
				} else {
					$('.datagrid-cell-check input[type=checkbox],.datagrid-header-check input[type=checkbox]').prop('disabled', true);
				}
			}
		}
	});
}
</script>
<jsp:include page="../HelpList/ImportHelp.jsp"></jsp:include>
</body>
</html>