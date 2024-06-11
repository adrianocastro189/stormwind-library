"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[1353],{2556:(e,s,r)=>{r.r(s),r.d(s,{assets:()=>d,contentTitle:()=>a,default:()=>u,frontMatter:()=>o,metadata:()=>i,toc:()=>l});var t=r(4848),n=r(8453);const o={sidebar_position:1,title:"Overview"},a=void 0,i={id:"resources/models/overview",title:"Overview",description:"Models are structures following class standards, mostly",source:"@site/docs/resources/models/overview.md",sourceDirName:"resources/models",slug:"/resources/models/overview",permalink:"/docs/resources/models/overview",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/models/overview.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1,title:"Overview"},sidebar:"tutorialSidebar",previous:{title:"Models",permalink:"/docs/category/models"},next:{title:"Container",permalink:"/docs/resources/models/container"}},d={},l=[{value:"Model standards",id:"model-standards",level:2}];function c(e){const s={a:"a",code:"code",h2:"h2",li:"li",ol:"ol",p:"p",pre:"pre",strong:"strong",ul:"ul",...(0,n.R)(),...e.components};return(0,t.jsxs)(t.Fragment,{children:[(0,t.jsxs)(s.p,{children:["Models are structures following ",(0,t.jsx)(s.a,{href:"../core/classes",children:"class standards"}),", mostly\r\nused to map game objects and ease data manipulation in the addon."]}),"\n",(0,t.jsx)(s.h2,{id:"model-standards",children:"Model standards"}),"\n",(0,t.jsx)(s.p,{children:"Models are classes that represent a data structure, like a raid marker,\r\na player, a macro, an item, etc. They're usually used to hold information\r\nabout game objects as a way to standardize structures."}),"\n",(0,t.jsx)(s.p,{children:"Here are some practices when creating models:"}),"\n",(0,t.jsxs)(s.ol,{children:["\n",(0,t.jsxs)(s.li,{children:[(0,t.jsx)(s.strong,{children:"Avoid constructors with parameters"}),": Prefer to use setters as that ease\r\non inheritance, testing and avoid compatibility issues in case new parameters\r\nare added to the constructors."]}),"\n",(0,t.jsxs)(s.li,{children:[(0,t.jsx)(s.strong,{children:"Implement chainable setters"}),": When a setter is called, it should return\r\nthe instance itself, so it can be chained with other setters. That improves\r\nwriting code and makes it more readable.","\n",(0,t.jsxs)(s.ul,{children:["\n",(0,t.jsxs)(s.li,{children:["Prefer to use ",(0,t.jsx)(s.code,{children:"value"})," as the setter parameter name instead of the\r\nproperty name, example:","\n",(0,t.jsx)(s.pre,{children:(0,t.jsx)(s.code,{className:"language-lua",children:"--[[--\r\nSets the model name.\r\n\r\n@tparam string value the model's name\r\n\r\n@treturn Module.ClassName self\r\n]]\r\nfunction ClassName:setProperty(value)\r\n    self.property = value\r\n    return self\r\nend\n"})}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(s.li,{children:[(0,t.jsx)(s.strong,{children:"There's no need for getters"}),": Lua doesn't have a way to protect\r\nproperties, so it's not necessary to create getters for them. If a property\r\nneeds to be read, it can be accessed directly, and that will save a lot of\r\nunnecessary code."]}),"\n"]})]})}function u(e={}){const{wrapper:s}={...(0,n.R)(),...e.components};return s?(0,t.jsx)(s,{...e,children:(0,t.jsx)(c,{...e})}):c(e)}},8453:(e,s,r)=>{r.d(s,{R:()=>a,x:()=>i});var t=r(6540);const n={},o=t.createContext(n);function a(e){const s=t.useContext(o);return t.useMemo((function(){return"function"==typeof e?e(s):{...s,...e}}),[s,e])}function i(e){let s;return s=e.disableParentContext?"function"==typeof e.components?e.components(n):e.components||n:a(e.components),t.createElement(o.Provider,{value:s},e.children)}}}]);