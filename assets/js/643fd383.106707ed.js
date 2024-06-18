"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[5646],{9996:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>i,contentTitle:()=>t,default:()=>m,frontMatter:()=>s,metadata:()=>d,toc:()=>c});var a=r(4848),o=r(8453);const s={sidebar_position:1,title:"Overview"},t=void 0,d={id:"resources/commands/overview",title:"Overview",description:"Slash commands in World of Warcraft are executed in the chat box that can",source:"@site/docs/resources/commands/overview.md",sourceDirName:"resources/commands",slug:"/resources/commands/overview",permalink:"/docs/resources/commands/overview",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/commands/overview.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1,title:"Overview"},sidebar:"tutorialSidebar",previous:{title:"Commands",permalink:"/docs/category/commands"},next:{title:"Command",permalink:"/docs/resources/commands/command"}},i={},c=[{value:"Stormwind Library commands",id:"stormwind-library-commands",level:2},{value:"Current limitations",id:"current-limitations",level:2}];function l(e){const n={a:"a",code:"code",h2:"h2",li:"li",ol:"ol",p:"p",strong:"strong",ul:"ul",...(0,o.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(n.p,{children:"Slash commands in World of Warcraft are executed in the chat box that can\r\ntrigger lots of things for a character as well as for their UI."}),"\n",(0,a.jsx)(n.p,{children:"Examples of slash commands:"}),"\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.code,{children:"/m"})," opens the macro window"]}),"\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.code,{children:"/dance"})," puts the character to dance"]}),"\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.code,{children:"/logout"})," logs the character off"]}),"\n"]}),"\n",(0,a.jsx)(n.p,{children:"There are lots of native commands, and addons can introduce their own."}),"\n",(0,a.jsx)(n.h2,{id:"stormwind-library-commands",children:"Stormwind Library commands"}),"\n",(0,a.jsx)(n.p,{children:"It's very easy to add new slash commands to the game and you can do that\r\nwith a couple of code lines."}),"\n",(0,a.jsx)(n.p,{children:"The Stormwind Library offers a small structure to add commands in a more OOP\r\napproach, which means you can wrap a command in a Lua class in case its\r\ncomplex enough to be handled by a procedural script."}),"\n",(0,a.jsx)(n.p,{children:'That said, if an addon needs to use the library commands resources, it must\r\nadhere to a few rules. Otherwise, the addon can "manually" introduce\r\ncommands in the traditional way and bypass this resource.'}),"\n",(0,a.jsxs)(n.ol,{children:["\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.strong,{children:"Single command name:"})," the library allows only a single command per\r\naddon. Which means the addon can't register ",(0,a.jsx)(n.code,{children:"/myAddonCommand"})," and\r\n",(0,a.jsx)(n.code,{children:"/myAddonAnotherCommand"}),", instead, it must use the concept of command\r\noperations."]}),"\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.strong,{children:"One callback per operation:"})," considering a single command per addon,\r\nthe first argument is considered the operation, which means something like\r\nthe real command inside the addon. As an example ",(0,a.jsx)(n.code,{children:"/myAddonCommand show"})," and\r\n",(0,a.jsx)(n.code,{children:"/myAddonCommand hide"})," are commands with two different operations: ",(0,a.jsx)(n.strong,{children:"show"}),"\r\nand ",(0,a.jsx)(n.strong,{children:"hide"}),".","\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsxs)(n.li,{children:["Still, a command callback may accept arguments, so a command like\r\n",(0,a.jsx)(n.code,{children:"/myAddonCommand show simpleUi darkMode"})," will call the ",(0,a.jsx)(n.strong,{children:"show"})," callback\r\npassing ",(0,a.jsx)(n.code,{children:"simpleUi"})," and ",(0,a.jsx)(n.code,{children:"darkMode"})," as arguments."]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,a.jsx)(n.p,{children:"If the addon can handle commands in the proposed way, then it can use the\r\nresources below to register, listen and trigger callbacks for slash\r\ncommands."}),"\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsx)(n.li,{children:(0,a.jsx)(n.a,{href:"command",children:"Creating and registering a command"})}),"\n",(0,a.jsx)(n.li,{children:(0,a.jsx)(n.a,{href:"commands-handler",children:"How the commands handler works"})}),"\n"]}),"\n",(0,a.jsx)(n.h2,{id:"current-limitations",children:"Current limitations"}),"\n",(0,a.jsx)(n.p,{children:"The current command structure has a few limitations that developers need to\r\nbe aware. These limitations can be covered in the future depending on their\r\ndemand and more clarity on how this structure is being used:"}),"\n",(0,a.jsxs)(n.ol,{children:["\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.strong,{children:"Commands must have an operation:"})," a command can't be created without\r\nthe operation, meaning that ",(0,a.jsx)(n.code,{children:"/myAddonCommand"})," with no arguments won't have\r\nany effects and won't forward to the addon callbacks.","\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsxs)(n.li,{children:["For cases where the addon needs only one single command, prefer to use\r\na default operation representing what the command opens or runs, examples:","\n",(0,a.jsxs)(n.ul,{children:["\n",(0,a.jsx)(n.li,{children:(0,a.jsx)(n.code,{children:"/myAddonCommand show"})}),"\n",(0,a.jsx)(n.li,{children:(0,a.jsx)(n.code,{children:"/myAddonCommand config"})}),"\n",(0,a.jsx)(n.li,{children:(0,a.jsx)(n.code,{children:"/myAddonCommand start"})}),"\n"]}),"\n"]}),"\n",(0,a.jsxs)(n.li,{children:["By default, calling ",(0,a.jsx)(n.code,{children:"/myAddonCommand"})," will trigger the ",(0,a.jsx)(n.strong,{children:"help"})," operation\r\nas better explained ",(0,a.jsx)(n.a,{href:"commands-handler#the-help-operation",children:"here"}),"."]}),"\n"]}),"\n"]}),"\n",(0,a.jsxs)(n.li,{children:[(0,a.jsx)(n.strong,{children:"Arguments can't escape quotes yet:"})," when calling commands handled by the\r\nStormwind Library, arguments are separated by a space (",(0,a.jsx)(n.code,{children:" "}),") meaning that\r\n",(0,a.jsx)(n.code,{children:"/myAddonCommand operation arg1 arg2"})," will call the operation passing both\r\narguments as two Lua variables and it also allows wrapping strings with\r\nspaces in ",(0,a.jsx)(n.code,{children:'""'})," or ",(0,a.jsx)(n.code,{children:"''"}),". However, until the current version, it's not possible\r\nto escape quotes in a way that the argument can't contain those characters."]}),"\n"]})]})}function m(e={}){const{wrapper:n}={...(0,o.R)(),...e.components};return n?(0,a.jsx)(n,{...e,children:(0,a.jsx)(l,{...e})}):l(e)}},8453:(e,n,r)=>{r.d(n,{R:()=>t,x:()=>d});var a=r(6540);const o={},s=a.createContext(o);function t(e){const n=a.useContext(s);return a.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function d(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:t(e.components),a.createElement(s.Provider,{value:n},e.children)}}}]);