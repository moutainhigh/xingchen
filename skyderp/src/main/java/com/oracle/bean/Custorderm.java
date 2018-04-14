package com.oracle.bean;

import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.comdot.data.DataSet;
import com.comdot.data.Table;
import com.common.tool.Func;
import com.common.tool.PinYin;
import com.flyang.main.pFunc;
////import com.common.tool.SizeParam;
import com.netdata.db.DbHelperSQL;
import com.netdata.db.ProdParam;
import com.netdata.db.QueryParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//*************************************
//  @author:sunhong  @date:2017-02-23 10:50:42
//*************************************
public class Custorderm implements java.io.Serializable {
	private Float Id;
	private String Noteno;
	private Long Accid;
	private Long Userid;
	private Long Wareid;
	private Long Colorid;
	private Long Sizeid;
	private Float Amount;
	private Float Price0;
	private Float Discount;
	private Float Price;
	private Float Curr;
	private String Remark0;
	private Date Lastdate;
	private Float Factamt;
	private String errmess;
	private String Wareno;
	private String Colorname;
	private String Sizename;
	// private String Accbegindate = "2000-01-01"; // 账套开始使用日期

	public void setId(Float id) {
		this.Id = id;
	}

	public Float getId() {
		return Id;
	}

	public void setNoteno(String noteno) {
		this.Noteno = noteno;
	}

	public String getNoteno() {
		return Noteno;
	}

	public void setAccid(Long accid) {
		this.Accid = accid;
	}

	public Long getAccid() {
		return Accid;
	}

	public void setWareid(Long wareid) {
		this.Wareid = wareid;
	}

	public void setUserid(Long userid) {
		this.Userid = userid;
	}

	public Long getWareid() {
		return Wareid;
	}

	public void setColorid(Long colorid) {
		this.Colorid = colorid;
	}

	public Long getColorid() {
		return Colorid;
	}

	public void setSizeid(Long sizeid) {
		this.Sizeid = sizeid;
	}

	public Long getSizeid() {
		return Sizeid;
	}

	public void setAmount(Float amount) {
		this.Amount = amount;
	}

	public Float getAmount() {
		return Amount;
	}

	public void setPrice0(Float price0) {
		this.Price0 = price0;
	}

	public Float getPrice0() {
		return Price0;
	}

	public void setDiscount(Float discount) {
		this.Discount = discount;
	}

	public Float getDiscount() {
		return Discount;
	}

	public void setPrice(Float price) {
		this.Price = price;
	}

	public Float getPrice() {
		return Price;
	}

	public void setCurr(Float curr) {
		this.Curr = curr;
	}

	public Float getCurr() {
		return Curr;
	}

	public void setRemark0(String remark0) {
		this.Remark0 = remark0;
	}

	public String getRemark0() {
		return Remark0;
	}

	// public void setLastdate(Date lastdate) {
	// this.Lastdate = lastdate;
	// }
	//
	// public String getLastdate() {
	// DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// return df.format(Lastdate);
	// }

	public void setFactamt(Float factamt) {
		this.Factamt = factamt;
	}

	public Float getFactamt() {
		return Factamt;
	}

	public String getErrmess() { // 取错误提示
		return errmess;
	}

	public void setWareno(String wareno) {
		Wareno = wareno;
	}

	public void setColorname(String colorname) {
		Colorname = colorname;
	}

	public void setSizename(String sizename) {
		Sizename = sizename;
	}

	// public void setAccbegindate(String accbegindate) {
	// this.Accbegindate = accbegindate;
	// }

