"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[8305],{5250:(e,n,r)=>{r.r(n),r.d(n,{assets:()=>c,contentTitle:()=>s,default:()=>m,frontMatter:()=>o,metadata:()=>i,toc:()=>d});var t=r(4848),a=r(8453);const o={sidebar_position:2,title:"Command"},s=void 0,i={id:"resources/commands/command",title:"Command",description:"The command object is a simple DTO object that can also house the callback",source:"@site/docs/resources/commands/command.md",sourceDirName:"resources/commands",slug:"/resources/commands/command",permalink:"/docs/resources/commands/command",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/commands/command.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2,title:"Command"},sidebar:"tutorialSidebar",previous:{title:"Overview",permalink:"/docs/resources/commands/overview"},next:{title:"Commands Handler",permalink:"/docs/resources/commands/commands-handler"}},c={},d=[{value:"Requirements",id:"requirements",level:2},{value:"Example",id:"example",level:2}];function l(e){const n={a:"a",code:"code",h2:"h2",li:"li",ol:"ol",p:"p",pre:"pre",strong:"strong",...(0,a.R)(),...e.components};return(0,t.jsxs)(t.Fragment,{children:[(0,t.jsx)(n.p,{children:"The command object is a simple DTO object that can also house the callback\r\nif the addon has a good class structure."}),"\n",(0,t.jsx)(n.p,{children:"It basically holds the required information to register a slash command in\r\nthe game:"}),"\n",(0,t.jsxs)(n.ol,{children:["\n",(0,t.jsxs)(n.li,{children:[(0,t.jsx)(n.strong,{children:"Operation:"})," the ",(0,t.jsx)(n.code,{children:"setOperation(operation)"})," expects a string operation\r\nname which will be the one used by the library to forward the command\r\nexecution."]}),"\n",(0,t.jsxs)(n.li,{children:[(0,t.jsx)(n.strong,{children:"Callback:"})," the ",(0,t.jsx)(n.code,{children:"setCallback(callback)"})," expects a function that will be\r\nexecuted when the library captures a command. This function may expect\r\nparameters that will be parsed by the commands handler."]}),"\n",(0,t.jsxs)(n.li,{children:[(0,t.jsx)(n.strong,{children:"Description:"})," optional property set with ",(0,t.jsx)(n.code,{children:"setDescription(description)"}),"\r\nthat will also store additional information for that command. When defined,\r\nthe ",(0,t.jsx)(n.a,{href:"commands-handler#the-help-operation",children:"default help operation"})," will print\r\nit after the operation name."]}),"\n"]}),"\n",(0,t.jsx)(n.h2,{id:"requirements",children:"Requirements"}),"\n",(0,t.jsxs)(n.p,{children:["In order to add commands, the library must be initialized with the ",(0,t.jsx)(n.code,{children:"command"}),"\r\nproperty. After that, every command instance created in the example below will\r\nbe registered as an operation that will be executed by the registered command."]}),"\n",(0,t.jsxs)(n.p,{children:["Read the ",(0,t.jsx)(n.a,{href:"../core/addon-properties",children:"Addon Properties"})," documentation for more\r\nreference."]}),"\n",(0,t.jsx)(n.h2,{id:"example",children:"Example"}),"\n",(0,t.jsxs)(n.p,{children:["Imagine an addon that needs to register a ",(0,t.jsx)(n.strong,{children:"clear"})," command that will clear\r\na table. Something like a cache clear. The addon holds the library instance\r\nin a property called ",(0,t.jsx)(n.code,{children:"library"}),"."]}),"\n",(0,t.jsxs)(n.p,{children:["First, the library must be initialized with the ",(0,t.jsx)(n.code,{children:"command"})," property:"]}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-lua",children:"CustomAddon.library = StormwindLibrary.new({\r\n  command = 'myAddon',\r\n  -- other properties here\r\n})\n"})}),"\n",(0,t.jsx)(n.p,{children:"After that, it's possible to register any other commands, called operations,\r\nas necessary."}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-lua",children:"-- instantiates a command using the library factory\r\nlocal command = CustomAddon.library:new('Command')\r\n\r\nfunction command:commandExecution(arg1, arg2)\r\n    -- execute any addon code here\r\n    print('command executed with arg1 = ' .. arg1 .. ', and arg2 = ' .. arg2)\r\nend\r\n\r\ncommand\r\n    :setDescription('Clears the addon cache')\r\n    :setOperation('clear')\r\n    :setCallback(command.commandExecution)\r\n\r\n-- registers the command in the library\r\nCustomAddon.library.commands:add(command)\n"})}),"\n",(0,t.jsx)(n.p,{children:"In game, running the following line in the chat will execute the command:"}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-shell",children:"/myAddon clear\n"})})]})}function m(e={}){const{wrapper:n}={...(0,a.R)(),...e.components};return n?(0,t.jsx)(n,{...e,children:(0,t.jsx)(l,{...e})}):l(e)}},8453:(e,n,r)=>{r.d(n,{R:()=>s,x:()=>i});var t=r(6540);const a={},o=t.createContext(a);function s(e){const n=t.useContext(o);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function i(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:s(e.components),t.createElement(o.Provider,{value:n},e.children)}}}]);