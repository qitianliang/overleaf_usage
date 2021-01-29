# overleaf 开源版本镜像
FROM sharelatex/sharelatex:2.5.0
# 镜像中安装完整版texlive,如遇到安装超级慢（我实际运行需要1~2小时，时间预估过于离谱时如10小时以上）尝试从xjtu获取
# ARG TEXLIVE_MIRROR=http://mirror.xjtu.edu.cn/CTAN/systems/texlive/tlnet
RUN tlmgr update --self
RUN tlmgr install scheme-full

# 如需中文特殊字体支持,请保证字体放在./fonts文件夹，将下面代码取消注释
# 如何添加window10中文字体库见 Readme

RUN apt-get update -y
RUN apt-get install -y xfonts-wqy
COPY ./fonts /usr/share/fonts
WORKDIR /usr/share/fonts
RUN mkfontscale
RUN mkfontdir
RUN fc-cache -fv
