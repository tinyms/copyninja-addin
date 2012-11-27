var colNames = [];
var params_ = [];
var index = 0;
for(var k=0;k<cn.table.Columns.length;k++){
	var col = cn.table.Columns[k];
	if(col.IsExclude){continue;}
	if(col.AutoValue){continue;}
	colNames[index] = col.Name;
	if(cn.options.Pattern=="None"){
		params_[index] = cn.options.Placeholder;
	}else if(cn.options.Pattern=="Name"){
		params_[index] = cn.options.Placeholder+col.Name;
	}else if(cn.options.Pattern=="Number"){
		var placeHolderIndex = index+1;
		params_[index] = cn.options.Placeholder+placeHolderIndex;
	}
	index++;
}

var table_name = cn.table.Name;
var str_index = table_name.indexOf(".");
if(str_index!=-1){
	table_name = table_name.substr(str_index+1);
}
cn.result = "INSERT INTO "+table_name+"("+colNames.join()+")VALUES("+params_.join()+")";