	// 删除记录
	public int Delete() {
		if (Wareid == 0 || Colorid == 0 || Noteno == "") {
			errmess = "wareid或colorid或noteno不是一个有效值！";
			return 0;
		}

		StringBuilder strSql = new StringBuilder();

		strSql.append("declare ");
		strSql.append("\n   v_totalcurr number; ");
		strSql.append("\n   v_totalamt number; ");
		strSql.append("\n begin ");
		strSql.append("\n   delete from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + " and colorid=" + Colorid + "; ");
		strSql.append("\n   select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "';");
		strSql.append("\n   update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt where accid=" + Accid + " and noteno='" + Noteno + "';");
		strSql.append("\n   commit;");
		strSql.append("\n end;");

		if (DbHelperSQL.ExecuteSql(strSql.toString()) < 0) {
			errmess = "删除失败！";
			return 0;
		} else {
			errmess = "删除成功！";
			return 1;
		}
	}

	// 增加记录
	public int Append() {
		StringBuilder strSql = new StringBuilder();
		StringBuilder strSql1 = new StringBuilder();
		StringBuilder strSql2 = new StringBuilder();
		strSql1.append("id,");
		strSql2.append("v_id,");
		// if (Id != null) {
		// strSql1.append("id,");
		// strSql2.append("'" + Id + "',");
		// }
		// if (Noteno != null) {
		strSql1.append("noteno,");
		strSql2.append("'" + Noteno + "',");
		// }
		// if (Accid != null) {
		strSql1.append("accid,");
		strSql2.append(Accid + ",");
		// }
		if (Wareid != null) {
			strSql1.append("wareid,");
			strSql2.append(Wareid + ",");
		}
		if (Colorid != null) {
			strSql1.append("colorid,");
			strSql2.append(Colorid + ",");
		}
		if (Sizeid != null) {
			strSql1.append("sizeid,");
			strSql2.append(Sizeid + ",");
		}
		if (Amount != null) {
			strSql1.append("amount,");
			strSql2.append(Amount + ",");
		}
		if (Price0 != null) {
			strSql1.append("price0,");
			strSql2.append("'" + Price0 + "',");
		}
		if (Discount != null) {
			strSql1.append("discount,");
			strSql2.append(Discount + ",");
		}
		if (Price != null) {
			strSql1.append("price,");
			strSql2.append("'" + Price + "',");
		}
		if (Curr != null) {
			strSql1.append("curr,");
			strSql2.append("'" + Curr + "',");
		}
		if (Remark0 != null) {
			strSql1.append("remark0,");
			strSql2.append("'" + Remark0 + "',");
		}
		if (Factamt != null) {
			strSql1.append("factamt,");
			strSql2.append("'" + Factamt + "',");
		}
		strSql1.append("lastdate");
		strSql2.append("sysdate");
		strSql.append("declare ");
		strSql.append("   v_id number; ");
		strSql.append(" begin ");
		strSql.append("   v_id:=custorderm_id.nextval; ");
		strSql.append("   insert into custorderm (");
		strSql.append("  " + strSql1.toString());
		strSql.append(")");
		strSql.append(" values (");
		strSql.append("  " + strSql2.toString());
		strSql.append(");");
		strSql.append("  select v_id into :id from dual; ");
		strSql.append(" end;");
		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("id", new ProdParam(Types.BIGINT));
		int ret = DbHelperSQL.ExecuteProc(strSql.toString(), param);

		if (ret < 0)
			return 0;
		else {
			long id = Long.parseLong(param.get("id").getParamvalue().toString());
			return 1;
		}
	}

	// 修改记录
	public int Update() {
		StringBuilder strSql = new StringBuilder();
		strSql.append("begin ");
		strSql.append("   update custorderm set ");
		// if (Id != null) {
		// strSql.append("id='" + Id + "',");
		// }
		// if (Noteno != null) {
		// strSql.append("noteno='" + Noteno + "',");
		// }
		// if (Accid != null) {
		// strSql.append("accid=" + Accid + ",");
		// }
		if (Wareid != null) {
			strSql.append("wareid=" + Wareid + ",");
		}
		if (Colorid != null) {
			strSql.append("colorid=" + Colorid + ",");
		}
		if (Sizeid != null) {
			strSql.append("sizeid=" + Sizeid + ",");
		}
		if (Amount != null) {
			strSql.append("amount=" + Amount + ",");
		}
		if (Price0 != null) {
			strSql.append("price0='" + Price0 + "',");
		}
		if (Discount != null) {
			strSql.append("discount=" + Discount + ",");
		}
		if (Price != null) {
			strSql.append("price='" + Price + "',");
		}
		if (Curr != null) {
			strSql.append("curr='" + Curr + "',");
		}
		if (Remark0 != null) {
			strSql.append("remark0='" + Remark0 + "',");
		}
		if (Factamt != null) {
			strSql.append("factamt='" + Factamt + "',");
		}
		strSql.append("lastdate=sysdate");
		strSql.append("  where id=" + Id + " ;");
		strSql.append("  commit;");
		strSql.append(" end;");
		int ret = DbHelperSQL.ExecuteSql(strSql.toString());
		if (ret < 0)
			return 0;
		else
			return 1;

	}

	// 获得数据列表
	public DataSet GetList(String strWhere, String fieldlist) {
		StringBuilder strSql = new StringBuilder();
		strSql.append("select " + fieldlist);
		strSql.append(" FROM custorderm ");
		if (!strWhere.equals("")) {
			strSql.append(" where " + strWhere);
		}
		return DbHelperSQL.Query(strSql.toString());
	}

	// 获取分页数据
	public Table GetTable(QueryParam qp, String strWhere, String fieldlist) {
		StringBuilder strSql = new StringBuilder();
		strSql.append("select " + fieldlist);
		strSql.append("\n FROM custorderm a");
		strSql.append("\n left outer join warecode b on a.wareid=b.wareid");
		strSql.append("\n left outer join colorcode c on a.colorid=c.colorid");
		strSql.append("\n left outer join sizecode d on a.sizeid=d.sizeid");
		strSql.append("\n left outer join brand f on b.brandid=f.brandid");
		if (!strWhere.equals("")) {
			strSql.append(" where " + strWhere);
		}
		qp.setQueryString(strSql.toString());
		return DbHelperSQL.GetTable(qp);
	}

	// 获取分页数据
	public Table GetTable(QueryParam qp) {
		// StringBuilder strSql = new StringBuilder();
		// strSql.append("select " + fieldlist);
		// strSql.append(" FROM custorderm ");
		// if (!strWhere.equals("")) {
		// strSql.append(" where " + strWhere);
		// }
		// qp.setQueryString(strSql.toString());
		return DbHelperSQL.GetTable(qp);
	}

	public int Exists() {
		// StringBuilder strSql = new StringBuilder();
		// strSql.append("select count(*) as num from custorderm");
		// // strSql.append(" where brandname='" + Brandname + "' and statetag=1 and rownum=1 and accid=" + Accid);
		// // if (Brandid != null)
		// // strSql.append(" and brandid<>" + Brandid);
		// if (DbHelperSQL.GetSingleCount(strSql.toString()) > 0) {
		// // errmess = "???:" + Brandname + " 已存在，请重新输入！";
		// return 0;
		// }
		return 1;
	}

	// 扫码
	public int doBarcodein(String barcode, long custid, int pricetype, int priceprec, int qxbj, int nearsaleok) {

		if (barcode.equals("")) {
			errmess = "条码未传入！";
			return 0;
		}
		if (Noteno.equals("")) {
			errmess = "单据号参数无效！";
			return 0;
		}
		if (Amount < -99999 || Amount > 99999) {
			errmess = "数量不是一个有效值！";
			return 0;
		}
		int currprec = 2;

		String qry = "declare ";
		qry += "\n    v_accid  number;"; // --账户id
		qry += "\n    v_noteno  varchar2(20);"; // --单据号
		qry += "\n    v_barcode  varchar2(30); "; // --条码
		qry += "\n    v_discount  number; "; // --折扣
		qry += "\n    v_pricetype  number(1); "; // --价格方式 0=进价1=零价
		qry += "\n    v_amount  number; "; // --个数
		qry += "\n    v_custid number(10); "; //
		qry += "\n    v_wareid number(10); "; //
		qry += "\n    v_colorid number(10); "; //
		qry += "\n    v_saleid number(10); "; //
		qry += "\n    v_saleid0 number(10); "; //
		qry += "\n    v_sizeid number(10); "; //
		qry += "\n    v_brandid number(10); "; //
		qry += "\n    v_barcode0  varchar2(30); "; // --条码
		qry += "\n    v_id  number(20); ";
		qry += "\n    v_id0  number(20); ";
		qry += "\n    v_price number;";
		qry += "\n    v_price0 number; ";
		qry += "\n    v_price1 number; ";
		qry += "\n    v_count number; ";
		// qry += "\n v_curr number; ";
		qry += "\n    v_curr number; ";
		qry += "\n    v_totalcurr number; ";
		qry += "\n    v_totalamt number; ";
		qry += "\n    v_wareno varchar2(40); ";
		qry += "\n    v_warename varchar2(80); ";
		qry += "\n    v_colorname varchar2(40); ";
		qry += "\n    v_sizename varchar2(40); ";
		qry += "\n    v_sizegroupno  varchar2(60); "; // --条码
		qry += "\n    v_groupno  varchar2(60); "; // --条码
		qry += "\n    v_tjtag number(1); ";
		qry += "\n    v_retcs varchar2(200); "; // --条码
		qry += "\n    vt_price1 number(14,2); vt_discount  number(14,2); vt_price  number(14,2); ";
		qry += "\n begin ";
		/*
		 * qry += "\n     v_accid:=" + accid + "; "; qry += "\n     v_noteno:='"
		 * + noteno + "'; "; qry += "\n     v_barcode:='" + barcode + "'; ";
		 */
		qry += "\n    v_amount:=" + Amount + "; ";
		qry += "\n    v_discount:=" + Discount + "; ";
		qry += "\n    v_pricetype:=" + pricetype + "; ";
		qry += "\n    v_saleid:=1; ";
		qry += "\n    v_custid:=" + custid + "; ";
		// =============================
		qry += "\n    v_count:=0;";
		if (barcode.length() >= 4) {
			qry += "\n   select nvl(min(id),0),nvl(min(barcode),''),count(*) into v_id,v_barcode0,v_count from (select id,barcode from warebarcode where barcode like '%" //
					+ barcode + "%' and accid=" + Accid + " and rownum<=2 ); ";//
		}
		qry += "\n   if v_count<>1 then";
		qry += "\n      begin";
		qry += "\n        select id,barcode into v_id,v_barcode0 from (select id,barcode from warebarcode where barcode=substr('" //
				+ barcode + "',1,length(barcode)) and accid=" + Accid + " order by barcode desc )  where rownum=1; ";
		qry += "\n      EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n        if v_count=0 then";
		qry += "\n           v_retcs:= '0 未找到条码:'||'" + barcode + "！';";
		qry += "\n        else ";
		qry += "\n           v_retcs:= '0 条码:'||'" + barcode + "不唯一！';";
		qry += "\n        end if;";
		qry += "\n        goto exit;";
		qry += "\n      end;";
		qry += "\n   end if;";

		qry += "\n   begin";
		qry += "\n     select a.wareid,a.colorid,a.sizeid,";
		qry += "\n     case v_pricetype when 0 then b.retailsale  when 1 then b.sale1 when 2 then b.sale2 when 3 then b.sale3 when 4 then b.sale4 when 5 then b.sale5 else b.retailsale end";
		qry += "\n       ,b.wareno,b.warename,c.colorname,d.sizename ,b.sizegroupno,d.groupno,b.brandid,b.tjtag ";//
		qry += "\n     into v_wareid,v_colorid,v_sizeid,v_price0 ,v_wareno,v_warename,v_colorname,v_sizename ,v_sizegroupno,v_groupno,v_brandid,v_tjtag ";
		qry += "\n     from warebarcode a  ";
		qry += "\n     left outer join warecode b on a.wareid=b.wareid ";
		qry += "\n     left outer join colorcode c on a.colorid=c.colorid ";
		qry += "\n     left outer join sizecode d on a.sizeid=d.sizeid ";
		qry += "\n     where a.id=v_id  and b.sizegroupno=d.groupno and b.statetag=1 ";//
		if (qxbj == 1) // 1 启用权限控制
			qry += "\n and (b.brandid=0 or exists (select 1 from employebrand x where b.brandid=x.brandid and x.epid=" + Userid + "))";
		qry += "\n      ;";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n     v_retcs:= '0 商品未授权或条码尺码异常！' ;  ";
		qry += "\n     goto exit;";
		qry += "\n   end;";

		qry += "\n     if v_sizegroupno<>v_groupno then";
		qry += "\n        v_retcs:= '0商品尺码组异常，请检查！' ;  ";
		qry += "\n        goto exit;";
		qry += "\n     end if;";
		qry += "\n     if v_tjtag=1 then";// 特价商品不打折
		qry += "\n        v_discount:=1;";
		qry += "\n        v_price:=v_price0;";
		qry += "\n        v_curr:=round(v_price*v_amount," + currprec + ");";
		qry += "\n        goto exit1;";
		qry += "\n     end if;";

		// pricetype:0=零价折扣,1=售价1,2=售价2,3=售价3,4=批发价,5=打包价,6=品牌价格
		//		qry += "\n   v_saleid:=f_saleofwareout(" + Accid + ",v_custid,v_wareid,v_colorid,v_saleid," + ntid + "); ";
		// 如果有品牌折扣
		qry += "\n   select count(*) into v_count from custbrand where custid=v_custid and brandid=v_brandid; ";
		qry += "\n   if v_count>0 then ";
		qry += "\n      select pricetype,discount into v_pricetype,v_discount from custbrand where custid=v_custid and brandid=v_brandid; ";
		qry += "\n      select ";
		qry += "\n      case v_pricetype when 0 then b.retailsale  when 1 then b.sale1 when 2 then b.sale2 when 3 then b.sale3 when 4 then b.sale4 when 5 then b.sale5 else b.retailsale end";
		qry += "\n      into v_price0";
		qry += "\n      from warecode b where accid=" + Accid + " and wareid=v_wareid;";
		qry += "\n   end if;";
		qry += "\n   v_price:=round(v_price0*v_discount," + priceprec + "); ";

		// 2.查找是否有调价记录（裴晓要求批发单也要取调价单记录）
		// qry += "\n begin";
		// qry += "\n select price into v_price1 from ( ";
		// qry += "\n select case v_pricetype when 0 then b.retailsale when 1 then b.sale1 when 2 then b.sale2 when 3 then b.sale3 when 4 then b.sale4 when 5 then b.sale5 else b.retailsale end as price";
		// qry += "\n from wareadjusth a join wareadjustm b on a.accid=b.accid and a.noteno=b.noteno";
		// qry += "\n where a.statetag=2";
		// qry += "\n and a.begindate<to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')+1";
		// qry += "\n and a.enddate>=to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') ";
		// if (houseid > 0)
		// qry += "\n and exists (select 1 from wareadjustc c where a.accid=c.accid and a.noteno=c.noteno and c.houseid=" + houseid + ")";
		// qry += "\n and b.wareid=v_wareid and a.accid=" + Accid + " order by a.notedate desc ) where rownum=1;";
		//
		// qry += "\n if v_price1>=v_price0 then "; // 如果调后价高于调前价
		// qry += "\n v_price0:=v_price1;v_discount:=1; ";
		// qry += "\n v_price:=v_price1; ";
		// qry += "\n else";
		// qry += "\n v_price:=v_price1; v_discount:=0; "; // 查到有调价记录
		// qry += "\n if v_price0>0 then";
		// qry += "\n v_discount:=round(v_price/v_price0,2); "; // 有调价记录,折扣=单价/原价
		// qry += "\n end if;";
		// qry += "\n end if ;";
		// qry += "\n EXCEPTION WHEN NO_DATA_FOUND THEN ";
		// qry += "\n v_price:=round(v_price0*v_discount," + priceprec + ");"; // 没有调价记录，单价=原价*折扣
		// qry += "\n end;";

		if (nearsaleok == 1) // 启用最近售价
		{
			qry += "\n   begin";
			// qry += "\n if v_saleid=3 or v_saleid=2 then ";
			// qry += "\n select price0,discount,price into vt_price1,vt_discount,vt_price from (";
			// qry += "\n select b.price0,b.discount,b.price from wareouth a join wareoutm b on a.accid=b.accid and a.noteno=b.noteno";
			// qry += "\n where a.accid=" + Accid + " and a.statetag=1 and a.ntid=1 and b.wareid=v_wareid and a.custid=v_custid";
			// qry += "\n and (b.saleid=2 or b.saleid=3)";
			// qry += "\n order by a.notedate desc,b.id desc";
			// qry += "\n ) where rownum=1;";
			// qry += "\n else ";
			//取最近售价
			qry += "\n        select price0,discount,price into vt_price1,vt_discount,vt_price from (";
			qry += "\n        select b.price0,b.discount,b.price from wareouth a join wareoutm b on a.accid=b.accid and a.noteno=b.noteno";
			qry += "\n        where a.accid=" + Accid + " and a.statetag=1 and a.ntid=1 and a.cleartag=0 and b.wareid=v_wareid and a.custid=v_custid";
			//			qry += "\n        and b.saleid=v_saleid";
			qry += "\n        order by a.notedate desc,b.id desc";
			qry += "\n        ) where rownum=1;";
			// qry += "\n end if;";
			qry += "\n     v_price1:=vt_price1;v_discount:=vt_discount;v_price:=vt_price;";
			qry += "\n     if v_price0<>v_price1  then";
			qry += "\n        v_discount:=case v_price0 when 0 then 1 else round(v_price/v_price0,2) end;";
			qry += "\n     end if;";
			// qry += "\n end if;";
			qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN  ";
			qry += "\n     vt_price1:=0;"; // 没有调价记录，单价=原价*折扣
			qry += "\n   end;";

		}
		qry += "\n     <<exit1>>";
		qry += "\n     select count(*) into v_count from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' ";//
		qry += "\n        and wareid=v_wareid and colorid=v_colorid and sizeid=v_sizeid ; ";//
		qry += "\n     if v_count=0 then ";//
		// qry += "\n v_price:=round(v_price0*v_discount," + priceprec + "); ";
		qry += "\n        v_curr:=round(v_price*v_amount," + currprec + "); ";//

		qry += "\n        insert into custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0) ";//
		qry += "\n        values (custorderm_id.nextval," + Accid + ",'" + Noteno + "',v_wareid,v_colorid,v_sizeid,v_amount,v_price0,v_discount,v_price,v_curr,''); ";//
		qry += "\n     else  ";//
		qry += "\n        select id into v_id from custorderm where accid=" + Accid + " and noteno='" + Noteno//
				+ "' and wareid=v_wareid and colorid=v_colorid and sizeid=v_sizeid and rownum=1 order by id ; ";//
		qry += "\n        update custorderm set amount=amount+v_amount,curr=round((amount+v_amount)*price,2) where id=v_id and noteno='" + Noteno + "' and accid=" + Accid + "; ";
		qry += "\n     end if; ";

		qry += "\n     select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "';  ";
		qry += "\n     update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt  where accid=" + Accid + " and noteno='" + Noteno + "';  ";

		qry += "\n     v_retcs:= '1 '||v_warename||':'||v_wareno||','||v_colorname||','||v_sizename||',条码:'||v_barcode0||',单价:'||v_price; ";
		// 填 入条码跟踪表
		qry += "\n     if '" + barcode + "'>v_barcode0  then";
		// noteid:0采购入库1采购退库2期初入库3调拨入库4零售出库5批发出库6经销退库7调拨出库8盘点9临时盘点10采购订单11客户订单12调拨订单
		qry += "\n        insert into warebarrecord (id,accid,barcode,noteid,noteno,amount,lastdate)";
		qry += "\n        values (warebarrecord_id.nextval," + Accid + ",'" + barcode + "',11,'" + Noteno + "',v_amount,sysdate); ";
		qry += "\n     end if;";
		qry += "\n     commit; ";
		qry += "\n     <<exit>> ";
		qry += "\n     select v_retcs into :retcs from dual; ";
		qry += "\n end; ";
		// System.out.println(qry);
		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(qry, param);
		if (ret < 0) {
			errmess = "操作异常！";
			return 0;
		}
		String retcs = param.get("retcs").getParamvalue().toString();

		errmess = retcs.substring(1);
		return Integer.parseInt(retcs.substring(0, 1));

		// if (barcode.equals("")) {
		// errmess = "条码未传入！";
		// return 0;
		// }
		// if (Noteno.equals("")) {
		// errmess = "单据号参数无效！";
		// return 0;
		// }
		// String qry = "declare ";
		// qry += "\n v_accid number;"; // --账户id
		// qry += "\n v_noteno varchar2(20);"; // --单据号
		// qry += "\n v_barcode varchar2(30); "; // --条码
		// qry += "\n v_discount number; "; // --折扣
		// qry += "\n v_pricetype number; "; // --价格方式 0=进价1=零价
		// qry += "\n v_amount number; "; // --个数
		// qry += "\n v_wareid number(10); "; //
		// qry += "\n v_colorid number(10); "; //
		// qry += "\n v_sizeid number(10); "; //
		// qry += "\n v_barcode0 varchar2(30); "; // --条码
		// qry += "\n v_id number(20); ";
		// qry += "\n v_id0 number(20); ";
		// qry += "\n v_price number;";
		// qry += "\n v_price0 number; ";
		// qry += "\n v_count number; ";
		// qry += "\n v_curr number; ";
		// qry += "\n v_totalcurr number; ";
		// qry += "\n v_totalamt number; ";
		// qry += "\n v_wareno varchar2(40); ";
		// qry += "\n v_warename varchar2(80); ";
		// qry += "\n v_colorname varchar2(40); ";
		// qry += "\n v_sizename varchar2(40); ";
		// qry += "\n v_retcs varchar2(200); ";
		// qry += "\n begin ";
		// qry += "\n v_amount:=" + Amount + "; ";
		// qry += "\n v_discount:=" + Discount + "; ";
		// qry += "\n v_pricetype:=" + pricetype + "; ";
		// // =======================
		// qry += "\n v_count:=0;";
		// if (barcode.length() >= 4) {
		// qry += "\n select nvl(min(id),0),nvl(min(barcode),''),count(*) into v_id,v_barcode0,v_count from (select id,barcode from warebarcode where barcode like '%" + barcode + "%' and accid=" + Accid
		// + " and rownum<=2 ); ";//
		// }
		// qry += "\n if v_count<>1 then";
		// qry += "\n begin";
		// qry += "\n select id,barcode into v_id,v_barcode0 from (select id,barcode from warebarcode where barcode=substr('" + barcode + "',1,length(barcode)) and accid=" + Accid
		// + " order by barcode desc ) where rownum=1; ";//
		// qry += "\n EXCEPTION WHEN NO_DATA_FOUND THEN ";
		// qry += "\n v_retcs:= '0 未找到条码:'||'" + barcode + "' ; ";
		// qry += "\n goto exit;";
		// qry += "\n end;";
		// qry += "\n end if;";
		//
		// qry += "\n begin";
		// qry += "\n select a.wareid,a.colorid,a.sizeid,";
		// // qry += "\n decode(v_pricetype,0,b.entersale,b.retailsale)";
		// qry += "\n case v_pricetype when 0 then b.retailsale when 1 then b.sale1 when 2 then b.sale2 when 3 then b.sale3 when 4 then b.sale4 when 5 then b.sale5 else b.retailsale end";
		// qry += "\n ,b.wareno,b.warename,c.colorname,d.sizename ";//
		// qry += "\n into v_wareid,v_colorid,v_sizeid,v_price0 ,v_wareno,v_warename,v_colorname,v_sizename ";
		// qry += "\n from warebarcode a ";
		// qry += "\n left outer join warecode b on a.wareid=b.wareid ";
		// qry += "\n left outer join colorcode c on a.colorid=c.colorid ";
		// qry += "\n left outer join sizecode d on a.sizeid=d.sizeid ";
		// qry += "\n where a.id=v_id ";//
		// if (qxbj == 1) // 1 启用权限控制
		// qry += "\n and (b.brandid=0 or exists (select 1 from employebrand x where b.brandid=x.brandid and x.epid=" + Userid + "))";
		// qry += "\n ;";
		// qry += "\n EXCEPTION WHEN NO_DATA_FOUND THEN ";
		// qry += "\n v_retcs:= '0商品未授权！' ; ";
		// qry += "\n goto exit;";
		// qry += "\n end;";
		//
		// qry += "\n if v_tjtag=1 then";// 特价商品不打折
		// qry += "\n v_discount:=1;";
		// qry += "\n v_price:=v_price0;";
		// qry += "\n v_curr:=round(v_price*v_amount,2);";
		// qry += "\n goto exit1;";
		// qry += "\n end if;";
		//
		// qry += "\n select count(*) into v_count from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' ";//
		// qry += "\n and wareid=v_wareid and colorid=v_colorid and sizeid=v_sizeid ; ";//
		// qry += "\n if v_count=0 then ";//
		// qry += "\n v_price:=round(v_price0*v_discount," + priceprec + "); ";//
		// qry += "\n v_curr:=v_price*v_amount; ";//
		// qry += "\n insert into custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0) ";//
		// qry += "\n values (custorderm_id.nextval," + Accid + ",'" + Noteno + "',v_wareid,v_colorid,v_sizeid,v_amount,v_price0,v_discount,v_price,v_curr,''); ";//
		// qry += "\n else ";//
		// qry += "\n select id into v_id from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=v_wareid and colorid=v_colorid and sizeid=v_sizeid and rownum=1 order by id ; ";//
		// qry += "\n update custorderm set amount=amount+v_amount,curr=(amount+v_amount)*price where id=v_id and noteno='" + Noteno + "' and accid=" + Accid + "; ";
		// qry += "\n end if; ";
		//
		// qry += "\n select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "'; ";
		// qry += "\n update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt ";
		// qry += "\n where accid=" + Accid + " and noteno='" + Noteno + "'; ";
		//
		// qry += "\n v_retcs:= '1 '||v_warename||':'||v_wareno||','||v_colorname||','||v_sizename||' 条码:'||v_barcode0; ";
		// // 填 入条码跟踪表
		// qry += "\n if '" + barcode + "'>v_barcode0 then";
		// // noteid:0采购入库1采购退库2期初入库3调拨入库4零售出库5批发出库6经销退库7调拨出库8盘点9临时盘点10采购订单11客户订单12调拨订单
		// qry += "\n insert into warebarrecord (id,accid,barcode,noteid,noteno,amount,lastdate)";
		// qry += "\n values (warebarrecord_id.nextval," + Accid + ",'" + barcode + "',11,'" + Noteno + "',v_amount,sysdate); ";
		// qry += "\n end if;";
		// qry += "\n commit; ";
		// qry += "\n <<exit>> ";
		// qry += "\n select v_retcs into :retcs from dual; ";
		// qry += "\n end; ";
		// Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		// param.put("retcs", new ProdParam(Types.VARCHAR));
		// int ret = DbHelperSQL.ExecuteProc(qry, param);
		// if (ret < 0) {
		// errmess = "操作异常！";
		// return 0;
		// }
		// String retcs = param.get("retcs").getParamvalue().toString();
		// errmess = retcs.substring(1);
		// return Integer.parseInt(retcs.substring(0, 1));
	}

	// 整手输入
	public int AppendHand(JSONObject jsonObject) {
		if (Wareid == null || Wareid == 0) {
			errmess = "wareid不是一个有效值1！";
			return 0;
		}
		if (!pFunc.isWarecodeOk(Accid, Wareid)) {
			errmess = "wareid不是一个有效值2！";
			return 0;
		}
		if (Amount == 0 || Noteno.length() <= 0) {
			errmess = "amount或noteno不是一个有效值！";
			return 0;
		}
		if (!jsonObject.has("coloridlist")) {
			errmess = "coloridlist未传入！";
			return 0;
		}
		if (!jsonObject.has("sizeidlist")) {
			errmess = "sizeidlist未传入！";
			return 0;
		}
		JSONArray colorArray = jsonObject.getJSONArray("coloridlist");
		JSONArray sizeArray = jsonObject.getJSONArray("sizeidlist");
		String qry = "declare ";
		qry += "\n    v_totalcurr number; ";
		// qry += "\n v_totalcheckcurr number; ";
		qry += "\n    v_totalamt number; ";
		qry += "\n    v_id  number;";
		qry += "\n begin ";
		String sizelist = "^";
		for (int i = 0; i < colorArray.size(); i++) {

			JSONObject colorObject = colorArray.getJSONObject(i);
			Colorid = Long.parseLong(colorObject.getString("colorid"));

			for (int j = 0; j < sizeArray.size(); j++) {

				JSONObject sizeObject = sizeArray.getJSONObject(j);
				Sizeid = Long.parseLong(sizeObject.getString("sizeid"));
				if (!sizelist.contains("^" + Sizeid + "^")) {
					if (!pFunc.isWaresizeOk(Accid, Wareid, Sizeid)) {
						errmess = "sizeid不是一个有效值！";
						return 0;
					}
					sizelist += Sizeid + "^";
				}

				Curr = Func.getRound(Amount * Price, 2);
				qry += "\n   begin ";
				qry += "\n     select id into v_id from Custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid;
				qry += "\n     and colorid=" + Colorid + " and sizeid=" + Sizeid + " and rownum=1; ";
				qry += "\n     update Custorderm set amount=amount+" + Amount + ",curr=(amount+" + Amount + ")*price where id=v_id;";
				qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN"; // 未找到，插入新记录
				qry += "\n     insert into Custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0)";
				qry += "\n     values (Custorderm_id.nextval," + Accid + ",'" + Noteno + "'," + Wareid + "," + Colorid + "," + Sizeid + "," + Amount + "," + Price0 + "," + Discount + "," + Price + "," + Curr + ",'');";
				qry += "\n  end; ";
			}
		}
		qry += "\n    select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr  from Custorderm where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n    update Custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt";
		qry += "\n    where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n    commit; ";
		qry += "\n end; ";
		if (DbHelperSQL.ExecuteSql(qry) < 0) {
			errmess = "操作异常！";
			return 0;
		} else {
			errmess = "操作成功！";
			return 1;
		}
	}

	// 成批更改客户订单折扣
	public int ChangeDisc(long custid, int priceprec) {
		if (Noteno == null || Noteno.length() <= 0) {
			errmess = "noteno不是一个有效值！";
			return 0;
		}
		String qry = "declare ";
		qry += "\n    v_price0 number;";
		qry += "\n    v_discount number;";
		qry += "\n    v_pricetype number(1);";
		qry += "\n   v_accid number;";
		qry += "\n   v_noteno varchar2(20);";
		qry += "\n   v_totalcurr number; ";
		qry += "\n begin ";
		if (custid > 0) {// 根据custid查询价格方式及折扣
			qry += "\n   begin";
			qry += "\n     select discount,pricetype into v_discount,v_pricetype from customer where accid=" + Accid + " and custid=" + custid + ";";
			qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN";
			qry += "\n     v_discount:=" + Discount + ";";
			qry += "\n     v_pricetype:=0;";
			qry += "\n   end;";
			qry += "\n   declare cursor cur_data is ";
			qry += "\n     select a.id,a.wareid,a.amount";
			qry += "\n     ,case v_pricetype when 0 then b.retailsale  when 1 then b.sale1 when 2 then b.sale2 when 3 then b.sale3 when 4 then b.sale4 when 5 then b.sale5 else b.retailsale end as price0";
			qry += "\n     from custorderm a join warecode b on a.wareid=b.wareid";
			qry += "\n     where a.accid=" + Accid + " and a.noteno='" + Noteno + "' and b.tjtag=0; ";
			qry += "\n     v_row cur_data%rowtype;";
			qry += "\n   begin";
			qry += "\n     for v_row in cur_data loop";
			qry += "\n         update custorderm set price0=v_row.price0,discount=v_discount,price=round(v_row.price0*v_discount," + priceprec + ")";
			qry += "\n         ,curr=round(amount*round(v_row.price0*v_discount," + priceprec + "),2)";
			qry += "\n         where id=v_row.id;";
			qry += "\n     end loop;";
			qry += "\n   end;";
		} else {
			qry += "   v_discount:=" + Discount + ";";
			qry += "   update custorderm set discount=v_discount,price=round(price0*v_discount," + priceprec + "),curr=round(amount*round(price0*v_discount," + priceprec + "),2)";
			qry += "     where accid=" + Accid + " and noteno='" + Noteno + "'; ";
		}
		qry += "   select nvl(sum(curr),0) into v_totalcurr from custorderm where  accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "   update custorderh set totalcurr=v_totalcurr where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "   commit;";
		qry += "end; ";
		if (DbHelperSQL.ExecuteSql(qry) < 0) {
			errmess = "操作失败！";
			return 0;
		} else {
			errmess = "操作成功！";
			return 1;
		}

	}

	// 成批增加数据
	public int Appendbat(JSONObject jsonObject, int priceprec) {
		Wareid = jsonObject.has("wareid") ? Long.parseLong(jsonObject.getString("wareid")) : 0;
		Noteno = jsonObject.has("noteno") ? jsonObject.getString("noteno") : null;
		Price0 = jsonObject.has("price0") ? Float.parseFloat(jsonObject.getString("price0")) : 0;
		Price = jsonObject.has("price") ? Float.parseFloat(jsonObject.getString("price")) : null;
		Discount = jsonObject.has("discount") ? Float.parseFloat(jsonObject.getString("discount")) : 1;
		//		long custid = jsonObject.has("custid") ? Long.parseLong(jsonObject.getString("custid")) : 0;

		// long houseid = jsonObject.has("houseid") ? Long.parseLong(jsonObject.getString("houseid")) : 0;
		// int ntid = jsonObject.has("ntid") ? Integer.parseInt(jsonObject.getString("ntid")) : 0;
		int statetag = jsonObject.has("statetag") ? Integer.parseInt(jsonObject.getString("statetag")) : 0;
		// String pricestr = jsonObject.has("pricestr") ? jsonObject.getString("pricestr") : null;
		String remark = jsonObject.has("remark") ? jsonObject.getString("remark") : null;
		String handno = jsonObject.has("handno") ? jsonObject.getString("handno") : null;

		if (Func.isNull(Noteno)) {
			errmess = "noteno不是一个有效值!";
			return 0;
		}

		if (Wareid == null || Wareid == 0) {
			errmess = "wareid不是一个有效值!";
			return 0;
		}

		if (!pFunc.isWarecodeOk(Accid, Wareid)) {
			errmess = "wareid不是一个有效值2!";
			return 0;
		}
		// if (houseid == 0) {
		// errmess = "houseid不是一个有效值!";
		// return 0;
		// }
		if (!jsonObject.has("colorsizelist")) {
			errmess = "colorsizelist未传入！";
			return 0;
		}
		JSONArray jsonArray = jsonObject.getJSONArray("colorsizelist");

		// if (!Func.isNull(pricestr)) // 如果传入了折扣价，按折后价算折扣
		if (Price != null) {
			// price = decimal.Parse(pricestr);
			// Price = Func.getRound(Float.parseFloat(pricestr), priceprec);
			if (Price0 == 0) {
				Price0 = Price;
				Discount = (float) 1;
			}

			else
				Discount = Func.getRound(Price / Price0, 2);
		} else {
			Price = Func.getRound(Price0 * Discount, priceprec);
			// curr = price * amount;
		}

		String qry = "declare ";
		qry += "\n    v_totalcurr  number;";
		qry += "\n    v_totalamt  number;";
		qry += "\n    v_id  number;";
		qry += "\n    v_noteno  varchar2(20);";
		qry += "\n    v_retcs  varchar2(100);";
		qry += "\n begin ";
		qry += "\n    update custorderm set amount=0 where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + ";";
		String sizelist = "^";

		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject2 = jsonArray.getJSONObject(i);
			Sizeid = Long.parseLong(jsonObject2.getString("sizeid"));
			if (!sizelist.contains("^" + Sizeid + "^")) {
				if (!pFunc.isWaresizeOk(Accid, Wareid, Sizeid)) {
					errmess = "sizeid不是一个有效值！";
					return 0;
				}
				sizelist += Sizeid + "^";
			}
			Colorid = Long.parseLong(jsonObject2.getString("colorid"));
			Amount = Float.parseFloat(jsonObject2.getString("amount"));
			Curr = Func.getRound(Amount * Price, 2);
			qry += "  begin ";
			qry += "    select id into v_id from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + " and colorid=" + Colorid + " and sizeid=" + Sizeid + " and rownum=1; ";
			qry += "    update custorderm set amount=amount+" + Amount + ",curr=(amount+" + Amount + ")*price where id=v_id;";
			qry += "  EXCEPTION WHEN NO_DATA_FOUND THEN"; // 未找到，挺插入新记录
			qry += "    insert into custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0)";
			qry += "    values (custorderm_id.nextval," + Accid + ",'" + Noteno + "'," + Wareid + "," + Colorid + "," + Sizeid + "," + Amount + "," + Price0 + "," + Discount + "," + Price + "," + Curr + ",'');";
			qry += " end; ";
		}
		qry += "\n  delete custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + " and amount=0;";

		qry += "\n  select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "';";

		qry += "\n  update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt,lastdate=sysdate ";
		if (remark != null)
			qry += ",remark='" + remark + "'";
		if (handno != null)
			qry += ",handno='" + handno + "'";
		if (statetag == 1)
			qry += ",statetag=1";
		qry += "\n     where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n   commit; ";

		qry += "\n   v_retcs:='1操作成功！' ; ";
		qry += "\n   select v_retcs into :retcs from dual;";
		qry += "\n end;";
		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(qry, param);
		if (ret < 0) {
			errmess = "操作异常！";
			return 0;
		}
		String retcs = param.get("retcs").getParamvalue().toString();

		errmess = retcs.substring(1);
		return Integer.parseInt(retcs.substring(0, 1));
	}

	// 获取商品+颜色汇总列表
	public int doGetColorsumList(QueryParam qp, int sizenum, int priceprec) {
		if (Noteno.equals("")) {
			errmess = "wareid或noteno不是一个有效的值！";
			return 0;
		}

		String qry = "select a.wareid,b.wareno,b.warename,b.units,b.sizegroupno,b.imagename0,a.colorid,c.colorname,min(id) as id,sum(a.amount) as amount";
		qry += "\n ,case sum(a.amount) when 0 then 0 else round(sum(a.amount*a.price0)/sum(a.amount)," + priceprec + ") end as price0";
		qry += "\n ,case sum(a.amount*a.price0) when 0 then 1 else round(sum(a.curr)/sum(a.amount*a.price0),2) end as discount";
		qry += "\n ,case sum(a.amount) when 0 then 0 else round(sum(a.curr)/sum(a.amount)," + priceprec + ") end as price";
		qry += "\n ,sum(a.curr) as curr";
		qry += "\n from custorderm a ";
		qry += "\n left outer join warecode b on a.wareid=b.wareid";
		qry += "\n left outer join colorcode c on a.colorid=c.colorid";
		// qry += "\n left outer join sizecode d on a.sizeid=d.sizeid";
		qry += "\n where a.ACCID=" + Accid + " and a.NOTENO='" + Noteno + "'";
		qry += "\n group by a.wareid,b.wareno,b.warename,b.units,b.sizegroupno,b.imagename0,a.colorid,c.colorname";

		Table tb = new Table();
		qp.setQueryString(qry);
		qp.setSumString("nvl(sum(amount),0) as totalamt,nvl(sum(curr),0) as totalcurr");
		String retcs;
		tb = DbHelperSQL.GetTable(qp);
		int count = tb.getRowCount();
		String fh = "";
		String fh1 = "";
		if (sizenum <= 0) // 不显示尺码
		{
			retcs = "{\"result\":1,\"msg\":\"操作成功！\"," + qp.getTotalString() + ",\"rows\":[";
			for (int i = 0; i < count; i++) {
				fh1 = "";
				retcs += fh + "{";
				for (int j = 0; j < tb.getColumnCount(); j++) {
					String strKey = tb.getRow(i).getColumn(j + 1).getName().toUpperCase();
					String strValue = tb.getRow(i).get(j).toString();
					retcs += fh1 + "\"" + strKey + "\":\"" + strValue + "\"";
					// jsonString.append(fh1 + "\"" + strKey + "\":\"" + strValue + "\"");
					fh1 = ",";
				}
				retcs += "}";
				fh = ",";
			}
			retcs += "]}";
			errmess = retcs;
			return 1;
		}
		// System.out.println("doGetWareinmcolorsumList 1.6");
		String sqlsize = "";
		String sqlsum = "";
		String qry1;
		// long wareid;
		long wareid0 = 0;
		// long colorid;
		retcs = "{\"result\":1,\"msg\":\"操作成功！\"," + qp.getTotalString() + ",\"rows\":[";
		for (int i = 0; i < count; i++) {
			Wareid = Long.parseLong(tb.getRow(i).get("WAREID").toString());
			Colorid = Long.parseLong(tb.getRow(i).get("COLORID").toString());
			if (Wareid != wareid0) {
				SizeParam sp = new SizeParam(Wareid, sizenum);
				sqlsize = sp.getSqlSize();
				sqlsum = sp.getSqlSum();
				wareid0 = Wareid;
			}
			retcs += fh + "{";
			fh1 = "";
			for (int j = 0; j < tb.getColumnCount(); j++) {
				String strKey = tb.getRow(i).getColumn(j + 1).getName().toUpperCase();
				String strValue = tb.getRow(i).get(j).toString();
				retcs += fh1 + "\"" + strKey + "\":\"" + strValue + "\"";
				// jsonString.append(fh1 + "\"" + strKey + "\":\"" + strValue + "\"");
				fh1 = ",";
			}

			// 取尺码数据
			qry1 = "select " + sqlsum + "," + sqlsize;
			qry1 += " from custorderm a where accid=" + Accid + " and noteno='" + Noteno + "'";
			qry1 += " and wareid=" + Wareid + " and colorid=" + Colorid;

			Table tb1 = DbHelperSQL.Query(qry1).getTable(1);
			for (int j = 1; j <= sizenum; j++) {
				retcs += ",\"AMOUNT" + j + "\":\"" + tb1.getRow(0).get("AMOUNT" + j).toString() + "\"" //
						+ ",\"SIZEID" + j + "\":\"" + tb1.getRow(0).get("SIZEID" + j).toString() + "\"" //
						+ ",\"SIZENAME" + j + "\":\"" + tb1.getRow(0).get("SIZENAME" + j).toString() + "\"";
			}

			retcs += "}";
			fh = ",";

		}
		retcs += "]}";
		errmess = retcs;
		return 1;
	}

	public int Load(long custid, int priceprec, int nearsaleok, String wareno) {
		if (Noteno.equals("")) {
			errmess = "wareid或noteno不是一个有效的值！";
			return 0;
		}
		Table tb = new Table();
		String qry = "";
		if (Wareid != null && Wareid > 0)
			qry = "select wareid,wareno,warename,entersale,retailsale,sale1,sale2,sale3,sale4,sale5,units,imagename0 from warecode where accid=" + Accid + " and statetag=1 and wareid=" + Wareid;
		else if (wareno.length() > 0) {
			qry = "select  wareid,wareno,warename,entersale,retailsale,sale1,sale2,sale3,sale4,sale5,units,imagename0 from warecode where accid=" + Accid + " and wareno='" + wareno + "' and statetag=1 and rownum=1";
		} else {
			errmess = "商品id参数无效！";
			return 0;
		}
		tb = DbHelperSQL.Query(qry).getTable(1);
		int rs = tb.getRowCount();
		if (rs == 0) {
			errmess = "未找到商品！";
			return 0;
		}

		Wareid = Long.parseLong(tb.getRow(0).get("WAREID").toString());
		Price0 = Float.parseFloat(tb.getRow(0).get("RETAILSALE").toString());
		Discount = (float) 1;
		Price = Price0;
		String retcs = "\"msg\":\"操作成功！\"";
//		String fh = "";
		for (int j = 0; j < tb.getColumnCount(); j++) {
			String strKey = tb.getRow(0).getColumn(j + 1).getName().toUpperCase();
			String strValue = tb.getRow(0).get(j).toString();
			retcs += ",\"" + strKey + "\":\"" + strValue + "\"";
		}
		String jstr = Funcpackge.myWareoutprice(Accid, Wareid, custid, 0, 0, 1, priceprec, nearsaleok, 0); // 取客户售价
		JSONObject jsonObject = JSONObject.fromObject("{" + jstr + "}");
		Price0 = Float.parseFloat(jsonObject.getString("PRICE0"));
		Discount = Float.parseFloat(jsonObject.getString("DISCOUNT"));
		Price = Float.parseFloat(jsonObject.getString("PRICE"));
		retcs += "," + jstr;

		// System.out.println(jstr);
		// 取颜色
		qry = "select a.colorid,b.colorname";
		qry += "\n  FROM warecolor a";
		qry += "\n  left outer join colorcode b on a.colorid=b.colorid";
		qry += "\n  where a.wareid=" + Wareid + " and b.statetag=1 and b.noused=0 ";
		qry += "\n  and (a.noused=0 or a.noused=1 and exists (select 1 from custorderm c ";
		qry += "\n  where c.accid=" + Accid + " and c.noteno='" + Noteno + "' and a.wareid=c.wareid and a.colorid=c.colorid) )";

		qry += "\n  order by b.colorno";

		tb = DbHelperSQL.Query(qry).getTable(1);
		String fh = "";
		rs = tb.getRowCount();
		// {"colorlist":[{"COLORID":"1","COLORNAME":"红色"},{"COLORID":"2","COLORNAME":"黄色"}]
		// ,"sizelist":[{"SIZEID":"1","SIZENAME":"XS","SIZENO":"01"},{"SIZEID":"2","SIZENAME":"S","SIZENO":"02"},{"SIZEID":"3","SIZENAME":"M","SIZENO":"03"},{"SIZEID":"4","SIZENAME":"L","SIZENO":"04"},{"SIZEID":"5","SIZENAME":"XL","SIZENO":"05"},{"SIZEID":"6","SIZENAME":"XXL","SIZENO":"06"},{"SIZEID":"7","SIZENAME":"3XL","SIZENO":"07"}]}

		retcs += ",\"colorlist\":[";

		for (int i = 0; i < rs; i++) {
			retcs += fh + "{\"COLORID\":\"" + tb.getRow(i).get("COLORID").toString() + "\""//
					+ ",\"COLORNAME\":\"" + tb.getRow(i).get("COLORNAME").toString() + "\"}";
			fh = ",";

		}
		retcs += "]";

		// 取尺码
		qry = "select a.sizeid,a.sizename,a.sizeno FROM sizecode a";
		qry += "\n  left outer join warecode b on a.accid=b.accid and a.groupno=b.sizegroupno";
		qry += "\n  where a.statetag=1 and a.noused=0 and a.accid=" + Accid + " and b.wareid=" + Wareid;
		qry += "\n  and not exists (select 1 from warenosize a1 where b.wareid=a1.wareid and a.sizeid=a1.sizeid)";
		qry += "\n  order by a.sizeno,a.sizename";

		tb = DbHelperSQL.Query(qry).getTable(1);
		fh = "";
		rs = tb.getRowCount();
		// {"colorlist":[{"COLORID":"1","COLORNAME":"红色"},{"COLORID":"2","COLORNAME":"黄色"}]
		// ,"sizelist":[{"SIZEID":"1","SIZENAME":"XS","SIZENO":"01"},{"SIZEID":"2","SIZENAME":"S","SIZENO":"02"},{"SIZEID":"3","SIZENAME":"M","SIZENO":"03"},{"SIZEID":"4","SIZENAME":"L","SIZENO":"04"},{"SIZEID":"5","SIZENAME":"XL","SIZENO":"05"},{"SIZEID":"6","SIZENAME":"XXL","SIZENO":"06"},{"SIZEID":"7","SIZENAME":"3XL","SIZENO":"07"}]}

		retcs += ",\"sizelist\":[";

		for (int i = 0; i < rs; i++) {
			retcs += fh + "{\"SIZEID\":\"" + tb.getRow(i).get("SIZEID").toString() + "\"" //
					+ ",\"SIZENAME\":\"" + tb.getRow(i).get("SIZENAME").toString() + "\"}";
			fh = ",";

		}
		retcs += "]";
		// 取入库数

		qry = "  select colorid,sizeid,amount,price,price0,discount,curr";
		qry += "\n  from custorderm a ";
		qry += "\n  where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid;
		qry += "\n  order by colorid";
		tb = DbHelperSQL.Query(qry).getTable(1);
		fh = "";
		rs = tb.getRowCount();
		retcs += ",\"amountlist\":[";
		Float totalcurr = (float) 0;
		Float totalamt = (float) 0;
		Amount = (float) 0;
		Curr = (float) 0;
		// Price0 = (float) 0;
		for (int i = 0; i < rs; i++) {
			Amount = Float.parseFloat(tb.getRow(i).get("AMOUNT").toString());
			Curr = Float.parseFloat(tb.getRow(i).get("CURR").toString());
			Price0 = Float.parseFloat(tb.getRow(i).get("PRICE0").toString());
			retcs += fh + "{\"COLORID\":\"" + tb.getRow(i).get("COLORID").toString() + "\"" //
					+ ",\"SIZEID\":\"" + tb.getRow(i).get("SIZEID").toString() + "\"" //
					+ ",\"AMOUNT\":\"" + Amount + "\"" //
					+ ",\"PRICE0\":\"" + tb.getRow(i).get("PRICE0").toString() + "\"" //
					+ ",\"DISCOUNT\":\"" + tb.getRow(i).get("DISCOUNT").toString() + "\"" //
					+ ",\"PRICE\":\"" + tb.getRow(i).get("PRICE").toString() + "\"" //
					+ ",\"CURR\":\"" + Curr + "\"}";
			fh = ",";
			totalcurr += Curr;
			totalamt += Amount;
		}
		retcs += "]";

		if (totalamt != 0)
			Price = Func.getRound(totalcurr / totalamt, priceprec);
		if (Price0 != 0)
			Discount = Func.getRound(Price / Price0, 2);

		retcs += ",\"ZAMOUNT\":\"" + totalamt + "\""//
				+ ",\"ZPRICE0\":\"" + Price0 + "\"" //
				+ ",\"ZDISCOUNT\":\"" + Discount + "\"" //
				+ ",\"ZPRICE\":\"" + Price + "\"" //
				+ ",\"ZCURR\":\"" + totalcurr + "\"";
		errmess = retcs;

		return 1;
	}

	public int Write(JSONObject jsonObject) {
		if (Wareid == 0 || Noteno.equals("")) {
			errmess = "wareid或noteno不是一个有效的值！";
			return 0;
		}
		if (!pFunc.isWarecodeOk(Accid, Wareid)) {
			errmess = "wareid不是一个有效的值！";
			return 0;
		}
		if (!jsonObject.has("rows")) {
			errmess = "rows不是一个有效的值！";
			return 0;
		}
		JSONArray jsonArray = jsonObject.getJSONArray("rows");
		String qry = "declare ";
		qry += "\n    v_totalcurr number; ";
		qry += "\n    v_totalamt number; ";
		qry += "\n     v_id  number;";
		qry += "\n  begin ";
		qry += "\n      update custorderm set amount=0 where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + "; ";
		String sizelist = "^";
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject2 = jsonArray.getJSONObject(i);
			Sizeid = Long.parseLong(jsonObject2.getString("sizeid"));
			if (!sizelist.contains("^" + Sizeid + "^")) {
				if (!pFunc.isWaresizeOk(Accid, Wareid, Sizeid)) {
					errmess = "sizeid不是一个有效值！";
					return 0;
				}
				sizelist += Sizeid + "^";
			}
			Colorid = Long.parseLong(jsonObject2.getString("colorid"));
			Amount = Float.parseFloat(jsonObject2.getString("amount"));
			Price0 = Float.parseFloat(jsonObject2.getString("price0"));
			Discount = Float.parseFloat(jsonObject2.getString("discount"));
			Price = Float.parseFloat(jsonObject2.getString("price"));
			Curr = Float.parseFloat(jsonObject2.getString("curr"));
			qry += "  begin ";
			qry += "    select id into v_id from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + " and colorid=" + Colorid + " and sizeid=" + Sizeid + " and rownum=1; ";
			qry += "    update custorderm set amount=" + Amount + ",price=" + Price + ",price0=" + Price0 + ",curr=" + Curr + ",discount=" + Discount + " where id=v_id and accid=" + Accid + " and noteno='" + Noteno
					+ "';";

			qry += "  EXCEPTION WHEN NO_DATA_FOUND THEN"; // 未找到，插入新记录
			qry += "    insert into custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0,lastdate)";
			qry += "    values (custorderm_id.nextval," + Accid + ",'" + Noteno + "'," + Wareid + " ," + Colorid + "," + Sizeid + "," + Amount + "," + Price0 + "," + Discount + "," + Price + "," + Curr + ",'',sysdate);";
			qry += " end; ";
		}
		qry += "\n      delete from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=" + Wareid + " and amount=0; ";
		qry += "\n      select nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "';  ";
		qry += "\n      update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt  ";
		qry += "\n      where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n      commit; ";
		qry += "\n end; ";
		if (DbHelperSQL.ExecuteSql(qry) < 0) {
			errmess = "操作异常！";
			return 0;
		} else {
			errmess = "操作成功！";
			return 1;
		}
	}

