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
import com.netdata.db.DbHelperSQL;
import com.netdata.db.ProdParam;
import com.netdata.db.QueryParam;
import net.sf.json.JSONObject;

//*************************************
//  @author:sunhong  @date:2017-03-07 21:44:00
//*************************************
public class Firstpaycurr implements java.io.Serializable {
	private Float Id;
	private Long Accid;
	private String Noteno;
	private String Notedatestr;
	private Date Notedate;
	private Long Provid;
	private String Handno;
	private String Payno;
	private Float Curr;
	private String Remark;
	private String Operant;
	private String Checkman;
	private Integer Statetag;
	private String Lastop;
	private Date Lastdate;
	private Long Houseid;
	private String errmess;
	// private String Accbegindate = "2000-01-01"; // 账套开始使用日期
	private String Calcdate = "";

	public void setCalcdate(String calcdate) {
		this.Calcdate = calcdate;
	}

	public void setId(Float id) {
		this.Id = id;
	}

	public Float getId() {
		return Id;
	}

	public void setAccid(Long accid) {
		this.Accid = accid;
	}

	public Long getAccid() {
		return Accid;
	}

	public void setNoteno(String noteno) {
		this.Noteno = noteno;
	}

	public String getNoteno() {
		return Noteno;
	}

	public void setNotedate(Date notedate) {
		this.Notedate = notedate;
	}

	public String getNotedate() {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(Notedate);
	}

	public void setProvid(Long provid) {
		this.Provid = provid;
	}

	public Long getProvid() {
		return Provid;
	}

	public void setHandno(String handno) {
		this.Handno = handno;
	}

	public String getHandno() {
		return Handno;
	}

	public void setPayno(String payno) {
		this.Payno = payno;
	}

	public String getPayno() {
		return Payno;
	}

	public void setCurr(Float curr) {
		this.Curr = curr;
	}

	public Float getCurr() {
		return Curr;
	}

	public void setRemark(String remark) {
		this.Remark = remark;
	}

	public String getRemark() {
		return Remark;
	}

	public void setOperant(String operant) {
		this.Operant = operant;
	}

	public String getOperant() {
		return Operant;
	}

	public void setCheckman(String checkman) {
		this.Checkman = checkman;
	}

	public String getCheckman() {
		return Checkman;
	}

	public void setStatetag(Integer statetag) {
		this.Statetag = statetag;
	}

	public Integer getStatetag() {
		return Statetag;
	}

	public void setLastop(String lastop) {
		this.Lastop = lastop;
	}

	public String getLastop() {
		return Lastop;
	}

	public void setHouseid(Long houseid) {
		this.Houseid = houseid;
	}

	public Long getHouseid() {
		return Houseid;
	}

	public String getErrmess() { // 取错误提示
		return errmess;
	}

	// public void setAccbegindate(String accbegindate) {
	// this.Accbegindate = accbegindate;
	// }

	// 删除记录
	public int Delete() {
		if (Noteno.equals("")) {
			errmess = "单据号无效！";
			return 0;
		}
		StringBuilder strSql = new StringBuilder();
		strSql.append("begin");
//		if (delbj == 1) {
//			strSql.append("  update firstpaycurr set statetag=2 ");
//			// strSql.Append(" where id=" + id + " and accid=" + accid + " and noteno='" + noteno + "'");
//			strSql.append(" where noteno='" + Noteno + "' and accid=" + Accid + ";");
//
//		} else {
			strSql.append("  delete firstpaycurr ");
			// strSql.Append(" where id=" + id + " and accid=" + accid + " and noteno='" + noteno + "'");
			strSql.append(" where statetag=0 and noteno='" + Noteno + "' and accid=" + Accid + ";");
//		}
		strSql.append(" end;");
		if (DbHelperSQL.ExecuteSql(strSql.toString()) < 0) {
			errmess = "删除失败！";
			return 0;
		} else {
			pFunc.myWriteLog(Accid, "期初应付", "【删除单据】" + Noteno + ",", Lastop);// 写日志
			errmess = "删除成功！";
			return 1;
		}
	}

