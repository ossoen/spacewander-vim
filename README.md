本人的vim配置来自于wklen/vim(当然有之后有很大的改动)，特将本人的配置和wklen对vim配置的说明陈列于此。
======================
k-vim的说明见于K-VIM.md
======================

### 自定义快捷键说明

    F1  关掉，防止跳出帮助
    F2  set nu/nonu
    F3  set list/nolist
    F4  set wrap/nowrap
    F5  set paste/nopaste
    F6  syntax on/off
    F9  tag 导航
    空格 /开启查找
    {   补全大括号
    Y   =y$   复制到行尾
    w!!  以sudo的权限保存
    kj   <Esc>，不用到角落去按esc了(或者使用ctrl + [)
    t    新起一行，下面，不进入插入模式
    T    新起一行，上面
    hjkl  上下左右
    ctrl + jkhl 进行上下左右窗口跳转,不需要ctrl+w+jkhl
    ctrl+n  相对行号绝对行号变换，默认用相对行号
    5j/5k  在相对行号模式下，往上移动5行 往下移动5行
    
	<Leader> , 设置leader键为,
    <Leader>sa   全选(select all)
    <Leader>tn  new tab
    <Leader>tc  tab close
    <Leader>to  tab only
    <Leader>tm  tab move
    <Leader>te  new tab edit
    <Leader>ev  修改.vimrc

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

--------------------

