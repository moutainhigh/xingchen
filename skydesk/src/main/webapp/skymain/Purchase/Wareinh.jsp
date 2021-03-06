
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> `
<meta http-equiv="expires" content="0"> 
<meta name="renderer" content="webkit|ie-comp|ie-stand" /> 
<meta http-equiv="X-UA-Compatible"  content="IE=edge,chrome=1">
<title>采购入库</title>
<script type="text/javascript" src="/skydesk/js/msgbox.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="http://win.skydispark.com/skyasset/js/jquery.min.js"></script>
<script type="text/javascript" src="http://win.skydispark.com/skyasset/js/decimal.min.js"></script>
<script type="text/javascript" src="http://win.skydispark.com/skyasset/webuploader/webuploader.min.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/jquery.easyui.min.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/easyui-lang-zh_CN.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/jquery.fyutils.js?ver=<%=tools.DataBase.VERSION%>"></script>
<script type="text/javascript" src="/skydesk/js/regexp.js?ver=<%=tools.DataBase.VERSION%>"></script>
<link rel="stylesheet" href="/skydesk/css/icon.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/skystyle.min.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/pagination.min.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/demo.min.css?ver=<%=tools.DataBase.VERSION%>" type="text/css" />
<link rel="stylesheet" href="/skydesk/css/msgbox.min.css?ver=<%=tools.DataBase.VERSION%>" />
</head>
<body class="easyui-layout layout panel-noscroll" >
	<!-- 工具栏 -->
<div id="toolbars" class="toolbar">
<div class="toolbar_box1">
	<div class="fl">
	<input class="btn1" type="button" id="addnotebtn" value="添加" onclick="addnoted()">
	<a class="btn1" href="javascript:void(0)" id="gysfhnum" onclick="openselloutd()">供应商发货</a>
	<input type="button" class="btn1" id="updatebtn" value="编辑" onclick="updatenoted()">
	<input  type="text" placeholder="搜索单据号、供应商、摘要<回车搜索>" data-end="yes" class="ipt1" id="qsnotevalue" maxlength="20"  data-enter="getnotedata()"><input type="button" id="highsearch" class="btn2"value="高级搜索▼" onclick="toggle()">
	</div>
	<div class="fl hide" id="searchbtn" style="width:20%"><input type="button" class="btn2" type="button" value="搜索" onclick="searchnote();toggle();"> 
	<input type="button" class="btn2" style="width: 100px;" value="清空搜索条件" onclick="resetsearch()">
	</div>
	<div class="fr">
	<input type="button" class="btn3" type="button" value="导出" id="odser" onclick="fyexportxls('#pp_total','#gg',currentdata,'api',0);">
	</div>
</div>
<!-- 高级搜索栏 -->
<div class="searchbar" style="display: none" data-enter="searchnote();toggle();">
<input type="hidden" id="swareid">
<input type="hidden" name="sprovid" id="sprovid"> 
<input type="hidden" name="shouseid" id="shouseid"> 
<div class="search-box">
<div class="s-box"><div class="title">开始日期</div>
<div class="text">
<input type="text" name="smindate" id="smindate" placeholder="<输入>" style="width: 162px;height:29px" class="easyui-datebox">
</div>
</div>
<div class="s-box"><div class="title">结束日期</div>
<div class="text">
<input type="text" name="smaxdate" id="smaxdate" placeholder="<输入>" style="width: 162px;height:29px" class="easyui-datebox">
</div>
</div>
<div class="s-box"><div class="title" style="color:#ff7900">*&nbsp;店铺</div>
<div class="text">
<input class="edithelpinput house_help" id="shousename" type="text" data-value="#shouseid"><span class="s-btn" onclick="selecthouse('search')"></span>
</div>
</div>

<div class="s-box"><div class="title" style="color:#ff7900">*&nbsp;供应商</div>
<div class="text">
<input class="edithelpinput provd_help" id="sprovname" type="text" data-value="#sprovid"><span class="s-btn" onclick="selectprov('search')"></span>
</div>
</div>

<div class="s-box"><div class="title">货号</div>
<div class="text">
<input class="edithelpinput" id="swareno" type="text" data-value="#swareid"><span class="s-btn" onclick="selectware('search')"></span>
</div></div>
<div class="s-box"><div class="title">自编号</div>
<div class="text">
<input class="hig25 wid160" type="text" name="shandno" id="shandno" placeholder="<输入>" >
</div>
</div>
<div class="s-box"><div class="title">摘要</div>
<div class="text">
<input class="hig25 wid160" type="text" name="sreamrk" id="sremark" placeholder="<输入>" >
</div>
</div>
<div class="s-box"><div class="title">采购订单</div>
<div class="text">
<input class="hig25 wid160" type="text" name="sorderno" id="sorderno" placeholder="<输入>" >
</div>
</div>
<div class="s-box"><div class="title">制单人</div>
<div class="text">
<input class="hig25 wid160" type="text" name="soperant" id="soperant" placeholder="<输入>" >
</div>
</div>
<div class="s-box">
<div class="title">单据状态</div>
	<div class="text">
	<label>
	<input type="radio" name="sstatetag" id="st3" value="2" checked="checked">所有
	</label>
	<label>
	<input type="radio" name="sstatetag" id="st1" value="0">未提交
	</label>
	<label>
	<input type="radio" name="sstatetag" id="st2" value="1">已提交
	</label>
	</div>
</div>
</div>
</div>
</div>
<table id="gg" style="overflow: hidden;height:900px"></table>
<!-- 分页 -->
<div class="page-bar">
	<div class="page-total">共有<span id="pp_total">0</span>条记录</div>
	<div id="pp" class="tcdPageCode page-code">
	</div>
</div>
<!-- 添加与修改采购入库表单 -->
<div id="ud" title="修改采购入库单" style="width: 100%;height:100%" class="easyui-dialog" closed="true" data-qickey>
<div id="udtool">
	<span id="updatingbar">
	<span><input class="btn4" type="button" data-btn="updatebtn" id="update" value="提交" onclick="updatewareinh(false)"></span>
	<span><input class="btn4" type="button" data-btn="updatebtn" id="pay" value="付款" onclick="openpay()"></span>
<!-- 	<span class="sepreate"></span> -->
<!-- 	<span><input class="btn4" type="button" id="load" value="载入" onclick="loadcg($('#uprovid').val())"></span> -->
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="load" value="载入采购订单" onclick="openprovorderd()"></span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="delete" value="导入" onclick="openimportd()"></span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="delete" value="删除单据" onclick="delwareinh()"></span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="discount" value="整单打折" onclick="opendisc()"></span>
	</span>
	<span id="isupdatedbar">
	<span><input class="btn4" type="button" id="paydetail" value="付款明细" onclick="openpaydetail()"></span>
	<span class="sepreate" id="sep-withdraw"></span>
	<span><input class="btn4" type="button" id="withdrawbtn" value="撤单" onclick="withdraw()"></span>	
	<span id="clearnotebar">
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="clearbtn" value="冲单" onclick="clearnote(0,$('#unoteno').val())"></span>
	</span>
	<span class="paynote">
	<span class="sepreate"></span>
	<span><input class="btn4 paynote" type="button" id="paynotebtn" value="付款记录" onclick="openpaynoted()"></span>
	</span>
	</span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="print" value="后台打印"></span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="selprint" value="选择打印端口" onclick="selprint()"></span>
	<span class="sepreate"></span>
	<input type="button" class="btn4" value="导出明细" onclick="openexportdialog()">
	<span id="copynotebar">
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="copybtn" value="复制单据" onclick="setfromnoteno($('#unoteno').val())"></span>
	<span class="sepreate"></span>
	<span><input class="btn4" type="button" id="pastebtn" value="粘贴单据" onclick="copynote(0,$('#unoteno').val())"></span>
	</span>
	<!-- 单据提交框 -->
<div id="udnote">
	<form id="udnoteform" action="" method="get">
	<input type="hidden" id="uid"> 
	<input type="hidden" id="untid">
	<input type="hidden" id="uistoday"> 
	<input type="hidden" id="ustatetag"> 
	<input type="hidden" id="uhouseid"> 
	<input type="hidden" id="uprovid">
	<input type="hidden" id="udiscount"> 
	<input type="hidden" id="upricetype">
	<input type="hidden" id="wtotalamt">
	<input type="hidden" id="wtotalcurr">
	<div class="search-box">
	<div class="s-box"><div class="title">单据号</div>
<div class="text"><input class="hig25 wid160" type="text" id="unoteno" readonly>
</div>
</div>
	<div class="s-box"><div class="title">日期</div>
<div class="text">
	   <input id="unotedate" type="text" style="width: 162px;height:29px" class="easyui-datetimebox" data-options="showSeconds:true,readonly:true,hasDownArrow:false,onShowPanel: setTodayDate,onHidePanel: changedate">
</div>
</div>
	<div class="s-box"><div class="title" style="color:#ff7900">*&nbsp;店铺</div>
<div class="text"><input class="edithelpinput house_help" type="text" id="uhousename" data-value="changenotehouse"><span onclick="selecthouse('update')"></span>
</div>
</div>
	<div class="s-box"><div class="title" style="color:#ff7900">*&nbsp;供应商</div>
<div class="text"><input class="edithelpinput provd_help" type="text" id="uprovname" data-value="changenoteprov" placeholder="---请选择---" ><span id="selprovspan" onclick="selectprov('update')" ></span>
</div>
</div>
<div class="s-box"><div class="title">费用</div>
	<div class="text"><input maxlength="16" type="text" autocomplete="off" class="edithelpinput" id="usaletotalcost" value="0" readonly><span onclick="selectsalecost()"></span>
</div>
</div>
	<div class="s-box"><div class="title">自编号</div>
<div class="text"><input maxlength="16" type="text" autocomplete="off" class="hig25 wid162" id="uhandno" placeholder="<输入>" onchange="changehandno(this.value)">
</div>
</div>
<div class="s-box" id="div_orderno"><div class="title">采购订单</div>
<div class="text" id="uorderno">
</div>
</div>
<div class="clearbox">
<div class="title">摘要</div>
<div class="text"><input maxlength="100" type="text" id="uremark" autocomplete="off" class="hig25 wid_remark" placeholder="<输入>" onchange="changeremark(this.value)">
</div>
</div>
</div>
	</form>
	</div>
<div class="warem-toolbars">
		<div class="fl" style="cursor: pointer;">
		<table border="0" cellspacing="0" class="fl-ml10">
<!-- 		<tr><td id="warembar" onclick="updown()" style="cursor: pointer;">▲&nbsp;&nbsp;商品明细</td><td id="wquickuwaretd"><input type="text" id="wquickuwareno"  class="edithelpinput wid145" placeholder="---选择或输入---"><span onclick="if(isAddWarem()){selectware('quickupdatew')}"></span></td></tr> -->
		<tr><td id="warembar" onclick="updown()" style="color:#ff7900">▲&nbsp;&nbsp;商品明细</td>
		<td id="wquickuwaretd"><input type="text" id="wquickuwareno"  class="edithelpinput wid145" data-value="quickaddwarem"  data-end="yes" placeholder="---选择或输入---" list="wareno_list"><span onclick="if(isAddWarem()){selectware('quickupdatew')}"></span></td>
		</table>
		<input type="hidden" id="wquickuwareid" >
		<datalist id="wareno_list">	
		</datalist>
		</div>
			<div class="fr" id="warem-toolbar">
			<span><input class="btn5" type="button" id="notecheckware" value="√扫码验货" onclick="opennotecheckd()"></span>
				<span class="seprate1"></span>
			<span><input class="btn5" type="button" id="barcodeware" value="＋扫码增加" onclick="openbarcodeadd()"></span>
				<span class="seprate1"></span>
				<span><input class="btn5" type="button" id="updateware" value="〼编辑" onclick="updatewd()"></span>
				<span class="seprate1"></span>
				<span><input class="btn5" type="button" id="delware" value="-删除行" onclick="delwaremx()"></span>
				<span class="seprate1"></span>
				<span><input class="btn5" type="button" id="delware" value="-清空明细" onclick="delwareallmx()"></span>
			</div>
			<div class="fr div_sort">
			<table>
			<tr>
			<td>
			<label onclick="getnotewarem($('#unoteno').val(), '1');">
			<input type="checkbox" id="waremsort" checked>录入排序
			</label>
			</td>
			<td>
			<label class="label_sort icon_jiantou_up">
			</label>
			</td>
			</tr>
			</table>
			</div>
	</div>
</div>
<!-- 商品明细表 -->
<div style="margin: 0 auto;width:auto">
<table id="waret" class="table1"></table>
<div id="warenametable" class="line30 mt10">
<div class="fr mr20" align="right" id="wmtotalnote"></div>
</div>
</div>
</div>
	<!-- 整单打折框 -->
	<div id="discd" title="整单打折" style="width: 350px; height: 200px"
		class="easyui-dialog" closed="true">
		<div style="margin-left: 40px;margin-top: 30px">
		<p>请输入折扣</p>
		<p><input class="hig25" id="alldiscount" type="text" placeholder="<请输入折扣>" data-enter="alldisc()"></p>
		</div>
		<div class="dialog-footer">
				<input type="button" class="btn1" style="width:70px;margin-right: 10px" name="updateware" value="保存" onclick="alldisc()">
				<input type="button" class="btn2" name="close" value="取消" onclick="$('#discd').dialog('close')">
		</div>
	</div>
<!-- 付款框 -->
<div id="payd" title="结账" style="width: 520px;" class="easyui-dialog" closed="true" data-qickey="F4:'updatewareinh(false)'">
<div style="width:100%;text-align: center;">
<table width="500" border="0" cellspacing="10" class="table1">
  <tr>
    <td align="right" class="header">本单应付</td>
    <td align="right"><input class="wid160 hig25" type="text" id="thispay" readonly></td>
    <td width="70" align="right" class="header">上次欠款</td>
    <td width="170" align="right"><input class="wid160 hig25" type="text" id="pastpay" readonly></td>
<!--   </tr> -->
<!--   <tr> -->
  </tr>
  <tr>
    <td align="right" class="header">折让优惠</td>
    <td align="right"><input class="wid160 hig25" type="text" id="discpay" placeholder="<输入>" onchange="sumpay()"></td>
<!--   </tr> -->
<!--   <tr> -->
    <td align="right" class="header">累计欠款</td>
    <td align="right"><input class="wid160 hig25" type="text" id="thisqkpay" readonly></td>
  </tr>
  <tr id="paylist" style="display: none"></tr>
  <tr>
    <td align="right" class="header">付款合计</td>
    <td align="right"><input class="wid160 hig25" type="text" id="sumpay" readonly></td>
<!--   </tr> -->
<!--   <tr> -->
    <td align="right" class="header">本单挂账</td>
    <td align="right"><input class="wid160 hig25" type="text" id="nopay" readonly></td>
  </tr>
</table>
</div>
<div class="dialog-normal-footer">
		<input type="button" class="btn1" style="width:70px;margin-right: 10px" name="updateware" value="结账" onclick="updatewareinh(false)">
		<input type="button" class="btn1" style="margin-right: 10px" name="updateware" value="结账并打印" onclick="updatewareinh(true)">
		<input type="button" class="btn2" name="close" value="取消" onclick="$('#payd').dialog('close')">
</div>
</div>
<!-- 付款明细框 -->
<div id="paydetaild" title="付款明细" style="width: 350px; height: 400px;" class="easyui-dialog" closed="true">
<div style="width:100%;height:300px;overflow: auto;text-align: center;">
<table width="300" border="0" cellspacing="10" class="table1">
  <tr>
    <td width="70" align="right" class="header">合计金额</td>
    <td width="170" align="right"><input class="wid160 hig25" type="text" id="totalpaym" readonly></td>
  </tr>
  <tr>
    <td align="right" class="header">折让优惠</td>
    <td align="right"><input class="wid160 hig25" type="text" id="discpaym" readonly></td>
  </tr>
  <tr>
    <td align="right" class="header">应结金额</td>
    <td align="right"><input class="wid160 hig25" type="text" id="actpaym" readonly></td>
  </tr>
   <tr id="paymlist" style="display: none"></tr>
  <tr>
    <td align="right" class="header">付款合计</td>
    <td align="right"><input class="wid160 hig25" type="text" id="sumpaym" readonly></td>
  </tr>
  <tr> 
    <td align="right" class="header">本单挂账</td>
    <td align="right"><input class="wid160 hig25" type="text" id="nopaym" readonly></td>
  </tr>
  <tr>
    <td align="right" class="header">欠款余额</td>
    <td align="right"><input class="wid160 hig25" type="text" id="pastpaym" readonly></td>
  </tr>
</table>
</div>
<div class="dialog-footer">
	<input type="button"  style="margin-right: 10px"  class="btn2" name="close" value="关闭" onclick="$('#paydetaild').dialog('close')">
</div>
	</div>
<div id="selloutd" title="载入供应商发货单" style="width: 800px; height: 370px" class="easyui-dialog" closed="true">
<div style="margin: 0 10px;">
<table id="selloutt"></table>
</div>
<!-- 分页 -->
<div class="page-bar">
	<div class="page-total" id="sellout_total">共有0条记录</div>
	<div id="selloutpp" class="tcdPageCode page-code">
	</div>
</div>
</div>
<!-- 订单载入窗 -->
<div id="loadd" title="载入未完成采购订货" style="width: 350px; height: 370px" class="easyui-dialog" closed="true">
<!-- <table id="loadt"></table> -->
<div class="textcenter" id="loadform">
<input type="hidden" id="lwareid">
<input type="hidden" id="lbrandid">
<input type="hidden" id="ltypeid">
<table class="table1" border="0" cellspacing="10" cellpadding="10">
  <tr>
    <td width="67" class="header" align="right">货号</td>
    <td width="170" align="right"><input class="edithelpinput wareno_help" data-value="#lwareid" type="text" id="lwareno" placeholder="<输入>"><span onclick="selectware('load')"></span></td>
  </tr>
  <tr>
    <td class="header" align="right">类型</td>
    <td align="right"><input class="edithelpinput" type="text" id="lwaretype" placeholder="<选择>" readonly><span onclick="selectwaretype('load')" ></span></td>
  </tr>
    <tr>
    <td width="67" class="header" align="right">品牌</td>
    <td width="170" align="right"><input class="edithelpinput brand_help" data-value="#lbrandid" type="text" id="lbrandname" placeholder="<输入>"><span onclick="selectbrand('load')"></span></td>
  </tr>
  <tr id="centdivm">
    <td class="header" align="right">季节</td>
    <td align="right">
<input  type="text" class="edithelpinput season_help" name="lseasonname" id="lseasonname" maxlength="20" placeholder="<选择或输入>">
<span onclick="opencombox(this)"></span></td>
  </tr>
  <tr>
    <td class="header" align="right">生产年份</td>
    <td align="right"><input class="hig25 wid160" type="text" id="lprodyear" placeholder="<输入>" maxlength="4"></td>
  </tr>
</table>
</div>
<div class="dialog-footer">
<div id="loadpp"  class="tcdPageCode fl"></div>
		<input type="button" class="btn1" style="width:100px;margin-right: 10px" value="清空载入条件" onclick="resetload()">
		<input type="button" class="btn1" style="width:70px;margin-right: 10px" value="载入" onclick="loadnote()">
		<input type="button" class="btn2" name="close" value="取消" onclick="$('#loadd').dialog('close')">
</div>
</div>
<!-- 修改时间框 -->
<div id="changenotedated" title="修改入库时间" style="width: 350px; height: 200px" data-options="modal: true"
	class="easyui-dialog" closed="true">
	<div style="margin-left: 40px;margin-top: 30px">
	<p>请输入入库时间</p>
	<p><input type="text" name="cg_notedate" id="cg_notedate" placeholder="<输入>" style="width: 162px;height:29px" class="easyui-datetimebox"></p>
	</div>
	<div class="dialog-footer">
			<input type="button" class="btn1" style="width:70px;margin-right: 10px" name="updateware" value="保存" onclick="changenotedate()">
			<input type="button" class="btn2" name="close" value="取消" onclick="$('#changenotedated').dialog('close')">
	</div>
</div>
<!-- 订单载入窗 -->
<div id="provorderd" title="载入采购订单" style="width: 800px; height: 370px" class="easyui-dialog" closed="true">
<div style="margin: 0 10px;">
<table id="provordert"></table>
</div>
<!-- 分页 -->
<div class="page-bar">
	<div class="page-total" id="provorder_total">共有0条记录</div>
	<div id="provorderpp" class="tcdPageCode page-code">
	</div>
</div>
</div>
<!-- 付款记录 -->
<div id="paynoted" title="付款情况" style="width: 900px; height: 400px;max-width: 100%" class="easyui-dialog" closed="true">
<div id="paynotetoolbar" class="toolbar" style="font-weight: 600;font-size: 14px;">
<div class="toolbar_box1">
<div class="fl">
<label>应付合计：</label>
<label id="paynote_totalcheckcurr">0.00</label>

</div>
<div class="fr">
<label>欠款：</label>
<label id="paynote_paybalcurr">0.00</label>
</div>
</div>
</div>
<table id="paynotet"></table>
<div class="dialog-footer">
<div id="paynotepp" class="tcdPageCode fl"></div>
<input type="button" class="btn1" id="btn_addpaynote" value="付款" onclick="addpaynoted()">
</div>
</div>
<div id="upaynoted" title="添加付款记录" style="width: 600px; height: 300px;"  class="easyui-dialog" closed=true>
		<table width="600px" border="0" cellspacing="10">
			<tr>
				<td width="70px" align="right">单据号</td>
				<td width="180px" align="left"><input type="text"
					style="width: 160px; height: 25px" value="<保存时自动生成>"
					id="paynotenoteno" name="paynotenoteno" width="175px" readonly />
					</td>
				<td width="70px" align="right">日期</td>
				<td width="180px" align="left"><input type="text"
					id="paynotedate" name="paynotedate" style="width: 160px; height: 25px"
					readonly /></td>
			</tr>
			<tr>
				<td align="right" width="50px">结算方式</td>
				<td align="left"><input type="text" class="edithelpinput wid145 hig25 pw_help" data-value="#paynotepayid" placeholder="<选择或输入>" id="paynotepayname"
					name="paynotepayname" /> <span onclick="Paywaydata('paynote')"></span>
					<input type="hidden" id="paynotepayid" name="paynotepayid"></td>
				<td align="right">金额</td>
				<td align="left"><input type="text" placeholder="<输入>"
					id="paynotecurr" name="paynotecurr" style="width: 160px; height: 25px"  class="onlyMoney" maxlength="8"/></td>
			</tr>
			<tr>
				<td align="right">自编号</td>
				<td align="left"><input type="text" placeholder="<输入>"
					id="paynotehandno" name="paynotehandno" style="width: 160px; height: 25px" />
				</td>
				<td align="right">备注</td>
				<td align="left"><input type="text" placeholder="<输入>"
					id="paynoteremark" name="paynoteremark" style="width: 160px; height: 25px" />
				</td>
			</tr>
		</table>
		<div class="dialog-footer" style="text-align: center;" id="div_updatebtn">
		<input type="button" class="btn1" value="付款" name="update1" onclick="addpaynote(1)">
		</div>
	</div>
<script type="text/javascript">
var levelid = Number(getValuebyName("GLEVELID"));
var pgid = 'pg1102';
setqxpublic();
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
var sizenum = getValuebyName("SIZENUM");
var cols = Number(sizenum) <= 5 ? 5 : Number(sizenum);
cols = cols >= 15 ? 15 : cols;
function setColums() {
	var colums = [];
	colums.push({
		field: 'ROWNUMBER',
		title: '序号',
		fixed: true,
		width: 40,
		halign: 'center',
		align: 'center',
		formatter: function(value, row, index) {
			if(isNaN(Number(value))&&value!=undefined&&value.length>0)
				return value;
			return index + 1;
		}
	}, {
		field: 'WARENO',
		title: '货号',
		width: 60,
		fixed: true,
		halign: 'center'
	},{
		field: 'WARENAME',
		title: '商品名称',
		width: 120,
		fixed: true,
		halign: 'center',
		align: 'left'
	},{
		field: 'UNITS',
		title: '单位',
		width: 40,
		fixed: true,
		halign: 'center',
		align: 'center'
	},{
		field: 'COLORNAME',
		title: '颜色',
		width: 60,
		fixed: true,
		halign: 'center',
		align: 'center'
	},{
		field: 'SIZENAME',
		title: '尺码',
		expable: false,
		width: 60,
		fixed: true,
		hidden: true,
		halign: 'center',
		align: 'center'
	});;
	for (var i = 1; i <= cols; i++) {
		colums.push({
			field: 'AMOUNT' + i,
			title: '<span id="title' + i + '"><span>',
// 			expable: false,
			fieldtype: "G",
			width: 35,
			fixed: true,
			halign: 'center',
			align: 'center',
			formatter: function(value, row, index) {
				return value == '' ? '': Number(value) == 0 ? '': value;
			}
		});
	}
	colums.push({
		field: 'AMOUNT',
		title: '小计',
		width: 50,
		fieldtype: "G",
		fixed: true,
		halign: 'center',
		align: 'center'
	},{
		field: 'PRICE0',
		title: '原价',
		width: 50,
		fixed: true,
		halign: 'center',
		align: 'right',
		hidden: allowinsale == '1' ? false : true,
		formatter: currfm
	},{
		field: 'DISCOUNT',
		title: '折扣',
		width: 40,
		fixed: true,
		halign: 'center',
		align: 'right',
		hidden: allowinsale == '1' ? false : true,
		formatter: currfm
	},{
		field: 'PRICE',
		title: '单价',
		width: 50,
		fixed: true,
		halign: 'center',
		align: 'right',
		hidden: allowinsale == '1' ? false : true,
		formatter: currfm
	},{
		field: 'CURR',
		title: '金额',
		width: 80,
		fixed: true,
		halign: 'center',
		align: 'right',
		hidden: allowinsale == '1' ? false : true,
		formatter: currfm
	},{
		field: 'RETAILSALE',
		title: '零售价',
		width: 50,
		fixed: true,
		halign: 'center',
		align: 'right',
		formatter: currfm
	},{
		field: 'RETAILCURR',
		title: '零售额',
		width: 80,
		fixed: true,
		halign: 'center',
		align: 'right',
		formatter: currfm
	});
	return colums;
}

function isAddWarem() {
	var houseid = Number($('#uhouseid').val());
	var provid = Number($('#uprovid').val());
	if (isNaN(houseid)||houseid==0) {
		alerttext('请选择店铺');
		$('#wquickuwareid').val("");
		$('#wquickuwareno').val("");
		$('#uhousename').focus();
		return false;
	} else if (isNaN(provid)||provid==0) {
		alerttext("请选择供应商");
		$('#wquickuwareid').val("");
		$('#wquickuwareno').val("");
		$('#uprovname').focus();
		return false;
	} else {
		return true;
	}
}
var notedateobj = {
	id: "#uid",
	noteno: "#unoteno",
	notedate: "#unotedate",
	action: "updatewareinhbyid"
}
$(function() {
	if(top.gysfhdnum > 0)
		$('#gysfhnum').addClass('newmsg');
	var myDate = new Date(top.getservertime());
	$('#smindate,#smaxdate').datebox('setValue', myDate.Format('yyyy-MM-dd')); // 设置日期输入框的值
	setaddbackprint("1102");
	$('div.div_sort .label_sort').click(function() {
		var $this = $(this);
		if ($this.hasClass('icon_jiantou_up'))
			$this.removeClass("icon_jiantou_up").addClass("icon_jiantou_down");
		else
			$this.removeClass("icon_jiantou_down").addClass("icon_jiantou_up");
		getnotewarem($('#unoteno').val(), 1);
	});
	//没有自动勾单 就不查看付款记录
	if(jzzdgd!=1||allowinsale!=1) $("span.paynote").remove();
	setwarem();
	$('#pp').createPage({
		pageCount: 1,
		current: 1,
		backFn: function(p) {
			getnotelist(p);
		}
	});
	$('#gg').datagrid({
		idField: 'NOTENO',
		height: $('body').height() - 45,
		fitColumns: true,
		striped: true, //隔行变色
		showFooter: true,
		nowrap: false,
		singleSelect: true,
		onDblClickCell: function(index, field, value) {
			var row = $(this).datagrid("getRows")[index];
			var noteno = "";
			if (field == "ORDERNO") {
				noteno = row.ORDERNO;
			}
			if (noteno.length > 0) {
				var pgno = noteno.substring(0, 2);
				detail_bol = true;
				opendetaild(pgno, noteno);
			} else detail_bol = false;
		},
		onDblClickRow: function(rowIndex, rowData) {
			updatenoted();
		},
		columns: [
			[{
				field: 'ID',
				title: 'ID',
				width: 200,
				hidden: true
			}, {
				field: 'ROWNUMBER',
				title: '序号',
				width: 50,
				fixed: true,
				align: 'center',
				halign: 'center',
				formatter: function(value, row, index) {
					if(isNaN(Number(value))&&value!=undefined&&value.length>0)
						return value;
					var p = $("#pp").getPage() - 1;
					return p * pagecount + index + 1;
				}
			}, {
				field: 'NOTENO',
				title: '单据号',
				width: 125,
				fixed: true,
				align: 'center',
				halign: 'center',
				styler: function(value, row, index) {
					if (value == "合计") {
						return 'color:#ff7900;font-weight:700';
					}
					if (row.STATETAG == '1') {
						return 'color:#00959a;font-weight:900';
					} else {
						return 'color:#ff7900;font-weight:700';
					}
				}
			}, {
				field: 'NOTEDATE',
				title: '单据日期',
				width: 112,
				fixed: true,
				align: 'center',
				halign: 'center',
				formatter: function(value, row, index) {
					return value == undefined ? '' : value.substring(0, 16);
				}
			}, {
				field: 'PROVNAME',
				title: '供应商',
				width: 150,
				fixed: true,
				align: 'left',
				halign: 'center'
			}, {
				field: 'ORDERNO',
				title: '采购订单号',
				width: 120,
				align: 'center',
				halign: 'center',
				fixed: true
			}, {
				field: 'HOUSENAME',
				title: '店铺名称',
				width: 150,
				fixed: true,
				align: 'left',
				halign: 'center'
			}, {
				field: 'TOTALCURR',
				title: '总金额',
				width: 80,
				fixed: true,
				align: 'right',
				halign: 'center',
				formatter: function(value, row, index) {
					return allowinsale == '1' ? Number(value).toFixed(2) : "***";
				}
			}, {
				field: 'TOTALAMT',
				title: '总数量',
				width: 80,
				fixed: true,
				align: 'right',
				halign: 'center',
				formatter: function(value, row, index) {
					return Number(value);
				}
			}, {
				field: 'PAYLIST',
				title: '付款方式',
				width: 150,
				fixed: true,
				align: 'left',
				halign: 'center',
				hidden: allowinsale == "1" ? false : true,
				formatter: function(value, row, index) {
					return (value != "" && value != undefined && value != null) ? value.replace(/ /g, "，") : '';
				}
			}, {
				field: 'REMARK',
				title: '摘要',
				width: 150,
				fixed: true,
				align: 'left',
				halign: 'center'
			}, {
				field: 'OPERANT',
				title: '制单人',
				width: 80,
				fixed: true,
				align: 'center',
				halign: 'center'
			}, {
				field: 'ACTION',
				title: '操作',
				width: 80,
				fixed: true,
				align: 'center',
				halign: 'center',
				formatter: function(value, row, index) {
					var stg = Number(row.STATETAG);
					var epname = getValuebyName("EPNAME");
					var operant = row.OPERANT;
					if (stg==0&&epname==operant)
						return '<input type="button" value="删除" class="m-btn" onclick="delnote(' + index + ')">';
					else
						return "";
				}
			}]
		],
		pageSize: 20,
		toolbar: '#toolbars'
	}).datagrid("keyCtr", "updatenoted()");
	getnotedata();
	allowinsale == '1' ? $('#update').remove() : $('#pay').remove();
	uploader_xls_options.uploadComplete = function(file){
		getnotewarem($("#unoteno").val(),1);
	}
	uploader_xls_options.startUpload = function(){
		if (uploader_xls.getFiles().length > 0) {
			uploader_xls.option('formData', {
				noteno: $('#unoteno').val(),
				provid: $("#uprovid").val()
			});
			uploader_xls.upload();
		} else {
			alerttext("文件列表为空！请添加需要上传的文件！");
		}
	}
	uploader_xls = SkyUploadFiles(uploader_xls_options);
	setuploadserver({
		server: "/skydesk/fyimportservice?importser=addwareinmxls",
		xlsmobanname: "warein",
		channel: "warein"
	});
});
var searchb = false;
function toggle() {
	if (searchb) {
		$('#highsearch').val('高级搜索▼');
		$('#searchbtn').hide();
		searchb = false;
	} else {
		$('#highsearch').val('高级搜索▲');
		$('#searchbtn').show();
		searchb = true;
	}
	$('.searchbar').slideToggle('fast');
	setTimeout(function() {
		$('#gg').datagrid('resize', {
			height: $('body').height() - 50
		});
	}, 200);
}
//清空搜索条件
function resetsearch() {
	var myDate = new Date(top.getservertime());
	$('#smindate,#smaxdate').datebox('setValue', myDate.Format('yyyy-MM-dd')); // 设置日期输入框的值
	$('#shousename,#shouseid,#shandno,#sprovname,#sprovid,#swareno,#swareid,#sremark,#sorderno').val('');
	$('#st3').prop('checked', true);
}
var currentdata = {};
var getnotelist = function(page) {
	var $dg = $("#gg");
	var options = $dg.datagrid("options");
// 	var sort = options.sortName;
// 	var order = options.sortOrder;
	currentdata["erpser"] = "wareinhlist";
// 	currentdata["sort"] = sort;
// 	currentdata["order"] = order;
	currentdata["mindate"] = $("#smindate").datebox("getValue");
	currentdata["maxdate"] = $("#smaxdate").datebox("getValue");
	currentdata["fieldlist"] = "a.id,a.noteno,a.accid,a.notedate,a.provid,a.houseid,a.ntid,a.handno,a.remark,a.operant,a.checkman,a.statetag,a.lastdate,a.totalamt,a.totalcurr,b.provname,b.discount,b.pricetype,c.housename,a.paylist,a.orderno";
	currentdata["rows"] = pagecount;
	currentdata["page"] = page;
	$dg.datagrid('loadData', nulldata);
	alertmsg(6);
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
					dqzjl = data.total;
					dqzamt = data.totalamount;
					dqzcurr = data.totalcurr;
					$("#pp").setPage({
						pageCount: Math.ceil(data.total / pagecount),
						current: Number(page)
					});
					data.footer = [{
						ROWNUMBER: "合计",
						TOTALAMT: dqzamt,
						TOTALCURR: dqzcurr
					}];
					$dg.datagrid('loadData', data);
					if(data.total>0)
						$('#gg').datagrid('scrollTo', 0);
					$('#pp_total').html(data.total);
					$('#qsnotevalue').focus();
				}
			} catch(e) {
				// TODO: handle exception
				console.error(e);top.wrtiejsErrorLog(e);
			}
		}
	});
}
//搜索
function getnotedata() {
	var value = $('#qsnotevalue').val();
	currentdata = {
		findbox: value,
		statetag: 2
	};
	getnotelist(1);
}
//高级搜索
function searchnote() {
	var houseid = Number($('#shouseid').val());
	var provid = Number($('#sprovid').val());
	var handno = $('#shandno').val();
	var wareid = Number($('#swareid').val());
	var remark = $('#sremark').val();
	var orderno = $('#sorderno').val();
	var operant = $('#soperant').val();
	var statetag;
	if ($('#st1').prop('checked')) {
		statetag = "0";
	} else if ($('#st2').prop('checked')) {
		statetag = "1";
	} else {
		statetag = "2";
	}
	currentdata = {
		houseid: houseid,
		handno: handno,
		orderno: orderno,
		provid: provid,
		wareid: wareid,
		remark: remark,
		operant: operant,
		statetag: statetag
	};
	getnotelist(1);
}
//收缩展开
var d = false;
function updown() {
	$('#udnote').slideToggle('fast');
	if (!d) {
		$('#warembar').html('▼&nbsp;&nbsp;商品明细');
		d = true;
	} else {
		$('#warembar').html('▲&nbsp;&nbsp;商品明细');
		d = false;
	}
	setTimeout(function() {
		$('#waret').datagrid('resize', {
			height: $('body').height() - 90
		});
	}, 200);

}

//增加单据
function addnoted() {
	$('#udnote').show();
	$('#warembar').html('▲&nbsp;&nbsp;商品明细');
	setTimeout(function() {
		$('#waret').datagrid('resize', {
			height: $('body').height() - 90
		});
	}, 200);
	d = false;
	$('#udnoteform')[0].reset();
	$('#udnoteform input[type=hidden]').val('');
	$('#uhouseid').val(getValuebyName('HOUSEID'));
	$('#uhousename').val(getValuebyName("HOUSENAME"));
	$('#uhousename,#uhandno,#uremark,#uprovname').removeAttr('readonly')
	$('#updatingbar,#wquickuwaretd,#ud #warem-toolbar').show();
	$('#isupdatedbar,#div_orderno,#clearnotebar').hide();
	$('#uhousename').next().show();
	$('#uprovname').next().show();
	$('#wquickuwareno').val('');
	$('#unotedate').datetimebox({
		readonly: false,
		hasDownArrow: true
	});
	addwareinh();
	$('#ud').dialog("setTitle","增加采购入库单");
	$('#ustatetag').val('0');
	$('#ud').dialog('open');
	$('#ud').data('qickey', "F4:'openpay()',F6:'opendisc()',Del:'delwareinh()'");
	$('#wquickuwareno').focus();
}
//编辑单据
function updatenoted() {
	if (detail_bol) return;
	$('#udnote').show();
	$('#warembar').html('▲&nbsp;&nbsp;商品明细');
	setTimeout(function() {
		$('#waret').datagrid('resize', {
			height: $('body').height() - 90
		});
	}, 200);
	d = false;
	//$('#div_waremx').hide();
	$('#waret').datagrid('loadData', nulldata);
	var row = $('#gg').datagrid('getSelected');
	if (!row) {
		alerttext("请选择一行数据，进行编辑!");
	} else {
		getnotebyid(row.NOTENO);
	}
}

function quickaddwd() {
	$('#quickuaddwaref')[0].reset();
	$('#quickutable').html('');
	if ($("#uprovid").val() == '0' || $("#uprovid").val() == '') {
		alerttext('请选择供应商');
	} else {
		$('#quickud').dialog('open');
	}
}
var pg = 1;
var sumpg = 1;
var nextpg = true;
//加载商品明细表
function setwarem() {
	$('#waret').datagrid({
		idField: 'ID',
		height: $('body').height() - 90,
		fitColumns: true,
		striped: true, //隔行变色
		showFooter: true,
		nowrap: false, //允许自动换行
		singleSelect: true,
		onSelect: function(rowIndex, rowData) {
			if (rowData) {
				for (var i = 1; i <= cols; i++) {
					$('#title' + i).html(eval('rowData.SIZENAME' + i));
				}
			}
		},
		onLoadSuccess: function(data) {
			var sizelength = 0;
			var rows = data.rows;
			var $dg = $('#waret');
			for (var i = 0; i < rows.length; i++) {
				var item = rows[i];
				while (sizelength <= sizenum) {
					var s = sizelength + 1;
					if (item["SIZENAME" + s] != "" && item["SIZENAME" + s] != undefined)
						sizelength++;
					else
						break;
				}
			}
			for (var i = 1; i <= sizenum; i++) {
				if (i <= sizelength)
					$dg.datagrid("showColumn", "AMOUNT" + i);
				else
					$dg.datagrid("hideColumn", "AMOUNT" + i);
			}
			$dg.datagrid('resize');
		},
		onDblClickRow: function(rowIndex, rowData) {
			if(!$("#warem-toolbar").is(":hidden")) updatewd();
		},
		columns: [setColums()],
		toolbar: "#udtool",
		pageSize: 20
	}).datagrid("keyCtr");
	var scrollfn = function(obj) {
		var $this = $(obj);
		var viewH = $this.height(); //可见高度
		var contentH = $this.get(0).scrollHeight; //内容高度
		var scrollTop = $this.scrollTop(); //滚动高度
		var noscroll = sumpg > pg && nextpg&&contentH==viewH&&scrollTop==0; //没有滚动跳的时候加载
		var hasscroll = contentH > (viewH + 1) && contentH - viewH - scrollTop <= 3 && $("#waret").datagrid("getRows").length > 0;//有滚动跳的时候加载
		if (noscroll||hasscroll) { //到达底部时,加载新内容
			if ($('#udnote').css('display') != "none") {
				$('#udnote').hide();
				$('#warembar').html('▼&nbsp;&nbsp;商品明细');
				setTimeout(function() {
					$('#waret').datagrid('resize', {
						height: $('body').height() - 90
					});
				},
				200);
				d = true;
			}
			if (sumpg > pg && nextpg) {
				nextpg = false;
				getnotewarem($('#unoteno').val(), pg + 1);
				nextpg = true;
			}
		}
	};
	$('#waret').prev().children('.datagrid-body').bind('mousewheel DOMMouseScroll', function(event, delta, deltaX, deltaY) {
	    scrollfn(this);
	});
}
//获取上面明细单据及分页
function getnotewarem(noteno, page) {
	alertmsg(6);
	var sortid = $('#waremsort').prop('checked') ? 1 : 0;
	var order = $('div.div_sort .label_sort').hasClass('icon_jiantou_up') ? "asc" : "desc";
	if(page==1) $('#waret').datagrid('loadData', nulldata);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		async: false,
		data: {
			erpser: "wareinmcolorsumlist",
			noteno: noteno,
			sizenum: sizenum,
			rows: pagecount,
			page: page,
			order: order,
			sortid: sortid
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					var totals = data.total;
					var totalamt = Number(data.totalamt);
					var totalcurr = Number(data.totalcurr);
					var retailcurr = Number(data.retailcurr);
					var totalcost = Number($("#usaletotalcost").val());
					data.footer = [{
						WARENO: "合计",
						AMOUNT: totalamt,
						CURR: totalcurr,
						RETAILCURR: retailcurr
					}];
					sumpg = Math.ceil(Number(totals)/pagecount);
					$('#warepp').setPage({
						pageCount: sumpg,
						current: Number(page)
					});
					$('#wtotalamt').val(totalamt);
					$('#wtotalcurr').val(Number(totalcurr).toFixed(2));
					if (page == 1) {
						pg = 1;
						$('#waret').datagrid('loadData', data);
						if ($('#waret').datagrid('getRows').length > 0) {
							$('#waret').datagrid('selectRow', 0);
						}
					} else {
						pg++;
						var rows = data.rows;
						for (var i in rows) {
							$('#waret').datagrid('appendRow', rows[i]);
						}
					}
					$('#waret').datagrid('loaded');
					$('#wmtotalnote').html('已显示' + $('#waret').datagrid('getRows').length + '条记录/共有' + totals + '条记录');
					var $dg = $("#gg");
					var index = $dg.datagrid("getRowIndex",noteno);
					$dg.datagrid('updateRow', {
						index: index,
						row: {
							TOTALAMT: totalamt,
							TOTALCURR: totalcurr+totalcost
						}
					});
					$dg.datagrid('updateFooter', {
						TOTALAMT: Number(dqzamt) - Number(dqamt) + Number(totalamt),
						TOTALCURR: Number(dqzcurr) - Number(dqcurr) + Number(totalcurr) + totalcost
					});
					dqzamt = Number(dqzamt) - Number(dqamt) + Number(totalamt);
					dqzcurr = Number(dqzcurr) - Number(dqcurr) + Number(totalcurr) + totalcost;
					dqamt = totalamt;
					dqcurr = totalcurr + totalcost;
				}
			} catch (ex) {
				console.error(ex.message);
			}
		}
	});
}
//编辑商品框
function updatewd() {
	$('#quickuaddwaref')[0].reset();
	$("#alldisc,#allpri").val("");
	$('#quickutable').html('');
	var arrs = $('#waret').datagrid('getSelected');
	if (arrs == null) {
		alerttext("请选择一行数据，进行编辑!");
	} else {
		var state = $('#ustatetag').val();
		if (state != '1') {
			getwaremsum(arrs.WAREID, $('#unoteno').val());
			$('#wquickuwareid').val(arrs.WAREID);
		}
	}
}

function delwaremx() {
	var noteno = $('#unoteno').val();
	var rowData = $('#waret').datagrid("getSelected");
	if (rowData) {
		var wareid = rowData.WAREID;
		var colorid = rowData.COLORID;
		$.messager.confirm(dialog_title, '您确认要删除' + rowData.WARENO + '，' + rowData.WARENAME + '，' + rowData.COLORNAME + '吗？', function(r) {
			if (r) {
				alertmsg(2);
				$.ajax({
					type: "POST", //访问WebService使用Post方式请求 
					url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
					data: {
						erpser: "delwareinmsum",
						noteno: noteno,
						wareid: wareid,
						colorid: colorid
					}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
					dataType: 'json',
					success: function(data) { //回调函数，result，返回值 
						if (valideData(data)) {
							getnotewarem(noteno, 1);
						}
					}
				});
			}
		});
	} else {
		alerttext("请选择一行数据，进行编辑!");
	}
}
function delwareallmx() {
	var noteno = $('#unoteno').val();
	var rows = $('#waret').datagrid("getRows");
	if (rows.length>0) {
		$.messager.confirm(dialog_title, '您确认要清空单据' + noteno + '的所有明细？',
		function(r) {
			if (r) {
				alertmsg(2);
				$.ajax({
					type: "POST",
					//访问WebService使用Post方式请求 
					url: "/skydesk/fyjerp",
					//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
					data: {
						erpser: "clearwareinm",
						noteno: noteno
					},
					//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
					dataType: 'json',
					success: function(data) { //回调函数，result，返回值 
						if (valideData(data)) {
							getnotewarem(noteno,1);
						}
					}
				});
			}
		});
	} else {
		alerttext("没有明细数据，无需清空！");
	}
}
function quickupdatesum() {
	var list = $('#quickutables tr:eq(1) input[type=text]').length - 2; //横向文本框数
	var line = $('#quickutables tr').length - 3; //竖向文本框数
	var y_price = $("#quickutables").data("price");
	$("#quickutables input.price").each(function(){
		$this = $(this);
		var price = Number($this.val());
		if(price>y_price){
			$this.addClass("warnprice");
		}else{
			$this.removeClass("warnprice");
		}
	});
	var totalamount = new Decimal(0);
	var totalcurr = new Decimal(0);
	var amount1 = new Array(line);
	var amount2 = new Array(list + 5);
	var quickjsonstr = new Array();
	if (line >= 1 && list >= 1) {
		for (i = 1; i <= line; i++) {
			amount1[i] = new Decimal(0);
			for (j = 1; j <= list + 1; j++) {
				if (j != list + 1) {
					var valuestr = $('#u' + i.toString() + "-" + j.toString()).val();
					var value = Number($('#u' + i.toString() + "-" + j.toString()).val());
					if (valuestr != ""&&!isNaN(value)) {
						quickjsonstr.push({
							colorid: $('#uacolor' + i).val(),
							sizeid: $('#uasize' + j).val(),
							amount: value,
							discount: $('#udisc' + i).val(),
							price0: $('#uprice0' + i).html(),
							price: $('#upri' + i).val(),
							curr: Number($('#upri' + i).val()) * Number(value)
						});
						amount1[i] = amount1[i].add(value);
						totalamount = totalamount.add(value);
					}
				} else {
					$('#usum' + i).html(amount1[i].valueOf());
					var curr = Number((amount1[i] * Number($('#upri' + i).val())).toFixed(points));
					$('#uacurr' + i).html(allowinsale == '1' ? curr.toFixed(2) : "***");
					totalcurr = totalcurr.add(curr);
				}
			}
		}
		for (i = 1; i <= list; i++) {
			amount2[i] = new Decimal(0);
			for (j = 1; j <= line + 1; j++) {
				if (j != line + 1) {
					var value = Number($('#u' + j.toString() + "-" + i.toString()).val() == undefined ? 0 : $('#u' + j.toString() + "-" + i.toString()).val() == '' ? 0 : $('#u' + j.toString() + "-" + i.toString()).val());
					if (value != 0) {
						amount2[i] = amount2[i].add(value);
					}
				} else if (j == line + 1) {
					var a = amount2[i].valueOf();
					$('#asum' + i).html(a == 0 ? "" : a);
				}
			}
		}
	}
	$('#asum' + (list + 1).toString()).html(totalamount.valueOf());
	$('#asum' + (list + 5).toString()).html(allowinsale == '1' ? totalcurr.toFixed(2) : "***");
	jsondata = quickjsonstr;
}
var hasTable = false;

function getwaremsum(wareid, noteno) {
	$('#quickutable').html('');
	if ($('#quickutables').length == 0 && hasTable == false) {
		hasTable = true;
		var houseid = $("#uhouseid").val();
		alertmsg(6);
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "getwareinmsum",
				noteno: noteno,
				houseid: houseid,
				wareid: wareid
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				if (valideData(data)) {
					var wareno = data.WARENO;
					var warename = data.WARENAME;
					var entersale = data.ENTERSALE;
					var retailsale = data.RETAILSALE;
					var pricetype = $('#upricetype').val();
					var price1 = pricetype == '0' ? entersale : retailsale;
					var defaultdisc = $('#udiscount').val();
					var colorlist = data.colorlist;
					var sizelist = data.sizelist;
					var amountlist = data.amountlist;
					var kclist = data.kclist;
					var kchj = [];
					var colorid;
					var sizeid;
					//获取hang数值
					var line = getJsonLength(colorlist);
					//获取lie数值
					var list = getJsonLength(sizelist);
					if (line == 0) {
						alerttext("该商品未选择任何可用商品颜色，请在商品档案中选择该商品颜色");
						hasTable = false;
						return;
					}
					if (list == 0) {
						alerttext("该商品未选择尺码组，请在商品档案中选择该商品尺码组");
						hasTable = false;
						return;
					}
					var table = document.createElement("table");
					table.id = "quickutables";
					table.setAttribute("data-price",data.PRICE);
					table.cellSpacing = 0;
					for (var i = 0; i <= line + 2; i++) {
						//alert(line);
						//创建tr
						var tr = document.createElement("tr");
						var curr = 0;
						var amt = 0;
						var price0 = price1; //单价
						var disc = defaultdisc; //折扣
						var price = Number(defaultdisc) * Number(price1); //折后价
						for (var j = 0; j <= list + 5; j++) {
							//alert(list);
							//创建td
							var td = document.createElement("td");
							if (i == 0) {
								tr.className = "table-header",
								td.align = "center";
								td.style.border = "none";
								if (j == 0) {
									td.style.width = '80px';
									td.innerHTML = '颜色';
								} else if (j == list + 1) {
									td.style.width = '60px';
									td.innerHTML = "小计";
								} else if (j == list + 2) {
									td.style.width = '80px';
									allowinsale == '1' ? td.innerHTML = "原价" : td.className = "hide";
								} else if (j == list + 3) {
									td.style.width = '60px';
									td.innerHTML = "折扣";
									allowinsale == '1' ? "" : td.className = "hide";
								} else if (j == list + 4) {
									td.style.width = '80px';
									td.innerHTML = "单价";
									allowinsale == '1' ? "" : td.className = "hide";
								} else if (j == list + 5) {
									td.style.width = '100px';
									td.innerHTML = "金额";
									allowinsale == '1' ? "" : td.className = "hide";
								} else {
									td.style.width = '50px';
									var input = document.createElement("input");
									input.type = "hidden";
									input.id = "uasize" + j;
									input.value = sizelist[j - 1].SIZEID;
									td.innerHTML = sizelist[j - 1].SIZENAME;
									td.appendChild(input);
								}
							} else if (i == line + 1) {
								tr.style.fontWeight = 600;
								if (j == 0) {
									td.innerHTML = "合计";
								} else {
									if (j == (list + 1)) {
										td.align = "center";
									} else if (j == (list + 2) || j == (list + 5)) {
										td.align = "right";
									}
									if (j == list + 2 || j == list + 3 || j == list + 4 || j == list + 5) {
										allowinsale == '1' ? "" : td.className = "hide";
									}
									td.id = "asum" + j;
									td.innerHTML = "";
								}
							} else if (i == line + 2) {
								if (j == 0) {
									td.innerHTML = "库存合计";
								} else if (j == list + 1) {
									var kcsum = new Decimal(0);
									for(var k in kchj){
										if(kchj[k] != undefined)
											kcsum = kcsum.add(kchj[k]);
									}
									td.innerHTML = kcsum.valueOf();
								} else if (hideyj && (j == list + 2||j == list + 3)) {
									td.className = "hide"; 
								}else if(j>0&&j<list+1){
									td.innerHTML = kchj[j] == undefined ? "" : kchj[j].valueOf();
								}
							} else {
								if (j == 0) {
									var input = document.createElement("input");
									input.type = "hidden";
									input.id = "uacolor" + i;
									input.value = colorlist[i - 1].COLORID;
									td.innerHTML = colorlist[i - 1].COLORNAME;
									td.appendChild(input);
								} else if (j == list + 1) {
									td.id = "usum" + i;
									td.align = "center";
									td.innerHTML = amt;
								} else if (j == list + 2) {
									td.id = "uprice0" + i;
									td.align = "right";
									td.innerHTML = Number(price0).toFixed(2);
									allowinsale == '1' ? "" : td.className = "hide";
								} else if (j == list + 3) {
									var input = document.createElement("input");
									input.id = "udisc" + i;
									input.className = "reg-disc";
									input.type = "text";
									input.maxLength = 4;
									input.autocomplete = 'off';
									input.value = Number(disc).toFixed(2);
									td.appendChild(input);
									$(input).keyup(function(e) {
										var key = e.which;
										if(key==13||(key<=40&&key>=38)) return;
										this.value = this.value.replace(/[^\d.]/g, "");
										this.value = this.value.replace(/^\./g, ""); //验证第一个字符是数字而不是. 
										this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
										if (Number(this.value) > 10) {
											alerttext("最大折扣为10", 1500);
											this.value = "10";
										}
										var t = Number(this.id.replace("udisc", ""));
										var price2 = 0;
										var tprice0 = Number($('#uprice0' + t).html());
										if (Number(tprice0) != 0) {
											price2 = Number(this.value) * tprice0;
										}
										$('#upri' + t).val(Number(price2).toFixed(2));
										quickupdatesum();
									});
									$(input).change(function() {
										this.value = Number(this.value).toFixed(2);
									});
									allowinsale == '1' ? "" : td.className = "hide";
								} else if (j == list + 4) {
									var input = document.createElement("input");
									input.className = "reg-curr price";
									input.id = "upri" + i;
									input.type = "text";
									input.maxLength = 7;
									input.autocomplete = 'off';
									input.value = Number(price).toFixed(2);
									$(input).keyup(function(e) {
										var key = e.which;
										if(key==13||(key<=40&&key>=38)) return;
										this.value = this.value.replace(/[^\d.]/g, "");
										var price2 = Number(this.value);
										var disc2;
										var t = Number(this.id.replace("upri", ""));
										var tprice0 = Number($('#uprice0' + t).html());
										if (Number(tprice0) == 0) {
											disc2 = 1;
										} else {
											disc2 = price2 / tprice0;
										}
										$('#udisc' + t).val(Number(disc2).toFixed(2));
										quickupdatesum();
									});
									$(input).change(function() {
										this.value = Number(this.value).toFixed(2);
									});
									td.appendChild(input);
									allowinsale == '1' ? "" : td.className = "hide";
								} else if (j == list + 5) {
									td.align = "right";
									td.id = "uacurr" + i;
									td.innerHTML = allowinsale == '1' ? (curr == undefined ? 0 : curr).toFixed(2) : "***";
									allowinsale == '1' ? "" : td.className = "hide";
								} else {
									var input = document.createElement("input");
									input.id = 'u' + i.toString() + "-" + j.toString();
									input.setAttribute("data-colnum", j);
									input.setAttribute("data-rownum", i);
									input.type = "text";
									input.className = "reg-amt";
									input.maxLength = 5;
									input.autocomplete = 'off';
									sizeid = sizelist[j - 1].SIZEID;
									colorid = colorlist[i - 1].COLORID;
									if (getJsonLength(amountlist) == 0 && getJsonLength(kclist) == 0) {
										input.setAttribute("placeholder", "");
									} else {
										for (var r = 0; r < amountlist.length; r++) {
											var colorids = amountlist[r].COLORID;
											var sizeids = amountlist[r].SIZEID;
											if (colorids == colorid && sizeid == sizeids) {
												price0 = amountlist[r].PRICE0;
												price = amountlist[r].PRICE;
												disc = amountlist[r].DISCOUNT;
												var val = input.value == '' ? 0 : Number(input.value);
												input.value = val + Number(amountlist[r].AMOUNT);
												amt = Number(amountlist[r].AMOUNT) + amt;
												curr = curr + Number(amountlist[r].CURR);
												//break;
											} else {
												input.placeholder = '';
											}
										}
										for (r in kclist) {
											var colorids = kclist[r].COLORID;
											var sizeids = kclist[r].SIZEID;
											if (colorids == colorid && sizeid == sizeids) {
												input.setAttribute("placeholder", kclist[r].AMOUNT);
												if (kchj[j] == undefined) kchj[j] = new Decimal(0);
												kchj[j] = kchj[j].add(kclist[r].AMOUNT);
												break;
											} else {
												input.setAttribute("placeholder", "");
											}
										}
									}
									td.appendChild(input);
								}
							}
							tr.appendChild(td);
						}
						table.appendChild(tr);
					}
					if ($('#quickutables').length == 0) {
						document.getElementById("quickutable").appendChild(table);
					}
					//autocreate(colorlist,sizelist);
					quickupdatesum();
					var amtl = getJsonLength(amountlist);
					var tname = amtl == 0 ? "添加" : "修改";
					var title = tname + "商品明细：" + wareno + "，" + warename;
					var out_wid = list * 52 + 400 - (allowinsale == 1 ? 0 : 310);
					out_wid = out_wid > 400 ? out_wid : 400;
					$('#quickud').dialog({
						title: title,
						width: out_wid
					});
					if (allowinsale == "1") {
						$('#quickud .dialog-footer .ml10').show();
					} else {
						$('#quickud .dialog-footer .ml10').hide();
					}
					if ($('#showprovhistory').prop('checked')) {
						if ($('#provwarehistoryt').data().datagrid == undefined) {
							setprovwarehistt();
						}
						$('#provwarehistorydiv').show();
						$('#provwarehistoryt').datagrid('resize');
						listsalehistory(1);
					} else {
						$('#provwarehistorydiv').hide();
					}
					$('#quickud').window('center');
					$('#quickud').dialog('open');
					$('#quickutables').width(out_wid - 30);
					$('#u1-1').focus();
				}
				hasTable = false;
			}
		});
	}
}
//添加生成采购入库单
function addwareinh() {
	alertmsg(6);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "addwareinh",
			houseid: getValuebyName("HOUSEID")
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					$('#uid').val(data.ID);
					$('#unoteno').val(data.NOTENO);
					changedatebj = false;
					$('#unotedate').datetimebox('setValue', data.NOTEDATE);
					changedatebj = true;
					$('#uhandno').val('');
					$('#uprovname').val('');
					dqamt = 0;
					dqcurr = 0;
					$('#qsnotevalue').val("");
					$("#smaxdate").datebox("setValue",top.getservertime());
					$('#waret').datagrid('loadData', nulldata);
					$('#wmtotalnote').html('已显示0条记录/共有0条记录');
					getnotedata();
				}
			} catch (e) {
				// TODO: handle exception
				console.error(e);top.wrtiejsErrorLog(e);
			}
		}
	});
}

function delnote(index) {
	var rows = $('#gg').datagrid('getRows');
	var row = rows[index];
	$('#uid').val(row.ID);
	$('#unoteno').val(row.NOTENO);
	delwareinh();
}
//删除单据
function delwareinh() {
	var id = $('#uid').val();
	var noteno = $('#unoteno').val();
	$.messager.confirm(dialog_title, '单据信息以及商品明细将全部清除，并且不可恢复，是否确认删除吗？', function(r) {
		if (r) {
			alertmsg(2);
			$.ajax({
				type: "POST", //访问WebService使用Post方式请求 
				url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
				data: {
					erpser: "delwareinhbyid",
					noteno: noteno
				}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
				dataType: 'json',
				success: function(data) { //回调函数，result，返回值 
					try {
						if (valideData(data)) {
							$("#ud").dialog('close');
							var $dg = $("#gg");
							var index = $dg.datagrid("getRowIndex",noteno);
							var rows = $dg.datagrid('getRows');
							var row = rows[index];
							$dg.datagrid('deleteRow', index).datagrid('refresh');
							$dg.datagrid('updateFooter', {
								TOTALAMT: Number(dqzamt) - Number(row.TOTALAMT),
								TOTALCURR: Number(dqzcurr) - Number(row.TOTALCURR)
							});
							dqzamt = Number(dqzamt) - Number(row.TOTALAMT);
							dqzcurr = Number(dqzcurr) - Number(row.TOTALCURR);
							$('#pp_total').html((dqzjl - 1));
							dqzjl = dqzjl - 1;
						}
					} catch (e) {
						// TODO: handle exception
						console.error(e);top.wrtiejsErrorLog(e);
					}
				}
			});
		}
	});
}

//选择店铺
function changehouse(id, noteno, houseid) {
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "updatewareinhbyid",
			ntid: 0,
			noteno: noteno,
			houseid: houseid
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				var $dg = $("#gg");
				var index = $dg.datagrid("getRowIndex",noteno);
				$dg.datagrid('updateRow', {
					index: index,
					row: {
						HOUSENAME: $('#uhousename').val(),
						HOUSEID: houseid
					}
				});
			}
		}
	});
}
//摘要
function changeremark(remark) {
	var id = $('#uid').val();
	var noteno = $('#unoteno').val();
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "updatewareinhbyid",
			ntid: 0,
			noteno: noteno,
			remark: remark
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				var $dg = $("#gg");
				var index = $dg.datagrid("getRowIndex",noteno);
				$dg.datagrid('updateRow', {
					index: index,
					row: {
						REMARK: remark
					}
				});
			}
		}
	})
}
//选择供应商
function changeprov(id, noteno, provid, discount, pricetype) {
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "updatewareinhbyid",
			ntid: 0,
			noteno: noteno,
			provid: provid,
			discount: discount,
			pricetype: pricetype
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				var $dg = $("#gg");
				var index = $dg.datagrid("getRowIndex",noteno);
				$dg.datagrid('updateRow', {
					index: index,
					row: {
						PROVNAME: $('#uprovname').val(),
						PROVID: provid,
						DISCOUNT: discount,
						PRICETYPE: pricetype
					}
				});
				if ($('#waret').datagrid('getRows').length > 0) {
					$.ajax({
						type: "POST", //访问WebService使用Post方式请求 
						url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
						data: {
							erpser: "changewareinmdisc",
							provid: provid,
							noteno: noteno,
							discount: discount
						}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
						dataType: 'json',
						success: function(data) { //回调函数，result，返回值 
							if (valideData(data)) {
								getnotewarem(noteno, '1');
							}
						}
					});
				}
			}
		}
	});
}
//改变自编号
function changehandno(handno) {
	var id = $('#uid').val();
	var noteno = $('#unoteno').val();
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "updatewareinhbyid",
			ntid: 0,
			noteno: noteno,
			handno: handno
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				var $dg = $("#gg");
				var index = $dg.datagrid("getRowIndex",noteno);
				$dg.datagrid('updateRow', {
					index: index,
					row: {
						HANDNO: handno
					}
				});
			}
		}
	});
}

function quickaddwarem() {
	var noteno = $('#unoteno').val();
	var wareid = $('#wquickuwareid').val();
	if (wareid == undefined || wareid == "") {
		alerttext("请重新选择货号！");
	} else {
		alertmsg(2);
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp", //调用WebService的地址和方  法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "writewareinmsum",
				noteno: noteno,
				wareid: wareid,
				rows: JSON.stringify(jsondata)
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				if (valideData(data)) {
					$('#quickud').dialog('close');
					$('#quickuaddwaref')[0].reset();
					$('#quickutable').html('');
					$('#wquickuwareno').val('');
					$('#wquickuwareid').val('');
					getnotewarem(noteno, '1');
					$('#alldisc').val('');
					$('#allpri').val('');
					$("#wquickuwareno").parent().children("ul").html("");
					$("#wquickuwareno").parent().children("ul").hide();
					$('#wquickuwareno').focus();
				}
			}
		});
	}
}
//打开打折框
function opendisc() {
	$('#discd').dialog({
		modal: true
	});
	$('#discd').dialog('open');
	$('#alldiscount').focus();
}
//整单打折	
function alldisc() {
	var discount = $('#alldiscount').val();
	var noteno = $('#unoteno').val();
	if (discount == '') {
		alerttext('请输入折扣');
	} else {
		alertmsg(2);
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp", //调用WebService的地址和方  法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "changewareinmdisc",
				noteno: noteno,
				discount: discount
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				if (valideData(data)) {
					$("#discd").dialog('close');
					getnotewarem(noteno, '1');
				}
			}
		});
	}
}
//打开付款窗口
function openpay() {
	$('#discpay').val('');
	$('#sumpay').val('');
	$('#nopay').val('');
	$('#discpay').removeAttr('readonly');
	var amt = $('#waret').datagrid('getRows').length;
	if (amt == 0) {
		alert('商品明细不能为空！');
	} else {
		var provid = $('#uprovid').val();
		$('#thispay').val($('#wtotalcurr').val());
		getpaywaylist();
		$('#updatediv').show();
		$('#payd').dialog('open');
	}
}
//付款明细窗口
function openpaydetail() {
	$('#discpaym').val('');
	$('#sumpaym').val('');
	$('#nopaym').val('');
	$('#discpaym').attr('readonly', true);
	$('#paydetaild').dialog({
		title: '付款明细',
		modal: true
	});
	var provid = $('#uprovid').val();
	$('#totalpaym').val($('#wtotalcurr').val());
	$('#paydetaild').dialog('open');
	getwareinpay();
}
//生成支付列表行

function getpaywaylist() {
	$('.paytr').detach();
	var noteno = $('#unoteno').val();
	var houseid = Number($("#uhouseid").val());
	houseid = xsdpdz == 1 ? houseid : 0;
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		async: false,
		data: {
			erpser: "getwareincheck",
			houseid: houseid,
			noteno: noteno
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) {
			if (valideData(data)) {
				$('#thispay').val(Number(data.TOTALCURR).toFixed(2));
				var balcurr = data.BALCURR;
				$('#pastpay').val(Number(balcurr).toFixed(2));
				var rows = data.PAYLIST;
				payline = getJsonLength(rows);
				var i = 1;
				var length = getJsonLength(rows);
				var tr = document.createElement("tr");
				var newtr = true;
				for (var row in rows) {
					if(newtr){
						tr = document.createElement("tr");
						tr.className = "paytr";
					}
					if (rows[row].PAYNO == "S" || rows[row].PAYNO == "R" || rows[row].PAYNO == "W" || rows[row].PAYNO == "Z")
						continue;
					var td1 = document.createElement("td");
					var td2 = document.createElement("td");
					var label = document.createElement("label");
					var inputt = document.createElement("input");
					var inputh = document.createElement("input");
					inputt.type = "text";
					inputh.type = "hidden";
					label.innerHTML = rows[row].PAYNAME;
					label.style.cursor = "pointer";
					label.onclick = function() {
						$('.paycurr').val("");
						var pi = this.id.replace("payname", "");
						var thispay = Number($('#thispay').val());
						var discpay = Number($('#discpay').val());
						var actpay = thispay - discpay;
						$('#pay' + pi).val(actpay.toFixed(2));
						sumpay();
						$('#pay' + pi).select().focus();
					};
					label.id = "payname" + i;
					inputt.id = "pay" + i;
					inputt.className = "wid160 hig25 paycurr";
					inputt.placeholder = "<输入>";
					$(inputt).change(function() {
						this.value = Number(this.value).toFixed(2);
					});
					inputt.onkeyup = function() {
						if (this.value != "-") {
							this.value = this.value.replace(/[^-?\d.*$]/g, '');
							sumpay();
						}
					};
					inputt.onafterpaste = function() {
						if (this.value != "-") {
							this.value = this.value.replace(/[^-?\d.*$]/g, '');
						}
					};
					inputh.id = "payid" + i;
					inputh.value = rows[row].PAYID;
					td1.appendChild(label);
					td1.align = "right";
					td1.className = "header";
					td2.appendChild(inputt);
					td2.align = "right";
					td2.appendChild(inputh);
					tr.appendChild(td1);
					tr.appendChild(td2);
					if(newtr){
						newtr = false;
					}else{
						newtr = true;
						$('#paylist').before(tr);
					}
					i = i + 1;
				}
				if(newtr==false) $('#paylist').before(tr);
				$('#discpay').focus();
				setTimeout(function() {
					sumpay();
					$('#pay1').focus();
				}, 200);
			} else {
				$('#payd').dialog('close');
			}
		}
	});
}
//得到支付记录
function getwareinpay() {
	var noteno = $('#unoteno').val();
	var houseid = Number($("#uhouseid").val());
	houseid = xsdpdz == 1 ? houseid : 0;
	$('.paymtr').detach();
	alertmsg(2);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		async: false,
		data: {
			erpser: "getwareinpaye",
			houseid: houseid,
			noteno: noteno
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) {
			$('#discpaym').val('0.00');
			$('#sumpaym').val('0.00');
			$('#nopaym').val('0.00');
			if (valideData(data)) {
				var rows = data.PAYLIST;
				var totalcurr = data.TOTALCURR;
				var balcurr = data.BALCURR;
				$('#thispay').val(Number(totalcurr).toFixed(2));
				$('#pastpaym').val(balcurr);
				var total = getJsonLength(rows);
				var i = 1;
				var sumpay = 0;
				for (var row in rows) {
					var curr = Number(rows[row].CURR);
					if (rows[row].PAYNO == '*') {
						$('#discpaym').val(curr.toFixed(2));
					} else {
						var tr = document.createElement("tr");
						tr.className = 'paymtr';
						var td1 = document.createElement("td");
						var td2 = document.createElement("td");
						var inputt = document.createElement("input");
						var label = document.createElement("label");
						inputt.type = "text";
						label.innerHTML = rows[row].PAYNAME;
						inputt.readOnly = true;
						inputt.value = curr.toFixed(2);
						inputt.className = "wid160 hig25";
						td1.align = "right";
						td1.className = "header";
						td2.align = "right";
						td1.appendChild(label);
						td2.appendChild(inputt);
						tr.appendChild(td1);
						tr.appendChild(td2);
						i = i + 1;
						sumpay = curr + sumpay;
						$('#paymlist').before(tr);
					}
				}
				$('#sumpaym').val(Number(sumpay).toFixed(2));
			}
			var actpay = Number($('#totalpaym').val()) - Number($('#discpaym').val());
			var nopay = actpay - Number($('#sumpaym').val());
			$('#actpaym').val(Number(actpay).toFixed(2));
			$('#nopaym').val(Number(nopay).toFixed(2));
		}
	});
}
//求付款合计
var paydata;
var paylist = "";

function sumpay() {
	var pastpay = Number($('#pastpay').val());
	var thispay = Number($('#thispay').val());
	var discpay = Number($('#discpay').val());
	pastpay = isNaN(pastpay) ? 0 : pastpay;
	thispay = isNaN(thispay) ? 0 : thispay;
	discpay = isNaN(discpay) ? 0 : discpay;
	$('#discpay').val(discpay.toFixed(2));
	var json = [];
	var sum = 0;
	var count = 0;
	paylist = '';
	for (var i = 1; i <= $("input.paycurr").length; i++) {
		if ($('#pay' + i).length > 0) {
			var pay = Number($('#pay' + i).val() == '' ? '0' : $('#pay' + i).val());
			sum = sum + pay;
			var payid = $('#payid' + i).val();
			if (pay != 0) {
				paylist += $('#payname' + i).html() + ":" + pay + ",";
				json[count] = {
					"payid": payid,
					"paycurr": pay
				};
				count = count + 1;
			}
		}
	}
	paydata = json;
	$('#sumpay').val(sum.toFixed(2));
	var nopay = thispay - discpay - sum;
	$('#thisqkpay').val((pastpay + nopay).toFixed(2));
	$('#nopay').val(nopay.toFixed(2));
}

function updatewareinh(print) {
	var id = $('#uid').val();
	var provid = $('#uprovid').val();
	var houseid = $('#uhouseid').val();
	var noteno = $('#unoteno').val();
	var totalcurr = Number($('#thispay').val());
	var totalamt = $('#wtotalamt').val();
	var paycurr0 = $('#discpay').val() == "" ? "0" : $('#discpay').val();
	var notedatestr = $('#unotedate').datetimebox('getValue');
	if (notedatestr.length != 19) {
		alerttext("请选择单据日期!");
		return;
	}
	parcurr0 = isNaN(Number(paycurr0)) ? 0 : Number(paycurr0);
	var sumpay = isNaN(Number($('#sumpay').val())) ? "0" : Number($('#sumpay').val());
	var thispay = isNaN(Number($('#thispay').val())) ? "0" : Number($('#thispay').val());
	var nopay = $('#nopay').val();
	nopay = isNaN(Number(nopay)) ? 0 : Number(nopay);
	var dofn = function(){
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "updatewareinhbyid",
				noteno: noteno,
				statetag: '1',
				ntid: '0',
				provid: provid,
				houseid: houseid,
				totalcurr: (allowinsale==1?totalcurr:null),
				totalamt: totalamt,
				notedatestr: notedatestr,
				paycurr0: paycurr0,
				paylist: JSON.stringify(paydata)
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				if (valideData(data)) {
					if (print) {
						$('#print').click();
					}
					if (paycurr0 != 0)
						paylist = '折让：' + paycurr0 + "，" + paylist;
					if (nopay != 0)
						paylist += "挂账：" + nopay;
					$('#ud').dialog('close');
					$('#payd').dialog('close');
					var $dg = $("#gg");
					var index = $dg.datagrid("getRowIndex",noteno);
					$dg.datagrid('updateRow', {
						index: index,
						row: {
							STATETAG: '1',
							PAYLIST: paylist
						}
					}).datagrid('refresh');
				}
			}
		});
	}
	if (sumpay <= thispay) {
		$.messager.confirm(dialog_title, '单据提交后禁止修改及删除，是否继续提交？', function(r) {
			if (r) {
				dofn();
			}
		});
	} else {
		if ((sumpay > thispay) && paycurr0 == 0) {
			$.messager.confirm(dialog_title, '本次付款大于应付金额，是否确认提交？', function(r) {
				if (r) {
					dofn();
				}
			});
		} else if (paycurr0 > thispay) {
			alert('本次付款大于应付金额，折让只允许小于等于本单应付！');
		}
	}
}

function withdraw() {
	var istoday = $('#uistoday').val();
	var noteno = $('#unoteno').val();
	var id = $('#uid').val();
	if (Number(istoday) == 1 || allowchangdate == 1) {
		$.messager.confirm(dialog_title, '您确定撤单吗？', function(r) {
			if (r) {
				alertmsg(2);
				$.ajax({
					type: "POST", //访问WebService使用Post方式请求 
					url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
					data: {
						erpser: "wareinhcancel",
						noteno: noteno
					}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
					dataType: 'json',
					success: function(data) { //回调函数，result，返回值 
						if (valideData(data)) {
							var $dg = $("#gg");
							var index = $dg.datagrid("getRowIndex",noteno);
							var rows = $dg.datagrid('getRows');
							var row = rows[index];
							if (row.OPERANT == getValuebyName("EPNAME")) {
								$dg.datagrid('updateRow', {
									index: index,
									row: {
										STATETAG: '0',
										PAYLIST: ""
									}
								});
							} else {
								$dg.datagrid('deleteRow', index);
								dqzamt = Number(dqzamt) - Number(row.TOTALAMT);
								dqzcurr = Number(dqzcurr) - Number(row.TOTALCURR);
								dqzjl = dqzjl - 1;
								$dg.datagrid('updateFooter', {
									TOTALAMT: dqzamt,
									TOTALCURR: dqzcurr
								});
								$('#pp_total').html((dqzjl - 1));
							}
							$dg.datagrid('refresh');
							$('#ud').dialog('close');
						}
					}
				});
			}
		});
	} else {
		alerttext('本单据不是当天单据，撤单只对当天单据有效！');
	}
}
var selloutser = true;

function openselloutd() {
	if (selloutser)
		setselloutt();
	$('#selloutd').dialog('open');
	sellerwareouthlist('1');
}

function setselloutt() {
	$('#selloutpp').createPage({
		pageCount: 1,
		current: 1,
		backFn: function(p) {
			sellerwareouthlist(p.toString());
		}
	});
	$('#selloutt').datagrid({
		idField: 'ID',
		width: '100%',
		height: 280,
		fitColumns: true,
		striped: true, //隔行变色
		singleSelect: true,
		columns: [
			[{
				field: 'ROWNUMBER',
				title: '序号',
				width: 30,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return index + 1;
				}
			}, {
				field: 'NOTENO',
				title: '单据号',
				width: 200,
				halign: 'center',
				align: 'center'
			}, {
				field: 'NOTEDATE',
				title: '单据日期',
				width: 200,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return value.substring(0, 16);
				}
			}, {
				field: 'PROVNAME',
				title: '供应商',
				width: 200,
				hidden: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'PROVNAME',
				title: '供应商',
				width: 200,
				halign: 'center',
				align: 'center'
			}, {
				field: 'TOTALCURR',
				title: '总金额',
				width: 200,
				halign: 'center',
				align: 'right',
				formatter: function(value, row, index) {
					return Number(value).toFixed(2);
				}
			}, {
				field: 'TOTALAMT',
				title: '总数量',
				width: 200,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return Number(value);
				}
			}, {
				field: 'OPERANT',
				title: '制单人',
				width: 200,
				halign: 'center',
				align: 'center'
			}]
		],
		onDblClickRow: function(index, data) {
			loadselloutnote();
		},
		pageSize: 20
	}).datagrid("keyCtr", "loadselloutnote()");
}

function sellerwareouthlist(page) {
	alertmsg(6);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "sellerwareouthlist",
			houseid: getValuebyName("HOUSEID"),
			rows: pagecount,
			page: page
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			if (valideData(data)) {
				$('#sellout_total').html("共有" + data.total + "条记录");
				$('#selloutpp').setPage({
					pageCount: Math.ceil(data.total / pagecount),
					current: Number(page)
				});
				$('#selloutt').datagrid('loadData', data);
			}
		}
	});

}

function loadselloutnote() {
	var row = $('#selloutt').datagrid("getSelected");
	if (row) {
		var noteno = row.NOTENO;
		var sellaccid = row.ACCID;
		alertmsg(2);
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求
			url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "loadsellerwareout",
				noteno: noteno,
				houseid: getValuebyName('HOUSEID'),
				sellaccid: sellaccid
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				try {
					if (valideData(data)) {
						alerttext("载入成功,入库单号：" + data.NOTENO);
						getnotedata();
						getnotebyid(data.NOTENO);
						if ($('#selloutt').datagrid("getRows").length == 1) {
							top.gysfhdnum = 0;
							$('#gysfhnum').removeClass('newmsg');
							$(top.$("#iframe_home"))[0].contentWindow.getskymsg();
						}
					}
				} catch (e) {
					console.error(e);
				}
			}
		});
		$('#selloutd').dialog('close');
	} else
		alerttext("请选择单据！");

}
//载入采购订单表
function loadcg(provid) {
	if (Number(provid) == 0 || isNaN(Number(provid))) {
		alerttext("请选择供应商!");
	} else {
		$('#loadd').dialog('open');
	}

}
function resetload() {
	$("#loadform input").val("");
}
//载入到入库单
function loadnote() {
	var noteno = $('#unoteno').val();
	var provid = $('#uprovid').val();
	var wareid = $('#lwareid').val();
	var typeid = $('#ltypeid').val();
	var brandid = $('#lbrandid').val();
	var seasonname = $('#lseasonname').val();
	var prodyear = $('#lprodyear').val();
	if (Number(provid) == 0 || isNaN(Number(provid))) {
		alerttext('请选择供应商');
	} else {
		alertmsg(2);
		$.ajax({
			type: "POST", //访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: "loadprovorderm",
				noteno: noteno,
				provid: provid,
				wareid: wareid,
				typeid: typeid,
				brandid: brandid,
				seasonname: seasonname,
				prodyear: prodyear
			}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值 
				if (valideData(data)) {
					getnotewarem(noteno, '1');
				}
			}
		});
		$('#loadd').dialog('close');
	}
}

//获取是否为当天单据
function getnotebyid(noteno) {
	alertmsg(6);
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "getwareinhbyid",
			noteno: noteno,
			fieldlist: "a.id,a.noteno,a.accid,a.notedate,a.provid,a.orderno,a.houseid,a.ntid,a.handno,a.remark,a.operant,a.checkman,a.statetag,a.lastdate,a.totalamt,a.totalcurr,a.totalcost,b.provname,b.discount,b.pricetype,c.housename,a.cleartag,a.paylist"
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					var rows = data.rows;
					if(data.total>0){
						var row = rows[0];
						$('#udnoteform input[type=hidden]').val('');
						$('#uid').val(row.ID);
						$('#unoteno').val(row.NOTENO);
						$('#uhouseid').val(row.HOUSEID);
						$('#uhousename').val(row.HOUSENAME);
						$('#uprovid').val(row.PROVID);
						$('#uprovname').val(row.PROVNAME);
						$('#uhandno').val(row.HANDNO);
						$('#wtotalcurr').val(row.TOTALCURR);
						$('#wtotalamt').val(row.TOTALAMT);
						$('#uoperant').val(row.OPERANT);
						$('#uremark').val(row.REMARK);
						$('#untid').val(row.NTID);
						$('#udiscount').val(row.DISCOUNT);
						$('#upricetype').val(row.PRICETYPE);
						$('#ustatetag').val(row.STATETAG);
						$("#uorderno").html(row.ORDERNO);
						if(row.ORDERNO.length>0){
							$("#div_orderno").show();
						}else{
							$("#div_orderno").hide();
						}
						var $dg = $("#gg");
						dqamt = row.TOTALAMT;
						dqcurr = row.TOTALCURR;
						var istoday = row.ISTODAY;
						$('#uistoday').val(istoday);
						var cleartag = row.CLEARTAG;
						var stg = row.STATETAG;
						if ((Number(istoday) == 1 || allowchangdate == 1) && allowchedan == '1' && cleartag == '0' && stg == "1") {
							$('#sep-withdraw').show();
							$('#withdrawbtn').show();
							$('#clearnotebar').hide();
						} else if (Number(istoday) == 0 && Number(allowclear) > 0 && cleartag == '0' && stg == "1") {
							$('#clearnotebar').show();
							$('#sep-withdraw').hide();
							$('#withdrawbtn').hide();
						} else {
							$('#clearnotebar').hide();
							$('#sep-withdraw').hide();
							$('#withdrawbtn').hide();
						}
						var epname = getValuebyName("EPNAME");
						var operant = row.OPERANT;
						if (stg==1||epname!=operant) {
							$('#ud').dialog("setTitle","浏览采购入库单");
							$('#uhandno,#uremark,#uhousename,#uprovname').attr('readonly', 'readonly');
							$('#updatingbar,#wquickuwaretd,#ud #warem-toolbar').hide();
							$('#uhousename').next().hide();
							$('#uprovname').next().hide();
							$('#isupdatedbar').show();
							//$('#waret').datagrid('hideColumn','ACTION');
							if (allowchedan == '1') {
								$('#ud').data('qickey', "F8:'openpaydetail()',F9:'$(\"#print\").click()',F10:'withdraw()'");
							} else {
								$('#ud').data('qickey', "F8:'openpaydetail()',F9:'$(\"#print\").click()'");
							}
							if (allowinsale == 1&&stg==1) {
								$('#paydetail,span.paynote').show();
							} else {
								$('#paydetail,span.paynote').hide();
							}
							$('#unotedate').datetimebox({
								readonly: true,
								hasDownArrow: false
							});
						} else {
							$('#ud').dialog("setTitle","修改采购入库单");
							$('#uhousename,#uhandno,#uremark,#uprovname').removeAttr('readonly')
							$('#isupdatedbar').hide();
							$('#updatingbar,#wquickuwaretd,#ud #warem-toolbar').show();
							$('#uhousename').next().show();
							$('#uprovname').next().show();
							$('#wquickuwareno').val('');
							//$('#waret').datagrid('showColumn','ACTION');
							$('#ud').data('qickey', "F4:'openpay()',F6:'opendisc()',Del:'delwareinh()'");
							$('#unotedate').datetimebox({
								readonly: false,
								hasDownArrow: true
							});
						}
						changedatebj = false;
						$('#unotedate').datetimebox('setValue', row.NOTEDATE);
						changedatebj = true;
						$('#ud').dialog('open');
						var totalcost = Number(row.TOTALCOST);
						$('#usaletotalcost').val(totalcost.toFixed(2));
						var totalcurr = Number(row.TOTALCURR);
						$('#paynote_totalcheckcurr').html(totalcurr.toFixed(2));
						getnotewarem(noteno, 1);
						if (stg==1) {
							$('#unoteno').focus();
						} else {
							$('#wquickuwareno').focus();
						}
					}
				}
			} catch (e) {
				// TODO: handle exception
				console.error(e);top.wrtiejsErrorLog(e);
			}
		}
	});
}

var provorderser = true;
function openprovorderd() {
	var houseid = Number($('#uhouseid').val());
	var provid = Number($('#uprovid').val());
	if (houseid > 0 && provid > 0) {
		if (provorderser)
			setprovordert();
		$('#provorderd').dialog('open');
		loadprovorderhlist('1');
	} else
		alerttext('请选择店铺或者供应商');
}

function setprovordert() {
	$('#provorderpp').createPage({
		pageCount: 1,
		current: 1,
		backFn: function(p) {
			loadprovorderhlist(p.toString());
		}
	});
	$('#provordert').datagrid({
		idField: 'ID',
		width: '100%',
		height: 280,
		fitColumns: true,
		striped: true, //隔行变色
		singleSelect: true,
		showFooter: true,
		columns: [
			[{
				field: 'ROWNUMBER',
				title: '序号',
				width: 30,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					var rn = Number(value);
					if (!isNaN(rn))
						return rn;
					else return "";
				}
			}, {
				field: 'NOTENO',
				title: '单据号',
				width: 120,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'NOTEDATE',
				title: '单据日期',
				width: 110,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return row.NOTEDATE == undefined ? '' : row.NOTEDATE.substring(0, 16);
				}
			}, {
				field: 'PROVNAME',
				title: '供应商',
				width: 100,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'TOTALCURR',
				title: '总金额',
				width: 100,
				fixed: true,
				halign: 'center',
				align: 'right',
				hidden: (allowinsale == '1' ? false : true),
				formatter: function(value, row, index) {
					return allowinsale == '1' ? value : "***";
				}
			}, {
				field: 'TOTALAMT',
				title: '订货数',
				width: 60,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return Number(value);
				}
			}, {
				field: 'TOTALFACTAMT',
				title: '已发货',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return Number(value);
				}
			}, {
				field: 'BALAMT',
				title: '未发货',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					var totalamt = Number(row.TOTALAMT);
					var totalfactamt = Number(row.TOTALFACTAMT);
					if (!isNaN(totalamt)) {
						var balamt = totalamt - totalfactamt;
						return balamt;
					}
					return "";
				}
			}, {
				field: 'OPERANT',
				title: '制单人',
				width: 200,
				halign: 'center',
				align: 'center'
			}]
		],
		onDblClickRow: function(index, data) {
			loadprovordernote();
		},
		pageSize: 20
	}).datagrid("keyCtr", "loadprovordernote()");
}

function loadprovorderhlist(page) {
	alertmsg(6);
	var provid = $('#uprovid').val();
	$.ajax({
		type: "POST", //访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "provorderhnotover",
			provid: provid,
			rows: pagecount,
			fieldlist: "*",
			sort: "notedate,id",
			order: "asc",
			page: page
		}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					$('#provorder_total').html("共有" + data.total + "条记录");
					$('#provorderpp').setPage({
						pageCount: Math.ceil(data.total / pagecount),
						current: Number(page)
					});
					data.footer = [{
						NOTENO: "合计",
						TOTALAMT: data.totalamt,
						TOTALFACTAMT: data.totalfactamt,
						TOTALCURR: data.totalcurr
					}];
					$('#provordert').datagrid('loadData', data);
				}
			} catch (e) {
				console.error(e);
			}
		}
	});

}

function loadprovordernote() {
	var row = $('#provordert').datagrid("getSelected");
	if (row) {
		var orderno = row.NOTENO;
		var noteno = $('#unoteno').val();
		var dofn = function() {
			alertmsg(2);
			$.ajax({
				type: "POST", //访问WebService使用Post方式请求 
				url: "/skydesk/fyjerp", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
				data: {
					erpser: "provordertoin",
					noteno: noteno,
					orderno: orderno
				}, //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
				dataType: 'json',
				success: function(data) { //回调函数，result，返回值 
					try {
						if (valideData(data)) {
							getnotewarem(noteno, '1');
							var $dg = $("#gg");
							var index = $dg.datagrid("getRowIndex",noteno);
							$dg.datagrid('updateRow', {
								index: index,
								row: {
									ORDERNO: orderno
								}
							});
							$("#div_orderno").show();
							$("#uorderno").html(orderno);
						}
					} catch (e) {
						console.error(e);
					}
				}
			});
			$('#provorderd').dialog('close');
		}
		var msg = "是否确认载入采购订单号:" + orderno + "！";
		var rows = $('#waret').datagrid('getRows');
		if (rows.length > 0) {
			msg = "发现该采购出库单子不是空单，载入后将清空原有商品明细，" + msg;
			$.messager.confirm(dialog_title, msg, function(r) {
				if (r) {
					dofn();
				}
			});
		} else {
			dofn();
		}
	} else
		alerttext("请选择单据！");

}
function setpaynotet(){
	$('#paynotepp').createPage({
		pageCount: 1,
		current: 1,
		backFn: function(p) {
			wareinpaycurrlist(p);
		}
	});
	$('#paynotet').datagrid({
		idField: 'NOTENO',
		width: '100%',
		toolbar: "#paynotetoolbar",
		height: 310,
		fitColumns: true,
		striped: true, //隔行变色
		singleSelect: true,
		showFooter: true,
		columns: [
			[{
				field: 'ROWNUMBER',
				title: '序号',
				width: 30,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					var rn = Number(value);
					if (!isNaN(rn))
						return rn;
					else return "";
				}
			}, {
				field: 'NOTEDATE',
				title: '单据日期',
				width: 110,
				fixed: true,
				halign: 'center',
				align: 'center',
				formatter: function(value, row, index) {
					return row.NOTEDATE == undefined ? '' : row.NOTEDATE.substring(0, 16);
				}
			}, {
				field: 'NOTENO',
				title: '单据号',
				width: 120,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'REMARK',
				title: '摘要',
				width: 100,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'PAYNAME',
				title: '结算方式 ',
				width: 100,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'CURR',
				title: '付款金额',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'right',
				formatter: currfm2
			}, {
				field: 'CURR0',
				title: '本单勾单',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'right',
				formatter: currfm2
			}, {
				field: 'HANDNO',
				title: '自编号',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'OPERANT',
				title: '制单人',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'CHECKMAN',
				title: '审核人',
				width: 80,
				fixed: true,
				halign: 'center',
				align: 'center'
			}, {
				field: 'ACTION',
				title: '操作',
				width: 80,
				fixed: true,
				hidden: true,
				halign: 'center',
				align: 'center',
				formatter: function(value,row,index){
					if(row.NOTEDATE=="合计") return "";
					return '<input type="button" class="m-btn" value="删除" onclick="delpaynote(' + index + ')">';
				}
			}]
		],
		onDblClickRow: function(index, row) {
			var noteno = row.NOTENO;
			if (noteno.length > 0 && detail_bol == true) {
				var pgno = noteno.substring(0, 2);
				opendetaild(pgno, noteno);
			}
		},
		onDblClickCell: function(index, field, value) {
			if (field == "ACTION") {
				detail_bol = false;
			} else detail_bol = true;
		},
		pageSize: 20
	}).datagrid("keyCtr");
}
function openpaynoted(){
	if($("#paynotet").data().datagrid==undefined){
		setpaynotet();
	}
	wareinpaycurrlist(1);
	$("#paynoted").dialog("open");
}

function wareinpaycurrlist(page){
	var noteno = $("#unoteno").val();
	alertmsg(2);
	$.ajax({
		type: "POST",
		//访问WebService使用Post方式请求 
		url: "/skydesk/fyjerp",
		//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
		data: {
			erpser: "wareinpaycurrlist",
			noteno: noteno,
			rows: pagecount,
			page: page
		},
		//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
		dataType: 'json',
		success: function(data) { //回调函数，result，返回值 
			try {
				if (valideData(data)) {
					$("#paynotetotal").html(data.total);
					$("#paynotepp").setPage({
						pageCount: Math.ceil(data.total / pagecount),
						current: Number(page)
					});
					data.footer = [{
						NOTEDATE: "合计",
						CURR: data.totalcurr,
						CURR0: data.totalcurr0
					}];
					var totalcheckcurr = new Decimal($("#paynote_totalcheckcurr").html());
					var paybalcurr = totalcheckcurr.sub(data.totalcurr0);
					if((Number(data.totalcurr0)>=totalcheckcurr && totalcheckcurr>0) || (Number(data.totalcurr0)<=totalcheckcurr && totalcheckcurr<0) || totalcheckcurr==0) 
						$("#btn_addpaynote").hide();
					else  
						$("#btn_addpaynote").show();
					$("#paynote_paybalcurr").html(paybalcurr.toFixed(2));
					$("#paynotecurr").attr("placeholder","<金额不得大于"+paybalcurr.toFixed(2)+">");
					$("#paynotet").datagrid("loadData",data);
				}
			} catch(e) {
				console.error(e);
			}
		}
	});
}
function addpaynoted(){
	$("#upaynoted table input:not(#paynotenoteno)").val("");
	$("#paynotedate").val(new Date(top.getservertime()).Format('yyyy-MM-dd hh:mm:ss'));
	$("#upaynoted").dialog("open");
}
//保存或提交
function addpaynote(statetag) {
	if ($('#uprovname').val() == "") {
		alerttext('请选择供应商！');
		return;
	} else if ($('#paynotepayname').val() == "") {
		alerttext("请选择结算方式！");
		return;
	}
	var paybalcurr = new Decimal($("#paynote_paybalcurr").html());
	var notedate = $('#paynotedate').val();
	var provid = $('#uprovid').val();
	var curr = Number($('#paynotecurr').val());
	if ((curr > paybalcurr && paybalcurr>0) || (curr < paybalcurr && paybalcurr<0)) {
		alerttext('结算金额大于该单的未结余额');
		return;
	}
	var handno = $('#paynotehandno').val();
	var ynoteno = $('#unoteno').val();
	var remark = $('#paynoteremark').val();
	var payid = $('#paynotepayid').val();
	var houseid = $('#uhouseid').val();
	erpser="addpaycurr";
	var dofn = function() {
		alertmsg(2);
		$.ajax({
			type: "POST",
			//访问WebService使用Post方式请求 
			url: "/skydesk/fyjerp",
			//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
			data: {
				erpser: erpser,
				notedate: notedate,
				provid: provid,
				curr: curr,
				handno: handno,
				remark: remark,
				payid: payid,
				statetag: statetag,
				ynoteno: ynoteno,
				houseid: houseid
			},
			//这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到                          
			dataType: 'json',
			success: function(data) { //回调函数，result，返回值
				if (valideData(data)) {
// 						var custbalcurr = new Decimal($("#ucustbalcurr").html());
// 						custbalcurr = custbalcurr.sub(curr);
						paybalcurr = paybalcurr.add(curr);
// 						$("#ucustbalcurr").html(custbalcurr.toFixed(2));
						$("#paynote_paybalcurr").html(paybalcurr.toFixed(2));
						$("#paynotepp").refreshPage();
						$("#upaynoted").dialog("close");
					}
				}
		});
	};
	$.messager.confirm(dialog_title, '您确认要增加并提交该付款该单据？',
		function(r) {
			if (r) {
				dofn();
			}
	});
}
//删除
function delpaynote(index) {
	var $dg = $("#paynotet");
	var rows = $dg.datagrid("getRows");
	var row = rows[index];
	if (!row) {
		alerttext("单据无效！");
		return;
	}
	var noteno = row.NOTENO;
	$.messager.confirm(dialog_title, '您确认要删除付款单' + noteno + '？',
	function(r) {
		if (r) {
			alertmsg(2);
			$.ajax({
				type: "POST",
				//访问WebService使用Post方式请求 
				url: "/skydesk/fyjerp",
				//调用WebService的地址和方法名称组合 ---- WsURL/方法名 
				data: {
					erpser: "delpaycurrbyid",
					noteno: noteno
				},
				//这里是要传递的参数，格式为 data: {paraName:paraValue},下面将会看到                          
				dataType: 'json',
				success: function(data) { //回调函数，result，返回值
					if (valideData(data)) {
						$("#paynotepp").refreshPage();
					}
				}
			});
		}
	});
}

$('#gg').datagrid({
    onLoadSuccess : function() {
        var $footer_t_b = $('.datagrid-footer .datagrid-footer-inner table tbody');
        var $footer_prev_b = $('.datagrid-footer').prev('.datagrid-body');
        var itemIndex = $footer_t_b.find('tr').last().attr('datagrid-row-index');
        if (itemIndex) {
            var $first_tr = $footer_t_b.find('tr');
            var lineHeight = $first_tr.first().height();
            var bodyHeight = $footer_prev_b.height();
            var tdCount = $first_tr.find('td:visible').size();
            itemIndex = parseInt(itemIndex) + 1;
            $('.datagrid-footer').prev('.datagrid-body').css('height', bodyHeight - lineHeight);
            $footer_t_b.append("<tr class='datagrid-row' datagrid-row-index='"+ itemIndex +"'>" +
                "<td></td>" +
                "<td colspan='"+ (tdCount - 1) +"'>" +
                "<b style='color:#000000;'>单据号：</b>" +
                "<b style='color:#ff3b30;'>红色提交收银台未付款；</b>" +
                "<b style='color:#00959a;margin-left: 5px;'>绿色已收款／挂账；</b>" +
                "<b style='color:#ff7900;margin-left: 5px;'>黄色未付款／未选商品。</b>" +
                //"<b style='color:#ff7900;margin-left: 15px;'>失效订单</b>" +
                "</td>" +
                "</tr>");
        }
    }
});
</script>
	<!-- 商品帮助列表 -->
	<jsp:include page="../HelpList/WareHelpList.jsp"></jsp:include>
	<jsp:include page="../HelpList/WareTypeHelpList.jsp"></jsp:include>
	<!-- 有折扣商品明细弹窗 -->
	<jsp:include page="../HelpList/DiscWarem.jsp"></jsp:include>
	<!-- 店铺帮助列表 -->
	<jsp:include page="../HelpList/HouseHelpList.jsp"></jsp:include>
	<!-- 供应商帮助列表 -->
	<jsp:include page="../HelpList/ProvHelpList.jsp"></jsp:include>
		<!-- 条码增加 -->
<jsp:include page="../HelpList/BarcodeAdd.jsp"></jsp:include>
	<!-- 端口帮助列表 -->
	<jsp:include page="../HelpList/PrintcsHelp.jsp"></jsp:include>
	<jsp:include page="../HelpList/NoteDetail.jsp"></jsp:include>
	<jsp:include page="../HelpList/NoteCheckHelp.jsp"></jsp:include>
		<jsp:include page="../HelpList/SaleCost.jsp"></jsp:include>
		<jsp:include page="../HelpList/PayWayHelpList.jsp"></jsp:include>
		<jsp:include page="../HelpList/ImportHelp.jsp"></jsp:include>
		<jsp:include page="../HelpList/ExportHelp.jsp"></jsp:include>
</body>
</html>