	public int AppendXLS(String provname, String housename) {
		if (provname.equals("")) {
			errmess = "供应商无效!";
			return 0;
		}
		if (housename.equals("")) {
			errmess = "店铺无效!";
			return 0;
		}
		if (Curr == 0) {
			errmess = "金额无效!";
			return 0;
		}
		String qry = "declare ";
		qry += "\n   v_noteno varchar2(20);";
		qry += "\n   v_retcs varchar2(200);";
		qry += "\n   v_id  number;";
		qry += "\n   v_houseid  number(10); ";
		qry += "\n   v_provid  number(10);";
		qry += "\n begin ";
		qry += "\n   begin ";
		qry += "\n      select provid into v_provid from provide where provname='" + provname + "' and statetag=1 and noused=0  and accid=" + Accid + " and rownum=1;";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n      v_retcs:= '0供应商:" + provname + " 未找到!' ; ";
		qry += "\n      goto exit;";
		qry += "\n   end;";
		qry += "\n   begin ";
		qry += "\n      select houseid into v_houseid from warehouse where housename='" + housename + "' and statetag=1 and noused=0  and accid=" + Accid + " and rownum=1;";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n      v_retcs:= '0店铺:" + housename + " 未找到!' ; ";
		qry += "\n      goto exit;";
		qry += "\n   end ;";

		qry += "\n  begin";
		qry += "\n   select 'QF'||To_Char(SYSDATE,'yyyymmdd')||trim(to_char(nvl(to_number(max(substr(noteno,11,5)),'99999'),0)+1,'00000')) into v_noteno from FIRSTPAYCURR";
		qry += "\n   where accid=" + Accid + "  and LENGTH(noteno)=15 and substr(noteno,1,10)= 'QF'||To_Char(SYSDATE,'yyyymmdd');";
		qry += "\n   v_id:=FIRSTPAYCURR_ID.NEXTVAL;";
		qry += "\n   insert into FIRSTPAYCURR (id, accid,noteno,notedate,provid,houseid,curr,remark,handno,statetag,operant,checkman,lastop,lastdate)";
		qry += "\n   values (v_id," + Accid + ",v_noteno,sysdate,v_provid ,v_houseid," + Curr + ",'" + Remark + "','" + Handno + "',1,'" + Lastop + "','','" + Lastop + "',sysdate);";
		qry += "\n   commit;";
		qry += "\n   v_retcs:= '1'||v_noteno;  ";
		qry += "\n  exception";
		qry += "\n  when others then ";
		//		qry += "\n  begin";
		qry += "\n     rollback;";
		qry += "\n     v_retcs:= '0操作失败!' ; ";
		qry += "\n  end;";
		qry += "\n  <<exit>>";
		qry += "\n  select v_retcs into :retcs from dual;";
		//		qry += "\n  end;";
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
		if (retcs.substring(0, 1).equals("0"))
			return 0;
		else
			return 1;
	}

