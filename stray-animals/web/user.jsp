<%--
  Created by IntelliJ IDEA.
  User: love
  Date: 2020/12/10
  Time: 下午5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- <link rel="stylesheet" href="css\font-awesome.min.css"> -->
    <script src="assets/js/jquery-3.2.1.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="assets/css/bootstrap-table.min.css">
    <!-- Latest compiled and minified JavaScript -->
    <script src="assets/js/bootstrap-table.min.js"></script>
    <!-- Latest compiled and minified Locales -->
    <script src="assets/js/bootstrap-table-zh-CN.min.js"></script>
    <script src="assets/layer/layer.js"></script>

</head>
<body>


<div class="container-fluid">
    <div class="row">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">用户管理面板</h3>
            </div>
            <div class="panel-body">

                <div id="toolbar">
                    <button class="btn btn-primary" onclick="addUser()"><span class="glyphicon glyphicon-plus"></span> 新增</button>
                </div>

<%--                <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg">Large modal</button>--%>

                <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="myModal">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                            </div>
                            <div class="modal-body">
                                <form action="" class="form-horizontal">

                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">新密码</label>
                                        <div class="col-sm-9">
                                            <input type="hidden" class="form-control" id="id">
                                            <input type="text" class="form-control" id="newPwd">
                                        </div>
                                    </div>

                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary" id="save-edit-btn">保存</button>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="addUserModal" id="addUserModal">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">新增用户</h4>
                            </div>
                            <div class="modal-body">
                                <form action="" class="form-horizontal">

                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">用户名</label>
                                        <div class="col-sm-9">
<%--                                            <input type="hidden" class="form-control" id="id">--%>
                                            <input type="text" class="form-control" id="username">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">密码</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="password">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">角色</label>
                                        <div class="col-sm-9">
                                            <select class="form-control" name="role" id="role"  placeholder="请选择" >
                                                <option disabled selected value>请选择</option>
                                                <option value="2">爱心机构</option>
                                                <option value="3">饲主</option>
                                            </select>
                                        </div>
                                    </div>



                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary" id="save-add-btn">保存</button>
                            </div>
                        </div>
                    </div>
                </div>



                <table id="table"></table>

            </div>
        </div>

    </div>
</div>
</body>
</body>
</html>
<script>


    $('#table').bootstrapTable({
        url: 'userQuery',        // 表格数据来源
        queryParams: function (params) {
            return {
                offset: params.offset,  //页码
                limit: params.limit,   //页面大小
                search : params.search, //搜索
                order : params.order, //排序
                ordername : params.sort, //排序
            };
        },
        classes: "table table-bordered table-hover text-info ",//这里设置表头样式
        search: true,
        showHeader : true,
        showColumns : true,
        showRefresh : false,
        pagination: true,//分页
        sidePagination : 'server',//服务器端分页
        pageNumber : 1,
        pageList: [5, 10, 20, 50],//分页步进值
        toolbar:'#toolbar',//工具栏
        toolbarAlign:'left',//工具栏的位置


        columns: [{
            field: 'id',
            title: 'ID',
            halign:'center',
            align:'center'

        }, {
            field: 'username',
            title: '用户名',
            halign:'center',
            align:'center'

        }, {
            field: 'role',
            title: '角色',
            halign:'center',
            align:'center',
            sortable: true,//启用排序
            formatter : function (value, row, index) {
                if (row['role'] === 1) {
                    return `<span>管理员</span>`;
                }
                if (row['role'] === 2) {
                    return '爱心机构';
                }
                if (row['role'] === 3) {
                    return '饲主';
                }
                return value;
            }


        },{
            field: 'createTime',
            title: '注册时间',
            halign:'center',
            align:'center',
            formatter:function (value, row, index) {
              return value;
            }

        } ,{
            field: '',
            title: '操作',
            halign:'center',
            align:'center',
            width:'320px',
            formatter: function (value, row, index) {

               return '<button class="btn btn-primary " onclick="editUser('+row.id+')">修改密码</button>' +
                   '<button style="margin-left: 10px" class="btn btn-danger" onclick="deleteUser('+row.id+')">删除</button>'

            }
        }

        ]
    });


    function editUser(id) {

        // 清空input框
        $("#newPwd").val("")
        $("#id").attr("value", id);

        // 打开模态框
        $('#myModal').modal('show');
    }

    function addUser() {
        // 清空input框
        $("#username").val("")
        $("#password").val("")
        $('#addUserModal').modal('show');
    }

    function deleteUser(id) {
        //询问框
        layer.confirm('确定要删除id为：'+id+'的用户吗？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                type: "post",
                url: "userDelete",
                dataType:"json",
                data: {
                    type: 'delete',
                    id
                },
                success:function(data){
                    if(data.status == 200) {
                        layer.msg(data.msg, {icon: 1});
                    }else {
                        layer.msg(data.msg, {icon: 2});
                    }

                    $('#table').bootstrapTable('refresh', {pageNumber:1});


                },
                error:function(jqXHR){
                    console.log("Erro")
                }
            });


        });
    }



    $("#save-add-btn").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var role = $("#role").val()
        if(username == null || username == "") {
            layer.msg("用户名不能为空哦！", {icon: 2})
            return
        }
        if(password == null || password == "") {
            layer.msg("密码不能为空哦！！", {icon: 2})
            return
        }

        if(role == null || role == "") {
            layer.msg("请选择角色！！", {icon: 2})
            return
        }

        $.ajax({
            type: "post",
            url: "userAdd",
            dataType:"json",
            data: {
                type: 'add',
                username,
                password,
                role
            },
            success:function(data){
                if(data.status == 200) {
                    layer.msg(data.msg, {icon: 1});
                    // 关闭模态框
                    $('#addUserModal').modal('hide');
                    // 刷新表格
                    $('#table').bootstrapTable('refresh');
                }else {
                    layer.msg(data.msg, {icon: 2});
                }


            },
            error:function(jqXHR){
                console.log("Erro")
            }
        });
    })

    $("#save-edit-btn").click(function () {
        var newPwd = $("#newPwd").val();

        if(newPwd == "") {
            layer.msg("不能为空哦！", {icon: 2})
            return
        }


        var id = $("#id").val()

        $.ajax({
            type: "post",
            url: "userUpdate",
            dataType:"json",
            data: {
                type: 'update',
                newPwd,
                id
            },
            success:function(data){
                console.log(data)
                if(data.status == 200) {
                    layer.msg(data.msg, {icon: 1});
                    // 关闭模态框
                    $('#myModal').modal('hide');
                    // 刷新表格
                    $('#table').bootstrapTable('refresh');
                }else {
                    layer.msg(data.msg, {icon: 2});
                }




            },
            error:function(jqXHR){
                console.log("Erro")
            }
        });

    })



    //关闭模态框数据保存到table
    // $("#sava-edit-btn").click(function () {
    //     $('#myModal').modal('hide');
    //     var id = $("#modal_id").val();
    //     var new_cus_name = $("#modal_cus_name").val();
    //     var new_bj_prd = $("#modal_bj_prd").val();
    //     var new_up = $("#modal_up").val();
    //     var new_mj_cst = $("#modal_mj_cst").val();
    //
    //     $table.bootstrapTable("updateRow",{
    //         index:index,
    //         row:{
    //             id:id,
    //             cus_name:new_cus_name,
    //             bj_prd:new_bj_prd,
    //             up:new_up,
    //             mj_cst:new_mj_cst
    //         }
    //     });
    // })


</script>