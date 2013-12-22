本人的vim配置来自于wklen/vim(当然之后有很大的改动)，特将本人的配置和wklen对vim配置的说明陈列于此。
---------

k-vim的说明见于K-VIM.md

### vim原生快捷键说明

    J   连接本行和下一行
    K   :! man xx 快速查询手册
    tx  跳到下一个x前面，大写则相反
    fx  跳到下一个x，大写则相反
    Ctrl + D 跳过下半页
    Ctrl + U 跳过上半页
    Ctrl + F 向前一页
    Ctrl + B 向後一页
    Ctrl + O 恢复光标移动
    Ctrl + I 撤销光标移动
    Ctrl + e/y 视口向下\向上移动
    gd  选中同样的单词
    '' 跳转到光标上次停靠的地方, 是两个', 而不是一个"
    mx 设置书签,x只能是a-z的26个字母
    (1左边的键)x 跳转到书签x处(“`”是1左边的键)

### 自定义快捷键说明

    F1  关掉，防止跳出帮助
    F2  set nu/nonu
    F3  set list/nolist
    F4  set wrap/nowrap
    F5  set paste/nopaste
    F8  taglist 导航
    F9  tag 导航
    ctrl + 空格 /开启查找
    { + <CR>   补全大括号
    Y   =y$   复制到行尾
    Z   折叠/反折叠
    w!!  以sudo的权限保存
    kj   <Esc>，不用到角落去按esc了(或者使用ctrl + [)
    @    新起一行，下面，不进入插入模式
    #    新起一行，上面
    U	 恢复
    ctrl + jkhl 进行上下左右窗口跳转,不需要ctrl+w+jkhl
    ctrl + 左右 左右标签跳转
    ctrl + 上   打开新标签
    ctrl + 下   关闭当前标签
    
    
    <Leader> , 设置leader键为,
    <Leader>sa   全选(select all)
    <Leader>tn  new tab
    <Leader>tc  tab close
    <Leader>to  tab only
    <Leader>tm  tab move
    <Leader>te  new tab edit
    <Leader>ev  修改.vimrc
    <Leader>sv  重新加载.vimrc

    <Leader>y 展示历史剪贴板
    <Leader>yc 清空
    yy/dd -> p -> ctrl+p可以替换非最近一次剪贴内容

    <Leader>p 开启文件搜索 ctrlp
    <Leader>f 同上
    <Leader>/ 去除匹配高亮
    <Leader>q 离开，等同于:q
    <Leader>q! 离开，等同于:q!
    <Leader>w 保存，等同于:w
    <Leader>d 删除并且不加入剪贴栈
    <Leader>f(,:=) 按照$0的符号切分格式化
    
    <Leader>v 选择一段区域
--------------------