	// 增加记录
	public int Append() {
		if (Provid == null || Provid == 0) {
			errmess = "Provid无效！";
			return 0;
		}
		if (Houseid == null || Houseid == 0) {
			errmess = "Houseid无效！";
			return 0;
		}
		// if (Fs == 0 && (Payid == null || Payid == 0)) {
		// errmess = "Payid无效！";
		// return 0;
		// }
		if (Curr == null || Curr == 0) {
			errmess = "金额无效！";
			return 0;
		}
		if (!Func.isNull(Notedatestr)) {
			if (Func.subString(Notedatestr, 1, 10).compareTo(Calcdate) <= 0) {
				errmess = "单据日期只能在系统登账日 " + Calcdate + " 之后！";
				return 0;
			}
		}
		if (Statetag == null)
			Statetag = 0;
		StringBuilder strSql = new StringBuilder();
		StringBuilder strSql1 = new StringBuilder();
		StringBuilder strSql2 = new StringBuilder();
		strSql1.append("id,");
		strSql2.append("v_id,");
		strSql1.append("accid,");
		strSql2.append(Accid + ",");
		// if (Noteno != null) {
		strSql1.append("noteno,");
		strSql2.append("v_noteno,");
		// }
		// if (Notedate != null) {
		if (!Func.isNull(Notedatestr)) {
			strSql1.append("notedate,");
			strSql2.append("to_date('" + Notedatestr + "','yyyy-mm-dd hh24:mi:ss'),");
		} else {
			strSql1.append("notedate,");
			strSql2.append("sysdate,");
		}
		// }
		// if (Provid != null) {
		strSql1.append("Provid,");
		strSql2.append(Provid + ",");
		// if (Houseid != null) {
		strSql1.append("houseid,");
		strSql2.append(Houseid + ",");
		// strSql1.append("payid,");
		// strSql2.append(Payid + ",");
		strSql1.append("curr,");
		strSql2.append(Curr + ",");
		if (Handno != null) {
			strSql1.append("handno,");
			strSql2.append("'" + Handno + "',");
		}
		if (Remark != null) {
			strSql1.append("remark,");
			strSql2.append("'" + Remark + "',");
		}
		if (Checkman != null) {
			strSql1.append("checkman,");
			strSql2.append("'" + Checkman + "',");
		}
		if (Statetag != null) {
			strSql1.append("statetag,");
			strSql2.append(Statetag + ",");
		}

		strSql1.append("operant,");
		strSql2.append("'" + Lastop + "',");
		strSql1.append("lastop,");
		strSql2.append("'" + Lastop + "',");
		strSql1.append("lastdate");
		strSql2.append("sysdate");
		strSql.append("declare ");
		strSql.append("\n   v_id number; ");
		strSql.append("\n   v_operant varchar2(20);");
		strSql.append("\n   v_noteno varchar2(20);");
		strSql.append("\n   v_retcs varchar2(200);");
		strSql.append("\n   v_retbj number(1); ");
		strSql.append("\n   v_count number; ");

		strSql.append("\n begin ");
		strSql.append("\n   v_retbj:=0;");
		strSql.append("\n     select count(*) into v_count from provide where accid=" + Accid + " and Provid=" + Provid + " and statetag=1;");
		strSql.append("\n     if v_count=0 then");
		strSql.append("\n        v_retcs:='供应商无效！';");
		strSql.append("\n        goto exit;");
		strSql.append("\n     end if;");
		strSql.append("\n     select count(*) into v_count from warehouse where accid=" + Accid + " and Houseid=" + Houseid + " and statetag=1;");
		strSql.append("\n     if v_count=0 then");
		strSql.append("\n        v_retcs:='店铺无效！';");
		strSql.append("\n        goto exit;");
		strSql.append("\n     end if;");
		// if (Fs == 0) {
		// strSql.append("\n select count(*) into v_count from payway where accid=" + Accid + " and Payid=" + Payid + " and statetag=1;");
		// strSql.append("\n if v_count=0 then");
		// strSql.append("\n v_retcs:='结算方式无效！';");
		// strSql.append("\n goto exit;");
		// strSql.append("\n end if;");
		// }
		strSql.append("\n   begin ");
		strSql.append("\n     select 'QF'||To_Char(SYSDATE,'yyyymmdd')||trim(to_char(nvl(to_number(max(substr(noteno,11,5)),'99999'),0)+1,'00000')) into v_noteno from firstpaycurr");
		strSql.append("\n     where accid=" + Accid + "  and LENGTH(noteno)=15 and substr(noteno,1,10)= 'QF'||To_Char(SYSDATE,'yyyymmdd');");
		strSql.append("\n     v_id:=firstpaycurr_ID.NEXTVAL;");

		strSql.append("\n     insert into firstpaycurr (" + strSql1.toString() + ")");
		strSql.append("\n     values (" + strSql2.toString() + ");");

		strSql.append("\n     commit;");
		strSql.append("\n     v_retbj:=1;  ");
		strSql.append("\n     select '\"msg\":\"操作成功\",\"ID\":\"'||id||'\",\"NOTENO\":\"'||noteno||'\",\"NOTEDATE\":\"'||to_char(notedate,'yyyy-mm-dd hh24:mi:ss')||'\"' into v_retcs from firstpaycurr where id=v_id;");
		strSql.append("\n     insert into LOGRECORD (id,accid,progname,remark,lastop)");
		strSql.append("\n     values (LOGRECORD_id.nextval," + Accid + ",'期初应付','【增加记录】单据号:'||v_noteno||';金额:" + Curr + "','" + Lastop + "');");
		strSql.append("\n    exception");
		strSql.append("\n    when others then ");
		strSql.append("\n    begin");
		strSql.append("\n      rollback;");
		strSql.append("\n      v_retbj:=0;v_retcs:='操作失败，请重试！';");// into :v_retbj,:v_notenolist from dual;");
		strSql.append("\n    end;");
		strSql.append("\n  end;");
		strSql.append("\n  <<exit>>");
		strSql.append("\n  select v_retbj,v_retcs into :retbj,:retcs from dual;");

		strSql.append("\n end;");
		//System.out.println(strSql.toString());

		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retbj", new ProdParam(Types.INTEGER));
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(strSql.toString(), param);
		// id = Long.parseLong(param.get("id").getParamvalue().toString());
		if (ret < 0) {
			errmess = "操作异常！";
			return 0;
		} else {
			errmess = param.get("retcs").getParamvalue().toString();
			return Integer.parseInt(param.get("retbj").getParamvalue().toString());
		}
	}