	// 从excel中导入
	public int LoadFromXLS(String gbbar) {
		if (Noteno.equals("")) {
			errmess = "单据号无效！";
			return 0;
		}
		if (Wareno.length() == 0 && gbbar.length() == 0) {
			errmess = "货号或国标码无效！";
			return 0;
		}
		if (Colorname.equals("")) {
			errmess = "颜色无效！";
			return 0;
		}
		if (Sizename.equals("")) {
			errmess = "尺码无效！";
			return 0;
		}
		if (Amount == 0) {
			errmess = "数量无效！";
			return 0;

		}
		// Curr =Func.getRound(Amount * Price,2);
		String qry = "declare ";
		qry += "\n    v_totalcurr  number;";
		qry += "\n    v_totalamt  number;";
		qry += "\n    v_totalcheckcurr  number;";
		qry += "\n    v_wareid  number;";
		qry += "\n    v_colorid  number;";
		qry += "\n    v_sizeid  number;";
		qry += "\n    v_price  number;";
		qry += "\n    v_wholesale  number;";
		qry += "\n    v_retailsale  number;";
		qry += "\n    v_pricetype  number;";
		qry += "\n    v_discount  number;";
		qry += "\n    v_id  number;";
		qry += "\n    v_sizegroupno  varchar2(60);";
		qry += "\n    v_retcs  varchar2(100);";
		qry += "\n begin ";
		if (gbbar.length() > 0) {
			qry += "\n   begin ";
			qry += "\n     select wareid,sizegroupno,sale4,retailsale into v_wareid,v_sizegroupno,v_wholesale,v_price from warecode where accid= " + Accid + " and gbbar='" + gbbar + "' and statetag=1 and rownum=1;";
			qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
			qry += "\n     v_retcs:= '0国标码" + gbbar + "未找到!' ; ";
			qry += "\n     goto exit; ";
			qry += "\n   end; ";

		} else {
			qry += "\n   begin ";
			qry += "\n     select wareid,sizegroupno,sale4,retailsale into v_wareid,v_sizegroupno,v_wholesale,v_price from warecode where accid= " + Accid + " and wareno='" + Wareno + "' and statetag=1 and rownum=1;";
			qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
			qry += "\n     v_retcs:= '0货号" + Wareno + "未找到!' ; ";
			qry += "\n     goto exit; ";
			qry += "\n   end; ";
		}
		if (Price > 0)
			qry += "\n   v_price:=" + Price + ";";
		// if (Price < 0) // 未传入单价，自动取系统约定的价格
		// {
		// qry += "\n begin";
		// qry += "\n select b.pricetype,b.discount into v_pricetype,v_discount from custorderh a join provide b on a.provid=b.provid where a.accid= " + Accid + " and a.noteno='" + Noteno + "';";
		// qry += "\n EXCEPTION WHEN NO_DATA_FOUND THEN ";
		// qry += "\n v_discount:=0;";
		// qry += "\n v_pricetype:=0;";
		// qry += "\n end;";
		// qry += "\n if v_pricetype=0 then "; // 进价
		// qry += "\n v_price:=round(v_entersale*v_discount,0);";
		// qry += "\n else "; // 零售价
		// qry += "\n v_price:=round(v_retailsale*v_discount,0);";
		// qry += "\n end if;";
		// }

		qry += "\n   begin ";
		qry += "\n     select a.colorid into v_colorid from warecolor a join colorcode b on a.colorid=b.colorid where b.accid= " + Accid + " and a.wareid=v_wareid and b.colorname='" + Colorname
				+ "' and b.statetag=1 and rownum=1;";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n     v_retcs:= '0颜色" + Colorname + "未找到!'; ";
		qry += "\n     goto exit; ";
		qry += "\n   end; ";

		qry += "\n   begin ";
		qry += "\n     select sizeid into v_sizeid from sizecode where accid= " + Accid + " and sizename='" + Sizename + "' and groupno=v_sizegroupno and statetag=1 and rownum=1;";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n     v_retcs:= '0尺码" + Sizename + "未找到!'; ";
		qry += "\n     goto exit; ";
		qry += "\n   end; ";
		qry += "\n    begin ";
		qry += "\n      select id into v_id from custorderm where accid=" + Accid + " and noteno='" + Noteno + "' and wareid=v_wareid and colorid=v_colorid and sizeid=v_sizeid and rownum=1; ";
		qry += "\n      update custorderm set amount=amount+" + Amount + ",curr=round((amount+" + Amount + ")*price,2) where id=v_id;";
		qry += "\n    EXCEPTION WHEN NO_DATA_FOUND THEN"; // 未找到，挺插入新记录
		qry += "\n      insert into custorderm (id,accid,noteno,wareid,colorid,sizeid,amount,price0,discount,price,curr,remark0)";
		qry += "\n      values (custorderm_id.nextval," + Accid + ",'" + Noteno + "',v_wareid,v_colorid,v_sizeid ," + Amount + ",v_price,1,v_price,round(" + Amount + "*v_price,2),'');";
		qry += "\n    end; ";

		qry += "\n    select  nvl(sum(amount),0),nvl(sum(curr),0) into v_totalamt,v_totalcurr from custorderm where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n    update custorderh set totalcurr=v_totalcurr,totalamt=v_totalamt where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n    v_retcs:= '1操作成功!'; ";
		qry += "\n    <<exit>>";
		qry += "\n    select v_retcs into :retcs from dual;";
		qry += "\n end; ";
		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(qry, param);
		if (ret < 0) {
			errmess = "操作异常！";
			return 0;
		}
		String retcs = param.get("retcs").getParamvalue().toString();

		errmess = retcs.substring(1);
		return Integer.parseInt(retcs.substring(0, 1));
	}
}