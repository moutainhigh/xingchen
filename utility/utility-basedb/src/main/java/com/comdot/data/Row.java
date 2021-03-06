package com.comdot.data;

//import java.util.*;
import com.comdot.data.type.*;

//数据存储的行，每个数据单元在设置值的时候都有类型检查
public class Row {
	private Meta meta;
	private Object[] values;

	public Row() {
	}

	public Row(Meta meta) {
		this.meta = meta;
		if (values == null) {
			this.values = new Object[meta.getCount()];
		}

		//System.out.println(this.meta.getCount() + " aaa");
		//System.out.println("3="+this.values[3] );
	}

	public void setMeta(Meta meta) {
		this.meta = meta;
		if (values == null) {
			this.values = new Object[meta.getCount()];
		}
	}

	public Meta getMeta() {
		return this.meta;
	}

	public Column getColumn(String name) {
		return meta.get(name);
	}

	public Column getColumn(int index) {
		return meta.get(index);
	}

	public void set(int index, Object value) throws DataException {
		// System.out.print("\n type=" + this.meta.get(index).getType());
		if (value == null)
			value = "";
//		 System.out.print("\n set = "+value);
//		if (!this.meta.get(index).isNULL() && value == null) {
//			throw new DataException("the index[" + index + "]can not be null!");
//			// System.out.print("\n 1");
//		}
		if (value != null && TypeCompare.typeCompare(value, this.meta.get(index).getType())) {
			this.values[index - 1] = value;
			// System.out.print("\n 2");
//		} else if (value == null) {
//			this.values[index - 1] = "";
//			// System.out.print("\n 3");
		} else {
			// System.out.print("\n 4");
			// throw new DataException("the index[" + index + "]data[" +
			// value.toString() + "] type is wrong!");
			throw new DataException("the type=" + this.meta.get(index).getType() + " is wrong!");
		}
	}

	public void set(String name, Object value) throws DataException {
		this.set(this.meta.get(name).getIndex(), value);
	}

	public Object get(int index) {
		return this.values[index];
	}

	public Object get(String name) {
//		System.out.print("\n get  name="+name+" index="+this.meta.get(name).getIndex());
		return this.values[this.meta.get(name).getIndex()];
	}
}
