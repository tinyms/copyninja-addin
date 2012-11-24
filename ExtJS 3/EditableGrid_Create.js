var containerId = cn.options.RenderTo==""?"EditableGrid":cn.options.RenderTo;
var map = {
	options:cn.options,
	table:cn.table,
	renderTo:containerId
};
cn.result = cn.render(cn.home+"tpl/EditableGrid.tpl",map);
var preview = {
	javascript: cn.result,
	containerId: containerId,
	data: cn.rows(10,cn.table.Name,cn.profileName)
}
var html = cn.render(cn.home+"tpl/GridPreview.tpl",preview);
cn.write(cn.home+"index.html",html);