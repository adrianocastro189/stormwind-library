"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[1994],{9347:(e,n,a)=>{a.r(n),a.d(n,{assets:()=>i,contentTitle:()=>r,default:()=>m,frontMatter:()=>s,metadata:()=>c,toc:()=>d});var o=a(4848),t=a(8453);const s={},r="Macros",c={id:"resources/models/macro",title:"Macros",description:"Macro is the mapping of a game macro accessed with /m.",source:"@site/docs/resources/models/macro.md",sourceDirName:"resources/models",slug:"/resources/models/macro",permalink:"/docs/resources/models/macro",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/models/macro.md",tags:[],version:"current",frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Item",permalink:"/docs/resources/models/item"},next:{title:"Player",permalink:"/docs/resources/models/player"}},i={},d=[{value:"How to use the Macro class",id:"how-to-use-the-macro-class",level:2},{value:"Example",id:"example",level:2}];function l(e){const n={a:"a",admonition:"admonition",code:"code",h1:"h1",h2:"h2",li:"li",ol:"ol",p:"p",pre:"pre",strong:"strong",...(0,t.R)(),...e.components};return(0,o.jsxs)(o.Fragment,{children:[(0,o.jsx)(n.h1,{id:"macros",children:"Macros"}),"\n",(0,o.jsxs)(n.p,{children:["Macro is the mapping of a game macro accessed with ",(0,o.jsx)(n.code,{children:"/m"}),"."]}),"\n",(0,o.jsx)(n.p,{children:"It basically allows macro manipulation without having to use the World of Warcraft API\r\nglobal functions."}),"\n",(0,o.jsxs)(n.p,{children:["When addons need to create/update macros, they can easily instantiate a macro\r\nby its name, use the setters to define its icon and body, then call the ",(0,o.jsx)(n.code,{children:"save()"})," method."]}),"\n",(0,o.jsxs)(n.admonition,{title:"Note about macro names",type:"tip",children:[(0,o.jsxs)(n.p,{children:["The ",(0,o.jsx)(n.strong,{children:"Macro"})," class was designed to work with macros created and managed by an addon."]}),(0,o.jsx)(n.p,{children:"It's not entirely related to query and manage existing and custom macros so it won't\r\nbehave well if used for that purpose."})]}),"\n",(0,o.jsx)(n.h2,{id:"how-to-use-the-macro-class",children:"How to use the Macro class"}),"\n",(0,o.jsxs)(n.ol,{children:["\n",(0,o.jsxs)(n.li,{children:["Instantiate a macro using the ",(0,o.jsx)(n.a,{href:"../core/factory",children:"factory resources"})]}),"\n",(0,o.jsx)(n.li,{children:"Customize is icon if necessary"}),"\n",(0,o.jsx)(n.li,{children:"Set a body"}),"\n",(0,o.jsx)(n.li,{children:"Save it!"}),"\n"]}),"\n",(0,o.jsxs)(n.admonition,{title:"Setting the macro body with an array",type:"tip",children:[(0,o.jsxs)(n.p,{children:["The Macro's ",(0,o.jsx)(n.code,{children:"setBody()"})," method accepts a string ",(0,o.jsx)(n.strong,{children:"or"})," an array of strings."]}),(0,o.jsxs)(n.p,{children:["If an array is passed, the library will automatically add a line break between the values\r\nto place a command per line. So, there's no need to concatenate lines with ",(0,o.jsx)(n.code,{children:"\\n"})," here."]})]}),"\n",(0,o.jsx)(n.h2,{id:"example",children:"Example"}),"\n",(0,o.jsx)(n.p,{children:"Imagine an addon that adds a macro to target a unit and wave. This is how it could\r\nimplement that:"}),"\n",(0,o.jsx)(n.pre,{children:(0,o.jsx)(n.code,{className:"language-lua",children:"local macro = library:new('Macro', 'MyAddonCustomMacro')\r\n\r\nmacro:setIcon(\"INV_Misc_QuestionMark\")\r\nmacro:setBody({\r\n    '/tar PlayerName',\r\n    '/wave'\r\n})\r\nmacro:save()\n"})}),"\n",(0,o.jsxs)(n.p,{children:["When the code above is executed, a macro with name ",(0,o.jsx)(n.strong,{children:"MyAddonCustomMacro"})," will be created\r\n",(0,o.jsx)(n.strong,{children:"or"})," updated with a body and icon."]})]})}function m(e={}){const{wrapper:n}={...(0,t.R)(),...e.components};return n?(0,o.jsx)(n,{...e,children:(0,o.jsx)(l,{...e})}):l(e)}},8453:(e,n,a)=>{a.d(n,{R:()=>r,x:()=>c});var o=a(6540);const t={},s=o.createContext(t);function r(e){const n=o.useContext(s);return o.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function c(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(t):e.components||t:r(e.components),o.createElement(s.Provider,{value:n},e.children)}}}]);