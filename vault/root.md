---
id: ik5Bi5OCTsmfKfq5JQtEB
title: Root
desc: ''
updated: 1666937026406
created: 1637610830605
---
# Welcome to Dendron

[![Netlify Status](https://api.netlify.com/api/v1/badges/e7d55491-d2ea-4139-808a-936b502c46d6/deploy-status)](#welcome-to-dendron)

[cy948](https://github.com/cy948)的个人知识库开源部分，主要包含板块：

- C [[cs.lang.c]]

- C 数据结构 [[degree.master.c]]

- 前端相关 [[cs.fe]]

- ASM （待上线）

若有问题欢迎通过页面最下方 `Edit on github` 进行提醒修改，无需提交规范；


{% if CONTEXT == 'deploy-preview' %}
  <h3>Preview:</h3>
  <p>Current branch{{ BRANCH }}</p>
{% endif %}


{% if CONTEXT == 'production' %}
  <h3>Production:</h3>
  <p>Current branch{{ BRANCH }}</p>
  <p>Version {{COMMIT_REF}} Head {{HEAD}}</p>
{% endif %}