	// 修改记录
	public int Update() {
		if (Noteno == null || Noteno.equals("")) {
			errmess = "单据号无效！";
			return 0;
		}
		if (!Func.isNull(Notedatestr)) {
			if (Func.subString(Notedatestr, 1, 10).compareTo(Calcdate) <= 0) {
				errmess = "单据日期只能在系统登账日 " + Calcdate + " 之后！";
				return 0;
			}
		}

		StringBuilder strSql = new StringBuilder();
		strSql.append("declare");
		strSql.append("\n   v_count number;");
		strSql.append("\n   v_retcs varchar2(200);");

		strSql.append("\n begin ");
		if (Provid != null) {
			strSql.append("\n   select count(*) into v_count from provide where accid=" + Accid + " and provid=" + Provid + " and statetag=1;");
			strSql.append("\n   if v_count=0 then");
			strSql.append("\n      v_retcs:='0供应商无效！';");
			strSql.append("\n      goto exit;");
			strSql.append("\n   end if;");
		}
		if (Houseid != null) {
			strSql.append("\n   select count(*) into v_count from warehouse where accid=" + Accid + " and Houseid=" + Houseid + " and statetag=1;");
			strSql.append("\n   if v_count=0 then");
			strSql.append("\n      v_retcs:='0店铺无效！';");
			strSql.append("\n      goto exit;");
			strSql.append("\n   end if;");
		}
		// if (Payid != null && Fs == 0) {
		// strSql.append("\n select count(*) into v_count from payway where accid=" + Accid + " and Payid=" + Payid + " and statetag=1;");
		// strSql.append("\n if v_count=0 then");
		// strSql.append("\n v_retcs:='0结算方式无效！';");
		// strSql.append("\n goto exit;");
		// strSql.append("\n end if;");
		// }
		strSql.append("\n   update Firstpaycurr set ");
		if (!Func.isNull(Notedatestr)) {
			strSql.append("notedate=to_date('" + Notedatestr + "','yyyy-mm-dd hh24:mi:ss'),");
		} else {
			strSql.append("notedate=sysdate,");
		}
		if (Provid != null) {
			strSql.append("provid=" + Provid + ",");
		}
		if (Handno != null) {
			strSql.append("handno='" + Handno + "',");
		}
		if (Curr != null) {
			strSql.append("curr='" + Curr + "',");
		}
		if (Remark != null) {
			strSql.append("remark='" + Remark + "',");
		}
		// if (Operant != null) {
		// }
		if (Checkman != null) {
			strSql.append("checkman='" + Checkman + "',");
		}
		if (Statetag != null) {
			strSql.append("statetag=" + Statetag + ",");
		}
		if (Houseid != null) {
			strSql.append("houseid=" + Houseid + ",");
		}
		strSql.append("operant='" + Lastop + "',");
		strSql.append("lastop='" + Lastop + "',");
		strSql.append("lastdate=sysdate");
		strSql.append("  where  noteno='" + Noteno + "' and accid=" + Accid + " ;");
		strSql.append("\n   v_retcs:='1操作成功';");
		strSql.append("\n   <<exit>>");
		strSql.append("\n   select v_retcs into :retcs from dual;");
		strSql.append("\n end;");
		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(strSql.toString(), param);
		if (ret < 0) {
			errmess = "操作异常！";
			return 0;
		}
		String retcs = param.get("retcs").getParamvalue().toString();

		errmess = retcs.substring(1);
		return Integer.parseInt(retcs.substring(0, 1));
	}

