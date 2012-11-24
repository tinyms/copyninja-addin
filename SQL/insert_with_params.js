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
		params_[index] = cn.options.Placeholder+index;
	}
	index++;
}
cn.result = "INSERT INTO "+cn.table.Name+"("+colNames.join()+")VALUES("+params_.join()+")";