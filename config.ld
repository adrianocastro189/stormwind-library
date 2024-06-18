function postprocess_html(html)
    -- adds the Google Analytics script to the end of the <head> tag
    return html:gsub('</head>', "<!-- Google tag (gtag.js) --><script async src='https://www.googletagmanager.com/gtag/js?id=G-GDGPH5FK71'></script><script>window.dataLayer = window.dataLayer || []; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', 'G-GDGPH5FK71');</script></head>")
end

sort=true
postprocess_html=postprocess_html