	// 获得数据列表
	public DataSet GetList(String strWhere, String fieldlist) {
		StringBuilder strSql = new StringBuilder();
		strSql.append("select " + fieldlist);
		//		strSql.append("\n ,case To_Char(a.notedate,'yyyy-mm-dd') when To_Char(SYSDATE,'yyyy-mm-dd') then '1' else '0' end as istoday");
		strSql.append("\n FROM firstpaycurr a");
		strSql.append("\n left outer join provide b on a.provid=b.provid");
		strSql.append("\n left outer join warehouse d on a.houseid=d.houseid");
		if (!strWhere.equals("")) {
			strSql.append("\n where " + strWhere);
		}
		//		System.out.println(strSql.toString());
		return DbHelperSQL.Query(strSql.toString());
	}

	// 获取分页数据
	public Table GetTable(QueryParam qp, String strWhere, String fieldlist) {
		StringBuilder strSql = new StringBuilder();
		strSql.append("select " + fieldlist);
		strSql.append(" FROM firstpaycurr a");
		strSql.append(" left outer join provide b on a.provid=b.provid");
		strSql.append(" left outer join warehouse d on a.houseid=d.houseid");
		if (!strWhere.equals("")) {
			strSql.append(" where " + strWhere);
		}
		qp.setQueryString(strSql.toString());
		return DbHelperSQL.GetTable(qp);
	}

	public boolean Exists() {
		StringBuilder strSql = new StringBuilder();
		strSql.append("select count(*) as num  from Firstpaycurr");
		// strSql.append(" where brandname='" + Brandname + "' and statetag=1 and rownum=1 and accid=" + Accid);
		// if (Brandid != null)
		// strSql.append(" and brandid<>" + Brandid);
		if (DbHelperSQL.GetSingleCount(strSql.toString()) > 0) {
			// errmess = "???:" + Brandname + " 已存在，请重新输入！";
			return true;
		}
		return false;
	}

