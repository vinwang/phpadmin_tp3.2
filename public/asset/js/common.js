var ifcheck = true;
$(function(){
  // setInterval("get_time()",1000);
  
  $('.select2').select2();
  $('#example2').DataTable({
    'paging'      : true,
    'lengthChange': true,
    'searching'   : true,
    'ordering'    : false,
    'info'        : true,
    'autoWidth'   : true,
    "oLanguage": {
    "sLengthMenu": "每页显示 _MENU_ 条记录",
    "sZeroRecords": "对不起，查询不到任何相关数据",
    "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_条记录",
    "sInfoEmtpy": "找不到相关数据",
    "sInfoFiltered": "数据表中共为 _MAX_ 条记录)",
    "sProcessing": "正在加载中...",
    "sSearch": "搜索",
    "oPaginate": {
    "sFirst": "第一页",
    "sPrevious":" 上一页 ",
    "sNext": " 下一页 ",
    "sLast": " 最后一页 "
    },
    }
  });
  $(".valideform").Validform({
      tiptype: function(msg,o,cssctl){
          if(o.type == '3'){
              layer.msg(msg);
          }
      },
      tipSweep: true,
      // postonce: true, //二次提交防御
      ajaxPost: true,
      beforeSubmit: function(curform){},
      callback: function(result){
          if(result.data.url != undefined && result.data.url){
              if(result.code == 0){
                  location.href = result.data.url;
              }
              else{
                  layer.open({
                      content: result.msg,
                      yes: function(index, layero){
                          location.href = result.data.url;
                          layer.close(index);
                      }
                  });
              }
          }
          else if(result.msg){
              layer.msg(result.msg);
          }
      }
  });
})
// 全选
function CheckAll(form)
{
	for (var i=0;i<form.elements.length;i++)
	{
		var e = form.elements[i];
		if(e.type=='checkbox') e.checked = ifcheck;
	}
	ifcheck = ifcheck == true ? false : true;
}

// 删除
function onOneDelete(url, content)
{
  layer.confirm(content,{icon:0,title:'提示信息'}, function(index){
    var index = layer.load(2,{shade:0.3});

      $.get(url, function(data){
        layer.close(index);
        if(data.code == 0){
        	layermsg(data.msg,1,'reload');
        }else{
            layermsg(data.msg);
      }
    },'json');
  });
  return false;
}

// 全选删除
function onBatchDelete(formid, url, content, isreport, pagetype)
{
    if (whole($('#' + formid)[0]) == false){
    layermsg('请先选择删除对象！');
        return false;
    }
    var content = content ? content : '删除所选记录';
    $('#' + formid).attr('action', url);
    layer.confirm(content,{icon:0,title:'提示信息'}, function(index){
      var index = layer.load(2,{shade:0.3});
        $.post(url,$('#'+formid).serialize(), function(data){
          layer.close(index);
        if(data.code == 0){
        layermsg(data.msg,1,'reload');
      }else{
        layermsg(data.msg);
      }
    },'json');
        return true;
    });
    return false;
}

// 判断是否选中
function whole(fm)
{
	for (var i=0;i<fm.elements.length;i++){
		var e = fm.elements[i];
		if(e.type=='checkbox'){
			if(e.checked==true) return true;
		}
	}
	return false;
}

//清空
function clearData(opt_uri,msg,back_uri, isreport, pagetype){
  var msg = msg ? msg : '您确定清空所有记录吗？';
  // if($('#table').val()){
  //   opt_uri += '/table/'+$('#table').val();
  //   back_uri += '/table/'+$('#table').val();
  // }
  layer.confirm(msg,{icon:0,title:'提示信息'}, function(index){
    var index = layer.load(2,{shade:0.3});
    $.get(opt_uri,function(data){
      layer.close(index);
      if(data.code == 1){
        window.location.href=back_uri;
      }
      else{
        layermsg('清空失败！');
      }
    },'json');
        return true;
    });
    return false;
}

function get_time(){
  var date  = new Date($.ajax({async: false}).getResponseHeader("Date"));
  var year = "", month = "", day = "", week = "", hour = "", minute = "", second = "";
  year = date.getFullYear();
  month = add_zero(date.getMonth()+1);
  day = add_zero(date.getDate());
  week = date.getDay();
  switch (date.getDay()) {
    case 0:val="星期日";break
    case 1:val="星期一";break
    case 2:val="星期二";break
    case 3:val="星期三";break
    case 4:val="星期四";break
    case 5:val="星期五";break
    case 6:val="星期六";break
  }
  hour = add_zero(date.getHours());
  minute = add_zero(date.getMinutes());
  second = add_zero(date.getSeconds());
  document.getElementById("timetable").innerHTML=" "+year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second+" "+val;
}

function add_zero(temp){
  if(temp < 10) return "0" + temp;
  else return temp;
}