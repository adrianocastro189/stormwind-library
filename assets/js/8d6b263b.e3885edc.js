"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[1540],{5432:(e,s,t)=>{t.r(s),t.d(s,{assets:()=>c,contentTitle:()=>o,default:()=>u,frontMatter:()=>r,metadata:()=>i,toc:()=>d});var n=t(4848),a=t(8453);const r={},o="View Constants",i={id:"resources/views/constants",title:"View Constants",description:"To avoid hardcoding some values that can be reused in multiple places and that",source:"@site/docs/resources/views/constants.md",sourceDirName:"resources/views",slug:"/resources/views/constants",permalink:"/docs/resources/views/constants",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/views/constants.md",tags:[],version:"current",frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Views",permalink:"/docs/category/views"},next:{title:"Window",permalink:"/docs/resources/views/window"}},c={},d=[{value:"Usage",id:"usage",level:2}];function l(e){const s={code:"code",h1:"h1",h2:"h2",li:"li",p:"p",pre:"pre",ul:"ul",...(0,a.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(s.h1,{id:"view-constants",children:"View Constants"}),"\n",(0,n.jsxs)(s.p,{children:["To avoid hardcoding some values that can be reused in multiple places and that\r\ncan have a big chance to be changed in the future in the game (or even in the\r\nlibrary), the ",(0,n.jsx)(s.code,{children:"src\\Views\\ViewConstants.lua"})," file was created to store these\r\nvalues as frozen tables."]}),"\n",(0,n.jsx)(s.p,{children:"This is a list of the constants available in the file:"}),"\n",(0,n.jsxs)(s.ul,{children:["\n",(0,n.jsxs)(s.li,{children:[(0,n.jsx)(s.code,{children:"DEFAULT_BACKGROUND_TEXTURE"}),": The default texture used in the backdrop of\r\nwindows and frames. This texture is available in the game and should not\r\nrequire any additional assets to work as a valid background texture."]}),"\n"]}),"\n",(0,n.jsx)(s.h2,{id:"usage",children:"Usage"}),"\n",(0,n.jsxs)(s.p,{children:["Just access the ",(0,n.jsx)(s.code,{children:"viewConstants"})," table in your code and use the constants:"]}),"\n",(0,n.jsx)(s.pre,{children:(0,n.jsx)(s.code,{className:"language-lua",children:"frame:SetBackdrop({\r\n    bgFile = library.viewConstants.DEFAULT_BACKGROUND_TEXTURE,\r\n    -- other backdrop properties\r\n})\n"})})]})}function u(e={}){const{wrapper:s}={...(0,a.R)(),...e.components};return s?(0,n.jsx)(s,{...e,children:(0,n.jsx)(l,{...e})}):l(e)}},8453:(e,s,t)=>{t.d(s,{R:()=>o,x:()=>i});var n=t(6540);const a={},r=n.createContext(a);function o(e){const s=n.useContext(r);return n.useMemo((function(){return"function"==typeof e?e(s):{...s,...e}}),[s,e])}function i(e){let s;return s=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:o(e.components),n.createElement(r.Provider,{value:s},e.children)}}}]);