	// 撤单
	public int Cancel(int changedatebj) {
		if (Noteno.equals("")) {
			errmess = "单据号无效！";
			return 0;
		}
		String qry = " declare";
		qry += "\n   v_notedate varchar2(10); ";
		qry += "\n   v_retcs varchar2(200); ";
		qry += "\n   v_checkman varchar2(20); ";
		qry += "\n begin ";

		qry += "\n   begin";
		qry += "\n     select to_char(notedate,'yyyy-mm-dd') ,checkman";
		qry += "\n     into v_notedate,v_checkman";
		qry += "\n     from firstpaycurr where accid=" + Accid + "  and noteno='" + Noteno + "' and statetag=1; ";
		qry += "\n   EXCEPTION WHEN NO_DATA_FOUND THEN ";
		qry += "\n     v_retcs:='0未找到单据!';";
		qry += "\n     goto exit;";
		qry += "\n   end;";
		qry += "\n   if length(v_checkman)>0 then ";// 如果收款单关联了销售单，重新刷新销售的的结算方式
		qry += "\n      v_retcs:= '0已审核的单据不允许撤单！'; ";
		qry += "\n      goto exit; ";
		qry += "\n   end if; ";
		qry += "\n   if v_notedate<='" + Calcdate + "' then ";
		qry += "\n      v_retcs:= '0系统登账日" + Calcdate + "及之前的单据不允许撤单！'; ";
		qry += "\n      goto exit; ";
		qry += "\n   end if; ";

		//		if (changedatebj == 0) // 不允许更改单据日期
		//		{
		//			qry += "\n   if v_notedate<to_char(sysdate,'yyyy-mm-dd') then ";
		//			qry += "\n      v_retcs:= '0今日之前的单据不允许撤单！'; ";
		//			qry += "\n      goto exit; ";
		//			qry += "\n   end if; ";
		//		}
		qry += "\n   update firstpaycurr set statetag=0 where accid=" + Accid + "  and noteno='" + Noteno + "' ; ";

		qry += "\n   v_retcs:= '1操作成功！';  ";

		qry += "\n   insert into LOGRECORD (id,accid,progname,remark,lastop)";
		qry += "\n   values (LOGRECORD_id.nextval," + Accid + ",'期初应付款','【撤单】单据号:" + Noteno + "','" + Operant + "');";
		qry += "\n   commit;";
		qry += "\n   <<exit>>";
		qry += "\n   select v_retcs into :retcs from dual;";
		qry += "\n end;";

		Map<String, ProdParam> param = new HashMap<String, ProdParam>();
		param.put("retcs", new ProdParam(Types.VARCHAR));
		int ret = DbHelperSQL.ExecuteProc(qry, param);
		if (ret == 0) {
			errmess = "操作异常！";
			return 0;
		}
		String retcs = param.get("retcs").getParamvalue().toString();

		errmess = retcs.substring(1);
		return Integer.parseInt(retcs.substring(0, 1));
	}

	// 审核/反审
	public int Check(int bj) {
		String qry = "declare";
		qry += "\n   v_count number;";
		qry += "\n   v_payid number(10);";
		qry += "\n   v_checkman varchar2(20);";
		qry += "\n   v_retcs varchar2(200);";
		qry += "\n   v_mess varchar2(200);";
		qry += "\n   v_statetag number(1);";
		qry += "\n begin";
		qry += "\n   select checkman,statetag into v_checkman,v_statetag from firstpaycurr where accid=" + Accid + " and noteno='" + Noteno + "';";
		qry += "\n   if v_statetag<>1 then ";
		qry += "\n      v_retcs:='0单据状态无效核！';";
		qry += "\n      goto exit;";
		qry += "\n   end if;";
		if (bj == 1) {// 审核
			qry += "\n   if length(v_checkman)>0 then ";
			qry += "\n      v_retcs:='0单据已审核！';";
			qry += "\n      goto exit;";
			qry += "\n   end if;";
			qry += "\n   update firstpaycurr set checkman='" + Operant + "' where accid=" + Accid + " and noteno='" + Noteno + "';";
			qry += "\n   v_mess:='【取消审核】';";

		} else {// 取消审核
			qry += "\n   if length(v_checkman)=0 then ";
			qry += "\n      v_retcs:='0当前单据未审核！';";
			qry += "\n      goto exit;";
			qry += "\n   end if;";
			qry += "\n   if v_checkman<>'" + Operant + "' then ";
			qry += "\n      v_retcs:='0系统不允许取消其他用户审核的单据！';";
			qry += "\n      goto exit;";
			qry += "\n   end if;";
			qry += "\n   update firstpaycurr set checkman='' where accid=" + Accid + " and noteno='" + Noteno + "';";
			qry += "\n   v_mess:='【审核】';";
		}
		qry += "\n   insert into LOGRECORD (id,accid,progname,remark,lastop)";
		qry += "\n   values (LOGRECORD_id.nextval," + Accid + ",'期初应付',v_mess||'单据号:" + Noteno + "','" + Operant + "');";
		qry += "\n   v_retcs:='1操作成功！';";
		qry += "\n   <<exit>>";
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

}