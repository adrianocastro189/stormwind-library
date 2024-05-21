"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[976],{5402:(r,e,a)=>{a.r(e),a.d(e,{assets:()=>d,contentTitle:()=>t,default:()=>h,frontMatter:()=>i,metadata:()=>o,toc:()=>l});var n=a(4848),s=a(8453);const i={},t="Raid Marker",o={id:"resources/models/raid-marker",title:"Raid Marker",description:"The raid marker model represents those icon markers that can",source:"@site/docs/resources/models/raid-marker.md",sourceDirName:"resources/models",slug:"/resources/models/raid-marker",permalink:"/docs/resources/models/raid-marker",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/resources/models/raid-marker.md",tags:[],version:"current",frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Player",permalink:"/docs/resources/models/player"},next:{title:"Realm",permalink:"/docs/resources/models/realm"}},d={},l=[{value:"Instances",id:"instances",level:2},{value:"Printable string",id:"printable-string",level:2}];function c(r){const e={code:"code",h1:"h1",h2:"h2",p:"p",pre:"pre",...(0,s.R)(),...r.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(e.h1,{id:"raid-marker",children:"Raid Marker"}),"\n",(0,n.jsx)(e.p,{children:"The raid marker model represents those icon markers that can\r\nbe placed on targets, mostly used in raids and dungeons, especially\r\n\ud83d\udc80 and \u274c."}),"\n",(0,n.jsx)(e.p,{children:"This model is used to represent the raid markers in the game, but\r\nnot only conceptually, but it maps markers and their indexes to\r\nbe represented by objects in the addon environment."}),"\n",(0,n.jsx)(e.h2,{id:"instances",children:"Instances"}),"\n",(0,n.jsx)(e.p,{children:"Raid Marker's constructor is private, which means this model can't be\r\nfreely instantiated. The reason for that is: there's a limited number\r\nof markers in the game, and each instance is not supposed to store any\r\nkinds of state, nor persistent data. In other words, this class behaves\r\nas an enum."}),"\n",(0,n.jsxs)(e.p,{children:["The only way to obtain markers instances is by getting them from the\r\nlibrary's ",(0,n.jsx)(e.code,{children:"raidMarkers"})," property, which stores the possible 9 markers,\r\nbeing the 0 marker just a way to remove a target mark. So, in fact, only\r\n8 instances are real markers."]}),"\n",(0,n.jsx)(e.p,{children:"Raid markers can be obtained by their name or numeric id:"}),"\n",(0,n.jsx)(e.pre,{children:(0,n.jsx)(e.code,{className:"language-lua",children:"library.raidMarkers['remove']   -- or library.raidMarkers[0]\r\nlibrary.raidMarkers['star']     -- or library.raidMarkers[1]\r\nlibrary.raidMarkers['circle']   -- or library.raidMarkers[2]\r\nlibrary.raidMarkers['diamond']  -- or library.raidMarkers[3]\r\nlibrary.raidMarkers['triangle'] -- or library.raidMarkers[4]\r\nlibrary.raidMarkers['moon']     -- or library.raidMarkers[5]\r\nlibrary.raidMarkers['square']   -- or library.raidMarkers[6]\r\nlibrary.raidMarkers['x']        -- or library.raidMarkers[7]\r\nlibrary.raidMarkers['skull']    -- or library.raidMarkers[8]\n"})}),"\n",(0,n.jsx)(e.h2,{id:"printable-string",children:"Printable string"}),"\n",(0,n.jsx)(e.p,{children:"Raid markers can be printed in the World of Warcraft default output,\r\nwhich is the chat window. That requires a big string that includes the\r\nnumeric identifier representing the marker."}),"\n",(0,n.jsxs)(e.p,{children:["The ",(0,n.jsx)(e.code,{children:"RaidMarker"})," class encapsulates that logic in a method called\r\n",(0,n.jsx)(e.code,{children:"getPrintableString()"}),". The example below will print the \ud83d\udc80 icon in\r\nthe chat."]}),"\n",(0,n.jsx)(e.pre,{children:(0,n.jsx)(e.code,{className:"language-lua",children:"local skullMarker = library.raidMarkers['skull']\r\n\r\nprint(skullMarker:getPrintableString() .. ' - this is a skull raid marker')\n"})})]})}function h(r={}){const{wrapper:e}={...(0,s.R)(),...r.components};return e?(0,n.jsx)(e,{...r,children:(0,n.jsx)(c,{...r})}):c(r)}},8453:(r,e,a)=>{a.d(e,{R:()=>t,x:()=>o});var n=a(6540);const s={},i=n.createContext(s);function t(r){const e=n.useContext(i);return n.useMemo((function(){return"function"==typeof r?r(e):{...e,...r}}),[e,r])}function o(r){let e;return e=r.disableParentContext?"function"==typeof r.components?r.components(s):r.components||s:t(r.components),n.createElement(i.Provider,{value:e},r.children)}}}]);