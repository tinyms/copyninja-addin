var data = {
	options : cn.options,
	fields : cn.fields
};
cn.result = cn.render(cn.home+"template/alerts.tpl",data);
cn.write(cn.home+"index.html",cn.result);