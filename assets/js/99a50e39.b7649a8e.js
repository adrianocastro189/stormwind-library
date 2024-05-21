"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[9022],{3482:(e,r,t)=>{t.r(r),t.d(r,{assets:()=>i,contentTitle:()=>l,default:()=>u,frontMatter:()=>s,metadata:()=>o,toc:()=>c});var n=t(4848),a=t(8453);const s={},l="Player",o={id:"resources/models/player",title:"Player",description:"The Player class is a model that maps player information.",source:"@site/docs/resources/models/player.md",sourceDirName:"resources/models",slug:"/resources/models/player",permalink:"/docs/resources/models/player",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/models/player.md",tags:[],version:"current",frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Macros",permalink:"/docs/resources/models/macro"},next:{title:"Raid Marker",permalink:"/docs/resources/models/raid-marker"}},i={},c=[{value:"Getting the current player instance",id:"getting-the-current-player-instance",level:2}];function d(e){const r={a:"a",code:"code",h1:"h1",h2:"h2",p:"p",pre:"pre",...(0,a.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(r.h1,{id:"player",children:"Player"}),"\n",(0,n.jsx)(r.p,{children:"The Player class is a model that maps player information."}),"\n",(0,n.jsx)(r.p,{children:"Just like any other model, it's used to standardize the way addons interact\r\nwith data related to players."}),"\n",(0,n.jsxs)(r.p,{children:["Its first version, introduced in the library version 1.2.0 includes only a few\r\nbasic properties like ",(0,n.jsx)(r.code,{children:"guid"}),", ",(0,n.jsx)(r.code,{children:"name"})," and ",(0,n.jsx)(r.code,{children:"realm"}),", but this model will grow\r\nover time as new expansions are released and new features are implemented in\r\nthe library."]}),"\n",(0,n.jsxs)(r.p,{children:["For a more detailed explanation of the Player model and its available methods\r\nand properties, please refer to the library\r\n",(0,n.jsx)(r.a,{href:"pathname:///lua-docs/classes/Models.Player.html",children:"technical documentation"}),"."]}),"\n",(0,n.jsx)(r.h2,{id:"getting-the-current-player-instance",children:"Getting the current player instance"}),"\n",(0,n.jsx)(r.p,{children:'The current player instance can be retrieved using a "static" method of the\r\nPlayer class, which also takes care of creating the instance and setting its\r\nproperties using the World of Warcraft API.'}),"\n",(0,n.jsx)(r.pre,{children:(0,n.jsx)(r.code,{className:"language-lua",children:"local player = library:getClass('Player').getCurrentPlayer()\n"})}),"\n",(0,n.jsxs)(r.p,{children:["Note that the example above is not not calling ",(0,n.jsx)(r.code,{children:":getCurr..."})," but\r\n",(0,n.jsx)(r.code,{children:".getCurr..."})," because this method is associated with the class itself, not\r\nwith an instance of the class."]}),"\n",(0,n.jsxs)(r.p,{children:["For convenience, once the library is loaded, the current player instance is\r\nautomatically created and stored in a property called ",(0,n.jsx)(r.code,{children:"currentPlayer"}),"."]}),"\n",(0,n.jsx)(r.pre,{children:(0,n.jsx)(r.code,{className:"language-lua",children:"local player = library.currentPlayer\n"})})]})}function u(e={}){const{wrapper:r}={...(0,a.R)(),...e.components};return r?(0,n.jsx)(r,{...e,children:(0,n.jsx)(d,{...e})}):d(e)}},8453:(e,r,t)=>{t.d(r,{R:()=>l,x:()=>o});var n=t(6540);const a={},s=n.createContext(a);function l(e){const r=n.useContext(s);return n.useMemo((function(){return"function"==typeof e?e(r):{...r,...e}}),[r,e])}function o(e){let r;return r=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:l(e.components),n.createElement(s.Provider,{value:r},e.children)}}}]);