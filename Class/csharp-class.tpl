<?
	var clsName = this.table.Name;
	if(this.opts.ClassName!=""){
		clsName = this.opts.ClassName;
	}
	var str_index = clsName.indexOf(".");
	if(str_index!=-1){
		clsName = clsName.substr(str_index+1);
	}
?>
namespace NS{
	public class ${clsName}{
	
		<?list this.table.Columns as index col?>
		<?
			if(col.IsExclude){continue;}
			var type = col.DataType;
			if(col.DataType=="date"){
				type = "DateTime";
			}
		?>
		private ${type} _${col.Name};
		<?endlist?>
		
		<?list this.table.Columns as index col?>
		<?
			if(col.IsExclude){continue;}
			var type = col.DataType;
			if(col.DataType=="date"){
				type = "DateTime";
			}
		?>
		public ${type} ${col.Name}{
			get{return this._${col.Name};}
			set{this._${col.Name}=value;}
		}
		<?endlist?>
	}
}